From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Tue, 27 Mar 2012 11:14:25 +0200
Message-ID: <20120327091425.GC6790@pengutronix.de>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327090148.GB6790@pengutronix.de>
 <20120327110615.3bfaf969@eb-e6520>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35477 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757839Ab2C0JO2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 05:14:28 -0400
Content-Disposition: inline
In-Reply-To: <20120327110615.3bfaf969@eb-e6520>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: joancarles <joancarles@fqingenieria.es>, Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Interesting question is now why it worked on your older kernel? The code
> > around BROKEN_TIMEOUT is there for much longer, I'd think.
> >=20
> not in fact it seems to have been broken from a long time and I think

I know and you are saying the same, in fact :) Your patch came in around
2.6.37 and here it was said that 2.6.39 works fine. Might be random,
though.

> because unlike the i.MX35 it seems that the i.MX25 manages to read
> properly the partition table even without the timeout quirk and it
> seems that I didn't do more extensive tests for this patch.

Please do next time.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9xhPEACgkQD27XaX1/VRs7lwCgxPN88PX2jwi7mId1SQF9cWu4
cpkAoKQ2+LKCet/lyzMMQE2ijKzlaAp6
=chu2
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
