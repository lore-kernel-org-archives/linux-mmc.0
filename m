From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V5 4/6] mmc: sdhci-esdhc: make the writel/readl as the
 general APIs
Date: Mon, 7 Mar 2011 11:48:33 +0100
Message-ID: <20110307104833.GC3425@pengutronix.de>
References: <1299060283-6404-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1299060283-6404-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47799 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653Ab1CGKsp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 05:48:45 -0500
Content-Disposition: inline
In-Reply-To: <1299060283-6404-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, richard.zhao@freescale.com, eric.miao@linaro.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data =3D
> +				(struct pltfm_imx_data *)pltfm_host->scratchpad;
> +

Uh, no. Sorry that was a misunderstanding of this:

=3D=3D=3D
Do you means keep the u32 scratchpad, and use one u32---> pointer exchange,=
 right?
-       u32 scratchpad; /* to handle quirks across io-accessor calls */
+       void *priv; /* to handle quirks across io-accessor calls */
=3D=3D=3D

When you said "exchanging" 'scratchpad' with a 'void *', I thought you real=
ly
meant replacing it in the struct like the diff sketches. Casting a variable=
 to
a struct * is not a good idea. The private structure itself looks okay.

> +	struct pltfm_imx_data *imx_data;
> +
> +	imx_data =3D kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
> +	pltfm_host->scratchpad =3D (u32)imx_data;
> =20
>  	clk =3D clk_get(mmc_dev(host->mmc), NULL);
>  	if (IS_ERR(clk)) {

Do that after clk_get, otherwise you leak memory if it clk_get fails.

Regards

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk10uAEACgkQD27XaX1/VRtL3gCfVSRJQ2ae/XxaX5ZDuYUl29e7
b+4AmgIaIfHNlav/A3h3aYTYks4mXLlX
=yZ9Q
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
