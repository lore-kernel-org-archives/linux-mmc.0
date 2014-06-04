From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove use of card_tasklet,
 which no longer exists
Date: Thu, 05 Jun 2014 07:56:15 +0900
Message-ID: <538FA40F.5040509@samsung.com>
References: <86mwdspk58.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47047 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaFDW4S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 18:56:18 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6O002AQ2DSKP30@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 05 Jun 2014 07:56:16 +0900 (KST)
In-reply-to: <86mwdspk58.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>

Hi, Chris.

Didn't you want to merge the below patch?

https://patchwork.kernel.org/patch/4239541/

I have tested with exynos series, and working fine.

Best Regards,
Jaehoon Chung

On 06/05/2014 04:08 AM, Chris Ball wrote:
> "mmc: sdhci: push card_tasklet into threaded irq handler" removed
> the card_tasklet, but it is still in use by sdhci-s3c.c.
> 
> Signed-off-by: Chris Ball <chris@printf.net>
> ---
> Hi,
> 
> sdhci-s3c is currently failing to build due to the removal of
> card_tasklet.  I think this trivial patch might do the right
> thing -- please could someone test that card detection still
> works and ACK if so?  Thanks!
> 
>  drivers/mmc/host/sdhci-s3c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 781b8a9..53a32e2 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -399,7 +399,6 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
>  			clk_disable_unprepare(sc->clk_io);
>  #endif
>  		}
> -		tasklet_schedule(&host->card_tasklet);
>  		spin_unlock_irqrestore(&host->lock, flags);
>  	}
>  }
> 

