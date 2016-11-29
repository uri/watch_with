let Player = {
  player: null,

  init(domId, videoId) {
    window.onYouTubeIframeAPIReady = () => {
      this.onIframeReady(domId, videoId);
    };

    let firstScriptTag = document.getElementsByTagName("script")[0];
    let tag = document.createElement("script");
    tag.src = "//www.youtube.com/iframe_api";
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
  },

  onIframeReady(domId, videoId) {
    this.player = new YT.Player(domId, {
      height: '390',
      width: '640',
      videoId: 'M7lc1UVf-VE',
      events: {
        'onReady': this.onPlayerReady,
        'onStateChange': this.onPlayerStateChange
      }
    })
  },

  onPlayerReady(event) {
    event.target.playVideo();
  },

  onPlayerStateChange(event) {

  },
}

export default Player;
