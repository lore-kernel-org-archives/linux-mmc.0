From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC v2 5/5] mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC
Date: Thu, 30 Jun 2016 13:50:24 +0200
Message-ID: <4198735.C1rpRVa8xf@wuerfel>
References: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au> <1467237940-24388-6-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:51729 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbcF3L5J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2016 07:57:09 -0400
In-Reply-To: <1467237940-24388-6-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>

On Thursday, June 30, 2016 12:05:40 AM CEST Simon Horman wrote:
> @@ -120,6 +127,26 @@ static int sdhi_sysc_dmac_init_dma(void)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_MMC_SDHI_INTERNAL_DMA)
> +int sdhi_internal_dmac_init_dma(void);
> +#else
> +static int sdhi_internal_dmac_init_dma(void)
> +{
> +       return -EINVAL;
> +}
> +#endif
> +
> +static int sh_mobile_sdhi_init_dma(enum tmio_mmc_dmac_type dmac_type)
> +{
> +       switch (dmac_type) {
> +       case TMIO_MMC_INTERNAL_DMAC:
> +               return sdhi_internal_dmac_init_dma();
> +
> +       case TMIO_MMC_SYSC_DMAC:
> +               return sdhi_sysc_dmac_init_dma();
> +       }
> +}
> +

I think it would be nicer to turn the logic around and handle the
different kinds of TMIO hardware like we do it for the sdhci types:

Make the common portion of the driver a module that just exports
functions but doesn't register a driver, and then put each variant
(PIO, internal DMA, SYSC-DMA) into a separate module that registers
its own driver.

Do you think that makes sense in this case?

	Arnd
