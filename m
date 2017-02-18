From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
Subject: Re: [PATCH v2 6/9] mmc: meson-gx: remove unneeded meson_mmc_clk_set
 in meson_mmc_clk_init
Date: Sat, 18 Feb 2017 04:44:31 +0100
Message-ID: <ef2944b5-e04c-780b-6256-31af7ceb87dc@poczta.onet.pl>
References: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
 <fc824f91-f686-64ab-83e4-86b04fd512f0@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pcqxk3RKqbCvbK1Ahog6v6j839ug4EB5q"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtpo35.poczta.onet.pl ([213.180.142.166]:33420 "EHLO
        smtpo35.poczta.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdBREEr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2017 23:04:47 -0500
In-Reply-To: <fc824f91-f686-64ab-83e4-86b04fd512f0@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pcqxk3RKqbCvbK1Ahog6v6j839ug4EB5q
Content-Type: multipart/mixed; boundary="JIqjKFHAMwghUSlaSrO7uxqUcuuvemIqF";
 protected-headers="v1"
From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Message-ID: <ef2944b5-e04c-780b-6256-31af7ceb87dc@poczta.onet.pl>
Subject: Re: [PATCH v2 6/9] mmc: meson-gx: remove unneeded meson_mmc_clk_set
 in meson_mmc_clk_init
References: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
 <fc824f91-f686-64ab-83e4-86b04fd512f0@gmail.com>
In-Reply-To: <fc824f91-f686-64ab-83e4-86b04fd512f0@gmail.com>

--JIqjKFHAMwghUSlaSrO7uxqUcuuvemIqF
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello Heiner,

W dniu 16.02.2017 o 20:42, Heiner Kallweit pisze:
> This clk_disable_unprepare isn't right here. At first the condition
> should be "if (ret)" as the disable/unprepare is supposed to be
> executed if the previous command fails.
> And if the previous command fails and meson_mmc_clk_init returns
> an error, then probe jumps to label free_host where we have this
> disable/unprepare already.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - extended commit message
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-g=
x-mmc.c
> index 68e76fa8..850b0152 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -320,11 +320,7 @@ static int meson_mmc_clk_init(struct meson_host *h=
ost)
>  	/* Get the nearest minimum clock to 400KHz */
>  	host->mmc->f_min =3D clk_round_rate(host->cfg_div_clk, 400000);
> =20
> -	ret =3D meson_mmc_clk_set(host, host->mmc->f_min);
> -	if (!ret)
> -		clk_disable_unprepare(host->cfg_div_clk);
> -
> -	return ret;
> +	return meson_mmc_clk_set(host, host->mmc->f_min);
>  }
> =20
>  static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *io=
s)
>=20

I see one problem here.
As you said, if the previous command (that is the meson_mmc_clk_set
function call) fails, then the whole meson_mmc_clk_init returns an error
value, and meson_mmc_probe jumps to free_host and disables the clock ther=
e.
But what happens if the clk_prepare_enable is the line that fails? in
this case, the function returns an error value too, and in the free_host
meson_mmc_probe tries to disable the clock that is not enabled, and that
probably results in a kernel warning because you tried to disable a
disabled clock.
I was preparing a patch to disable clocks in the probe function only if
they were enabled before, but then the meson_mmc_clk_init function
remains a problem, because we don't know if the clock was enabled
successfully or not when it returns an error.


--JIqjKFHAMwghUSlaSrO7uxqUcuuvemIqF--

--pcqxk3RKqbCvbK1Ahog6v6j839ug4EB5q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAEBCAA5FiEE8PeJXyv9t1Bfiq63mRxoPZnIFPkFAlinwyEbHHdlYmN6YXRf
MjAwQHBvY3p0YS5vbmV0LnBsAAoJEJkcaD2ZyBT5IaIIALn/SYhtVTMMNoyaVgwx
Dq0PipAMK5XGzVNYLtITk1Ey7GjmqDwXfp7LRRbDiVRiNI8GHO3BLVLwnrc0rRVr
KeKJbzX4uI/Bx7DGqnsEawMe3B7oB0BVhR6oKiVCPm++6WljpTNAA/zkLr1nJ5d7
YzLvaFy2o+RpOgVKbCngRU3sJrO2YZS43YxPlufK6iHOjm9RClVJEmQtipVZMRhH
FtpLHm5hOO0Q9UPUANiaMbkmVk9ca4iPHcT9xbr3SKO3Ya4p0Ezmfrsm90HnplWb
AlQbohbPd4PIPtl0sFviKJ/PGWe4tcb4M4kjIIcaBLXoS8AIqTWbf2KHAmdyMc2q
ldU=
=J22d
-----END PGP SIGNATURE-----

--pcqxk3RKqbCvbK1Ahog6v6j839ug4EB5q--
