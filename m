From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-esdhc: Add SDHCI_QUIRK_32BIT_DMA_ADDR
Date: Mon, 29 May 2017 11:02:00 +0300
Message-ID: <d70f8b0c-a17e-7cac-ff8e-227547ba0a4b@intel.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30092 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750846AbdE2IH5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 May 2017 04:07:57 -0400
In-Reply-To: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit@wsystem.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?Q?Eric_B=c3=a9nard?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>

On 03/05/17 13:05, Benoît Thébaudeau wrote:
> The eSDHC can only DMA from 32-bit-aligned addresses.
> 
> This fixes the following test cases of mmc_test:
>   11:	Badly aligned write
>   12:	Badly aligned read
>   13:	Badly aligned multi-block write
>   14:	Badly aligned multi-block read
> 
> Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>

I would expect to see Acks from other sdhci-esdhc users.  Nevertheless for
sdhci:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index c4bbd74..e7893f2 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -19,6 +19,7 @@
>   */
>  
>  #define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
> +				SDHCI_QUIRK_32BIT_DMA_ADDR | \
>  				SDHCI_QUIRK_NO_BUSY_IRQ | \
>  				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
>  				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
> 

