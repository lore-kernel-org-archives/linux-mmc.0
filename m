From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/7] mmc: sdhci-pltfm: bail out if register resource is
 too small
Date: Tue, 19 Apr 2016 14:32:36 +0300
Message-ID: <57161754.5050303@intel.com>
References: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
 <1460600990-10993-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26222 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbcDSLgY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Apr 2016 07:36:24 -0400
In-Reply-To: <1460600990-10993-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 14/04/16 05:29, Masahiro Yamada wrote:
> This code checks the resource size and displays an error message if
> it is too small, but still moves forward.  Let is fail in that case.

is -> it

How do you know there aren't drivers that actually have a smaller size?

One that might not is sdhci-dove which appears to sidestep some registers in
sdhci_dove_readw().


> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/mmc/host/sdhci-pltfm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 072bb27..7d12203 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -127,8 +127,11 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>  		goto err;
>  	}
>  
> -	if (resource_size(iomem) < 0x100)
> +	if (resource_size(iomem) < 0x100) {
>  		dev_err(&pdev->dev, "Invalid iomem size!\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
>  
>  	host = sdhci_alloc_host(&pdev->dev,
>  		sizeof(struct sdhci_pltfm_host) + priv_size);
> 

