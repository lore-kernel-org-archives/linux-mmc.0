From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/4] mmc: sdhci-pltfm: move .h-file into apropriate
 subdir
Date: Wed, 22 Sep 2010 11:14:05 +0200
Message-ID: <20100922091405.GC2693@pengutronix.de>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
 <1285072210-10207-3-git-send-email-w.sang@pengutronix.de>
 <20100922012011.GE27885@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40701 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab0IVJOG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2010 05:14:06 -0400
Content-Disposition: inline
In-Reply-To: <20100922012011.GE27885@trinity.fluff.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben@trinity.fluff.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Richard Zhu <r65037@freescale.com>


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 22, 2010 at 02:20:11AM +0100, Ben Dooks wrote:
> On Tue, Sep 21, 2010 at 02:30:08PM +0200, Wolfram Sang wrote:
> > Make use of the mmc-directory.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> >  drivers/mmc/host/sdhci-cns3xxx.c |    2 +-
> >  drivers/mmc/host/sdhci-pltfm.c   |    2 +-
> >  drivers/mmc/host/sdhci-pltfm.h   |    2 +-
> >  include/linux/mmc/sdhci-pltfm.h  |   35 ++++++++++++++++++++++++++++++=
+++++
> >  include/linux/sdhci-pltfm.h      |   35 ------------------------------=
-----
>=20
> hmm, you lost rename detection... best enable it to make these diffs clea=
rer.

Do you mean just for the diffstat or for the whole patch? I am
reluctant to do the latter because you can't apply patches with plain
'patch' anymore. Or are git-patches considered standard meanwhile?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyZyNwACgkQD27XaX1/VRuwDQCfb2GrMpwOno87YSfldEQCBxyH
1cYAn3611VmnFBONdN3iMGxJJ98HFBJV
=zbCU
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
