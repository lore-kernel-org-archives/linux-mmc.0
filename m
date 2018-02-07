From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 09/16] mmc: tmio: use MMC_CAP2_NO_WRITE_PROTECT
 instead of TMIO own flag
Date: Wed, 7 Feb 2018 20:31:21 +0100
Message-ID: <20180207193121.eeydxcgwweory7c4@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-10-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gddbdaaca34w7fg5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-10-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--gddbdaaca34w7fg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:09AM +0900, Masahiro Yamada wrote:
> TMIO_MMC_WRPROTECT_DISABLE is equivalent to MMC_CAP2_NO_WRITE_PROTECT.
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
> "toshiba,mmc-wrprotect-disable" at the same time.
>=20
> I checked under arch/arm/boot/dts/ and arch/arm64/boot/dts/renesas/,
> and I did not see any Renesas boards with "wp-gpios".  So, this
> conversion should be safe.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

>  static void tmio_mmc_of_parse(struct platform_device *pdev,
> -			      struct tmio_mmc_data *pdata)
> +			      struct mmc_host *mmc)

I like how this cleanups improves things in various parts of the code,
like here. Nice!


--gddbdaaca34w7fg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7VAkACgkQFA3kzBSg
Kbb1jQ/9EXil36iv/xpgBsFCyN+cX/tlqARCX1792u3Pem80vusK1eAHjdDxeYRF
sRpqJeW6Q+BfBbEbir4KhFLUjNmC9CD294ZwsvNQE/tk+HXd5W3UZnSzNl1GRUr4
AgchWls+13MVGv0IbD6Ox2eCXRfbpnjStUrxzxA1uWnHNTMeDGd4NQE+KQJ9HGhE
RR8F+4NtMhyUawssHgFgi5Yt7hZmd+Yo2GZewSOYL+CGAseYIbtHOUqQLej1rRa2
NJLj0G2tZJjxfA3fYqHucr5eOLUSUU6emFPrAJ1WuzpqVHpo38OpUA6KL/jcsqIT
MOn/rGB9r4Nv6dk6F6ek+CIryHDBfHXC+eCZxpDaYECsR38CTp+vu/rGpmFa/U6e
lsHPxVMdSmbd5KLyCWDVi71BEBpuUp1I1HYMTOzejLQDtCLy0AWrLnuM4SQhXLuh
1kK3qMfZD2wnJyH4HZVYgaiMOkov03GkxK0TYUiwGuHThG8XX9daRGkEDXxdqeT5
yQEyPUKqCjrrwIpsAMKGQMIsgG6GMRW91zBDEmEqwhVkIiSUCw0TRP3BB0uTmfYe
Zhr+s3s7boV9C9vsn/qocrQuhkR1oSSHLAOr1dLzL/PkEpc7C1YgLhOpCK3TaqZY
arJd8qtW9VZ5VF5CqlGblyfYVUnH8QjLX4z7k3hD0zGCZkx2jKs=
=3gdZ
-----END PGP SIGNATURE-----

--gddbdaaca34w7fg5--
