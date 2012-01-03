From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 3/5 v3] ESDHC: Power management for ESDHC
Date: Tue, 3 Jan 2012 02:54:53 +0100
Message-ID: <20120103015453.GA3767@pengutronix.de>
References: <1324958792-16742-1-git-send-email-r66093@freescale.com>
 <m2lipppscs.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38811 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab2ACBy4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2012 20:54:56 -0500
Content-Disposition: inline
In-Reply-To: <m2lipppscs.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: r66093@freescale.com, linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Jiang Yutang <b14898@freescale.com>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2012 at 07:00:51PM -0500, Chris Ball wrote:

> Wolfram, do you have time to look at this?  Looks like we need to expose
> suspend/resume hooks to -pltfm users for this use case -- I don't think
> any esdhc code should be in sdhci-pltfm.c.  (I don't mind writing the
> patch if you agree that that's the correct solution here.)

I won't have time to look at it, but what you say sounds reasonable to me.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8CX+0ACgkQD27XaX1/VRvzbwCggv9QAA2VBppbIPmkei5GkcjH
k5QAnRjkijr/N1O+PxFy6YTegcy1IgT7
=EV2Q
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
