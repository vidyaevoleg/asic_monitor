const API = {
  machines: {
    update (params, success, error) {
      return Rails.ajax({
        type: 'PUT',
        url: '/api/machines/' + params.id,
        data: objectToFormData({machine: params}),
        success: success,
        error: error
      })
    },
    create (params, success, error) {
      return Rails.ajax({
        type: 'POST',
        url: '/api/machines',
        data: objectToFormData({ machine: params }),
        success: success,
        error: error
      })
    },
    updateTemplate (params, success, error) {
      return Rails.ajax({
        type: 'PUT',
        url: '/api/machines/' + params.id + '/update_template',
        data: objectToFormData({template: params}),
        success: success,
        error: error
      })
    },
    delete (id, success) {
      return Rails.ajax({
        type: 'DELETE',
        url: '/api/machines/' + id,
        success: success
      })
    },
    reboot (id, success, error) {
      return Rails.ajax({
        type: 'PUT',
        url: '/api/machines/' + id + '/reboot',
        success: success,
        error: error
      })
    }
  }
}

export default API;
