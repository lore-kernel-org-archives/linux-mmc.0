From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Fri, 17 Jan 2014 10:02:14 +0100
Message-ID: <20140117090214.GA2348@piout.net>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54509 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751064AbaAQJCW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 04:02:22 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote :
> "for SDIO slots" is somewhat misleading; nearly all controllers only
> do one slot/device per controller. The designware controller can do
> multiple slots, and that adds a bit of driver and binding complexity
> for something that seemingly not a single vendor has actually
> implemented.
>=20
> So we can likely assume to keep these reset/power/clock lines per host
> controller, no need to add a slot construct.
>=20

Actually, the atmel chips have two slots per controller so it would
probably be better to think about that now.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJS2PGWAAoJEKbNnwlvZCyzSBEP/0JHmP/zpGSGeDiRaDNVz+9p
VcNNBWGRt4yJPCtdk6TdXTfZ5kNVgT5Ms0aIXvnu0OCkvYY803vlQL9SnehB2uYW
mlQb4BS+DaqsQfLoPTjTzpwzHRB8xy88/tsOS5CNmyNd348g5yRTYOVCVRSWRRDP
FTE/tKfnpNRXpbs9MgaMqNhbqGjseaNMrTldoyR/4KJDSOUy+agD4WDJRbHVfFy8
g0iIu0XxUC3bJnamUz/NHn4sJjY71zZa3opSG+LaxtpdHwDHvwIK8i8ENKy2/hhV
1NL9WKR2OeIGVkm6fliL1TxSExXmy2mAoggbDAeZ/gWLLV4CWcdU4jcEIrDwVKVK
kAVMaqGbGpCgLO5Xicmep46XBFaCYCj2paKYVnq1w4pRQDVG7lEz3S7K73SlmSHa
zOWBz9j6KB2PepT86EBgkqK9P2gbqc3hkwj9kzYp5MZncw61u7VsND+n+M42DY2+
pgtixZPdy4bfWJB/VBJzmL3G/vwuVIHEDGunCttu++5caL5ieNUnMs4doFwvuaSh
4omVnNZgC9B5+izI6hW/jcRVQp+jfY00kXgpLRDEJ9fIwPh4YYygXI6ZF/ie3ZbV
o1VdxMrtiL2Djk6iQ1UjDhKZGNU2JBZoq6zWQ11qndVZwGrCk9Z9DNLfJI6uALmy
X6ypETd/FmCiLBQCrBa+
=Kc9H
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
