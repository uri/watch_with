class MessageLog {

  constructor(dom, channel) {
    this.messageLog = [];
    this.messageLogDom = dom;
    this.channel = channel;
  }

  joinCallback() {
    this.info( this._joinMessage() );
  }

  info (message) {
    this.messageLog.push(message);
    if (this.channel) {
      this.channel.push("new_message", {msg: message})
    }
    if(this.messageLogDom) {
      let el = document.createElement("li");
      el.appendChild( document.createTextNode(message) );
      this.messageLogDom.appendChild( el );
    }
  }

  _joinMessage() {
    return "You have joined the room.";
  }
}

export default MessageLog;
