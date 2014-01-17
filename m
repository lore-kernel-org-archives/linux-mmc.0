From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Fri, 17 Jan 2014 10:39:10 +0100
Message-ID: <20140117093909.GB2348@piout.net>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <20140116195819.GY15937@n2100.arm.linux.org.uk>
 <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54708 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750937AbaAQJjN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 04:39:13 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 12:00:47PM -0800, Olof Johansson wrote :
> On Thu, Jan 16, 2014 at 11:58 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote:
> >> We've dealt with it with local code in our tree for Chrome OS, and I
> >> suspect everyone else has too. It's definitely time to solve
> >> generically.
> >
> > As there's no code for any Cubox-i or Hummingboard (they're both purely
> > DT), what this means is that the answer to Wifi/BT support in mainline =
is
> > that this is "impossible at the moment"...
> >
> > I guess this is becoming a higher priority issue which really needs to =
be
> > solved somehow. :)
>=20
> I'm looking at it right now actually, might as well sort it out while
> people are paying attention. Patches a little later today unless I get
> distrac^Winterrupted. :)
>=20

Maybe it is not completely related but I think it needs to be thought
about while you are it:

The TI wilink chips (TiWi, wl12xx, wl18xx) have wifi on SDIO and BT on
UART but they share the same clock. So, the next question would be what
if I just want to enable one or the other (and take that decision at
runtime) ?

Where do I put the pinctrl/clocks/regulators in the DT ? I guess it can
become an issue to enable both WiFi and BT at the same time if both SDIO
and UART are trying to handle the same pinctrl and regulators.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJS2Po9AAoJEKbNnwlvZCyz758P/1QhvVi+qHo0brigdq618gmz
EwC6giiGgRgNO2hUC5VsmOWFySY+uiAXRZC+i4n5CynWF0CfIAfbW/Wp2UIakkk+
ZNZqFchjByQQyClomIWS28ZRn9ImhTKH8PJd2k+7Isw4I7HbVzE5k+MAlRCd/sMq
QJ/V5JD7GcM9rmLQTGaq/fGAiWkq2zf15dF9/96bbSuDmmrcI5GsvcuteJ5AyOYJ
GF6SQDcEs/dMq6zQ44IfmI+f/fQ1fyEUWYIVYsOiufcf0+9bFtOlkymjYR1Wtdyo
Moo4CaJjcC2HNQB6vh93yieq3nLVGSZqIK8gEbHlwRFmAk2jQheNBYlNswwyzRMu
OZIQFJybwJAGepvdDg/oUi5BiMo0BW8jrntaogjhB2cyRM1DgVNU7zqv+EB3C6UT
EPSXVQcESkgXRpaSz1NlCi0oNzIiTpBT62pR8nJ8MbQksw3XgIV+uPCbd+XR+Kv1
KRpK2zDRosogyJr/zDaFiQAtTtRxY3kJBNqiaCv1lWdBwhtgNVr+UuV1d/LfoVfC
D476BFMNBeXsgJatHWtkosT0h5pBLoZ9ItzYXIqJTELiyILNstTXHJKGe6HAq0II
VnlKT1BhLipK5VR5ds62vHpTexr2QfH4cFUbTTKbv2TcPI/4BfGqQ15dNe62A6PA
KGUzYIE2uly5IcBv5lP9
=ytnz
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
