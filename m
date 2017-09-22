From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Fix voltage switch for some Intel host controllers
Date: Fri, 22 Sep 2017 11:45:45 +0200
Message-ID: <CAPDyKFqAQ_0JEBC7DisOrXz+tL1gC=U6tdNU+uhZOj178PtUug@mail.gmail.com>
References: <1505736968-18891-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:53172 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdIVJpq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 05:45:46 -0400
Received: by mail-it0-f47.google.com with SMTP id c195so785039itb.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 02:45:46 -0700 (PDT)
In-Reply-To: <1505736968-18891-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 18 September 2017 at 14:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Some Intel host controllers (e.g. CNP) use an ACPI device-specific method
> to ensure correct voltage switching. Fix voltage switch for those, by
> adding a call to the DSM.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index bbaddf18a1b3..d0ccc6729fd2 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -392,6 +392,7 @@ static int mfd_sdio_probe_slot(struct sdhci_pci_slot *slot)
>
>  enum {
>         INTEL_DSM_FNS           =  0,
> +       INTEL_DSM_V18_SWITCH    =  3,
>         INTEL_DSM_DRV_STRENGTH  =  9,
>         INTEL_DSM_D3_RETUNE     = 10,
>  };
> @@ -557,6 +558,19 @@ static void intel_hs400_enhanced_strobe(struct mmc_host *mmc,
>         sdhci_writel(host, val, INTEL_HS400_ES_REG);
>  }
>
> +static void sdhci_intel_voltage_switch(struct sdhci_host *host)
> +{
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct intel_host *intel_host = sdhci_pci_priv(slot);
> +       struct device *dev = &slot->chip->pdev->dev;
> +       u32 result = 0;
> +       int err;
> +
> +       err = intel_dsm(intel_host, dev, INTEL_DSM_V18_SWITCH, &result);
> +       pr_debug("%s: %s DSM error %d result %u\n",
> +                mmc_hostname(host->mmc), __func__, err, result);
> +}
> +
>  static const struct sdhci_ops sdhci_intel_byt_ops = {
>         .set_clock              = sdhci_set_clock,
>         .set_power              = sdhci_intel_set_power,
> @@ -565,6 +579,7 @@ static void intel_hs400_enhanced_strobe(struct mmc_host *mmc,
>         .reset                  = sdhci_reset,
>         .set_uhs_signaling      = sdhci_set_uhs_signaling,
>         .hw_reset               = sdhci_pci_hw_reset,
> +       .voltage_switch         = sdhci_intel_voltage_switch,
>  };
>
>  static void byt_read_dsm(struct sdhci_pci_slot *slot)
> --
> 1.9.1
>
