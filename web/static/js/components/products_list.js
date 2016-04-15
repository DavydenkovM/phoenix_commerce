import React, { Component, PropTypes } from 'react'
import { connect } from 'react-redux';

class ProductsList extends Component {
  render() {
    console.log(this.props);

    return (
      <div>
        <h3>{this.props.title}</h3>
        <ul className="products">{this.props.children}</ul>
      </div>
    )
  }
}

ProductsList.propTypes = {
  children: PropTypes.node,
  title: PropTypes.string.isRequired
}

export default ProductsList;
