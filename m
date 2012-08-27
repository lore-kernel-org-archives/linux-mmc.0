From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc: break out early if clock is 0
Date: Mon, 27 Aug 2012 19:07:37 -0400
Message-ID: <87txvox7ba.fsf@octavius.laptop.org>
References: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60902 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab2H0XHl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Aug 2012 19:07:41 -0400
In-Reply-To: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Wed, 22 Aug 2012 23:10:01 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, Aug 22 2012, Shawn Guo wrote:
> Since commit 30832ab (mmc: sdhci: Always pass clock request value zero
> to set_clock host op) gets in, esdhc_set_clock starts hitting
> "if (clock == 0)" where ESDHC_SYSTEM_CONTROL has been operated.  This
> causes SDHCI card-detection function being broken.  Fix the regression
> by moving "if (clock == 0)" above ESDHC_SYSTEM_CONTROL operation.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index b97b2f5..d25f9ab 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -48,14 +48,14 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
>  	int div = 1;
>  	u32 temp;
>  
> +	if (clock == 0)
> +		goto out;
> +
>  	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
>  	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
>  		| ESDHC_CLOCK_MASK);
>  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>  
> -	if (clock == 0)
> -		goto out;
> -
>  	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
>  		pre_div *= 2;

Thanks, pushed to mmc-next for 3.6.  (stable@ shouldn't be CC'd.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
