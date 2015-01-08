From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH] mmc: mmci: Get rid of unused variable and operations
 on it
Date: Thu, 08 Jan 2015 14:43:30 +0530
Message-ID: <54AE4A3A.1050806@smartplayin.com>
References: <1418737895-6404-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp116.ord1c.emailsrvr.com ([108.166.43.116]:35113 "EHLO
	smtp116.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750705AbbAHJNS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jan 2015 04:13:18 -0500
In-Reply-To: <1418737895-6404-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, chris@printf.net

Hi Ulf,

Any comment on this change?

Thanks
Pramod
On Tuesday 16 December 2014 07:21 PM, Pramod Gurav wrote:
> DMA configuration has been removed from function mmci_dma_setup but the
> local mask variable was not removed. This remains unused hence remove
> it from the function and operations on it
> 
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
>  drivers/mmc/host/mmci.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f31d702..08bbeb0 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -435,7 +435,6 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>  static void mmci_dma_setup(struct mmci_host *host)
>  {
>  	const char *rxname, *txname;
> -	dma_cap_mask_t mask;
>  	struct variant_data *variant = host->variant;
>  
>  	host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
> @@ -444,10 +443,6 @@ static void mmci_dma_setup(struct mmci_host *host)
>  	/* initialize pre request cookie */
>  	host->next_data.cookie = 1;
>  
> -	/* Try to acquire a generic DMA engine slave channel */
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -
>  	/*
>  	 * If only an RX channel is specified, the driver will
>  	 * attempt to use it bidirectionally, however if it is
> 
