From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: call sdhci_card_event() instead of card
 tasklet
Date: Fri, 30 May 2014 13:41:30 +0900
Message-ID: <53880BFA.8060007@samsung.com>
References: <000c01cf7bbb$1e190250$5a4b06f0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:65301 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaE3Elc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 May 2014 00:41:32 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6D00D33ED65KD0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 30 May 2014 13:41:30 +0900 (KST)
In-reply-to: <000c01cf7bbb$1e190250$5a4b06f0$%han@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Chris Ball' <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, 'Ben Dooks' <ben-linux@fluff.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Seungwon Jeon' <tgih.jun@samsung.com>

Hi, Jingoo.

did you test with your patch? It didn't work.
And we don't maintain the sdhci_s3c_notify_change(). Instead, we can use the API of slot-gpio and mmc_of_parse().

https://patchwork.kernel.org/patch/4239541/

Best Regards,
Jaehoon Chung

On 05/30/2014 12:56 PM, Jingoo Han wrote:
> The card tasklet was removed by the commit 3560db8 (mmc: sdhci:
> push card_tasklet into threaded irq handler). However, the task
> let has been used by sdhci_s3c_notify_change() in order to handle
> GPIO detection. Then, it calls sdhci_tasklet_card().
> 
> The card tasklet eventually called sdhci_card_event(). Thus,
> the sdhci_card_event() should be called directly instead of
> the card tasklet.
> 
> This patch also fixes the following build error.
> drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_notify_change'
> drivers/mmc/host/sdhci-s3c.c:402:25: error: 'struct sdhci_host' has no member named 'card_tasklet'
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 781b8a9..4386e91 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -399,7 +399,8 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
>  			clk_disable_unprepare(sc->clk_io);
>  #endif
>  		}
> -		tasklet_schedule(&host->card_tasklet);
> +		host->mmc->ops->card_event(host->mmc);
> +		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
>  		spin_unlock_irqrestore(&host->lock, flags);
>  	}
>  }
> 

