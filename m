From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: don't print uninitialized variables
Date: Wed, 27 Jan 2016 10:14:44 +0200
Message-ID: <56A87C74.2010905@ti.com>
References: <3411189.gO0215GrNM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51610 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbcA0IPV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jan 2016 03:15:21 -0500
In-Reply-To: <3411189.gO0215GrNM@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/26/2016 05:26 PM, Arnd Bergmann wrote:
> When DT based probing is used but the DMA request fails, the
> driver will print uninitialized stack data from the rx_req
> and tx_req variables, as indicated by this warning:
>=20
> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
> drivers/mmc/host/omap_hsmmc.c:2162:3: warning: 'rx_req' may be used u=
ninitialized in this function [-Wmaybe-uninitialized]
>    dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channe=
l %u\n", rx_req);
>=20
> This removes the DMA request line number from the warning, which
> is the easiest solution and won't hurt us any more as we are
> planning to remove the legacy code path anyway.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> A simpler patch as v1 with the same result, as suggested by Peter Ujf=
alusi.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index b6639ea0bf18..87f0d840a166 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2159,7 +2159,7 @@ static int omap_hsmmc_probe(struct platform_dev=
ice *pdev)
>  						 &rx_req, &pdev->dev, "rx");
> =20
>  	if (!host->rx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channe=
l %u\n", rx_req);
> +		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channe=
l\n");
>  		ret =3D -ENXIO;
>  		goto err_irq;
>  	}
> @@ -2169,7 +2169,7 @@ static int omap_hsmmc_probe(struct platform_dev=
ice *pdev)
>  						 &tx_req, &pdev->dev, "tx");
> =20
>  	if (!host->tx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channe=
l %u\n", tx_req);
> +		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channe=
l\n");
>  		ret =3D -ENXIO;
>  		goto err_irq;
>  	}
>=20


--=20
P=E9ter
