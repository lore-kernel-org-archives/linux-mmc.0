From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci: use IS_ENABLE(CONFIG_LEDS_CLASS) to
 enable LED struct members
Date: Wed, 20 Apr 2016 09:15:12 +0300
Message-ID: <57171E70.90702@intel.com>
References: <1460607580-22599-1-git-send-email-yamada.masahiro@socionext.com>
 <1460607580-22599-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292AbcDTGS7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2016 02:18:59 -0400
In-Reply-To: <1460607580-22599-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 14/04/16 07:19, Masahiro Yamada wrote:
> defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> 
> is equivalent to:
> 
> IS_ENABLED(CONFIG_LEDS_CLASS)
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v2:
>   - Newly added
> 
>  drivers/mmc/host/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0decc85..27e8603 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -428,7 +428,7 @@ struct sdhci_host {
>  	struct mmc_host_ops mmc_host_ops;	/* MMC host ops */
>  	u64 dma_mask;		/* custom DMA mask */
>  
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> +#if IS_ENABLED(CONFIG_LEDS_CLASS)
>  	struct led_classdev led;	/* LED control */
>  	char led_name[32];
>  #endif
> 

