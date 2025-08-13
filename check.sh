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
run_test ./proof/absolute_value_definition.lix
run_test ./proof/absolute_value_division.lix
run_test ./proof/absolute_value_identity.lix
run_test ./proof/absolute_value_inequality_greater.lix
run_test ./proof/absolute_value_inequality_less.lix
run_test ./proof/additive_cancellation.lix
run_test ./proof/am_gm_inequality.lix
run_test ./proof/archimedean_property.lix
run_test ./proof/binomial_theorem.lix
run_test ./proof/cartesian_product_distributive_intersection.lix
run_test ./proof/cartesian_product_distributive_union.lix
run_test ./proof/circle_area.lix
run_test ./proof/circle_circumference.lix
run_test ./proof/complement_empty.lix
run_test ./proof/complement_universal.lix
run_test ./proof/complex_conjugate.lix
run_test ./proof/complex_modulus.lix
run_test ./proof/componendo.lix
run_test ./proof/componendo_dividendo.lix
run_test ./proof/congruence_addition.lix
run_test ./proof/congruence_multiplication.lix
run_test ./proof/congruence_reflexive.lix
run_test ./proof/congruence_symmetric.lix
run_test ./proof/congruence_transitive.lix
run_test ./proof/constant_function_property.lix
run_test ./proof/contrapositive.lix
run_test ./proof/cross_multiplication.lix
run_test ./proof/cube_difference.lix
run_test ./proof/cube_sum.lix
run_test ./proof/demorgan_law_generalized.lix
run_test ./proof/demorgans_law_logic.lix
run_test ./proof/density_rationals.lix
run_test ./proof/difference_of_cubes.lix
run_test ./proof/difference_of_squares.lix
run_test ./proof/disjoint_sets.lix
run_test ./proof/distributive_law_logic.lix
run_test ./proof/dividendo.lix
run_test ./proof/division_algorithm.lix
run_test ./proof/division_definition.lix
run_test ./proof/division_sign_rules.lix
run_test ./proof/double_negative.lix
run_test ./proof/empty_set_intersection.lix
run_test ./proof/eulers_formula.lix
run_test ./proof/eulers_totient.lix
run_test ./proof/even_function_property.lix
run_test ./proof/even_plus_even.lix
run_test ./proof/even_plus_odd.lix
run_test ./proof/even_root_nonnegative.lix
run_test ./proof/even_times_integer.lix
run_test ./proof/exponent_difference.lix
run_test ./proof/exponent_fractional.lix
run_test ./proof/exponent_negative.lix
run_test ./proof/exponent_product_base.lix
run_test ./proof/exponent_quotient.lix
run_test ./proof/exponent_quotient_base.lix
run_test ./proof/exponent_zero.lix
run_test ./proof/factorization_integers.lix
run_test ./proof/fermats_little_theorem.lix
run_test ./proof/fraction_division.lix
run_test ./proof/fraction_simplification.lix
run_test ./proof/fraction_subtraction.lix
run_test ./proof/function_composition_associative.lix
run_test ./proof/gcd_lcm_relation.lix
run_test ./proof/greatest_common_divisor.lix
run_test ./proof/identity_function.lix
run_test ./proof/implication_equivalence.lix
run_test ./proof/inequality_addition_different_signs.lix
run_test ./proof/inequality_antisymmetry.lix
run_test ./proof/inequality_chain.lix
run_test ./proof/infinite_geometric_series.lix
run_test ./proof/least_common_multiple.lix
run_test ./proof/linear_function_property.lix
run_test ./proof/logarithm_base_change.lix
run_test ./proof/logarithm_power.lix
run_test ./proof/logarithm_product.lix
run_test ./proof/logarithm_quotient.lix
run_test ./proof/mathematical_induction.lix
run_test ./proof/mixed_number_conversion.lix
run_test ./proof/modular_arithmetic.lix
run_test ./proof/multiplication_sign_rules.lix
run_test ./proof/multiplicative_cancellation.lix
run_test ./proof/negative_fraction.lix
run_test ./proof/odd_function_property.lix
run_test ./proof/odd_plus_odd.lix
run_test ./proof/odd_root_sign.lix
run_test ./proof/odd_times_odd.lix
run_test ./proof/opposite_of_product.lix
run_test ./proof/opposite_of_sum.lix
run_test ./proof/pigeonhole_principle.lix
run_test ./proof/power_set_property.lix
run_test ./proof/product_roots_quadratic.lix
run_test ./proof/pythagorean_theorem.lix
run_test ./proof/quadratic_residue.lix
run_test ./proof/quadratic_vertex.lix
run_test ./proof/reciprocal_inequality_negative.lix
run_test ./proof/reciprocal_of_reciprocal.lix
run_test ./proof/reciprocal_product.lix
run_test ./proof/reverse_triangle_inequality.lix
run_test ./proof/root_of_square.lix
run_test ./proof/root_product.lix
run_test ./proof/root_quotient.lix
run_test ./proof/set_antisymmetry.lix
run_test ./proof/set_difference_empty.lix
run_test ./proof/set_difference_self.lix
run_test ./proof/set_intersection_associativity.lix
run_test ./proof/set_partition.lix
run_test ./proof/set_reflexivity.lix
run_test ./proof/set_union_associativity.lix
run_test ./proof/set_union_distributive.lix
run_test ./proof/similar_triangles.lix
run_test ./proof/square_difference.lix
run_test ./proof/square_nonnegative.lix
run_test ./proof/square_sum.lix
run_test ./proof/strict_inequality_transitivity.lix
run_test ./proof/subset_intersection.lix
run_test ./proof/subset_union.lix
run_test ./proof/subtaction_definition.lix
run_test ./proof/sum_arithmetic_series.lix
run_test ./proof/sum_geometric_series.lix
run_test ./proof/sum_of_cubes.lix
run_test ./proof/symmetric_difference.lix
run_test ./proof/transitive_divisibility.lix
run_test ./proof/triangle_angle_sum.lix
run_test ./proof/triangle_inequality_three.lix
run_test ./proof/universal_set_union.lix
run_test ./proof/vector_cross_product.lix
run_test ./proof/vector_dot_product.lix
run_test ./proof/well_ordering_principle.lix
run_test ./proof/zero_product_inequality.lix

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