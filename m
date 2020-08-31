Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4EBC433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 13:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED5820866
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 13:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaNnv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:43:51 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:48488 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgHaNnu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Aug 2020 09:43:50 -0400
Date:   Mon, 31 Aug 2020 09:43:49 -0400
From:   Rich Felker <dalias@libc.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mark Brown <broonie@kernel.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: Don't use dma mappings unless
 CONFIG_HAS_DMA is set
Message-ID: <20200831134348.GN3265@brightrain.aerifal.cx>
References: <20200831131636.51502-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831131636.51502-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 31, 2020 at 03:16:36PM +0200, Ulf Hansson wrote:
> The commit cd57d07b1e4e ("sh: don't allow non-coherent DMA for NOMMU") made
> CONFIG_NO_DMA to be set for some platforms, for good reasons.
> Consequentially, CONFIG_HAS_DMA doesn't get set, which makes the DMA
> mapping interface to be built as stub functions.
> 
> For weird reasons this causes the mmc_spi driver to fail to ->probe(), as
> it relies on the dma mappings APIs, no matter of CONFIG_HAS_DMA is set or
> not. This is wrong, so let's fix this.
> 
> Fixes: cd57d07b1e4e ("sh: don't allow non-coherent DMA for NOMMU")
> Reported-by: Rich Felker <dalias@libc.org>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/mmc_spi.c | 86 +++++++++++++++++++++++---------------
>  1 file changed, 52 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 39bb1e30c2d7..5055a7eb134a 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1278,6 +1278,52 @@ mmc_spi_detect_irq(int irq, void *mmc)
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_HAS_DMA
> +static int mmc_spi_dma_alloc(struct mmc_spi_host *host)
> +{
> +	struct spi_device *spi = host->spi;
> +	struct device *dev;
> +
> +	if (!spi->master->dev.parent->dma_mask)
> +		return 0;
> +
> +	dev = spi->master->dev.parent;
> +
> +	host->ones_dma = dma_map_single(dev, host->ones, MMC_SPI_BLOCKSIZE,
> +					DMA_TO_DEVICE);
> +	if (dma_mapping_error(dev, host->ones_dma))
> +		return -ENOMEM;
> +
> +	host->data_dma = dma_map_single(dev, host->data, sizeof(*host->data),
> +					DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(dev, host->data_dma)) {
> +		dma_unmap_single(dev, host->ones_dma, MMC_SPI_BLOCKSIZE,
> +				 DMA_TO_DEVICE);
> +		return -ENOMEM;
> +	}
> +
> +	dma_sync_single_for_cpu(dev, host->data_dma, sizeof(*host->data),
> +				DMA_BIDIRECTIONAL);
> +
> +	host->dma_dev = dev;
> +	return 0;
> +}
> +
> +static void mmc_spi_dma_free(struct mmc_spi_host *host)
> +{
> +	if (!host->dma_dev)
> +		return;
> +
> +	dma_unmap_single(host->dma_dev, host->ones_dma, MMC_SPI_BLOCKSIZE,
> +			 DMA_TO_DEVICE);
> +	dma_unmap_single(host->dma_dev, host->data_dma,	sizeof(*host->data),
> +			 DMA_BIDIRECTIONAL);
> +}
> +#else
> +static inline mmc_spi_dma_alloc(struct mmc_spi_host *host) { return 0; }
> +static inline void mmc_spi_dma_free(struct mmc_spi_host *host) {}
> +#endif
> +
>  static int mmc_spi_probe(struct spi_device *spi)
>  {
>  	void			*ones;
> @@ -1374,23 +1420,9 @@ static int mmc_spi_probe(struct spi_device *spi)
>  	if (!host->data)
>  		goto fail_nobuf1;
>  
> -	if (spi->master->dev.parent->dma_mask) {
> -		struct device	*dev = spi->master->dev.parent;
> -
> -		host->dma_dev = dev;
> -		host->ones_dma = dma_map_single(dev, ones,
> -				MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
> -		if (dma_mapping_error(dev, host->ones_dma))
> -			goto fail_ones_dma;
> -		host->data_dma = dma_map_single(dev, host->data,
> -				sizeof(*host->data), DMA_BIDIRECTIONAL);
> -		if (dma_mapping_error(dev, host->data_dma))
> -			goto fail_data_dma;
> -
> -		dma_sync_single_for_cpu(host->dma_dev,
> -				host->data_dma, sizeof(*host->data),
> -				DMA_BIDIRECTIONAL);
> -	}
> +	status = mmc_spi_dma_alloc(host);
> +	if (status)
> +		goto fail_dma;
>  
>  	/* setup message for status/busy readback */
>  	spi_message_init(&host->readback);
> @@ -1458,20 +1490,12 @@ static int mmc_spi_probe(struct spi_device *spi)
>  fail_add_host:
>  	mmc_remove_host(mmc);
>  fail_glue_init:
> -	if (host->dma_dev)
> -		dma_unmap_single(host->dma_dev, host->data_dma,
> -				sizeof(*host->data), DMA_BIDIRECTIONAL);
> -fail_data_dma:
> -	if (host->dma_dev)
> -		dma_unmap_single(host->dma_dev, host->ones_dma,
> -				MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
> -fail_ones_dma:
> +	mmc_spi_dma_free(host);
> +fail_dma:
>  	kfree(host->data);
> -
>  fail_nobuf1:
>  	mmc_free_host(mmc);
>  	mmc_spi_put_pdata(spi);
> -
>  nomem:
>  	kfree(ones);
>  	return status;
> @@ -1489,13 +1513,7 @@ static int mmc_spi_remove(struct spi_device *spi)
>  
>  	mmc_remove_host(mmc);
>  
> -	if (host->dma_dev) {
> -		dma_unmap_single(host->dma_dev, host->ones_dma,
> -			MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
> -		dma_unmap_single(host->dma_dev, host->data_dma,
> -			sizeof(*host->data), DMA_BIDIRECTIONAL);
> -	}
> -
> +	mmc_spi_dma_free(host);
>  	kfree(host->data);
>  	kfree(host->ones);
>  
> -- 
> 2.25.1

A change to Kconfig is also needed to remove the HAS_DMA dependency.

Rich
