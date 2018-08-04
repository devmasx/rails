require 'erb'
rails_versions = %w[
  5.2.1.rc1
  5.2.0
  5.2.0.rc2
  5.2.0.rc1
  5.2.0.beta2
  5.2.0.beta1
  5.1.6
  5.1.5
  5.1.5.rc1
  5.1.4
  5.1.4.rc1
  5.1.3
  5.1.3.rc3
  5.1.3.rc2
  5.1.3.rc1
  5.1.2
  5.1.2.rc1
  5.1.1
  5.1.0
  5.1.0.rc2
  5.1.0.rc1
  5.1.0.beta1
  5.0.7
  5.0.6
  5.0.6.rc1
  5.0.5
  5.0.5.rc2
  5.0.5.rc1
  5.0.4
  5.0.4.rc1
  5.0.3
  5.0.2
  5.0.2.rc1
  5.0.1
  5.0.1.rc2
  5.0.1.rc1
  5.0.0.1
  5.0.0
  5.0.0.rc2
  5.0.0.rc1
  5.0.0.racecar1
  5.0.0.beta4
  5.0.0.beta3
  5.0.0.beta2
  5.0.0.beta1.1
  5.0.0.beta1
  4.2.10
  4.2.10.rc1
  4.2.9
  4.2.9.rc2
  4.2.9.rc1
  4.2.8
  4.2.8.rc1
  4.2.7.1
  4.2.7
  4.2.7.rc1
  4.2.6
  4.2.6.rc1
  4.2.5.2
  4.2.5.1
  4.2.5
  4.2.5.rc2
  4.2.5.rc1
  4.2.4
  4.2.4.rc1
  4.2.3
  4.2.3.rc1
  4.2.2
  4.2.1
  4.2.1.rc4
  4.2.1.rc3
  4.2.1.rc2
  4.2.1.rc1
  4.2.0
  4.2.0.rc3
  4.2.0.rc2
  4.2.0.rc1
  4.2.0.beta4
  4.2.0.beta3
  4.2.0.beta2
  4.2.0.beta1
  4.1.16
  4.1.16.rc1
  4.1.15
  4.1.15.rc1
  4.1.14.2
  4.1.14.1
  4.1.14
  4.1.14.rc2
  4.1.14.rc1
  4.1.13
  4.1.13.rc1
  4.1.12
  4.1.12.rc1
  4.1.11
  4.1.10
  4.1.10.rc4
  4.1.10.rc3
  4.1.10.rc2
  4.1.10.rc1
  4.1.9
  4.1.9.rc1
  4.1.8
  4.1.7.1
  4.1.7
  4.1.6
  4.1.6.rc2
  4.1.6.rc1
  4.1.5
  4.1.4
  4.1.3
  4.1.2
  4.1.2.rc3
  4.1.2.rc2
  4.1.2.rc1
  4.1.1
  4.1.0
  4.1.0.rc2
  4.1.0.rc1
  4.1.0.beta2
  4.1.0.beta1
  4.0.13
  4.0.13.rc1
  4.0.12
  4.0.11.1
  4.0.11
  4.0.10
  4.0.10.rc2
  4.0.10.rc1
  4.0.9
  4.0.8
  4.0.7
  4.0.6
  4.0.6.rc3
  4.0.6.rc2
  4.0.6.rc1
  4.0.5
  4.0.4
  4.0.4.rc1
  4.0.3
  4.0.2
  4.0.1
  4.0.1.rc4
  4.0.1.rc3
  4.0.1.rc2
  4.0.1.rc1
  4.0.0
  4.0.0.rc2
  4.0.0.rc1
  4.0.0.beta1
]

DOCKERHUB_REPOSITORY = 'devmasx/rails'.freeze
# you need login in docker hub
def docker_push(tag)
  system("docker push #{DOCKERHUB_REPOSITORY}:#{tag}")
end

def docker_build(tag)
  system("docker build -t #{DOCKERHUB_REPOSITORY}:#{tag} .")
end

def dockerfile_build(version)
  template = ERB.new(File.read('Dockerfile.erb'))
  result = template.result(binding)
  File.open('Dockerfile', 'w') { |file| file.write(result) }
  puts "build Dockerfile #{version}"
end

rails_versions.each do |version|
  # tag_name = base_image.split(':').last
  dockerfile_build(version)
  docker_build(version)
  # docker_push(version)
end
