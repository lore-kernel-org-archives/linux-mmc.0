From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 3/7] regulator: add pbias regulator support
Date: Thu, 9 Jan 2014 17:27:08 +0000
Message-ID: <20140109172708.GF12858@sirena.org.uk>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
 <1389279062-32291-1-git-send-email-balajitk@ti.com>
 <1389279062-32291-4-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50275 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbaAIR1S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 12:27:18 -0500
Content-Disposition: inline
In-Reply-To: <1389279062-32291-4-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, tony@atomide.com, mark.rutland@arm.com


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 08:20:58PM +0530, Balaji T K wrote:
> pbias register controls internal power supply to sd card i/o pads
> in most OMAPs (OMAP2-5, DRA7).
> Control bits for selecting voltage level and
> enabling/disabling are in the same PBIAS register.

Acked-by: Mark Brown <broonie@linaro.org>

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSztvpAAoJELSic+t+oim9tOUP/2o1yIzavcRzvOLn3MKQqBhD
rvAA1z4Vni7rlSksAYn6ed8OjNJY9YGGzfql/Rj/253gjzeahmKW9nd3b1LuspDJ
JxjzChNbID0RCFI+rAuoerQkiAzyk2/nSrycQPnklHdPWBqQx5b+9FBEU+m9HYqs
BLWF61w+iF3pU0np94JV5Lq5m+hAKUQGzks25QuFnmtRoDHKDLZpHWGoVFUSJhCb
6xjOVlv6qhaY3/GaCPv2D8CGlpbOc2pQGwXnoneFP2H5HHBPiieUJET3dpFqIQ6o
FvOSzSS3MGzhRegXUdgQoniJa+iyElTjvBzMTRRUJ5ISMuG8fgk3Nxn9bt3mf0JI
dsEUyKhudiYF/dvf9aVvSJ6+tzA8ccZF/6wa7foet8nXvfbmKU8d3p36nnkKuabY
4nTcq/GWnr/4MAZ+9ELjzVmT8lbhlKHTCQnWqPXogisyMpOYyMHQMNPrmw3mHGwy
4gLDB+wudfBH666gWgiMULrmymFz6Q1MfD4o5q5Tes4GwxGWSasEzdmepoac3bMx
9reu0T8TCDKRBiiVO2CbEzqeDaAlsTgGjgU5fUojd8aNc+uEuV+MmjEWCYZSaPJ8
uH1Okvq9P37MyoV1wlv7lE/V/WpEki3yY0SKyy00oimIV24F9x3ya+8vT1RRlrMC
XNS0CaIdFprRMcLBmSwq
=rg6u
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
