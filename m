From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH] mmc: sdhci-of-at91: don't put device in suspend after
 probe
Date: Wed, 10 Feb 2016 13:50:44 +0200
Message-ID: <56BB2414.1040606@intel.com>
References: <1455098283-14500-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21615 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757562AbcBJLyP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Feb 2016 06:54:15 -0500
In-Reply-To: <1455098283-14500-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com

On 10/02/16 11:58, Ludovic Desroches wrote:
> By putting the device in suspend at the end of the probe, it is
> impossible to wake up on non software event such as card
> insertion/removal.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> 
> Hi,
> 
> Since I had no feedback on this topic:
> http://permalink.gmane.org/gmane.linux.kernel.mmc/35160
> 
> I would like to no more put the device in suspend at the end of the probe. If
> my device is suspended at the end of the probe, I have no issue to resume on
> a software event such as mounting my sdcard but hardware event such as card
> insertion and removal do not trigger a resume.

You can't use runtime PM unless you have a way to wake-up.

Currently, sdhci disables card detect interrupts when runtime suspended,
and drivers use a card-detect GPIO to wake-up.


> 
> It seems there are only two sdhci drivers using runtime pm so maybe nobody has
> noticed this issue.
> 
> Regards
> 
> Ludovic
> 
>  drivers/mmc/host/sdhci-of-at91.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 9cb86fb..ae24dea 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -210,8 +210,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto pm_runtime_disable;
>  
> -	pm_runtime_put_autosuspend(&pdev->dev);
> -
>  	return 0;
>  
>  pm_runtime_disable:
> 

