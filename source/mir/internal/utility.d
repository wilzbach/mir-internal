module mir.internal.utility;

import std.traits;
import std.meta;

import mir.ndslice.slice;

alias Iota(size_t j) = Iota!(0, j);

template Iota(size_t i, size_t j)
{
    static assert(i <= j, "Iota: i should be less than or equal to j");
    static if (i == j)
        alias Iota = AliasSeq!();
    else
        alias Iota = AliasSeq!(i, Iota!(i + 1, j));
}

enum isSimpleSlice(S) = is(S : Slice!(N1, T1[]), size_t N1,T1) || is(S : Slice!(N2, T2*), size_t N2,T2);

template realType(C)
{
    static if (isComplex!C)
        alias realType = typeof(Unqual!C.init.re);
    else
        alias realType = Unqual!C;
}

template isComplex(C)
{
    enum bool isComplex
     = is(Unqual!C == creal)
    || is(Unqual!C == cdouble)
    || is(Unqual!C == cfloat);
}

enum isVector(V) = is(V : T1[], T1) || is(V : Slice!(1, T2*), T2);
enum isMatrix(M) = is(M : Slice!(2, T*), T);
