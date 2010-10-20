From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: sdhci_dumpregs: allow private information to be
	dumped on error
Date: Wed, 20 Oct 2010 13:16:21 +0200
Message-ID: <20101020111621.GA10261@pengutronix.de>
References: <CF727CE6-DAE4-4B18-9BAE-BF373D6DF990@marvell.com> <20101019194724.GC31336@pengutronix.de> <20101019200445.GB28424@void.printf.net> <16B90FE9-6FB8-4FCA-867E-CE40EBF26223@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58956 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab0JTLQZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Oct 2010 07:16:25 -0400
Content-Disposition: inline
In-Reply-To: <16B90FE9-6FB8-4FCA-867E-CE40EBF26223@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Philip,

> sdhci_dumpregs is used to debug the hardware/driver so I do not see an issue
> here.  The register info is not useful to a normal linux user.   We can fine
> tune the timing on the controller so knowing the settings is useful if there
> are CRC errors.

I'd prefer to keep such changes local because they are not needed for a wider
audience. (And adding something to dump_regs is trivial enough.)

Nevertheless, thanks for the suggestion!

Best regards,

   Wolfram

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky+z4UACgkQD27XaX1/VRuOmQCfSlY7dsd1T7YrKIeD/5aiaxI7
rv4AnjMjymxEKR67408ytcmMAoOakRa3
=lDsB
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
