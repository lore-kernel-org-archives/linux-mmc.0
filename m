From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 07/16] mmc: renesas_sdhi: use
 MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag
Date: Wed, 7 Feb 2018 20:28:15 +0100
Message-ID: <20180207192815.vdamhm66jheysz2b@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-8-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zo37svggflk3cl6r"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-8-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--zo37svggflk3cl6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:07AM +0900, Masahiro Yamada wrote:
> TMIO_MMC_WRPROTECT_DISABLE is equivalent to MMC_CAP2_NO_WRITE_PROTECT.
>=20
> The flag is propagated as follows:
>        renesas_sdhi_of_data::capabilities2
>     -> tmio_mmc_data::capabilities2
>     -> mmc_host::caps2
>=20
> Only the difference is the TMIO_... makes tmio_mmc_get_ro() return 0
> (i.e. it does not affect mmc_gpio_get_ro() at all), while MMC_CAP2_...
> returns 0 before calling ->get_ro() hook (i.e. it affects both IP own
> logic and GPIO detection).
>=20
> The TMIO MMC drivers do not set-up gpio_ro by themselves.  Only the
> possibility, if any, would be DT specifies "wp-gpios" property, and
> gpio_ro is set by mmc_gpiod_request_ro() called from mmc_of_parse().
> However, it does not make sense to specify "wp-gpios" property and
> TMIO_MMC_WRPROTECT_DISABLE at the same time.
>=20
> I checked under arch/arm/boot/dts/ and arch/arm64/boot/dts/renesas/,
> and I did not see any Renesas boards with "wp-gpios".  So, this
> conversion should be safe.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--zo37svggflk3cl6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7U08ACgkQFA3kzBSg
KbbAXxAAqi8m84Ap+9tgvamODyw7yixxgyMLKqqJKWzHnTz23t/IqCNfFdL9nYSr
t2QSWsKeIXEu2SVh3Hot4T7G3iBKqz1lVh0gFLBxKVBhvT99NGez6+KNVksjbzX6
J8+gkslGDQolKWLbGHWyos7pUn29HKKkV6EWgNuICBN2sh1M7SYAR2nJKL7STS6W
ZXZpJv01NA/sZU9Fzq8Ulvj/Rpn0L5TT+0BnSOjsx5F1dM0Cpgh1wZPL+4dpwbMc
8u/acIvL/22Nopan6kJ9Zdbllmq6h8WHMJvGvWNNcJ5HViqChBQHJfzS6CGhjVWC
dQEWLy/aUN728HG2KgREv9oAOYcYIp4abrqQgyfJrRQV45IloTuffE7PY6Zr9A2R
jIpoe+c9mtDeXWltZJ7LpmKELBO2FccDhlnf8dblx/CT0ZQ90kiF29ZFA6zFxfSM
uOKDdhZS3814h6mAznQGHg71UlSClmO2s8m3zbnr66E1MR8+oLyhlgUTL/inuN+L
1BLJOVzBRqP2BM/UHSPCnNW+OfimKW+HmQuNUYMwWDshScz58EzcB2mpKGXICaSZ
MyFaAGoILFNdGxx3TBZXfe9+RxjnuYawkponvxPyxcbeLj54R5s2ubB3AIFOfgve
QblFrq7w2378BSKmqVm+N240ZUtGoWIU0R9WCMH34Fw6vwL1gvU=
=LSf4
-----END PGP SIGNATURE-----

--zo37svggflk3cl6r--
