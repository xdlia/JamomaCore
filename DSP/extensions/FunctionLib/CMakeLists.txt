cmake_minimum_required(VERSION 3.0)
project(FunctionLib)

set(PROJECT_SRCS
${CMAKE_CURRENT_SOURCE_DIR}/TTFunctionLib.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTExpFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTFreeHandFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTLinearFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTLogFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTLowpassFunction.cpp    
${CMAKE_CURRENT_SOURCE_DIR}/source/TTPowerFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTSmoothPolynomialFunction.cpp  
${CMAKE_CURRENT_SOURCE_DIR}/source/TTTanhFunction.cpp
  
${CMAKE_CURRENT_SOURCE_DIR}/source/TTQuadraticEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTQuadraticEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTQuadraticEaseInOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTCubicEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTCubicEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTCubicEaseInOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTQuarticEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTQuarticEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTQuarticEaseInOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTQuinticEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTQuinticEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTQuinticEaseInOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTSineEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTSineEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTSineEaseInOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTCircularEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTCircularEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTCircularEaseInOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTExponentialEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTExponentialEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTExponentialEaseInOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTElasticEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTElasticEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTElasticEaseInOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTBackEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTBackEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTBackEaseInOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTBounceEaseInFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTBounceEaseOutFunction.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/TTBounceEaseInOutFunction.cpp
  
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTExpFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTFreeHandFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTLinearFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTLogFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTPowerFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTSmoothPolynomialFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTTanhFunction.test.cpp
  
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTQuadraticEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTQuadraticEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTQuadraticEaseInOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTCubicEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTCubicEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTCubicEaseInOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTQuarticEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTQuarticEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTQuarticEaseInOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTQuinticEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTQuinticEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTQuinticEaseInOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTSineEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTSineEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTSineEaseInOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTCircularEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTCircularEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTCircularEaseInOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTExponentialEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTExponentialEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTExponentialEaseInOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTElasticEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTElasticEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTElasticEaseInOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTBackEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTBackEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTBackEaseInOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTBounceEaseInFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTBounceEaseOutFunction.test.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tests/TTBounceEaseInOutFunction.test.cpp
)

include_directories("${PROJECT_SOURCE_DIR}/includes")

file(GLOB_RECURSE PROJECT_HDRS ${CMAKE_CURRENT_SOURCE_DIR}/includes/*.h)
add_jamoma_extension()

if(BUILD_JAMOMAPD)
        install(TARGETS ${PROJECT_NAME}
                        DESTINATION "${JAMOMAPD_INSTALL_FOLDER}/Jamoma/support"
                        COMPONENT JamomaPd)
endif()
