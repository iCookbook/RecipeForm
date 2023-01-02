Pod::Spec.new do |s|
  s.name             = 'RecipeForm'
  s.version          = '0.1.0'
  s.summary          = 'RecipeForm module of the Cookbook app.'
  s.homepage         = 'https://github.com/htmlprogrammist/RecipeForm'
  s.author           = { 'htmlprogrammist' => '60363270+htmlprogrammist@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/iCookbook/RecipeForm.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'RecipeForm/Sources/**/*'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'RecipeForm/Tests/**/*.{swift}'
  end
end
