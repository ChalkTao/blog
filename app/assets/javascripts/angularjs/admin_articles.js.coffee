@app.controller 'AdminArticlesController', [ '$scope', '$http', '$location', '$timeout', '$cookies', '$sce', ($scope, $http, $location, $timeout, $cookies, $sce)->

  $scope.body_active = true

  $scope.init = (id)->
    url = '/admin/articles/' + id + '.json'
    $http
      url: url
      method: 'GET'
    .success (res)->
      $scope.title = res.title
      $scope.content = res.content

  $scope.changeToBody = ->
    $scope.body_active = true

  $scope.changeToPreview = ->
    $scope.body_active = false
    $scope.previewHTML = 'Loading...'
    $http.post '/admin/articles/preview', { content: $scope.content }
    .success (res)->
      $scope.previewHTML = res

  $scope.trustAsPreviewHTML = ()->
    $sce.trustAsHtml($scope.previewHTML)

  $scope.addTag = (e)->
    new_labels= $(e.target).text()
    if $scope.labels
      $scope.labels += ", #{new_labels}"
    else
      $scope.labels = new_labels
]
