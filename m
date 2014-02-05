From: Mark Brown <broonie@kernel.org>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Wed, 5 Feb 2014 17:11:21 +0000
Message-ID: <20140205171121.GE32298@sirena.org.uk>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <20140116195819.GY15937@n2100.arm.linux.org.uk>
 <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
 <20140117093909.GB2348@piout.net>
 <20140117104423.GR17530@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36369 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbaBERLo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Feb 2014 12:11:44 -0500
Content-Disposition: inline
In-Reply-To: <20140117104423.GR17530@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2014 at 11:44:23AM +0100, Andrew Lunn wrote:

> I've not looked at regulators, but i would hope it also does reference
> counting of a regulators users.

Yes, it does.

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8nC2AAoJELSic+t+oim9h1YP/02/tJg8pq4/+I+qY2Vayq+S
UgqnpVEIXFtK0eUpDdsK8/e7tcLtHSoG8sr+834tGOlu/+iCLeO8XssExxYvXw5P
UJ1EFv0Y7+36Pf1t7bMBilc7CQ+PtgVjsbbQcmoKmwACOjjRv2/Wjq9Ygeww53Ro
gYmFRIPI6fK9T98wLEjkaxuNRKvdLVQuV8f3+SqlDIVIHA169wkjGOGe0Sf98l7k
IueFsS+NclrujsPt2lnIAPZEbbt780mcsKrBUSS4WKA/A4EBGB9V3uxtxnRrVuF2
F/zSyQMLgIqlstvJiUWY3JYAzc6p549wXxbLca2a2tprJzbsdgTJ10Rt3QP/dSy6
nEZzqb1kjrV0c0pVYSSTC9hKQZmKrlG2oVZFNPqduOXvP3JfdB7T2uddY3xYw5zl
vaszvfXLzWax/ThJ0MdpFA5P0wgF39MeCocMj84M9ZWijCS9jOavt+nplcDnX/0K
YDYRTg8T05i/akcHmev6XPig5TtqxYYZ6FgEDBUmnJHyCe4N12WSn5uOxpYr/AzZ
uj3duLfirfs25xEaSkBqGKk/4QUSME/c6EJHMBM5lj7I47SUcQlfCFhJq5UdtcyH
0sD0itYKdUWqvijwJNqMP4zXktH1eY+Ge55NLyP3e2Alnf8uxt9Z1j5KasmenuCe
SFasDM5w3jJ1E4i4CnaO
=t7hw
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
