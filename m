From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: ignore timing DDR52 in tuning
Date: Mon, 24 Jul 2017 13:47:20 +0300
Message-ID: <46c596c6-238f-36ca-40b8-660341b225e2@intel.com>
References: <1500661858-17610-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14502 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbdGXKys (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Jul 2017 06:54:48 -0400
In-Reply-To: <1500661858-17610-1-git-send-email-zjwu@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

On 21/07/17 21:30, Zhoujie Wu wrote:
> Emmc DDR52 mode uses fixed delay, return earlier if
> timing is MMC_TIMING_MMC_DDR52 in execute tuning function.
> 
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-xenon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 6ef33aa..edd4d915 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -311,7 +311,8 @@ static int xenon_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  
> -	if (host->timing == MMC_TIMING_UHS_DDR50)
> +	if (host->timing == MMC_TIMING_UHS_DDR50 ||
> +		host->timing == MMC_TIMING_MMC_DDR52)
>  		return 0;
>  
>  	/*
> 

