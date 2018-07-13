$('#editmaterials').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget)
  var prodname = button.data('prodname')
  var id = button.data('id')
  var uom = button.data('uom')
  var bar = button.data('bar')
  var store = button.data('store')
  var prc = button.data('prc')

  var modal = $(this)
  modal.find('.modal-body #id').val(id)
  modal.find('.modal-body #prod').text(prodname)
  modal.find('.modal-body #bar').val(bar)
  modal.find('.modal-body #str').val(store)
  modal.find('.modal-body #prc').val(prc)

  var uom = document.getElementById('uom');
  var opts = uom.options;
  for (var opt, j = 0; opt = opts[j]; j++) {
    if (opt.value == uom) {
      uom.selectedIndex = j;
      break;
    }
  }
})