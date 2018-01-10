From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] sdhci: Advertise 2.0v supply on SDIO host interface
Date: Wed, 10 Jan 2018 18:01:36 +0100
Message-ID: <CAPDyKFoRDhx9VzyUjxK=5u+JLcBait29hLozbhX_B9Zov61COA@mail.gmail.com>
References: <20180110153250.13094-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:44092 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbeAJRBh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jan 2018 12:01:37 -0500
Received: by mail-it0-f66.google.com with SMTP id b5so178960itc.3
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jan 2018 09:01:37 -0800 (PST)
In-Reply-To: <20180110153250.13094-1-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10 January 2018 at 16:32, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Intel Edison the Broadcom WiFi card, which is connected to SDIO,
> requires 2.0v, while the host, according to Intel Merrifield TRM,
> supports 1.8v supply only.
>
> The card announces itself as
>
>   mmc2: new ultra high speed DDR50 SDIO card at address 0001
>
> Introduce a custom OCR mask and ->set_power() callback to override 2.0v
> supply on Intel Merrifield platforms by enforcing 1.8v power choice.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - address comments given by Adrian
>  drivers/mmc/host/sdhci-pci-core.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 3e4f04fd5175..24c2b2504b3f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -778,6 +778,8 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>                 slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>                 break;
>         case INTEL_MRFLD_SDIO:
> +               /* Advertise 2.0v for compatibility with the SDIO card's OCR */
> +               slot->host->ocr_mask = MMC_VDD_20_21 | MMC_VDD_165_195;
>                 slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
>                                          MMC_CAP_POWER_OFF_CARD;
>                 break;
> @@ -789,10 +791,35 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>         return 0;
>  }
>
> +static void intel_mrfld_sdhci_set_power(struct sdhci_host *host,
> +                                       unsigned char mode, unsigned short vdd)
> +{
> +       /*
> +        * Without a regulator, SDHCI does not support 2.0v but we get
> +        * here because we advertised 2.0v support for compatibility
> +        * with the SDIO card's OCR. Map it to 1.8v for the purpose of
> +        * turning on the power.
> +        */
> +       if (IS_ERR(host->mmc->supply.vmmc) && vdd == ilog2(MMC_VDD_20_21))
> +               vdd = ilog2(MMC_VDD_165_195);

Why not instead extend the range in sdhci_set_power_noreg() to also
check for MMC_VDD_20_21?

Or is there a problem with that?

> +
> +       sdhci_set_power(host, mode, vdd);
> +}
> +

Kind regards
Uffe
