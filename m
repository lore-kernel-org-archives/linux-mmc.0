From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-bcm2835: Staticize bcm2835_sdhci_get_min_clock
Date: Sat, 24 Aug 2013 21:38:54 -0400
Message-ID: <87fvtyv9ap.fsf@octavius.laptop.org>
References: <1372228021-28895-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37984 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab3HYBjE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 21:39:04 -0400
In-Reply-To: <1372228021-28895-1-git-send-email-sachin.kamat@linaro.org>
	(Sachin Kamat's message of "Wed, 26 Jun 2013 11:57:01 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, swarren@wwwdotorg.org

Hi Sachin,

On Wed, Jun 26 2013, Sachin Kamat wrote:
> 'bcm2835_sdhci_get_min_clock' is used only in this file.
> Make it static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/sdhci-bcm2835.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
> index 0584a1c..36fa2df 100644
> --- a/drivers/mmc/host/sdhci-bcm2835.c
> +++ b/drivers/mmc/host/sdhci-bcm2835.c
> @@ -119,7 +119,7 @@ static u8 bcm2835_sdhci_readb(struct sdhci_host *host, int reg)
>  	return byte;
>  }
>  
> -unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
> +static unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
>  {
>  	return MIN_FREQ;
>  }

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
