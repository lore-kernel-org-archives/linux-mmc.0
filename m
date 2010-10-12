From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc_rescan: reduce verbosity
Date: Tue, 12 Oct 2010 08:00:45 +0200
Message-ID: <20101012060045.GA8252@pengutronix.de>
References: <1286833731-30567-1-git-send-email-eric@eukrea.com> <alpine.LFD.2.00.1010112007250.2764@xanadu.home> <20101012021236.GA8179@void.printf.net> <alpine.LFD.2.00.1010112257570.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59584 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab0JLGAr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 02:00:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010112257570.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <cjb@laptop.org>, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, linux-mmc@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 11, 2010 at 11:00:30PM -0400, Nicolas Pitre wrote:
> On Tue, 12 Oct 2010, Chris Ball wrote:
>=20
> > Hi,
> >=20
> > On Mon, Oct 11, 2010 at 09:50:46PM -0400, Nicolas Pitre wrote:
> > > On Mon, 11 Oct 2010, Eric B=E9nard wrote:
> > > > since commit 820f2bcfdc32cd90061224c930cf670f961e12d1 mmc_rescan
> > > > includes a pr_info which prints 4 lines each second for hosts confi=
gured
> > > > with MMC_CAP_NEEDS_POLL. Tested on i.MX51's sdhci-esdhc.
> > > > This patch increase log level to debug (but maybe the right solution
> > > > would be to remove this log).
> > >=20
> > > Indeed.  Flooding the log with debug messages is not much better.
> >=20
> > Other options include:
> >=20
> > (a) Turn the message into a DBG().  (CONFIG_MMC_DEBUG=3Dy)
> > (b) Turn the message into a DBG(), predicated on !MMC_CAP_NEEDS_POLL.
> > (c) Remove the message.
> >=20
> > Any thoughts?  I'll go with (c) unless we agree on a better idea.
>=20
> My preference would be (a).  You don't lose the intended debugging aid=20
> but it has to be turned on explicitly.  The people who might care=20
> most probably have CONFIG_MMC_DEBUG=3Dy already.

+1 There has been a lot of discussion/issues about the initialization
frequency, so this output might be desired in special situations.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyz+Y0ACgkQD27XaX1/VRsKwACgtcSaZF4xCwpjpn5Oy7Sw/JKN
ACoAn2Vhw85X3/yxsu+LJLSIUQVCG+5R
=8OAK
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
