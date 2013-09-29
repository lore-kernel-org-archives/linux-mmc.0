From: Sascha Sommer <saschasommer@freenet.de>
Subject: Re: [PATCH 22/27] mmc: sdricoh_cs: Move away from using deprecated
 APIs
Date: Sun, 29 Sep 2013 19:56:42 +0200
Message-ID: <20130929195642.7cefc9ef@madeira.sommer.dynalias.net>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
	<1380207292-16968-23-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout2.freenet.de ([195.4.92.92]:57328 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754874Ab3I2SVY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 29 Sep 2013 14:21:24 -0400
In-Reply-To: <1380207292-16968-23-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi,

Am Thu, 26 Sep 2013 16:54:47 +0200
schrieb Ulf Hansson <ulf.hansson@linaro.org>:

> Suspend and resume of cards are being handled from the protocol layer
> and consequently the mmc_suspend|resume_host APIs are deprecated.
> 
> This means we can simplify the suspend|resume callbacks by removing
> the use of the deprecated APIs.
> 
> Cc: Sascha Sommer <saschasommer@freenet.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/sdricoh_cs.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdricoh_cs.c
> b/drivers/mmc/host/sdricoh_cs.c index 50adbd1..b7e3057 100644
> --- a/drivers/mmc/host/sdricoh_cs.c
> +++ b/drivers/mmc/host/sdricoh_cs.c
> @@ -516,9 +516,7 @@ static void sdricoh_pcmcia_detach(struct
> pcmcia_device *link) #ifdef CONFIG_PM
>  static int sdricoh_pcmcia_suspend(struct pcmcia_device *link)
>  {
> -	struct mmc_host *mmc = link->priv;
>  	dev_dbg(&link->dev, "suspend\n");
> -	mmc_suspend_host(mmc);
>  	return 0;
>  }
>  
> @@ -527,7 +525,6 @@ static int sdricoh_pcmcia_resume(struct
> pcmcia_device *link) struct mmc_host *mmc = link->priv;
>  	dev_dbg(&link->dev, "resume\n");
>  	sdricoh_reset(mmc_priv(mmc));
> -	mmc_resume_host(mmc);
>  	return 0;
>  }
>  #else

Acked-by: Sascha Sommer <saschasommer@freenet.de> 


Regards

Sascha
