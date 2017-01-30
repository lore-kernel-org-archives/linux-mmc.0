From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv1 1/2] mmc: sdhci-msm: Remove platform_execute_tuning from sdhci_msm_ops
Date: Mon, 30 Jan 2017 11:04:24 +0100
Message-ID: <CAPDyKFrXjdx+9scxwo13V-SZ_zgePSMy6kmM+FydizU45zdRRQ@mail.gmail.com>
References: <1485247827-12898-1-git-send-email-riteshh@codeaurora.org> <1485247827-12898-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38658 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdA3K3B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 05:29:01 -0500
Received: by mail-wm0-f46.google.com with SMTP id r141so26517331wmg.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2017 02:27:57 -0800 (PST)
In-Reply-To: <1485247827-12898-2-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Pramod Gurav <pramod.gurav@linaro.org>, jeremymc@redhat.com, git@kchr.de

On 24 January 2017 at 09:50, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> platform_execute_tuning should not really exist as it does not
> do anything useful.
>
> So remove this ops and directly plug sdhci_msm_execute_tuning
> with mmc_host_ops.
>
> Also in case of HS400 tuning clear SDHCI_HS400_TUNING flag once
> HS400 related mode selection is done.
>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index f958697..b3e8f44 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -827,12 +827,12 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>         return ret;
>  }
>
> -static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
> +static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
> +       struct sdhci_host *host = mmc_priv(mmc);
>         int tuning_seq_cnt = 3;
>         u8 phase, tuned_phases[16], tuned_phase_cnt = 0;
>         int rc;
> -       struct mmc_host *mmc = host->mmc;
>         struct mmc_ios ios = host->mmc->ios;
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> @@ -855,6 +855,7 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>         if (host->flags & SDHCI_HS400_TUNING) {
>                 sdhci_msm_hc_select_mode(host);
>                 msm_set_clock_rate_for_bus_mode(host, ios.clock);
> +               host->flags &= ~SDHCI_HS400_TUNING;
>         }
>
>  retry:
> @@ -1119,7 +1120,6 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
>
>  static const struct sdhci_ops sdhci_msm_ops = {
> -       .platform_execute_tuning = sdhci_msm_execute_tuning,
>         .reset = sdhci_reset,
>         .set_clock = sdhci_msm_set_clock,
>         .get_min_clock = sdhci_msm_get_min_clock,
> @@ -1294,6 +1294,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                                          MSM_MMC_AUTOSUSPEND_DELAY_MS);
>         pm_runtime_use_autosuspend(&pdev->dev);
>
> +       host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto pm_runtime_disable;
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>
