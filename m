From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: don't print uninitialized variables
Date: Tue, 26 Jan 2016 16:52:40 +0200
Message-ID: <56A78838.3050400@ti.com>
References: <1453737031-1959584-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51946 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965268AbcAZOxN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Jan 2016 09:53:13 -0500
In-Reply-To: <1453737031-1959584-1-git-send-email-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/25/2016 05:50 PM, Arnd Bergmann wrote:
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
> This restructures the function to separate the simple DT probe
> from the more complex platform data code path, and only
> prints the information that is actually available and
> needed in case of an error, which makes it nicer to read
> and avoids the warning.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 48 +++++++++++++++++++++------------=
----------
>  1 file changed, 23 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index b6639ea0bf18..e06b1881b6a1 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2002,8 +2002,6 @@ static int omap_hsmmc_probe(struct platform_dev=
ice *pdev)
>  	struct resource *res;
>  	int ret, irq;
>  	const struct of_device_id *match;
> -	dma_cap_mask_t mask;
> -	unsigned tx_req, rx_req;
>  	const struct omap_mmc_of_data *data;
>  	void __iomem *base;
> =20
> @@ -2133,7 +2131,17 @@ static int omap_hsmmc_probe(struct platform_de=
vice *pdev)
> =20
>  	omap_hsmmc_conf_bus_power(host);
> =20
> -	if (!pdev->dev.of_node) {
> +	host->tx_chan =3D dma_request_slave_channel(&pdev->dev, "tx");
> +	host->rx_chan =3D dma_request_slave_channel(&pdev->dev, "rx");
> +	if (!host->tx_chan || !host->rx_chan) {

While it is really unlikely that we are failing to get only one of the
channels... It means anyway that the omap_hsmmc is not usable, but we w=
ill
still try to get via legacy mode and there is a chance that we might ge=
t some
channel.

Too bad that I can not send the conversion to dma_request_chan() yet du=
e to
missing things in arch...

It might be simpler to just remove the printout of the rx/tx_req from t=
he
dev_err() when reporting failed channel requests...

> +		dma_cap_mask_t mask;
> +		unsigned tx_req, rx_req;
> +
> +		dev_err(mmc_dev(host->mmc), "falling back to manual DMA configurat=
ion\n");
> +
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_SLAVE, mask);
> +
>  		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
>  		if (!res) {
>  			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> @@ -2141,6 +2149,12 @@ static int omap_hsmmc_probe(struct platform_de=
vice *pdev)
>  			goto err_irq;
>  		}
>  		tx_req =3D res->start;
> +		host->tx_chan =3D dma_request_channel(mask, omap_dma_filter_fn, &t=
x_req);
> +		if (!host->rx_chan) {
> +			dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine chann=
el %u\n", tx_req);
> +			ret =3D -ENXIO;
> +			goto err_irq;
> +		}
> =20
>  		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
>  		if (!res) {
> @@ -2149,29 +2163,13 @@ static int omap_hsmmc_probe(struct platform_d=
evice *pdev)
>  			goto err_irq;
>  		}
>  		rx_req =3D res->start;
> -	}
> -
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -
> -	host->rx_chan =3D
> -		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> -						 &rx_req, &pdev->dev, "rx");
> +		host->tx_chan =3D dma_request_channel(mask, omap_dma_filter_fn, &r=
x_req);
> =20
> -	if (!host->rx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channe=
l %u\n", rx_req);
> -		ret =3D -ENXIO;
> -		goto err_irq;
> -	}
> -
> -	host->tx_chan =3D
> -		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> -						 &tx_req, &pdev->dev, "tx");
> -
> -	if (!host->tx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channe=
l %u\n", tx_req);
> -		ret =3D -ENXIO;
> -		goto err_irq;
> +		if (!host->tx_chan) {
> +			dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine chann=
el %u\n", rx_req);
> +			ret =3D -ENXIO;
> +			goto err_irq;
> +		}
>  	}
> =20
>  	/* Request IRQ for MMC operations */
>=20


--=20
P=E9ter
