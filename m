From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: remove ESDHC_CD_GPIO handling from IO accessory
Date: Tue, 15 Jan 2013 10:22:41 -0500
Message-ID: <87a9sapj26.fsf@laptop.org>
References: <1358263194-3298-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41857 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086Ab3AOPXB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Jan 2013 10:23:01 -0500
In-Reply-To: <1358263194-3298-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Tue, 15 Jan 2013 23:19:54 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi Shawn,

On Tue, Jan 15 2013, Shawn Guo wrote:
> With commit 9444e07 (mmc: remove unncessary mmc_gpio_free_cd() call from
> slot-gpio users) in place, those ESDHC_CD_GPIO handling in IO accessory
> becomes unnecessary.  Remove them.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index dd7fcc1..ae68bc9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -150,16 +150,6 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  
>  	u32 val = readl(host->ioaddr + reg);
>  
> -	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
> -		/*
> -		 * After SDHCI core gets improved to never query
> -		 * SDHCI_CARD_PRESENT state in GPIO case, we can
> -		 * remove this check.
> -		 */
> -		if (boarddata->cd_type == ESDHC_CD_GPIO)
> -			val &= ~SDHCI_CARD_PRESENT;
> -	}
> -
>  	if (unlikely(reg == SDHCI_CAPABILITIES)) {
>  		/* In FSL esdhc IC module, only bit20 is used to indicate the
>  		 * ADMA2 capability of esdhc, but this bit is messed up on
> @@ -192,13 +182,6 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
>  	u32 data;
>  
>  	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
> -		if (boarddata->cd_type == ESDHC_CD_GPIO)
> -			/*
> -			 * These interrupts won't work with a custom
> -			 * card_detect gpio (only applied to mx25/35)
> -			 */
> -			val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> -
>  		if (val & SDHCI_INT_CARD_INT) {
>  			/*
>  			 * Clear and then set D3CD bit to avoid missing the

Yay for removing ugly code!  Thanks for doing this; pushed to mmc-next
for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
