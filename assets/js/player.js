let Player = {
  player: null,
  channel: null,
  user_id: null,

  init(domId, videoId, user_id, channel) {
    this.user_id = user_id;
    this.channel = channel;

    this.channel.on("new_state", resp => {
      let state = resp.event_code
      let ctime = resp.current_time;

      console.log("Seeking to " );
      console.log(ctime);
      this.player.seekTo(ctime);
      this.player.playVideo();
    })

    window.onYouTubeIframeAPIReady = () => {
      console.log("Initializing the message")
      this.onIframeReady(domId, videoId);
    };

    let firstScriptTag = document.getElementsByTagName("script")[0];
    let tag = document.createElement("script");
    tag.src = "//www.youtube.com/iframe_api";
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
  },

  onIframeReady(domId, videoId) {
    console.log("These are the parameters: " + domId + ", " + videoId);
    console.log(domId);
    this.player = new YT.Player(domId, {
      height: '390',
      width: '640',
      videoId: videoId,
      events: {
        'onReady': (event => this.onPlayerReady(event)),
        'onStateChange': (event => this.onPlayerStateChange(event))
      }
    })
  },

  onPlayerReady(event) {
    this.player.playVideo();
  },

  onPlayerStateChange(event) {
    if (event.data == 1) {
      let ctime = this.player.getCurrentTime();
      console.log("setting time to " + ctime)
        this.channel.push("state_change", {
          user_id: this.user_id,
          new_state: event.data,
          current_time: ctime
        })
    }
  },

  createBindings(buttonId) {
    let button = document.getElementById(buttonId);
    button.addEventListener("click", e => {

      e.preventDefault();
    });
  },

  setLogger(logger) {
    this.logger = logger;
  },

  info(message) {
    if (this.logger) {
      this.logger.info( message );
    }
  }
};

export default Player;
