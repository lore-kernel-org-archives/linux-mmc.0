From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
Date: Mon, 15 Oct 2018 09:33:40 +0200
Message-ID: <20181015073339.GB981@kunai>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <20181014223311.GE3260@kunai>
 <CAK7LNATPf4mEdH16eZzLg4x3tP-jvXcTWqqY0DgCpmGjt9x9zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNATPf4mEdH16eZzLg4x3tP-jvXcTWqqY0DgCpmGjt9x9zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Some sub-systems rebase, and some do not.
> It is up to the sub-system maintainer.

We used to have a very strict rule to not rebase anything which ends up
in linux-next. Dunno what happened to this rule but I liked it.

> I know what you are saying, but this is how we develop in linux-next.

I wonder about that...

> You need to use "git rebase --onto".

And what about lists with commit IDs tracking patches on their way
upstream? Yes, there is git-patch-id, yet I think it is easier to admit
that incremental changes happen anyway. I know Ulf view differs...


--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvEQtMACgkQFA3kzBSg
KbZW7A//SzoiU+7yrnHZTjCTQrhFvyBb/Fwz05y53DBDUH5XsQ+nzDlM0PcjShMT
/b2SrsgzL76oKEdvOVp/KmXcirg9NcZz/qV2AilNpjCZRjYZhur5KR+0UgWr8MdH
cxTZB9yJHw9xYugHMZlZtLK6rilwPgNy7aaUdwUbD195LndxH2xG+nSKPtipV5xb
BkDZjKHQcFiKbXF7h7afMQDyC8tmyj+h41q3sKTgeOekUMjghccq5cLncFbuiaXr
/ktKuBLj2ozRd5YIRx0IE7ZlAWwz673chyWJDLr7AVRFIsxhY4P+NtE2vJDKmoiP
ouP/KgkQEHfaSoPTDQsl4XWE851Sx/pmOW6lztwGy8yJbzhSDc32hLDvMp/9ZSnz
SBInUWgMrawj/wEv/cO/MZk+gN84Ak0eA/5RiBXD/zNfHWX7pgJTDfEnjxRnCHB1
XIAMqQL2jXYQmoJ/17FjmdaNHIAMb0myoJfCNhwKGLYw89ARTfb+4Hj4yzTnsD8D
urKTN2v4LVm7ILPdyzl2lqKr7ODCG+KI2n3EPxuUK8jK/BV8m3zLFkoFCbT0cSxx
f1r3pzvdzfA5RwxxJxIrVnpbA5/vQlfkFNrqnGzXBNTEuZxXNnYEYyqCgOTOx8fw
vVtr0b6FqiSb8WJQaVJs8WhkVrh3VvdUafGXV6YUPEzxexRhuB8=
=Xd4A
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
