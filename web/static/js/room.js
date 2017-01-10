import socket from "./socket"
import Player from "./player"
import MessageLog from "./message_log"



let Room = {
  roomId: null,
  message_log: null,
  user_id: null,

  init(roomId) {
    this.roomId = roomId;

    socket.connect();
    this.channel = socket.channel("room:" + roomId, {});
    this.channel.join()
      .receive("ok", resp => {
        const playerDomId = "player";
        let videoId = document.getElementById(playerDomId).getAttribute("data-video-id");
        this.user_id = resp.user_id;
        Player.init(playerDomId, videoId, this.user_id, this.channel);
        this.message_log = new MessageLog( this.messageLogDom, this.channel );
        this.message_log.joinCallback();
        this.message_log.info("Your user ID is " + this.user_id)
      })
      .receive("error", resp => { console.log("Could not join the channel") });

      this.channel.on("new_message", resp => {
        this.message_log.info(resp.msg);
      });

  },

  setLogging(dom) {
    this.messageLogDom = dom;
  },

  joinCallback(resp) {
  }
}

export default Room;
