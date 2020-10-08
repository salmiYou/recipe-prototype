import DS from 'ember-data';

const { attr, belongsTo, hasMany, Model } = DS;

export default Model.extend({
  name:             attr('string'),
  authorTip:       attr('string'),
  prepTime:        attr('string'),
  cookTime:        attr('string'),
  image:            attr('string'),
  rate:             attr('number'),
  difficulty:       attr('number'),
  peopleQuantity:  attr('number'),
  nbComments:      attr('number'),

  author:       belongsTo('author'),
  tags:         hasMany('tag'),
  ingredients:  hasMany('ingredient'),

});
