From: Jingoo Han <jg1.han@samsung.com>
Subject: RE: [PATCH] mmc: sdhci-s3c: use dev_pm_ops
Date: Wed, 14 Dec 2011 13:50:21 +0900
Message-ID: <003a01ccba1b$e2a63b10$a7f2b130$%han@samsung.com>
References: <003901ccba18$8e421a60$aac64f20$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38403 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab1LNEuV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 23:50:21 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LW600GMMG36WID0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 14 Dec 2011 13:50:20 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.153])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LW60046FG3W0Y30@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Wed, 14 Dec 2011 13:50:20 +0900 (KST)
In-reply-to: <003901ccba18$8e421a60$aac64f20$%han@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Ben Dooks' <ben-linux@fluff.org>, 'Jingoo Han' <jg1.han@samsung.com>

I have just checked mmc-next branch.
Please, don't submit this patch.

Thank you.

> -----Original Message-----
> Subject: [PATCH] mmc: sdhci-s3c: use dev_pm_ops
> 
> Instead of using legacy suspend/resume methods, using newer dev_pm_ops
> structure allows better control over power management.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   19 +++++++++++++------
>  1 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index cb60c41..5272c74 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -621,17 +621,18 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  }
> 
>  #ifdef CONFIG_PM
> -
> -static int sdhci_s3c_suspend(struct platform_device *dev, pm_message_t pm)
> +static int sdhci_s3c_suspend(struct device *dev)
>  {
> -	struct sdhci_host *host = platform_get_drvdata(dev);
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> 
> -	return sdhci_suspend_host(host, pm);
> +	return sdhci_suspend_host(host, PMSG_SUSPEND);
>  }
> 
> -static int sdhci_s3c_resume(struct platform_device *dev)
> +static int sdhci_s3c_resume(struct device *dev)
>  {
> -	struct sdhci_host *host = platform_get_drvdata(dev);
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> 
>  	return sdhci_resume_host(host);
>  }
> @@ -641,12 +642,18 @@ static int sdhci_s3c_resume(struct platform_device *dev)
>  #define sdhci_s3c_resume NULL
>  #endif
> 
> +static const struct dev_pm_ops sdhci_s3c_pm_ops = {
> +	.suspend	= sdhci_s3c_suspend,
> +	.resume		= sdhci_s3c_resume,
> +};
> +
>  static struct platform_driver sdhci_s3c_driver = {
>  	.probe		= sdhci_s3c_probe,
>  	.remove		= __devexit_p(sdhci_s3c_remove),
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "s3c-sdhci",
> +		.pm	= &sdhci_s3c_pm_ops,
>  	},
>  };
> 
> --
> 1.7.1


