From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/3] mmc: replacing hardcoded value for runtime PM suspend
Date: Fri, 2 Sep 2016 15:39:49 +0800
Message-ID: <cc6129e7-5250-8c2e-73e0-1134e2a7146d@rock-chips.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
 <1472739890-3384-2-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:56723 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbcIBHkk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2016 03:40:40 -0400
In-Reply-To: <1472739890-3384-2-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: alex lemberg <alex.lemberg@sandisk.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, avi.shchislowski@sandisk.com

Hi

On 2016/9/1 22:24, alex lemberg wrote:
> Add MMC_AUTOSUSPEND_DELAY_MS define

I'm thinking should we expose it to userspace
via sysfs, since I don't know why it should be 3ms, not 4ms, 5ms, etc.


>
> Signed-off-by: alex lemberg <alex.lemberg@sandisk.com>
> ---
>  drivers/mmc/card/block.c | 3 ++-
>  include/linux/mmc/host.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 48a5dd7..f4386ed 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2610,7 +2610,8 @@ static int mmc_blk_probe(struct mmc_card *card)
>  			goto out;
>  	}
>
> -	pm_runtime_set_autosuspend_delay(&card->dev, 3000);
> +	pm_runtime_set_autosuspend_delay(&card->dev,
> +		MMC_RUNTIME_SUSPEND_DELAY_MS);
>  	pm_runtime_use_autosuspend(&card->dev);
>
>  	/*
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index aa4bfbf..8cb8218 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -22,6 +22,8 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/pm.h>
>
> +#define MMC_RUNTIME_SUSPEND_DELAY_MS	3000
> +
>  struct mmc_ios {
>  	unsigned int	clock;			/* clock rate */
>  	unsigned short	vdd;
>


-- 
Best Regards
Shawn Lin

