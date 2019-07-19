using ModularIndicies
using Test, OffsetArrays

@testset "0-d" begin
    A = fill(1)
    @test A[Mod(5)] == 1
    @test A[Mod(-1)] == 1
    @test A[Mod(2:3)] == [1, 1]
    @test A[Mod(2, 30)] == [1, 1]

    A[Mod(2)] = 2
    @test A[] == 2
end

@testset "1-d" begin
    A = 1:10
    @test A[Mod(11)] == A[1]

    A = collect(1:5)
    A[Mod(7)] = 0
    @test A == [1,0,3,4,5]
    
    A = rand(10)
    @test A[Mod(11)] == A[1]
    @test A[Mod(11:15)] == A[1:5]

end

@testset "2-d" begin
    A = rand(5,5)
    @test A[Mod(11), 2] == A[1, 2]
    @test A[2, Mod(11)] == A[2, 1]

    @test A[Mod(11:12), 2] == A[1:2, 2]
    @test A[Mod(11,12), 1] == A[1:2, 1]


    A = OffsetArray(reshape(-10:13,3,:), -1, 0)
    # axes(A) == (Base.IdentityUnitRange(0:2), Base.IdentityUnitRange(1:8))
    @test A[Mod(3), 1] == A[0, 1]
    @test A[0, Mod(9)] == A[0, 1]
end


@testset "Invalid constructions" begin
    @test_throws MethodError Mod(1.5)
    @test_throws MethodError Mod([1.5, 2.5])
    @test_throws MethodError Mod(1.5, 2.5)
    @test_throws MethodError Mod(1:.1:2)
    @test_throws MethodError Mod((1,2,3))
end
