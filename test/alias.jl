@testset "Alias" begin
    @testset "⊕ & ⊙" begin
        # ⨁,⨀ are not ⊕,⊙
        funs = [max, min, +, *, logadd, nlogadd]
        for ⨁ ∈ funs, ⨀ ∈ funs
            ⨁ == ⨀ && continue
            a = Dioid{⨁,⨀}(rand())
            b = Dioid{⨁,⨀}(rand())
            @test a ⊕ b == a + b
            @test a ⊙ b == a * b
        end
    end

    @testset "⊖ & ⨸" begin
        pyt(x,y) = sqrt(x^2 + y^2)
        ipyt(z,y) = sqrt(z^2 - y^2)

        Dioids.inverse(::Val{pyt}) = ipyt
        Dioids.inverse(::Val{ipyt}) = pyt

        funs = [+, *, pyt, ipyt]
        for ⨁ ∈ funs, ⨀ ∈ funs
            ⨁ == ⨀ && continue
            # make sure a > b, so pyt/ipyt can be tested here
            a = Dioid{⨁,⨀}(rand() + 7)
            b = Dioid{⨁,⨀}(rand() + 2)
            @test a ⊖ b == a - b
            @test a ⨸ b == a / b
        end
    end
end

