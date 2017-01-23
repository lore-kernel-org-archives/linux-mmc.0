From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 0/13] arm64: allwinner: a64: Enable MMC support
Date: Mon, 23 Jan 2017 11:58:42 +0100
Message-ID: <20170123105842.37q23ecxecrjr6so@lukather>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cen64qteailglgvu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56821 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWK64 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2017 05:58:56 -0500
Content-Disposition: inline
In-Reply-To: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>


--cen64qteailglgvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Mon, Jan 16, 2017 at 05:56:50PM +0100, Maxime Ripard wrote:
> Hi,
>=20
> Here is a new attempt at getting the MMC controllers running, following t=
he
> work done by Andre.
>=20
> This has been tested on a board with one SDIO device (a Marvell WiFi chip)
> and a Kingston eMMC with 1.8V IOs.
>=20
> For SDIO, the HS DDR mode works just fine. That serie also enables the
> SDR104 mode to work on the devices that are capable of this.
>=20
> For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
> moment, but since it's significantly more complex, and at the same time
> Allwinner recommends to limit its frequency to 100MHz, this doesn't have
> any benefits. If there's any at some point, this can be added later.

Unless you have objections, I'd really like this to be in
4.11. There's a bunch of things where I'm not entirely sure
(especially the clock gating part), it would be great if you could
have a look.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--cen64qteailglgvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYheHdAAoJEBx+YmzsjxAgyQIQAKO+Cd2sHm89WDnMnWxoroP0
QpMpRWV3uh97m+Ju2PjAHEn2+vds+L2/PJXHcnNgPgVtwZ2RtDg2uPfcWqPfJzuU
MDYG1LwJJrew7mal8JKwrYA6OyEONTb9EWXQ1GZLsCOX2uVwkrnL+kfLDaUM4tFX
wfFcuDbCMTiSJIKfTQFu+2VyEiWOG/9aFPLbH3HHEg2uHK86CQriutTBM7+lh3A3
DFcaWtkJz4qFmZAOQVIQ1pPS97mASjRpaQhXovtIOME3n6WwEI7MYWLrCYepQCaj
SocVeCahyWfe1HhasiDPXG9lpaXF7ZF8koTXtpeBzbYnKUlSO0zwkbUXtBUsqqfS
Y2j18rjap5o/46DFlgWJ/Ttd0jWITcLmKk8ZMfPYeuxn/qEqfUJ2Rj2u0iqx5UOM
tyFtegUn1ZnhveT2vbyboALYuboXzprR/ZHov26KFt6FLG9wG8IWuuHEYgKfehoa
e89rkFSbjjzf0Zztmf92mFfARd7M+85m3k1voVJDSRfGEsNJA79IUI0kR5aok4Qj
CCxZn3kutfbqLnPBD7D32rDiNdRRExZk7xP+a/qODR6K3NJ5SaEluhbbXI0iMxnd
QDIMYyo/DJsbmGyuph4OV/vzPtuSyjbodVAgn7wC2wMqpa4yQswoGVA6co/02pOk
YFtcP844EyuDqgUeYs6U
=ip82
-----END PGP SIGNATURE-----

--cen64qteailglgvu--
