From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 3/5] mmc: sdhci: make sdhci-of device drivers self
 registered
Date: Tue, 19 Apr 2011 12:21:01 +0200
Message-ID: <20110419102101.GD4164@pengutronix.de>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
 <1301042931-4869-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51387 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1DSKUx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 06:20:53 -0400
Content-Disposition: inline
In-Reply-To: <1301042931-4869-4-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +static int __devinit sdhci_esdhc_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host;
> +	int ret;
> +
> +	host =3D sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata);
> +	if (!host)
> +		return -ENOMEM;

Just noticed: Since pltfm_init may fail due to various reasons, maybe
ERRPTR might be a good idea?

[...]

> +static int __init sdhci_hlwd_init(void)
> +{
> +	return platform_driver_register(&sdhci_hlwd_driver);
> +}
> +module_init(sdhci_hlwd_init);
> +
> +static void __exit sdhci_hlwd_exit(void)
> +{
> +	platform_driver_unregister(&sdhci_hlwd_driver);
> +}
> +module_exit(sdhci_hlwd_exit);
> +
> +MODULE_DESCRIPTION("Secure Digital Host Controller Interface OF driver");
> +MODULE_AUTHOR("Xiaobo Xie <X.Xie@freescale.com>, "
> +	      "Anton Vorontsov <avorontsov@ru.mvista.com>");
> +MODULE_LICENSE("GPL v2");

Please double check the authors. It is based on the fsl driver, but the
copyright should go to

 * Copyright (C) 2009 The GameCube Linux Team
 * Copyright (C) 2009 Albert Herranz

I think.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2tYg0ACgkQD27XaX1/VRuY8QCfXu37oeDYKrWSDWJIO5HAqlt3
fqsAn3pnnBWRIdicOOV9QDh7MjFHFNXl
=XxX4
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
