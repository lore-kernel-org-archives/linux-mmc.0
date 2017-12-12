From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Disable clk_xin clock in the remove
Date: Tue, 12 Dec 2017 10:37:22 +0100
Message-ID: <3d975547-3f25-eaab-29fe-c06ee4cb206b@xilinx.com>
References: <20171212081955.2309-1-flavio.ceolin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0059.outbound.protection.outlook.com ([104.47.34.59]:34496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750715AbdLLJhi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 12 Dec 2017 04:37:38 -0500
In-Reply-To: <20171212081955.2309-1-flavio.ceolin@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Flavio Ceolin <flavio.ceolin@intel.com>, linux-kernel@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI...)" <linux-mmc@vger.kernel.org>

On 12.12.2017 09:19, Flavio Ceolin wrote:
> clk_xin is properly prepared/enabled on sdhci_arasan_probe(), and
> unprepared/disabled in the error path, but it is not being
> unprepared/disabled on sdhci_arasan_remove().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Flavio Ceolin <flavio.ceolin@intel.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 0720ea7..69bd260 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -692,6 +692,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>  	struct clk *clk_ahb = sdhci_arasan->clk_ahb;
> +	struct clk *clk_xin = devm_clk_get(&pdev->dev, "clk_xin");

I don't think this is right. You have already asked for this clock in
probe. It means you should reuse pltfm_host->clk = clk_xin;

And if you look at sdhci_pltfm_unregister you will find out that
clk_disable_unprepare(pltfm_host->clk);
is called there.

>  
>  	if (!IS_ERR(sdhci_arasan->phy)) {
>  		if (sdhci_arasan->is_phy_on)
> @@ -705,6 +706,9 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(clk_ahb);
>  
> +	if (!IS_ERR(clk_xin))

And clk_xin is required property.

> +		clk_disable_unprepare(clk_xin);
> +
>  	return ret;
>  }
>  
> 

It means NACK from me.

Thanks,
Michal
