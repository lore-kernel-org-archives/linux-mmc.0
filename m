From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Thu, 23 Sep 2010 10:48:13 +0200
Message-ID: <20100923084716.GB2994@pengutronix.de>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de>
 <4C98792C.5000900@st.com>
 <20100921094457.GD3168@pengutronix.de>
 <4C9A0518.3090904@st.com>
 <20100922141223.GF2693@pengutronix.de>
 <4C9A1427.7030806@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50391 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab0IWIsR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 04:48:17 -0400
Content-Disposition: inline
In-Reply-To: <4C9A1427.7030806@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> 3) In the end, another hook could be added in the sdhci_pltfm_data to
> >>    invoke specific own functions for claiming resources etc.
> >>    For example, I need an extra callback to invoke the STM pad manager
> >>    that's used for managing clocks, PIO lines and syscfg registers.
> >>
> >>    I'm thinking about something like this:
> >>
> >>    struct sdhci_pltfm_data {
> >>         struct sdhci_ops *ops;
> >>         unsigned int quirks;
> >>         int (*init)(struct sdhci_host *host);
> >>         void (*exit)(struct sdhci_host *host);
> >>         int (*claim_resource)(struct platform_device *pdev);
> >>                  |
> >>                  |_ we can use another name.
> >>    };
> >=20
> > And init() is too late?
>=20
> No it's not late but I need the dev structure from the platform_device.
> We could add the "struct device dev;" in the sdhci_host structure
> instead of.
> In this case the sdhci_host should be moved within the new
> include/linux/mmc/sdhci.h file.
> Indeed, this could make sense because the drivers/mmc/host/sdhci.h will
> only have the HW register configuration. Shared macros (quirks) and
> structures among sdhci driver based could be moved in
> include/linux/mmc/sdhci.h header.
>=20
> What do you think?

I think it will be better to give init() access to all information
needed than to implement another hook. I tried with this patch

https://patchwork.kernel.org/patch/196992/

I am still not sure what kind of information you need from the pdev. Can
you create a branch somewhere with your current work?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkybFE0ACgkQD27XaX1/VRuXcwCgm2qBxi2SDIpOS75eaTBlb5Jq
bLwAn3/bJQEPTME3GUo4icahPXvfaRvk
=sjTS
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
