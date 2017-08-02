From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] mmc: sdhci: ignore 3.3v voltage switch if ios.vdd is 0
Date: Wed, 02 Aug 2017 09:36:56 +0200
Message-ID: <877eymbeuf.fsf@free-electrons.com>
References: <1501631901-1304-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36040 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbdHBHhI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Aug 2017 03:37:08 -0400
In-Reply-To: <1501631901-1304-1-git-send-email-zjwu@marvell.com> (Zhoujie Wu's
        message of "Tue, 1 Aug 2017 16:58:21 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, thomas.petazzoni@free-electrons.com

Hi Zhoujie, Adrian and Ulf, 
 
 On mar., août 01 2017, Zhoujie Wu <zjwu@marvell.com> wrote:

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
> 	Not sure if this is the best way to fix it. Please help to
> suggest. Thanks.

I don't know if there is a link, but I observed that when the kernel
boot with an UHS SD Card plugged (and after a warm reset) then the bus
speed is only "High Speed". Whereas if I plugged it while the kernel is
running the "Ultra " speed is detected.

I observed that with the sdhci-xenon driver, but I don't have any other
UHS capable controller available to compare it and to know if it is
something at sdhci level or at xenon level.

Thanks,

Gregory

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
> -- 
> 1.9.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
