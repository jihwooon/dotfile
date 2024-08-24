local M = {}

M.generate_commit_message = function()
  local prompt = [[
    당신은 코드 변경 사항에 대한 Git Commit을 작성해 주는 리뷰어입니다.
    제공된 diff 코드를 명확하고 간결하게 커밋 메시지로 요약해야 합니다.
  ]] .. "다음 형식을 따라 한국어로 커밋 메시지를 작성해 주세요" .. [[:
  ]] .. [[
    1. 첫 줄은 커밋 제목이며, 50자 이하로 제한하고 명령형으로 작성해야 합니다. (예: "사용자 역할(Role) 엔티티 추가 및 User 엔티티 관계 설정")
  ]] .. [[
    2. 제목 다음에 빈 줄을 하나 넣어주세요.
  ]] .. [[
    3. 그 다음부터는 본문입니다. 본문은 다음 내용을 포함해야 합니다:
      - 변경 사항에 대한 간략한 설명 (2-3줄)
      - "주요 변경사항:" 이라는 제목
      - 번호를 매긴 목록 형태로 주요 변경 사항을 상세히 설명
  ]] .. [[
    4. 각 항목은 가능한 상세하게 작성하되, 전체적으로 간결함을 유지해야 합니다.
  ]]

  return prompt
end

M.generate_prompt = function()
  local prompt = {
    -- Code related prompts
    Explain = "다음 코드가 어떻게 작동하는지 설명해 주세요.",
    Review = "아래 코드를 검토하여 개선사항을 제시해 주시기 바랍니다.",
    Tests =
    "선택된 코드의 작동 방식을 설명하고, 해당 코드에 대한 단위 테스트를 생성해 주세요.",
    Refactor =
    "다음 코드의 명확성과 가독성을 개선하기 위해 리팩토링해 주세요.",
    FixCode = "의도한 대로 작동하도록 다음 코드를 수정해 주세요.",
    FixError = "다음 텍스트의 오류를 설명하고 해결책을 제시해 주세요.",
    BetterNamings = "다음 변수와 함수들의 이름을 더 적절하게 개선해 주세요.",
    Documentation = "다음 코드에 대한 문서를 작성해 주세요.",
    SwaggerApiDocs = "Swagger를 사용하여 다음 API에 대한 문서를 작성해 주세요.",
    SwaggerJsDocs = "Swagger를 사용하여 다음 API에 대한 JSDoc을 작성해 주세요.",
    -- Text related prompts
    Summarize = "다음 텍스트를 요약해 주세요.",
    Spelling = "다음 텍스트의 문법과 맞춤법 오류를 수정해 주세요.",
    Wording = "다음 텍스트의 문법과 표현을 개선해 주세요.",
    Concise = "다음 텍스트를 더 간결하게 다시 작성해 주세요.",
  }
  return prompt
end

return M
