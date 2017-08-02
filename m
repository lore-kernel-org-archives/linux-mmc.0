From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: ignore 3.3v voltage switch if ios.vdd is 0
Date: Wed, 2 Aug 2017 10:28:23 +0300
Message-ID: <9bae1ec1-9c40-d496-d6c9-b874844995fc@intel.com>
References: <1501631901-1304-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:3904 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbdHBHhg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Aug 2017 03:37:36 -0400
In-Reply-To: <1501631901-1304-1-git-send-email-zjwu@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

On 02/08/17 02:58, Zhoujie Wu wrote:
> One issue was found on a removable high speed sd card with
> runtime pm enabled.
> When SD card is unplugged, it keep printing "Switching to 3.3V
> signalling voltage failed".
> And found below sequence triggers the error.
> 
> mmc_rescan
> 	-> mmc_sd_detect
> 		-> mmc_power_off  -- mmc->ios.vdd is update to 0.
> 	-> mmc_claim_host
> 		-> sdhci_runtime_resume_host
> 			-> sdhci_start_signal_voltage_switch

We ought to be able to skip restoring the I/O state when the power is off i.e.:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cf2166e4190d..4a70f2f765b6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2934,7 +2934,8 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)

 	sdhci_init(host, 0);

-	if (mmc->ios.power_mode != MMC_POWER_UNDEFINED) {
+	if (mmc->ios.power_mode != MMC_POWER_UNDEFINED &&
+	    mmc->ios.power_mode != MMC_POWER_OFF) {
 		/* Force clock and power re-program */
 		host->pwr = 0;
 		host->clock = 0;


> 				-> mmc_regulator_set_vqmmc
> 					-> mmc_ocrbitnum_to_vdd
> 
> When mmc_ocrbitnum_to_vdd is called, the mmc->ios.vdd is 0, so it
> always return -EINVAL. The signal switch will always fail and
> print out warning.
> 
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> ---
> Hi Ulf,
> 	Not sure if this is the best way to fix it. Please help to suggest. Thanks.
> 
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ecd0d43..011ebbe 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1878,7 +1878,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		ctrl &= ~SDHCI_CTRL_VDD_180;
>  		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>  
> -		if (!IS_ERR(mmc->supply.vqmmc)) {
> +		if ((!IS_ERR(mmc->supply.vqmmc)) && mmc->ios.vdd) {
>  			ret = mmc_regulator_set_vqmmc(mmc, ios);
>  			if (ret) {
>  				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
> 

