
## 목적
재사용이 가능하도록 모듈화 하여 인프라를 논리적인 유닛으로 구성할 수 있도록 한다

## 아이디어
- module 이 추가되었을 다, 추가된 모듈만 github action workflow 를 태운다

## 모듈의 디렉토리 구조
모듈 생성시, 지켜야하는 디렉토리 구조에 대한 컨벤션은 다음과 같다
```
module
  - examples
  - test
  - main.tf
  - verions.tf
  - variables.tf
  - outputs.tf
  - .terraform-docs.yml
```

## ToDo
- 변경된 모듈만 이벤트를 트리거해서 github action 워크플로우를 태울 수 있는 방안
- 모듈을 Terraform Registry 에 자동 배포 기능
- 테스트

