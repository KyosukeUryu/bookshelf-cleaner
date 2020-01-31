import React from "react"
import PropTypes from "prop-types"

import Timestamp from "react-timestamp"

class Comment extends React.Component {
  render () {
    return (
      <React.Fragment>
        <li className="progress-content">
          {this.props.content}<br/>
          投稿者：{this.props.user}<br/>
          <Timestamp relative date={this.props.time} precision={3} />
        </li>
      </React.Fragment>
    );
  }

  componentDidMount() {
    var self = this;
    setInterval(function() { self.forceUpdate() }, 5000);
  }
}

Comment.propTypes = {
  content: PropTypes.string,
  time: PropTypes.string,
};
export default Comment
