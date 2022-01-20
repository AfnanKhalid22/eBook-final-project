////
////  audioBook.swift
////  eBook
////
////  Created by Fno Khalid on 13/05/1443 AH.
////
//

import UIKit
import AVKit


final class AudioBookVC : UIViewController {
    
    var audio: Book
    
    private lazy var bookPlayer : MediaPlayer = {
        let mediaPlayer = MediaPlayer(album: audio)
        mediaPlayer.translatesAutoresizingMaskIntoConstraints = false
        return mediaPlayer
    }()
    
    init(audioBook: Book) {
        self.audio = audioBook
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder){
        fatalError("nill")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBlurredView()
        setupView()
    }
    private func setupView() {
        addBlurredView()
        view.addSubview(bookPlayer)
        
        setupConstraints()
    }
    
    private func addBlurredView() {
        if !UIAccessibility.isReduceMotionEnabled {
            self.view.backgroundColor = UIColor(named: "Color")
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            view.addSubview(blurEffectView)
        }
        else {
            view.backgroundColor = UIColor.black
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            bookPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bookPlayer.play()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        bookPlayer.stop()
        UIApplication.shared.isIdleTimerDisabled = false
    }

}

final class MediaPlayer: UIView {
    
    var booksAudio: Book
    private var player = AVAudioPlayer()
    private var timer : Timer?
    private var playingIndex = 0
    var postIndex: Int?

    
    private lazy var bookName: UILabel = {
         let bookName = UILabel()
        bookName.translatesAutoresizingMaskIntoConstraints = false
        bookName.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 32)
        bookName.textAlignment = .center
        return bookName
     }()
    
    private lazy var bookCover: UIImageView = {
         let bookCover = UIImageView()
        bookCover.translatesAutoresizingMaskIntoConstraints = false
        bookCover.contentMode = .center
        bookCover.clipsToBounds = true
        bookCover.layer.shadowColor = UIColor.black.cgColor
        bookCover.layer.shadowOpacity = 25.0
        bookCover.layer.shadowRadius = 10
        bookCover.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        return bookCover
     }()
    
    private lazy var progressBar: UISlider = {
         let progressBar = UISlider()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
        progressBar.minimumTrackTintColor = UIColor(named: "subtitelColor")
        return progressBar
     }()
    
    private lazy var elapsedTimeLabel: UILabel = {
         let elapsedTimeLabel = UILabel()
        elapsedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        elapsedTimeLabel.font = .systemFont(ofSize: 14 , weight: .light)
        elapsedTimeLabel.text = "00.00"
        return elapsedTimeLabel
     }()
    
    private lazy var remainingTimeLabel: UILabel = {
        let remainingTimeLabel = UILabel()
        remainingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        remainingTimeLabel.textColor = .darkGray
        remainingTimeLabel.font = .systemFont(ofSize: 14 , weight: .light)
        remainingTimeLabel.text = "00.00"
       return remainingTimeLabel
     }()
    
    private lazy var bookNameLabel: UILabel = {
        let bookNameLabel = UILabel()
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameLabel.font = .systemFont(ofSize: 20 , weight: .bold)
        bookNameLabel.textAlignment = .center
        
       return bookNameLabel
     }()
    
    private lazy var aurtherLabel: UILabel = {
        let aurtherLabel = UILabel()
        aurtherLabel.translatesAutoresizingMaskIntoConstraints = false
        aurtherLabel.font = .systemFont(ofSize: 20 , weight: .light)
        aurtherLabel.textAlignment = .center
       return aurtherLabel
     }()
    
