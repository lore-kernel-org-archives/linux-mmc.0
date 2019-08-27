From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6 boards by
 disabling DDR
Date: Tue, 27 Aug 2019 15:32:11 +0200
Message-ID: <20190827133211.g5n4uasyz2yvjpjr@flea>
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lkjtz2d6pscj5wie"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alejandro =?utf-8?B?R29uesOhbGV6?= <alejandro.gonzalez.correo@gmail.com>
Cc: ulf.hansson@linaro.org, wens@csie.org, linus.walleij@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org


--lkjtz2d6pscj5wie
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2019 at 05:05:58PM +0200, Alejandro Gonz=E1lez wrote:
> Some Allwinner H6 boards have timing problems when dealing with
> DDR-capable eMMC cards. These boards include the Pine H64 and Tanix TX6.
>
> These timing problems result in out of sync communication between the
> driver and the eMMC, which renders the memory unsuable for every
> operation but some basic commmands, like reading the status register.
>
> The cause of these timing problems is not yet well known, but they go
> away by disabling DDR mode operation in the driver. Like on some H5
> boards, it might be that the traces are not precise enough to support
> these speeds. However, Jernej Skrabec compared the BSP driver with this
> driver, and found that the BSP driver configures pinctrl to operate at
> 1.8 V when entering DDR mode (although 3.3 V operation is supported), whi=
le
> the mainline kernel lacks any mechanism to switch voltages dynamically.
> Finally, other possible cause might be some timing parameter that is
> different on the H6 with respect to other SoCs.

This should be a comment in the driver where this is disabled.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lkjtz2d6pscj5wie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWUw2wAKCRDj7w1vZxhR
xYt3AP4+3qKwy0ckh4dZ7jCoxIsKTjo6Lg7T9mmsX0KTdpD3uAD/UnDk8+qHwDox
MZfS8s6gYu/gIOndKMAIAGQBPJh+bgU=
=Cii8
-----END PGP SIGNATURE-----

--lkjtz2d6pscj5wie--
