From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 5/7] mmc: sdhci-bcm-kona: kill the "external_clk" member
 in driver private struct
Date: Fri, 6 Feb 2015 14:40:00 +0800
Message-ID: <20150206064000.GH5965@pek-khao-d1.corp.ad.wrs.com>
References: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
 <1423192522-6056-6-git-send-email-haokexin@gmail.com>
 <54D45655.4030908@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:50948 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbBFGkK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Feb 2015 01:40:10 -0500
Received: by mail-qc0-f182.google.com with SMTP id l6so10351212qcy.13
        for <linux-mmc@vger.kernel.org>; Thu, 05 Feb 2015 22:40:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54D45655.4030908@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2015 at 09:51:17PM -0800, Ray Jui wrote:
> > @@ -265,19 +264,19 @@ static int sdhci_bcm_kona_probe(struct platform_d=
evice *pdev)
> >  	}
> > =20
> >  	/* Get and enable the external clock */
>=20
> Would you mind changing the above comment to "/* Get and enable the core
> clock */?

Sure.

>=20
> > -	kona_dev->external_clk =3D devm_clk_get(dev, NULL);
> > -	if (IS_ERR(kona_dev->external_clk)) {
> > +	pltfm_priv->clk =3D devm_clk_get(dev, NULL);
> > +	if (IS_ERR(pltfm_priv->clk)) {
> >  		dev_err(dev, "Failed to get external clock\n");
>=20
> Change to "Failed to get the core clock"

OK, I will change all the references of "external clock" to "core clock".

> Not sure if this is relevant and should be done in the same patch. But
> both callbacks get_max_clock and get_timeout_clock in this driver can be
> set to sdhci_pltfm_clk_get_max_clock. That will help to get rid of two
> redundant private functions in this driver.

Sounds good. I will add this in the v2.

Thanks,
Kevin

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU1GHAAAoJEJNY7TDerrFxs90IAJSwDjsytEXB/esegR+mDvlh
SDvGIpw/k7OeXnM3jhfVfIZ8ZTQg2cvA3sWzAgjtPNLf/VDeqZU1mqk1LYQ3HD+Z
4uiGE6qrOYr8NEjsiL3U115vdYbK8IebnSgADb63nn3A/GE2JtIbcq6+tIBh9pg4
6UlykBV/Vo9aowATvmDCAF+DY7ofhvx7aTcu4cRX2CpImkrSDtqnbVyqB42tDF0h
6v5ypQhN6g96K+XaIy4W7et7K3SZEVxa49COBUIY8mF/QP/gzPZ+fixc5e23M5Eb
KZgURef9iq6o7RMjJQqlGBQFzvWziyg6Q6QWYa1/NBnYvT2cNtIVUbZW8ftPbXM=
=lRqM
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
