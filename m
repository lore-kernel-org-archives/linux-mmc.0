From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Thu, 23 Sep 2010 11:51:42 +0200
Message-ID: <20100923095142.GC2994@pengutronix.de>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de>
 <4C98792C.5000900@st.com>
 <20100921094457.GD3168@pengutronix.de>
 <4C9A0518.3090904@st.com>
 <20100922141223.GF2693@pengutronix.de>
 <4C9A1427.7030806@st.com>
 <20100923084716.GB2994@pengutronix.de>
 <4C9B1E32.4070700@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53516 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429Ab0IWJvr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 05:51:47 -0400
Content-Disposition: inline
In-Reply-To: <4C9B1E32.4070700@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> static int mmc_pad_resources(struct sdhci_host *sdhci)
> {
>         if (!devm_stm_pad_claim(sdhci->mmc->parent,
>                                 &stx7108_mmc_pad_config,
>                                 dev_name(sdhci->mmc->parent)))
>                 return -ENODEV;
>=20
>         return 0;
> }
>=20
> static struct sdhci_pltfm_data stx7108_mmc_platform_data =3D {
>                 .init =3D &mmc_pad_resources,

You can drop the &

>                 .quirks =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> };
>=20
> static struct platform_device stx7108_mmc_device =3D {
>                 .name =3D "sdhci",
>=20
> [snip]

All in all, this looks like the right way! A good example how to
slightly update and then use the pltfm-driver. Redundant code saved and
benefits for all added :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkybIy4ACgkQD27XaX1/VRsfdACgrt2LFnlzvk/+Uyj61vcaAhhy
xVwAn01e8w3HHWYbHuZ8GtPywxDtFq6w
=yWi2
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
