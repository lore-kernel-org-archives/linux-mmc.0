From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 4/6] mmc: sdhci-s3c: Handle error from mmc_of_parse()
Date: Mon, 22 Dec 2014 13:23:29 +0900
Message-ID: <54979CC1.2040107@samsung.com>
References: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
 <1418895704-25908-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39839 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbaLVEXb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Dec 2014 23:23:31 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NGY004MQUV56O10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 22 Dec 2014 13:23:29 +0900 (KST)
In-reply-to: <1418895704-25908-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 12/18/2014 06:41 PM, Ulf Hansson wrote:
> Since mmc_of_parse() may fail, let's deal with it and thus do proper
> error handling.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index c45b893..a282822 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -607,7 +607,9 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_suspend_ignore_children(&pdev->dev, 1);
>  
> -	mmc_of_parse(host->mmc);
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret)
> +		goto err_req_regs;
>  
>  	ret = sdhci_add_host(host);
>  	if (ret) {
> 

