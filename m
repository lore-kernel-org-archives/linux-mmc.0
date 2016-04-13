From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: use IS_REACHABLE(CONFIG_LEDS_CLASS) to enable
 LED code
Date: Wed, 13 Apr 2016 11:59:43 +0300
Message-ID: <570E0A7F.8070200@intel.com>
References: <1460537730-23430-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:54336 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757853AbcDMJDk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Apr 2016 05:03:40 -0400
In-Reply-To: <1460537730-23430-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 13/04/16 11:55, Masahiro Yamada wrote:
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

I recently sent a change to the LEDS code:

	http://marc.info/?l=linux-mmc&m=146046055330711

So, if that is accepted, this will need to be changed - there will be only
one place CONFIG_LEDS_CLASS is used then.

> ---
> 
>  drivers/mmc/host/sdhci.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6bd3d17..7a4fbe8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -38,11 +38,6 @@
>  #define DBG(f, x...) \
>  	pr_debug(DRIVER_NAME " [%s()]: " f, __func__,## x)
>  
> -#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
> -	defined(CONFIG_MMC_SDHCI_MODULE))
> -#define SDHCI_USE_LEDS_CLASS
> -#endif
> -
>  #define MAX_TUNING_LOOP 40
>  
>  static unsigned int debug_quirks = 0;
> @@ -270,7 +265,7 @@ static void sdhci_deactivate_led(struct sdhci_host *host)
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>  
> -#ifdef SDHCI_USE_LEDS_CLASS
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>  static void sdhci_led_control(struct led_classdev *led,
>  	enum led_brightness brightness)
>  {
> @@ -1328,7 +1323,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  	WARN_ON(host->mrq != NULL);
>  
> -#ifndef SDHCI_USE_LEDS_CLASS
> +#if !IS_REACHABLE(CONFIG_LEDS_CLASS)
>  	sdhci_activate_led(host);
>  #endif
>  
> @@ -2214,7 +2209,7 @@ static void sdhci_tasklet_finish(unsigned long param)
>  	host->cmd = NULL;
>  	host->data = NULL;
>  
> -#ifndef SDHCI_USE_LEDS_CLASS
> +#if !IS_REACHABLE(CONFIG_LEDS_CLASS)
>  	sdhci_deactivate_led(host);
>  #endif
>  
> @@ -3360,7 +3355,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	sdhci_dumpregs(host);
>  #endif
>  
> -#ifdef SDHCI_USE_LEDS_CLASS
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>  	snprintf(host->led_name, sizeof(host->led_name),
>  		"%s::", mmc_hostname(mmc));
>  	host->led.name = host->led_name;
> @@ -3390,7 +3385,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  
>  	return 0;
>  
> -#ifdef SDHCI_USE_LEDS_CLASS
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>  reset:
>  	sdhci_do_reset(host, SDHCI_RESET_ALL);
>  	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> @@ -3430,7 +3425,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  
>  	mmc_remove_host(mmc);
>  
> -#ifdef SDHCI_USE_LEDS_CLASS
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>  	led_classdev_unregister(&host->led);
>  #endif
>  
> 

