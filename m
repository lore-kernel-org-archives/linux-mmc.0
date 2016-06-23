From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-msm: fix spelling mistake: "Perpheral" ->
 "Peripheral"
Date: Thu, 23 Jun 2016 13:38:23 +0300
Message-ID: <576BBC1F.3050702@intel.com>
References: <1466675526-3176-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55879 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbcFWKmb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jun 2016 06:42:31 -0400
In-Reply-To: <1466675526-3176-1-git-send-email-colin.king@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On 23/06/16 12:52, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> trivial fix to spelling mistake in dev_err message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 0653fe7..343e4bd 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -473,7 +473,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	msm_host->pclk = devm_clk_get(&pdev->dev, "iface");
>  	if (IS_ERR(msm_host->pclk)) {
>  		ret = PTR_ERR(msm_host->pclk);
> -		dev_err(&pdev->dev, "Perpheral clk setup failed (%d)\n", ret);
> +		dev_err(&pdev->dev, "Peripheral clk setup failed (%d)\n", ret);
>  		goto bus_clk_disable;
>  	}
>  
> 

