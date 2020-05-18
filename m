Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DDEC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 20:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B662075F
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 20:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mmZYxWdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgERUWE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 16:22:04 -0400
Received: from www.zeus03.de ([194.117.254.33]:38578 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgERUWD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 May 2020 16:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=BYUPYXah7xTH9LNKl8izh7O1nN0Y
        eMtqVH7vVI3WPos=; b=mmZYxWdTrEbc+fe21si1Y5/TMppk6piLb67yus/Bn06a
        LVMr06aQeM4Fe+EKEvyjg8MweEDetiQ8wvK3otOwGRKz86kyYRY0soPFux23c3a2
        uNaok4FIWMvdWVF6oqK6HmYX+4uLGJVyCEE6ZCEltcGf3eMokwAfekr2DauadAs=
Received: (qmail 1154607 invoked from network); 18 May 2020 22:22:01 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 May 2020 22:22:01 +0200
X-UD-Smtp-Session: l3s3148p1@gjtc6vGldKMgAwDPXwfCAIWBZdj99x2z
Date:   Mon, 18 May 2020 22:22:00 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started'
 while probing
Message-ID: <20200518202200.GC5109@ninjato>
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <20200515140459.15273-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 04:04:59PM +0200, Ulf Hansson wrote:
> If the tmio device is attached to a genpd (PM domain), that genpd may have
> ->start|stop() callback assigned to it. To make sure the device is
> accessible during ->probe(), genpd's ->start() callback must be invoked,
> which is currently managed by tmio_mmc_host_probe(). This is very likely =
to
> be too late for some cases, as registers may be read and written way befo=
re
> that.
>=20
> To fix this behaviour, let's drop the call to dev_pm_domain_start() from
> tmio_mmc_host_probe() - and let the tmio clients manage this instead.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Okay, this seems to work on Gen3.

> @@ -909,6 +910,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>  	if (ret)
>  		goto efree;
> =20
> +	dev_pm_domain_start(&pdev->dev);
> +

Can't we put it before the custom clk_enable()? And then clean up
further like this to have the main clock only controlled via RPM?

--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -83,16 +83,11 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host=
 *host)
 {
 	struct mmc_host *mmc =3D host->mmc;
 	struct renesas_sdhi *priv =3D host_to_priv(host);
-	int ret =3D clk_prepare_enable(priv->clk);
-
-	if (ret < 0)
-		return ret;
+	int ret;
=20
 	ret =3D clk_prepare_enable(priv->clk_cd);
-	if (ret < 0) {
-		clk_disable_unprepare(priv->clk);
+	if (ret < 0)
 		return ret;
-	}
=20
 	/*
 	 * The clock driver may not know what maximum frequency
@@ -198,7 +193,6 @@ static void renesas_sdhi_clk_disable(struct tmio_mmc_ho=
st *host)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
=20
-	clk_disable_unprepare(priv->clk);
 	clk_disable_unprepare(priv->clk_cd);
 }
=20
@@ -906,12 +900,12 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |=3D TMIO_MMC_SDIO_STATUS_SETBITS;
=20
+	dev_pm_domain_start(&pdev->dev);
+
 	ret =3D renesas_sdhi_clk_enable(host);
 	if (ret)
 		goto efree;
=20
-	dev_pm_domain_start(&pdev->dev);
-
 	ver =3D sd_ctrl_read16(host, CTL_VERSION);
 	/* GEN2_SDR104 is first known SDHI to use 32bit block count */
 	if (ver < SDHI_VER_GEN2_SDR104 && mmc_data->max_blk_count > U16_MAX)


Again, this is only tested on Gen3. I will check Gen2 tomorrow.

> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index 93e83ad25976..b8f5687e10be 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -17,6 +17,7 @@
>  #include <linux/mmc/host.h>
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
> +#include <linux/pm_domain.h>
>  #include <linux/scatterlist.h>
> =20
>  #include "tmio_mmc.h"
> @@ -172,6 +173,8 @@ static int tmio_mmc_probe(struct platform_device *pde=
v)
>  	host->mmc->f_max =3D pdata->hclk;
>  	host->mmc->f_min =3D pdata->hclk / 512;
> =20
> +	dev_pm_domain_start(&pdev->dev);
> +

I am quite sure tmio_mmc won't need this, but better safe than sorry.

Thanks, Ulf!


--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7C7mgACgkQFA3kzBSg
KbbwAxAAsLsKCsCM5LyTljydirSDX2KTHpjzuxUE/TNqoTnf9t9mo19CQqF/JQ8t
ABhvYG/tiDbHCH70LtcOTDZd9ebeUi1CX3rJKwbPVdTIG6lSnu2FcjmVKm8NkWBc
3EJKc0f5InfX/g4f7KCKCYxcLw0Boskl8YxZHsAH7jUt0OUzP36daA5BwsyFW7r1
UpKrrG9bUM/mzBd1T9zw+PukQBHFFZ6Tgh4qnQxTGYFOQKXtGncA753r6wMZ+E1a
Zj91kXjYTaeruDKwwBp9+EkQd7DofwQU3/g6LOVLAJYxdrO/DOH6S05jS1w00xBl
UDd5WUJy6jc8smSr5E3bkzTI1uWFBycqkjp+3wd+AkLP457hzcZf2EimRF34iLa9
niXc0dMLopp6QllTTP9B1LCh3MsXAXR5h1aJnuaGnPHKrq4Iyi3jOjlFI1aEULYG
QtY7mZBnFoD7jyc9PxO/D4IkuZBHnJqeCqipTRUfRLw2XHXBiT/+odB+8MDnIHop
/l2IbeedhbYbDr14SxS6cFAMjMjxVg5gSPlrVBm6qf4LKsjiKRh4YS63gbLR7Ef8
N2TPasnW/gbgtnEBOwd2pIGVSiIoMXgf6ilD3kg55mdHgg7/uNpWO05zEoIG0KPQ
I02qDGoFNlwHfFCiRRH43RfoMP+6tQ+/BclQuuHoyvgBbj2bPpM=
=l7oz
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
