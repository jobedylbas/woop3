# Podfile

platform :ios, '13.0'
use_frameworks!

target 'WoopSicredi3' do
    pod 'RxSwift', '6.2.0'
    pod 'RxCocoa', '6.2.0'
end

# RxTest and RxBlocking make the most sense in the context of unit/integration tests
target 'WoopSicredi3Tests' do
    inherit! :search_paths
    pod 'RxBlocking', '6.2.0'
    pod 'RxTest', '6.2.0'
end
