From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [patch] sdhci-pltfm: add call back function
Date: Mon, 27 Sep 2010 14:41:32 +0200
Message-ID: <20100927124132.GG2664@pengutronix.de>
References: <AANLkTi=tkP2O+EaY5xSQ8EZAR0rP9gTz34cipC-WTHjf@mail.gmail.com>
 <20100926160933.GA23180@pengutronix.de>
 <AANLkTimhN4+RvF8cj3KTDSLLuUfQ1dR+jmEV4-Gv9qhz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57439 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab0I0Mlg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 08:41:36 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimhN4+RvF8cj3KTDSLLuUfQ1dR+jmEV4-Gv9qhz@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Richard Zhu <r65037@freescale.com>


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2010 at 09:06:57AM +0800, Eric Miao wrote:
> On Mon, Sep 27, 2010 at 12:09 AM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
> > On Sun, Sep 26, 2010 at 04:52:06AM -0400, zhangfei gao wrote:
> >> Add several call back to sdhci-pltfm.c, help give suggestion
> >
> > Just formal things, without looking at the code yet.
> >
> > Make seperate patches out of these, everyone with a proper description.
> >
> >> 1. struct sdhci_host *(*alloc_host)(struct device *dev), since
> >> specific driver need some private variable to allocate and free,
> >> including clk.
> >> 2. unsigned int =A0(*get_quirk)(struct sdhci_host *host); add this
> >> because one driver may serve several device, each one may require
> >> different quirk, and specific driver is right one to know.
> >> 3. void (*set_max_speed)(struct sdhci_host *host); this should be done
> >> after add_host, which impact f_max.
> >> 4. int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data
> >> *pdata, void* priv_pdata); copy from Wolfram Sang's patch to transfer
> >> platform data, copy here for test.
> >
>=20
> Just a rough idea, considering the potential differences (I believe
> there will be
> more in the future) between the SDHCI of different SoCs, would it make mo=
re
> sense to make sdhci-pltfm.c as a common function library for sdhci-<soc>.=
c?

Yeah, I think Alan Cox mentioned this idea, too. My guess is that it
will be well received, if somebody actually does it ;) Up to that point,
it probably makes sense to keep redundancy low by the means we have
today, i.e. pltfm. That should help a later migration process.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygkPwACgkQD27XaX1/VRvzDgCfTdN86Ow+3cbTOBppAyvkvKOR
ok4AoLVZE4QAfPWjiC/VkiS1cNnQmF2b
=VJJ/
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--
