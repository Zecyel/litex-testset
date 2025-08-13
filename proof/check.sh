#!/bin/bash

# 初始化计数器
total_tests=0
passed_tests=0
failed_tests=0

echo "开始检查所有证明文件..."
echo "=================================="

# 函数：运行测试并检查结果
run_test() {
    local file=$1
    local test_name=$(basename "$file" .lix)
    total_tests=$((total_tests + 1))
    
    echo -n "测试 $test_name: "
    
    # 运行litex命令并捕获输出
    output=$(litex -f "$file" 2>&1)
    exit_code=$?
    
    # 检查是否包含"Success! :)"
    if echo "$output" | grep -q "Success! :)"; then
        echo "✓ 通过"
        passed_tests=$((passed_tests + 1))
    else
        echo "✗ 失败"
        # echo "  输出: $output"
        failed_tests=$((failed_tests + 1))
    fi
}

# 运行所有测试
run_test ./absolute_value_definition.lix
run_test ./absolute_value_division.lix
run_test ./absolute_value_identity.lix
run_test ./absolute_value_inequality_greater.lix
run_test ./absolute_value_inequality_less.lix
run_test ./additive_cancellation.lix
run_test ./am_gm_inequality.lix
run_test ./archimedean_property.lix
run_test ./binomial_theorem.lix
run_test ./cartesian_product_distributive_intersection.lix
run_test ./cartesian_product_distributive_union.lix
run_test ./circle_area.lix
run_test ./circle_circumference.lix
run_test ./complement_empty.lix
run_test ./complement_universal.lix
run_test ./complex_conjugate.lix
run_test ./complex_modulus.lix
run_test ./componendo.lix
run_test ./componendo_dividendo.lix
run_test ./congruence_addition.lix
run_test ./congruence_multiplication.lix
run_test ./congruence_reflexive.lix
run_test ./congruence_symmetric.lix
run_test ./congruence_transitive.lix
run_test ./constant_function_property.lix
run_test ./contrapositive.lix
run_test ./cross_multiplication.lix
run_test ./cube_difference.lix
run_test ./cube_sum.lix
run_test ./demorgan_law_generalized.lix
run_test ./demorgans_law_logic.lix
run_test ./density_rationals.lix
run_test ./difference_of_cubes.lix
run_test ./difference_of_squares.lix
run_test ./disjoint_sets.lix
run_test ./distributive_law_logic.lix
run_test ./dividendo.lix
run_test ./division_algorithm.lix
run_test ./division_definition.lix
run_test ./division_sign_rules.lix
run_test ./double_negative.lix
run_test ./empty_set_intersection.lix
run_test ./eulers_formula.lix
run_test ./eulers_totient.lix
run_test ./even_function_property.lix
run_test ./even_plus_even.lix
run_test ./even_plus_odd.lix
run_test ./even_root_nonnegative.lix
run_test ./even_times_integer.lix
run_test ./exponent_difference.lix
run_test ./exponent_fractional.lix
run_test ./exponent_negative.lix
run_test ./exponent_product_base.lix
run_test ./exponent_quotient.lix
run_test ./exponent_quotient_base.lix
run_test ./exponent_zero.lix
run_test ./factorization_integers.lix
run_test ./fermats_little_theorem.lix
run_test ./fraction_division.lix
run_test ./fraction_simplification.lix
run_test ./fraction_subtraction.lix
run_test ./function_composition_associative.lix
run_test ./gcd_lcm_relation.lix
run_test ./greatest_common_divisor.lix
run_test ./identity_function.lix
run_test ./implication_equivalence.lix
run_test ./inequality_addition_different_signs.lix
run_test ./inequality_antisymmetry.lix
run_test ./inequality_chain.lix
run_test ./infinite_geometric_series.lix
run_test ./least_common_multiple.lix
run_test ./linear_function_property.lix
run_test ./logarithm_base_change.lix
run_test ./logarithm_power.lix
run_test ./logarithm_product.lix
run_test ./logarithm_quotient.lix
run_test ./mathematical_induction.lix
run_test ./mixed_number_conversion.lix
run_test ./modular_arithmetic.lix
run_test ./multiplication_sign_rules.lix
run_test ./multiplicative_cancellation.lix
run_test ./negative_fraction.lix
run_test ./odd_function_property.lix
run_test ./odd_plus_odd.lix
run_test ./odd_root_sign.lix
run_test ./odd_times_odd.lix
run_test ./opposite_of_product.lix
run_test ./opposite_of_sum.lix
run_test ./pigeonhole_principle.lix
run_test ./power_set_property.lix
run_test ./product_roots_quadratic.lix
run_test ./pythagorean_theorem.lix
run_test ./quadratic_residue.lix
run_test ./quadratic_vertex.lix
run_test ./reciprocal_inequality_negative.lix
run_test ./reciprocal_of_reciprocal.lix
run_test ./reciprocal_product.lix
run_test ./reverse_triangle_inequality.lix
run_test ./root_of_square.lix
run_test ./root_product.lix
run_test ./root_quotient.lix
run_test ./set_antisymmetry.lix
run_test ./set_difference_empty.lix
run_test ./set_difference_self.lix
run_test ./set_intersection_associativity.lix
run_test ./set_partition.lix
run_test ./set_reflexivity.lix
run_test ./set_union_associativity.lix
run_test ./set_union_distributive.lix
run_test ./similar_triangles.lix
run_test ./square_difference.lix
run_test ./square_nonnegative.lix
run_test ./square_sum.lix
run_test ./strict_inequality_transitivity.lix
run_test ./subset_intersection.lix
run_test ./subset_union.lix
run_test ./subtaction_definition.lix
run_test ./sum_arithmetic_series.lix
run_test ./sum_geometric_series.lix
run_test ./sum_of_cubes.lix
run_test ./symmetric_difference.lix
run_test ./transitive_divisibility.lix
run_test ./triangle_angle_sum.lix
run_test ./triangle_inequality_three.lix
run_test ./universal_set_union.lix
run_test ./vector_cross_product.lix
run_test ./vector_dot_product.lix
run_test ./well_ordering_principle.lix
run_test ./zero_product_inequality.lix

# 输出统计结果
echo "=================================="
echo "测试完成！"
echo "总测试数: $total_tests"
echo "通过: $passed_tests"
echo "失败: $failed_tests"

if [ $failed_tests -eq 0 ]; then
    echo "🎉 所有测试都通过了！"
    exit 0
else
    echo "❌ 有 $failed_tests 个测试失败"
    exit 1
fi