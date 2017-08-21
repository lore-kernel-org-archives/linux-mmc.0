From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Mon, 21 Aug 2017 13:33:39 +0200
Message-ID: <20170821113339.GA3790@katana>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
 <1503311897-18807-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503311897-18807-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	  Below is the number clocks for each supported SoC:
> -	   1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
> -	      R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
> -	   2: R7S72100
> +	  Most supported SoCs only have 1 clock. Devices which have more
> +	  than 1 clock are listed below:
> +	  2: R7S72100"

I like this, but stray " at the end of the line?

With that fixed:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmaxQ4ACgkQFA3kzBSg
KbaIfQ//daNIHt5Al+PXloMKlBubGkAbsmcg5g3Qx4kBdEMI1fQUncpFPC8go1Sg
HUsn1aW0FLNVcB5JWfNvZzrPVkkVdURVC3QhQPwRIDTotB/lLPE9exTytScWBht8
cuY7LLI6uAE8zaoETNoJftGV4uAxifngQ2Q6e2Fr/pwDzZZiMIcXE1T6KXLxNLt/
EUiCe4rxNMoecRQEsIiA1FwxiA6JFK1aADfuR72wdMesSbiRlIpykjwUphCkSE7H
tivmn0WSbuGQl7mVrj+9m1GiKL3sm7KL4/hpYD/zlYvX6naulx1JSPX2PUHWoXTW
aLeng0lTMDQs/EdgHhfuGjWO/LfNdWPjxL+q4ShBiJnE8vc6sDQEL9IY09EFIZCb
lZtAqS1n0tv3mXMP9oyIftdDGHwUOHDbOO3nyghRh9E8G+t/zo4iGKEhmmyrOKZU
Wb821QwAI/ILWLKSuEPYFMvPJE7L7UGnJjt8izIsAuTieOk623MihLz9opaZn6aW
NRWjrZLFkQTMVylL0FEexxN3JkNB3GMZhkxlkV5SaTyiH/aMI/+uEWTouedsxCtg
0o4K1W5vf8Mx/tMq3WkD9CNTqFarglTtjJS6U7qYkVmywT9omT1BxD/UsTaS39R6
d9x7BTNFDY5klVs1ULU1LKm+nScOaC/71x2PnT9StKybOyOydhE=
=DY+8
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
