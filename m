From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency
 constraints
Date: Wed, 7 Mar 2012 20:54:39 +0000
Message-ID: <20120307205439.GM3107@opensource.wolfsonmicro.com>
References: <201203040101.53177.rjw@sisk.pl>
 <201203071005.54890.rjw@sisk.pl>
 <878vjcgn8h.fsf@ti.com>
 <201203072151.07432.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9HASspBA3mgrZm7c"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45211 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755953Ab2CGUym (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Mar 2012 15:54:42 -0500
Content-Disposition: inline
In-Reply-To: <201203072151.07432.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>


--9HASspBA3mgrZm7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 09:51:07PM +0100, Rafael J. Wysocki wrote:

> That would be fine, but it doesn't _conflict_ with a more direct (so to
> speak) knob in sysfs, does it?

Well, perhaps - one of the issues I remember from last time we discussed
this was that there's a tension between the embedded space where the
idea of userspace charging around and playing with low level parameters
to make things hang together is scary and the PC space where the kernel
just isn't going to be able to cope with everyone's systems reliably as
it's got too little information about the hardware.

--9HASspBA3mgrZm7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV8sJAAoJEBus8iNuMP3dUNEP/0l3Luzea7MKrGsA3kIePYsx
zfMPSJ5UwkDYrl7+1D6V8Ulobc4nOLd0fGuB6betd4SJRWB4YJMT9PNnAwHydhQg
IfWeUtLcaqNOSihqJRmvwqdtU17kcUhzHwtS5CNJkbq7TPXcHLEJWfqTMyPAfZIs
i22qhI1aflOd0LUmHQjIrZ7YRvYj31yf1aJdhLiSoig8svKmqBgYhooCKnlWFZbT
MCci2tLJcJcj1tjxFpYtmavREQXhMbwGsZRw6ftQf2kxBkT+win+7AiJXAifwLJQ
qGz45MPlEXz5Ie6dA3Pxlqwof4KZjD5QzLsWFciDobn4ytBwTZcvFSQEYC3oxzYD
JSCvqbbK7bFeAkuWO9ZKy4ye4xUIPUQgOSCpFbb7zeZAsWujuaRGfl0QSQewHCOs
ncf8IRwHyH8QaZMVWTeJIjPq4HaoVu5E1cwqZDP3CyyLkCWX7zUvtJ9kKiH7f+dN
fICrQbAzR6XsEdR0qXZks1m8ITavG5Y2GbNTttgSEnJeEZT7UmY3kSfYf7rMYLet
o5DyHPpsXBuDEhmVReFWNhGbVT5XZNXVOKaYMkCqMDEbNFcBK+60vothDc0jj2+P
OSOtp4oM+8aityVcXwiY4WtVkWMQT5OKPRaz4mvzDCdVbHwwtI8WfDYMPIm+gXVc
BzmNUyywV017D4SN7D0g
=0i/x
-----END PGP SIGNATURE-----

--9HASspBA3mgrZm7c--
