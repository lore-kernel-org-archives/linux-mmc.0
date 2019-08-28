From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some
 H6 boards by disabling DDR
Date: Wed, 28 Aug 2019 15:43:34 +0200
Message-ID: <20190828134334.qzuwodoxmw7ov5yg@flea>
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
 <CACRpkdazfe3gJr6Q+X05GzxPuKtUg0M780SPA_oR5bd+-xBPvA@mail.gmail.com>
 <CAGb2v67e8EiS-LUuhAyPc57nWd4iOBEWC_SZbH801Lzi4QWGyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v6flhv747vrdixqb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v67e8EiS-LUuhAyPc57nWd4iOBEWC_SZbH801Lzi4QWGyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Alejandro =?utf-8?B?R29uesOhbGV6?= <alejandro.gonzalez.correo@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-mmc@vger.kernel.org


--v6flhv747vrdixqb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 09:29:32PM +0800, Chen-Yu Tsai wrote:
> On Wed, Aug 28, 2019 at 8:52 PM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >
> > On Sun, Aug 25, 2019 at 5:06 PM Alejandro Gonz=E1lez
> > <alejandro.gonzalez.correo@gmail.com> wrote:
> >
> > > Jernej Skrabec compared the BSP driver with this
> > > driver, and found that the BSP driver configures pinctrl to operate at
> > > 1.8 V when entering DDR mode (although 3.3 V operation is supported),=
 while
> > > the mainline kernel lacks any mechanism to switch voltages dynamicall=
y.
>
> AFAIK The Pine H64 does not have the ability to switch I/O voltages. It is
> fixed to either 1.8V (the default based on the schematics) or 3.3V.

Should that be handled at the board level then maybe?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--v6flhv747vrdixqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWaFBgAKCRDj7w1vZxhR
xUbcAQDTgCwVjSWuZKxoSkt/fp1VLfWi1UjCpSZ0cCr11a5BwAD8DLgodYfexZWL
iW8NfsUfcOV7SktdFUgfMP1x74uruwE=
=sxYW
-----END PGP SIGNATURE-----

--v6flhv747vrdixqb--
