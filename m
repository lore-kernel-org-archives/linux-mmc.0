From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (1/5)] mmc: sdhci-pltfm calls the sdhci_alloc_host with
 pdev->dev
Date: Wed, 10 Nov 2010 16:43:52 +0100
Message-ID: <20101110154352.GC2691@pengutronix.de>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49756 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab0KJPnz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 10:43:55 -0500
Content-Disposition: inline
In-Reply-To: <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for the work in general, just...

> -	if (pdev->dev.parent)
> -		host =3D sdhci_alloc_host(pdev->dev.parent, 0);
> -	else
> -		host =3D sdhci_alloc_host(&pdev->dev, 0);
> -
> +	host =3D sdhci_alloc_host(&pdev->dev, 0);
>  	if (IS_ERR(host)) {
>  		ret =3D PTR_ERR(host);
>  		goto err;

NACK. This part looks different in current mainline (and for a reason).
Removing the dev.parent-branch will break some PCI-based solutions.

I think you should first rebase the series to mmc-next and then ask for
review. It is too confusing for reviewers otherwise. At least, I will
stop here.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzavbgACgkQD27XaX1/VRusiwCgq6nAy1PRa1PyCmaRiZRNOT0o
UlcAn2eSje1+tIfyFWyjHZ7hn3Jk1LnJ
=DEKk
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
