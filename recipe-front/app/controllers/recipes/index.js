import Controller from '@ember/controller';
import { run } from '@ember/runloop';

export default Controller.extend({
  searchFieldValue: null,

  _seachRecipes(term) {
    this.set('isLoading', true);
    if (term.length == 0) {
      this.set('model', []);
    }
    else {
      this.store.query('recipe', { filter: term, page: 1 })
          .then(recipes => {
            this.set('isLoading', false);
            this.set('model', recipes);
          });
    }
  },

  actions: {
    searchRecipes() {
      run.debounce(this, this._seachRecipes, this.get('searchFieldValue'), 500);
    }
  }
});