From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [v5 4/4] mmc: sdhci-cadence: refactor probe function
Date: Wed, 29 Mar 2017 16:03:48 +0300
Message-ID: <e8d41b5d-55db-9ed1-6bb1-d197fc547dd6@intel.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
 <1490106806-3936-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:44907 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932308AbdC2NL3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 29 Mar 2017 09:11:29 -0400
In-Reply-To: <1490106806-3936-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>

On 21/03/17 16:33, Piotr Sroka wrote:
> Use added dev variable for devm_clk_get.
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes for v5:
> - patch created in v5
> ---
>  drivers/mmc/host/sdhci-cadence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index c3c7090..5aa238d 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -305,7 +305,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  
> -	clk = devm_clk_get(&pdev->dev, NULL);
> +	clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> 