    private lazy var previousButton: UIButton = {
         let previousButton = UIButton()
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        previousButton.setImage(UIImage(systemName: "backward.end.fill", withConfiguration: config), for: .normal)
       previousButton.addTarget(self, action: #selector(didTapPrevious(_:)), for: .touchUpInside)
        previousButton.tintColor = .white
        return previousButton
     }()
    
    private lazy var playPlauseButton: UIButton = {
         let playPlauseButton = UIButton()
        playPlauseButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        playPlauseButton.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        playPlauseButton.addTarget(self, action: #selector(didTapPlayPause(_:)), for: .touchUpInside)
        playPlauseButton.tintColor = .white
        return playPlauseButton
     }()
    
    private lazy var nextButton: UIButton = {
         let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        nextButton.setImage(UIImage(systemName: "forward.end.fill", withConfiguration: config), for: .normal)
       nextButton.addTarget(self, action: #selector(didTapNext(_:)), for: .touchUpInside)
        nextButton.tintColor = .white
        return nextButton
     }()
    
    private lazy var controlStack: UIStackView = {
         let controlStack = UIStackView(arrangedSubviews: [previousButton,playPlauseButton,nextButton])
        controlStack.translatesAutoresizingMaskIntoConstraints = false
        controlStack.axis = .horizontal
        controlStack.distribution = .equalSpacing
        controlStack.spacing = 20
        return controlStack
     }()
    
    
    init(album: Book) {
        self.booksAudio = album
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        bookName.text = booksAudio.name
        bookCover.image = UIImage(named: booksAudio.image)
        setupPlayer(song: booksAudio)
     //   setupPlayer(song: album.BooksInfo[playingIndex])
        
        [bookName , bookNameLabel , aurtherLabel , elapsedTimeLabel , remainingTimeLabel].forEach { (v) in
            v.textColor = .white
        }
        
        [bookName, bookCover , bookNameLabel , aurtherLabel, progressBar , elapsedTimeLabel , remainingTimeLabel, controlStack].forEach{(v) in
        addSubview(v)
        }
        setupConstraints()
    }
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            bookName.leadingAnchor.constraint(equalTo: leadingAnchor),
            bookName.trailingAnchor.constraint(equalTo: trailingAnchor),
            bookName.topAnchor.constraint(equalTo: topAnchor, constant: 25),
        ])
        NSLayoutConstraint.activate([
            bookCover.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bookCover.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -16),
            bookCover.topAnchor.constraint(equalTo: bookName.bottomAnchor, constant: 32),
            bookCover.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.5),
        ])
        NSLayoutConstraint.activate([
            bookNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bookNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            bookNameLabel.topAnchor.constraint(equalTo: bookCover.bottomAnchor, constant: 12),
        ])
   
        NSLayoutConstraint.activate([
            aurtherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            aurtherLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            aurtherLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 10),
        ])
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            progressBar.topAnchor.constraint(equalTo: aurtherLabel.bottomAnchor, constant: 8),
        ])
        NSLayoutConstraint.activate([
            elapsedTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            elapsedTimeLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
        ])
        NSLayoutConstraint.activate([
            remainingTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            remainingTimeLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            controlStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            controlStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -32),
            controlStack.topAnchor.constraint(equalTo: remainingTimeLabel.bottomAnchor, constant: 8),
        ])
        
    }
    private func setupPlayer(song: Book) {
        guard let url = Bundle.main.url(forResource: booksAudio.name, withExtension: "mp3")
        else {return
            
        }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
        bookNameLabel.text = song.name
        aurtherLabel.text = song.by
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.prepareToPlay()
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error)
        }
    
    }
    
    func play() {
        progressBar.value = 0.0
        progressBar.maximumValue = Float(player.duration)
        player.play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
        
    }
    func stop() {
        player.stop()
        timer?.invalidate()
        timer = nil
        
    }

    private func setPlayPauseIcon(isPlaying: Bool) {
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        playPlauseButton.setImage(UIImage(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill", withConfiguration: config) , for: .normal)
    }
    
    @objc func updateProgress(_ sender: UISlider){
        progressBar.value = Float(player.currentTime)
        
        elapsedTimeLabel.text = getFormattedTime(timeInterval: player.currentTime)
        let remainingTime = player.duration - player.currentTime
        remainingTimeLabel.text = getFormattedTime(timeInterval: remainingTime)

    }
    
    @objc func progressScrubbed(_ sender: UISlider){
        player.currentTime = Float64(sender.value)
        
    }
    @objc func didTapPrevious(_ sender: UIButton){
        playingIndex -= 1
        if playingIndex < 0 {
            playingIndex = booksAudio.BooksInfo.count - 1
        }
        setupPlayer(song: booksAudio)
    //  setupPlayer(song: album.BooksInfo[playingIndex])
        play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    @objc func didTapPlayPause(_ sender: UIButton){
        if player.isPlaying {
            player.pause()
        }
        else {
            player.play()
        }
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    @objc func didTapNext(_ sender: UIButton){
        playingIndex += 1
        if playingIndex >= booksAudio.BooksInfo.count {
            playingIndex = 0
        }
        setupPlayer(song: booksAudio)
        play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    private func getFormattedTime(timeInterval : TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minsString = timeFormatter.string(from: NSNumber(value: mins)) , let secStr = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00.00"
        }
        return "\(minsString):\(secStr)"
    }
}

extension MediaPlayer: AVAudioPlayerDelegate {
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        didTapNext(nextButton)
    }
}

