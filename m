From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: ignore restoring the I/O state if MMC_POWER_OFF
Date: Tue, 8 Aug 2017 12:38:07 +0200
Message-ID: <CAPDyKFr1U+tG8tf6o_xjxA384GzNTAeBMZWCj2SQ2gKHh_30Og@mail.gmail.com>
References: <1501788520-26244-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33894 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbdHHKiI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 06:38:08 -0400
Received: by mail-qk0-f177.google.com with SMTP id u139so17117186qka.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2017 03:38:08 -0700 (PDT)
In-Reply-To: <1501788520-26244-1-git-send-email-zjwu@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 3 August 2017 at 21:28, Zhoujie Wu <zjwu@marvell.com> wrote:
> One issue was found on a removable high speed sd card with
> runtime pm enabled.
> When SD card is unplugged, it keep printing "Switching to 3.3V
> signalling voltage failed".
> And found below sequence triggers the error.
>
> mmc_rescan
>         -> mmc_sd_detect
>                 -> mmc_power_off  -- mmc->ios.vdd is updated to 0.
>         -> mmc_claim_host
>                 -> sdhci_runtime_resume_host
>                         -> sdhci_start_signal_voltage_switch
>                                 -> mmc_regulator_set_vqmmc
>                                         -> mmc_ocrbitnum_to_vdd
>
> When mmc_ocrbitnum_to_vdd is called, the mmc->ios.vdd is 0, so it
> always return -EINVAL. The signal switch will always fail and
> print out warning.
> Ignore restoring the I/O state when runtime resume if MMC_POWER_OFF.
>
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> This patch is the updated version for my previous patch
> mmc: sdhci: ignore 3.3v voltage switch if ios.vdd is 0.
> Suggested by Adrian, so added his name in signed-off-by as well.
>
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 98700f9..c3f67f1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2934,7 +2934,8 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>
>         sdhci_init(host, 0);
>
> -       if (mmc->ios.power_mode != MMC_POWER_UNDEFINED) {
> +       if (mmc->ios.power_mode != MMC_POWER_UNDEFINED &&
> +           mmc->ios.power_mode != MMC_POWER_OFF) {
>                 /* Force clock and power re-program */
>                 host->pwr = 0;
>                 host->clock = 0;
> --
> 1.9.1
>
