From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] sdhci: Advertise 2.0v on SDIO host interface
Date: Sat, 6 Jan 2018 13:44:28 +0100
Message-ID: <CAPDyKFoq2qF13+9yqt4HYmvqYWvcqtvxRp1wm=2uYbv_FiXNOA@mail.gmail.com>
References: <20180105203743.35201-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:34283 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbeAFMoa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Jan 2018 07:44:30 -0500
Received: by mail-it0-f48.google.com with SMTP id m11so7003045iti.1
        for <linux-mmc@vger.kernel.org>; Sat, 06 Jan 2018 04:44:30 -0800 (PST)
In-Reply-To: <20180105203743.35201-1-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 5 January 2018 at 21:37, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Intel Edison the Broadcom WiFi card, which is connected to SDIO,
> requires 2.0v, while the host, according to Intel Merrifield TRM,
> supports 1.8v I/O only.
>
> The card announces itself as
>
>   mmc2: new ultra high speed DDR50 SDIO card at address 0001
>
> Introduce a custom OCR mask and ->set_power() callback to override 2.0v
> signaling on Intel Merrifield platforms by enforcing 1.8v power choice.

This seems to be about VDD (vmmc) rather than about signaling voltage?

Could you verify that is the case? I think we have had too many cases
historically, which mixing the two voltages together and thus we end
up by luck getting things to work.

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - quirk free approach
>  drivers/mmc/host/sdhci-pci-core.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 3e4f04fd5175..029fcb19eb91 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -778,6 +778,7 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>                 slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>                 break;
>         case INTEL_MRFLD_SDIO:
> +               slot->host->ocr_mask = MMC_VDD_20_21 | MMC_VDD_165_195;

So this is about VDD and what VDD voltage levels the host support. If
there a way to find out these values dynamically, that should be done
instead.

>                 slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
>                                          MMC_CAP_POWER_OFF_CARD;
>                 break;
> @@ -789,10 +790,37 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>         return 0;
>  }
>
> +static void intel_mrfld_sdhci_set_power(struct sdhci_host *host,
> +                                       unsigned char mode, unsigned short vdd)
> +{
> +       if (IS_ERR(host->mmc->supply.vmmc)) {
> +               switch (1 << vdd) {
> +               case MMC_VDD_20_21:
> +                       sdhci_set_power_noreg(host, mode, ilog2(MMC_VDD_165_195));

This looks weird.

I don't think you should need to treat the MMC_VDD_20_21 in a special way.

Or perhaps this is because this is about signal voltage after all?

> +                       break;
> +               default:
> +                       sdhci_set_power_noreg(host, mode, vdd);
> +                       break;
> +               }
> +       } else {
> +               sdhci_set_power(host, mode, vdd);
> +       }
> +}
> +
> +static const struct sdhci_ops intel_mrfld_sdhci_pci_ops = {
> +       .set_clock              = sdhci_set_clock,
> +       .set_power              = intel_mrfld_sdhci_set_power,
> +       .enable_dma             = sdhci_pci_enable_dma,
> +       .set_bus_width          = sdhci_set_bus_width,
> +       .reset                  = sdhci_reset,
> +       .set_uhs_signaling      = sdhci_set_uhs_signaling,
> +};
> +
>  static const struct sdhci_pci_fixes sdhci_intel_mrfld_mmc = {
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>         .quirks2        = SDHCI_QUIRK2_BROKEN_HS200 |
>                         SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .ops            = &intel_mrfld_sdhci_pci_ops,
>         .allow_runtime_pm = true,
>         .probe_slot     = intel_mrfld_mmc_probe_slot,
>  };
> --
> 2.15.1
>

Kind regards
Uffe
