From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Fri, 9 Sep 2011 15:08:55 +0200
Message-ID: <20110909130855.GR1912@pengutronix.de>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
 <20110909114004.GP1912@pengutronix.de>
 <2239AC579C7D3646A720227A37E026811A22BD@039-SN1MPN1-005.039d.mgd.msft.net>
 <20110909123324.GQ1912@pengutronix.de>
 <2239AC579C7D3646A720227A37E026811A2311@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eyYj78xbwv+yMvU1"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51390 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933423Ab1IINJA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2011 09:09:00 -0400
Content-Disposition: inline
In-Reply-To: <2239AC579C7D3646A720227A37E026811A2311@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, Xu Lei-B33228 <B33228@freescale.com>, Kumar Gala <galak@kernel.crashing.org>


--eyYj78xbwv+yMvU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Previously, I sent this patch together  with another one. But
> technically they are separated patches.  I got some comments from
> Anton about the patch. I will try to address the comment. but for this
> one, it is a stand along patch. I'd like to push it first.

Okay.

> I do not see any comment about byte swapping about this patch.
> you may have mis-understanding here.

I was misguided, yes, sorry. BE/LE issues with additional byteswapping
are a mind twister :/ Having a second look, it looks okay to me. One
could think about putting this into sdhci_platform as well, but this can
be done later if needed. Sadly, I currently don't have hardware to test
it.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--eyYj78xbwv+yMvU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5qD+cACgkQD27XaX1/VRubIACgopSfpZCL5tDlkpdGGE0i2qla
s1cAnjosG/RlaaGzhli707im1SOCRZBI
=0AAa
-----END PGP SIGNATURE-----

--eyYj78xbwv+yMvU1--
