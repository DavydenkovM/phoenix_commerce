import React, { Component, PropTypes } from 'react'
import { Link } from 'react-router'

export default class Product extends Component {
  render() {
    const { price, quantity, name, description, image } = this.props
      return (
        <div> 
          <Link to='qwe'> {name} </Link>
          <h4> {price} </h4>
          <img src={image}></img>
          <p>{description}</p>
        </div>
      )
  }
}

Product.propTypes = {
  price: PropTypes.string,
  quantity: PropTypes.number,
  name: PropTypes.string
}
