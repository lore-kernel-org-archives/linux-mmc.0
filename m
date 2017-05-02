From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: arasan: Trivial print fix
Date: Tue, 2 May 2017 13:23:02 +0300
Message-ID: <3c89cef1-ce6c-fbcf-13e7-dd6f54194db7@intel.com>
References: <1493720396-37592-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:19461 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbdEBK2v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 May 2017 06:28:51 -0400
In-Reply-To: <1493720396-37592-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, michal.simek@xilinx.com, shubhrajyoti.datta@gmail.com

On 02/05/17 13:19, Shubhrajyoti Datta wrote:

Subject should be consistent and most patches have been starting with:

	mmc: sdhci-of-arasan:

> ret is signed however is printed as unsigned fix the same.
> If printed as a negative number the result is easier to read.
> No functional change.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 1de40e6..77cc68b 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -704,7 +704,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret) {
> -		dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
> +		dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
>  		goto unreg_clk;
>  	}
>  
> 

