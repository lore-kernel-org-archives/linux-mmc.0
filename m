From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v10 15/15] ARM: dts: sun7i: Add basic support for the
 Cubietruck WiFi module
Date: Sun, 4 May 2014 23:02:12 -0500
Message-ID: <20140505040212.GC11606@lukather>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35353 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750982AbaEEEFM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 May 2014 00:05:12 -0400
Content-Disposition: inline
In-Reply-To: <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 05:57:29PM +0200, Hans de Goede wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The WiFi
> part is a BCM43362 IC connected to MMC3 in the A20 SoC via SDIO.
> The IC also takes a power enable signal via GPIO.
>=20
> The WiFi module supports out-of-band interrupt signaling via GPIO,
> but this is not supported in this patch.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

It doesn't have Chen-Yu SoB. Chen-Yu, are you fine with adding it?

No need to respin the set, I'll add it when applying if it's ok.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTZw1EAAoJEBx+YmzsjxAgGDgP/RdSkxqfd9PZsrqZ0uhSQdJz
qM+lAmdlw48ZG74fu2/ZEeBaDKcikaKp3IMveqD0f5lNRD11kfSSI8AnhZ2fMf4k
Bid+n6ETXTwYJ8g22o2CC6y95oZhUwvl36juweOB4ro6qVG9rKm+Bt4+wLg3QMs6
QaXWOe26GaomzBckyz6r7c8W2qYvbwus5YPwBs60qOJQJKysmckOmk586NLdSl1G
glXVD1Y5EcYpYs/sTqMBNOwkftHIGwWBp53RsFdiG99z9YmCyizMboM6Ccr++FpU
+JIJ1CVmRgHbN3bKXYLSQwT/9vTebfLmCP+Oy0+s70xgBrjtBCwKsltlnlRONreA
IMRHd45geDgkhua1zld0sSZz0lDsbTiKhVFrZbMWZI9nWKtQEcpfsSmFXkEbynn8
zpLtvqjHTO5IdixPUT6efupCmsf6Qu2c/wSQRp33iOg25nakDLw7tD5KaA5DBzag
Yku6cJBJV7Qwf/vbyznUnlgOokzpgV3txNIeYHZhOoH34JiQgQWiAYo4d/XUjaOD
hmGILZJ9VwwrXm8+0J34jd2Wj0tepHcuwv2pRBTehuJRa23rUs/WIkTqBGeq1VTu
SOkVFDzpB0jTcFHTpXPP6DY+K2LBIGE1bTc/RkGZLgpnMKTboDnjU0IDVB0evOga
uXuSDsjn7cBNQvpKiBVK
=c/z9
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
