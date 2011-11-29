From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove old and misprototyped suspend
 operations
Date: Wed, 30 Nov 2011 00:05:40 +0900
Message-ID: <4ED4F4C4.2020805@samsung.com>
References: <1321898451-5347-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29416 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab1K2PJU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2011 10:09:20 -0500
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LVF00CSUGRICOU0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Nov 2011 00:09:19 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LVF00GMVGLHUB00@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Nov 2011 00:05:41 +0900 (KST)
In-reply-to: <1321898451-5347-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, patches@opensource.wolfsonmicro.com

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 11/22/2011 03:00 AM, Mark Brown wrote:

> Now that the driver is using dev_pm_ops the suspend operations in the
> platform_driver structure won't get called so don't need to be there,
> and certainly shouldn't be the same function as dev_pm_ops since the
> signatures are different.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 4cb272c..9a20d1f 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -647,8 +647,6 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
>  static struct platform_driver sdhci_s3c_driver = {
>  	.probe		= sdhci_s3c_probe,
>  	.remove		= __devexit_p(sdhci_s3c_remove),
> -	.suspend	= sdhci_s3c_suspend,
> -	.resume	        = sdhci_s3c_resume,
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "s3c-sdhci",


