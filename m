From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH v2] mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO
 host controller
Date: Mon, 28 Apr 2014 15:02:46 +0000
Message-ID: <a3075651ae064d2fb70073eb3472ede4@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <Pine.LNX.4.64.1404261404030.21367@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:5169 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756466AbaD1PCw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Apr 2014 11:02:52 -0400
In-Reply-To: <Pine.LNX.4.64.1404261404030.21367@axis700.grange>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>

Hi Guennadi,

On 26 April 2014 13:06, Guennadi wrote:
> Subject: [PATCH v2] mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO
> host controller
> 
> This patch adds a driver for the Renesas usdhi6rol0 SD/SDIO host controller
> in both PIO and DMA modes.

...
> +static void usdhi6_dma_stop_unmap(struct usdhi6_host *host)
> +{
> +	struct mmc_data *data = host->mrq->data;
> +
> +	if (!host->dma_active)
> +		return;
> +
> +	usdhi6_write(host, USDHI6_CC_EXT_MODE, 0);
> +	host->dma_active = false;
> +
> +	if (data->flags & MMC_DATA_READ)
> +		/* TODO: do we have to synchronise? */
> +		dma_unmap_sg(host->chan_rx->device->dev, data->sg,
> +			     data->sg_len, DMA_FROM_DEVICE);
Yes, you have to sync, so you can remove this TODO comment.

...
> +static int usdhi6_probe(struct platform_device *pdev)
> +{
...
> +	host		= mmc_priv(mmc);
> +	host->mmc	= mmc;
> +	host->wait	= USDHI6_WAIT_FOR_REQUEST;
> +	host->timeout	= msecs_to_jiffies(1000);
In all places you use host->timeout, the code uses host->timeout * 4. Wouldn't it better to just set it here to 4 seconds?

Thanks
Phil
