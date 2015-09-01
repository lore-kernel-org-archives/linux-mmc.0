From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pxav3: Print ret value on error from
 sdhci_add_host() fn
Date: Tue, 01 Sep 2015 13:37:18 -0700
Message-ID: <1441139838.12163.5.camel@perches.com>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
	 <1441135454-6902-3-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:55731 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752023AbbIAUhX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2015 16:37:23 -0400
In-Reply-To: <1441135454-6902-3-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
> Return value would give clear information about the actual root-cause
> of the failure.

I'm not sure why that is as nearly every error path in
sdhci_add_host emits a message.

> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
[]
> @@ -455,7 +455,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  
>  	ret = sdhci_add_host(host);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to add host\n");
> +		dev_err(&pdev->dev, "failed to add host ret - %d\n", ret);
>  		goto err_add_host;
>  	}
>  

If this is really desirable, there are many other callers of
sdhci_add_host with error messages just like this one.

