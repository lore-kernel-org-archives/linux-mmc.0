From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-s3c: Use CONFIG_PM_SLEEP to ifdef system
 suspend
Date: Mon, 02 Jan 2012 11:07:59 +0900
Message-ID: <4F01117F.6000206@samsung.com>
References: <1325211872-12567-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46676 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab2ABCIC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Jan 2012 21:08:02 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LX5008OMF9B7D10@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 02 Jan 2012 11:08:00 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LX500JLAF9COE50@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 02 Jan 2012 11:08:00 +0900 (KST)
In-reply-to: <1325211872-12567-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi Mark.

On 12/30/2011 11:24 AM, Mark Brown wrote:

> This matches current best practice as one can have runtime PM enabled
> without system sleep and CONFIG_PM is defined for both.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 1af756e..df066b5 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -20,6 +20,7 @@
>  #include <linux/io.h>
>  #include <linux/gpio.h>
>  #include <linux/module.h>
> +#include <linux/pm.h>

I think this include is unnecessary.

Thanks,
Jaehoon Chung

>  
>  #include <linux/mmc/host.h>
>  
> @@ -620,8 +621,7 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -
> +#ifdef CONFIG_PM_SLEEP
>  static int sdhci_s3c_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> @@ -635,10 +635,11 @@ static int sdhci_s3c_resume(struct device *dev)
>  
>  	return sdhci_resume_host(host);
>  }
> +#endif
>  
> +#ifdef CONFIG_PM
>  static const struct dev_pm_ops sdhci_s3c_pmops = {
> -	.suspend	= sdhci_s3c_suspend,
> -	.resume		= sdhci_s3c_resume,
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_s3c_suspend, sdhci_s3c_resume)
>  };
>  
>  #define SDHCI_S3C_PMOPS (&sdhci_s3c_pmops)


