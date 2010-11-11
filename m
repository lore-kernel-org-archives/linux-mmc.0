From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (1/5)] mmc: sdhci-pltfm calls the sdhci_alloc_host with
	pdev->dev
Date: Thu, 11 Nov 2010 08:48:18 +0100
Message-ID: <20101111074818.GA28699@pengutronix.de>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com> <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com> <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com> <20101110154352.GC2691@pengutronix.de> <4CDB9850.709@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44161 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788Ab0KKHsU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 02:48:20 -0500
Content-Disposition: inline
In-Reply-To: <4CDB9850.709@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Removing the dev.parent-branch will break some PCI-based solutions.
> Hmm, I suspected this :-(. Unfortunately I need to not pass the parent
> for the problem described in the patch.
> How to proceed? Do I have to re-introduce the sdhci-stm driver?

The current mainline code does not work for you?

> > I think you should first rebase the series to mmc-next and then ask for
> > review. It is too confusing for reviewers otherwise. At least, I will
> > stop here.
> At any rate, no problem to re-base the patches to the mmc-next.I'll do
> it soon!

Great!

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzbn8IACgkQD27XaX1/VRu0HgCgsZGQWZ9YAKk+g42UmWhQzyGf
p6IAoJYR7LKRWsuuj/kdG4kCB2NsAYib
=2o6K
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
