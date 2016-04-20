From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci: use IS_REACHABLE(CONFIG_LEDS_CLASS) to
 enable LED code
Date: Wed, 20 Apr 2016 09:14:54 +0300
Message-ID: <57171E5E.1080701@intel.com>
References: <1460607580-22599-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39438 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbcDTGSm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2016 02:18:42 -0400
In-Reply-To: <1460607580-22599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 14/04/16 07:19, Masahiro Yamada wrote:
> defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>     defined(CONFIG_MMC_SDHCI_MODULE))
> 
> is equivalent to:
> 
> defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>     defined(MODULE))
> 
> and it can also be written shortly as:
> 
> IS_REACHABLE(CONFIG_LEDS_CLASS)
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
> 
> Changes in v2:
>   - Rebase on the next branch (7766e58f5be39dcc35d30a703422a3d0b8ec8c0c)
> 
>  drivers/mmc/host/sdhci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b284924..eedc18a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -259,9 +259,7 @@ static void __sdhci_led_deactivate(struct sdhci_host *host)
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>  
> -#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
> -				   defined(CONFIG_MMC_SDHCI_MODULE))
> -
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>  static void sdhci_led_control(struct led_classdev *led,
>  			      enum led_brightness brightness)
>  {
> 

