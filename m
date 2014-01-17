From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Fri, 17 Jan 2014 11:14:56 +0100
Message-ID: <20140117101456.GD2348@piout.net>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <20140116195819.GY15937@n2100.arm.linux.org.uk>
 <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
 <20140117093909.GB2348@piout.net>
 <CAGb2v640Qeb60dMq2kH6M6NqkVbdUh1JcCus3a7D7icQeDdKNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54910 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750775AbaAQKPF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 05:15:05 -0500
Content-Disposition: inline
In-Reply-To: <CAGb2v640Qeb60dMq2kH6M6NqkVbdUh1JcCus3a7D7icQeDdKNg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Olof Johansson <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2014 at 06:06:41PM +0800, Chen-Yu Tsai wrote :
> On Fri, Jan 17, 2014 at 5:39 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Maybe it is not completely related but I think it needs to be thought
> > about while you are it:
> >
> > The TI wilink chips (TiWi, wl12xx, wl18xx) have wifi on SDIO and BT on
> > UART but they share the same clock. So, the next question would be what
> > if I just want to enable one or the other (and take that decision at
> > runtime) ?
>=20
> Some Broadcom chips (BCM4329/4330) and the AP6210 found on CubieTruck
> are like this as well. In our case, the SD/MMC host driver hasn't been
> mainlined yet. But BT on UART is independent and usable.
>=20
> > Where do I put the pinctrl/clocks/regulators in the DT ? I guess it can
> > become an issue to enable both WiFi and BT at the same time if both SDIO
> > and UART are trying to handle the same pinctrl and regulators.
>=20
> Shouldn't the clocks and regulators be registered in the DT _AS_ clocks
> and regulators? fixed-regulator already accepts GPIO lines. fixed-rate-cl=
ock
> mentions GPIOs in DT bindings, but doesn't seem to use them in the code.
> We'd still need a device to tie them to, especially in the UART use case.
>=20

Yeah, I meant if you tie your clock/pinctrl/reset/regulator to both the
BT and the WiFI nodes because it is shared, you'll at least get a
warning or one of the two won't be working.

> Or we could try rfkill devices. Not saying it's the correct way, but it is
> a solution.
>=20

You'll get the same issue there. Two rfkill devices sharing the same
clock or reset for example.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJS2QKfAAoJEKbNnwlvZCyz0zUP/j988Zb8a8pjqzTpgAZHwB9P
3ggwAfjeDZCl04Bs0wRleFmS1m30FpcIxpyE5PlnMU0BBQgMThx4t0f0CdxXK05j
clufckWZqTRcMo7f3TCjP34l7uxJl4vwrkbKJsS+vnSC8whkny1zgvW95oR0QvOa
9pdTzCMPA8nJbHe+lWZf6gGyeb9z/pxHqMXv1gPFMm3T5SFCTu7Ky4QFKGw5N45U
saOAog+y6RRabpM1dN98PFyDm99wP6y6HmV+zl0D+CLRrWykrb446rLZ3UEHtJLI
xsvdSl/Wwy4VYIwZOLNLB1eG6iLwtMj3x+IhsxdUBnson8Pkn1bjes7E5+q+eO4B
48Zz4z6ESajosKsCK1oRdzRmL7crV/kcuhJwq535Ef28UJKkO742HKYafuYo3vZO
AN+wn5PisXGtcpoTz7YRUE20XliAJPdyjvreWtrgJvbWEIvEkjtJsmED2uvwVnWc
BN0q2HZGSbFO73Y4AMHTuiwURJqv+kQNKdqpZweuO90UOMEwdFxAP1zosCxdWg1Z
cSWhMY3SnXKfWFpfumTh66z6pqYwLTbqHBTCdbkiPvgOGqVnYhaTQ9lecZInFi5q
Z9Rwc+52TBAErcwOfr2CQO/bHLQ35V1ig6Bs+OY8BCGJzkx/4mfhLP1gzOTkkXtQ
op8MMh80FfwIHeZve8lj
=ROgt
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
