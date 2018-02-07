From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 08/16] sh: kfr2r09: use MMC_CAP2_NO_WRITE_PROTECT
 instead of TMIO own flag
Date: Wed, 7 Feb 2018 20:28:54 +0100
Message-ID: <20180207192854.fnzanswn52zm6es3@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-9-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qryj6jou2wpnfecu"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-9-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-sh-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--qryj6jou2wpnfecu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:08AM +0900, Masahiro Yamada wrote:
> TMIO_MMC_WRPROTECT_DISABLE is equivalent to MMC_CAP2_NO_WRITE_PROTECT.
>=20
> The flag is propagated as follows:
>     tmio_mmc_data::capabilities2 -> mmc_host::caps2
>=20
> Only the difference is the TMIO_... makes tmio_mmc_get_ro() return 0
> (i.e. it does not affect mmc_gpio_get_ro() at all), while MMC_CAP2_...
> returns 0 before calling ->get_ro() hook (i.e. it affects both IP own
> logic and GPIO detection).
>=20
> The TMIO MMC drivers do not set-up gpio_ro by themselves, so gpio_ro
> is obviously unused by legacy boards like this.  So, this conversion
> should be safe.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--qryj6jou2wpnfecu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7U3YACgkQFA3kzBSg
Kbbwjw/7BOZTH8WCzr0tdfHQhYR61u6eShFWFx2Ow4SiRxP2P3qGE46XoAvSeJ9h
wL08flsd2kXBOjlhTxWolZjZPjqB+PYpb3RhL5Hd5SCyeGRyEjRP6ZMsY0vHPz9V
3QgV8eaHXUJlHtTrNwoChpaJRZzV/0uvX4wGoUTr2LHoyRogtqUrw6de3NPVdB0+
KZornPKsbHYqic8/PXw4iHM0XlFt8Qh+WdCEA6NSc/9tiCSDc/bGccfzLYrloCyI
tfdFP1RBdY3HemK9ZyfHbelT5Fm3EEolbkhq1heLVk+81NudVp9T3bpTlhEVKO2I
7UF4VXPGV8CVYXfaA592F56cTHwJrKr4AVj7DeTA2ls6e4SeDu+aPjM9+oru26mJ
5eW7zuDfQxPMHkSbdYAAN2vGe3+Dfe8VoiC1K9frQBaFDCc2i97cj+2Yg+5YbdPM
B/fGaY7U4NGlKjLsLHX5drqteeDOepziAwtmt/vpGugGRnyWCj45ndcrdA9cB5PO
GKz9CQ2O91lp/UKWSwUjc+pkJiQSXS7CKvTsmQ64Rhdtmb49rDTl+dWGiR/QksGb
3sF3Xs23jHzjh/UaosEF9eupKyQYfMgmxMnqm4vkWG5bJlU8uBh+17Jox1bJo77l
wCo0iwYSIyP3t48kqa82eWewTy+Qob9ol19Y+9KpRtr86bEFFMY=
=VhT6
-----END PGP SIGNATURE-----

--qryj6jou2wpnfecu--
