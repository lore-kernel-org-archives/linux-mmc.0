From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH -next] mmc: sdhci-msm: Fix error return code in
 sdhci_msm_probe()
Date: Thu, 27 Oct 2016 09:24:20 +0300
Message-ID: <2005a16c-5cf4-25ad-b01b-5bbf25c751c2@intel.com>
References: <1477494281-24246-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:17165 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbcJ0G3N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 27 Oct 2016 02:29:13 -0400
In-Reply-To: <1477494281-24246-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-mmc@vger.kernel.org

On 26/10/16 18:04, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return a negative error code from the platform_get_irq_byname()
> error handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: ad81d3871004 ("mmc: sdhci-msm: Add support for UHS cards")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 795f16f..b78d72f 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -649,6 +649,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	if (msm_host->pwr_irq < 0) {
>  		dev_err(&pdev->dev, "Get pwr_irq failed (%d)\n",
>  			msm_host->pwr_irq);
> +		ret = msm_host->pwr_irq;
>  		goto clk_disable;
>  	}
> 
> 

