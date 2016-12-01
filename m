From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] mmc: sdhci-pci: Add PCI ID for Intel byt sdio host
 controller sub-vended by NI
Date: Thu, 1 Dec 2016 09:14:09 +0100
Message-ID: <CAPDyKFoMB2VEgmtnJiQ=ODbtgau9_L43539Z8xEYTeLUoekVFQ@mail.gmail.com>
References: <1480360599-13295-1-git-send-email-zach.brown@ni.com> <1480360599-13295-2-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480360599-13295-2-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 November 2016 at 20:16, Zach Brown <zach.brown@ni.com> wrote:
> Add PCI ID for Intel byt sdio host controller sub-vended by NI.
>
> The controller has different behavior because of the board layout NI
> puts it on.
>
> Signed-off-by: Zach Brown <zach.brown@ni.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 1d9e00a..9741505 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -375,6 +375,13 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>         return 0;
>  }
>
> +static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
> +{
> +       slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
> +                                MMC_CAP_WAIT_WHILE_BUSY;
> +       return 0;
> +}
> +
>  static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
> @@ -447,6 +454,15 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
>         .ops            = &sdhci_intel_byt_ops,
>  };
>
> +static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
> +       .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +       .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
> +                         SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .allow_runtime_pm = true,
> +       .probe_slot     = ni_byt_sdio_probe_slot,
> +       .ops            = &sdhci_intel_byt_ops,
> +};
> +
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
> @@ -1079,6 +1095,14 @@ static const struct pci_device_id pci_ids[] = {
>         {
>                 .vendor         = PCI_VENDOR_ID_INTEL,
>                 .device         = PCI_DEVICE_ID_INTEL_BYT_SDIO,
> +               .subvendor      = PCI_VENDOR_ID_NI,
> +               .subdevice      = 0x7884,
> +               .driver_data    = (kernel_ulong_t)&sdhci_ni_byt_sdio,
> +       },
> +
> +       {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_BYT_SDIO,
>                 .subvendor      = PCI_ANY_ID,
>                 .subdevice      = PCI_ANY_ID,
>                 .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_sdio,
> --
> 2.7.4
>
