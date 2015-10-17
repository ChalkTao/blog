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
      $scope.labels = res.labels || []
      $http 
        url: '/admin/labels.json'
        method: 'GET'
      .success (res)->
        $scope.all_labels = res

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

  $scope.addLabel = (label)->
    target = $scope.all_labels.indexOf(label)
    if target > -1
      $scope.all_labels.splice(target, 1)
    $scope.labels.push(label)

  $scope.removeLabel = (label)->
    target = $scope.labels.indexOf(label)
    if target > -1
      $scope.labels.splice(target, 1)
    $scope.all_labels.push(label)

]
