import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: 'Track 01',
      artistName: 'JH DAM',
      albumArtImagePath: 'assets/images/album1.jpg',
      audioPath: '/audio/chill1.mp3',
    ),
    Song(
      songName: 'Track 02',
      artistName: 'Unknow Friend',
      albumArtImagePath: 'assets/images/album2.jpg',
      audioPath: '/audio/chill2.mp3',
    ),
    Song(
      songName: 'Track 03',
      artistName: 'NAME Band',
      albumArtImagePath: 'assets/images/album3.jpg',
      audioPath: '/audio/chill3.mp3',
    ),
  ];

  // current song playing index
  int? _currentSongIndex;

  // GETTERS
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // SETTERS
  set currentSongIndex(int? newIndex) {
    // update current song index
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); // play the song at the new index
    }

    // update UI
    notifyListeners();
  }

  // Audio Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // Constructor
  PlaylistProvider() {
    listenToDuration();
  }

  // initially not playing
  bool _isPlaying = false;

  // play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume song
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to a specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() {
    // if more than 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      // if it's within first 2 seconds of the song, go to previous song
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        // if it's the first song, loop back to the last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // Liston to Durations
  void listenToDuration() {
    // Listen for total Duration
    _audioPlayer.onDurationChanged.listen(
      (newDuration) {
        _totalDuration = newDuration;
        notifyListeners();
      },
    );

    // Listen for current Duration
    _audioPlayer.onDurationChanged.listen(
      (newPosition) {
        _currentDuration = newPosition;
        notifyListeners();
      },
    );

    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
}
