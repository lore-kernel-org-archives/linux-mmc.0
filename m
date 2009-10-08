From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: 70a3341a71 broke omap_hsmmc?
Date: Thu, 8 Oct 2009 11:24:30 +0200
Message-ID: <20091008092430.GA22561@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49156 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725AbZJHJZX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2009 05:25:23 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Matt Fleming <matt@console-pimps.org>, Ian Molton <ian@mnementh.co.uk>, "Roberto A. Foglietta" <roberto.foglietta@gmail.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Pierre Ossman <pierre@ossman.eu>, Philip Langdale <philipl@overt.org>, Madhusudhan <madhu.cr@ti.com>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hello,

commit 70a3341a711f27ae77714ae7dd360a4e7e2d5e7c changed registering of
omap_hsmmc_host from using platform_driver_probe to using
platform_driver_register.  But omap_hsmmc_driver doesn't have a probe
entry.  So I expect that the driver doesn't bind correctly.

The fix is either convert back to platform_driver_probe or (add
platform_driver_probe to omap_hsmmc_driver and move it to section
=2Edevinit.text).

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
