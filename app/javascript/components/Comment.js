import React from "react"
import PropTypes from "prop-types"
class Comment extends React.Component {
  render () {
    return (
      <React.Fragment>
        <li className="progress-content">
          {this.props.content}<br/>
          {this.props.time} 投稿者：{this.props.user}
        </li>
      </React.Fragment>
    );
  }
}

Comment.propTypes = {
  content: PropTypes.string,
  time: PropTypes.string,
};
export default Comment
