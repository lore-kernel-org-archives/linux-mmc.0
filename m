From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
Date: Wed, 18 May 2016 14:07:57 +0300
Message-ID: <5a9e0163-1fbb-e0a6-95ff-0b720ba5c110@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
 <1463561115-31798-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:54337 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbcERLJB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 May 2016 07:09:01 -0400
In-Reply-To: <1463561115-31798-3-git-send-email-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, afenkart@gmail.com, ulf.hansson@linaro.org, linux@armlinux.org.uk, tony@atomide.com
Cc: rogerq@ti.com, bcousson@baylibre.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, nsekhar@ti.com

On 05/18/16 11:45, Kishon Vijay Abraham I wrote:

> +static int omap_hsmmc_dma_init(struct omap_hsmmc_host *host)
> +{
> +	dma_cap_mask_t mask;
> +	unsigned int tx_req, rx_req;
> +	struct resource *res;
> +	struct platform_device *pdev =3D to_platform_device(host->dev);
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	if (!pdev->dev.of_node) {
> +		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> +			return -ENXIO;
> +		}
> +		tx_req =3D res->start;
> +
> +		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> +			return -ENXIO;
> +		}
> +		rx_req =3D res->start;
> +	}
> +
> +	host->rx_chan =3D
> +		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> +						 &rx_req, &pdev->dev, "rx");
> +
> +	if (!host->rx_chan) {
> +		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channe=
l\n");
> +		return -ENXIO;
> +	}
> +
> +	host->tx_chan =3D
> +		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> +						 &tx_req, &pdev->dev, "tx");
> +
> +	if (!host->tx_chan) {
> +		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channe=
l\n");
> +		return -ENXIO;

upstream moved to use dma_request_chan() so this part needs to be chang=
ed.

> +	}
> +
> +	return 0;
> +}
> +
> +static void omap_hsmmc_dma_exit(struct omap_hsmmc_host *host)
> +{
> +	if (host->tx_chan)
> +		dma_release_channel(host->tx_chan);
> +	if (host->rx_chan)
> +		dma_release_channel(host->rx_chan);
> +}
> +
>  static int omap_hsmmc_probe(struct platform_device *pdev)
>  {
>  	struct omap_hsmmc_platform_data *pdata =3D pdev->dev.platform_data;
> @@ -2000,8 +2219,6 @@ static int omap_hsmmc_probe(struct platform_dev=
ice *pdev)
>  	struct resource *res;
>  	int ret, irq;
>  	const struct of_device_id *match;
> -	dma_cap_mask_t mask;
> -	unsigned tx_req, rx_req;
>  	const struct omap_mmc_of_data *data;
>  	void __iomem *base;
> =20
> @@ -2114,7 +2331,10 @@ static int omap_hsmmc_probe(struct platform_de=
vice *pdev)
>  	mmc->max_blk_size =3D 512;       /* Block Length at max can be 1024=
 */
>  	mmc->max_blk_count =3D 0xFFFF;    /* No. of Blocks is 16 bits */
>  	mmc->max_req_size =3D mmc->max_blk_size * mmc->max_blk_count;
> -	mmc->max_seg_size =3D mmc->max_req_size;
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		mmc->max_seg_size =3D ADMA_MAX_LEN;
> +	else
> +		mmc->max_seg_size =3D mmc->max_req_size;
> =20
>  	mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>  		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
> @@ -2130,46 +2350,12 @@ static int omap_hsmmc_probe(struct platform_d=
evice *pdev)
> =20
>  	omap_hsmmc_conf_bus_power(host);
> =20
> -	if (!pdev->dev.of_node) {
> -		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> -		if (!res) {
> -			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> -			ret =3D -ENXIO;
> -			goto err_irq;
> -		}
> -		tx_req =3D res->start;
> -
> -		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> -		if (!res) {
> -			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> -			ret =3D -ENXIO;
> -			goto err_irq;
> -		}
> -		rx_req =3D res->start;
> -	}
> -
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -
> -	host->rx_chan =3D
> -		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> -						 &rx_req, &pdev->dev, "rx");
> -
> -	if (!host->rx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channe=
l\n");
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
l\n");
> -		ret =3D -ENXIO;
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		ret =3D omap_hsmmc_adma_init(host);
> +	else
> +		ret =3D omap_hsmmc_dma_init(host);
> +	if (ret)
>  		goto err_irq;
> -	}
> =20
>  	/* Request IRQ for MMC operations */
>  	ret =3D devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
> @@ -2225,11 +2411,11 @@ err_slot_name:
>  	mmc_remove_host(mmc);
>  err_irq:
>  	device_init_wakeup(&pdev->dev, false);
> -	if (host->tx_chan)
> -		dma_release_channel(host->tx_chan);
> -	if (host->rx_chan)
> -		dma_release_channel(host->rx_chan);
>  	pm_runtime_dont_use_autosuspend(host->dev);
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		omap_hsmmc_adma_exit(host);
> +	else
> +		omap_hsmmc_dma_exit(host);
>  	pm_runtime_put_sync(host->dev);
>  	pm_runtime_disable(host->dev);
>  	if (host->dbclk)
> @@ -2248,8 +2434,10 @@ static int omap_hsmmc_remove(struct platform_d=
evice *pdev)
>  	pm_runtime_get_sync(host->dev);
>  	mmc_remove_host(host->mmc);
> =20
> -	dma_release_channel(host->tx_chan);
> -	dma_release_channel(host->rx_chan);
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		omap_hsmmc_adma_exit(host);
> +	else
> +		omap_hsmmc_dma_exit(host);
> =20
>  	pm_runtime_dont_use_autosuspend(host->dev);
>  	pm_runtime_put_sync(host->dev);
> diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux=
/platform_data/hsmmc-omap.h
> index 8e981be..e26013d 100644
> --- a/include/linux/platform_data/hsmmc-omap.h
> +++ b/include/linux/platform_data/hsmmc-omap.h
> @@ -27,6 +27,7 @@
>  #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
>  #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
>  #define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
> +#define OMAP_HSMMC_USE_ADMA			BIT(3)
> =20
>  struct omap_hsmmc_dev_attr {
>  	u8 flags;
>=20


--=20
P=E9ter
