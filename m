From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Only do AMD tuning for HS200
Date: Wed, 11 Apr 2018 16:52:59 +0200
Message-ID: <CAPDyKFqUF_rMSYON_hg7JyA94W6FJMfHVBenKL2_YLXVJVWGxg@mail.gmail.com>
References: <20180406220806.150534-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406220806.150534-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: satyajit.sahu@amd.com, Shyam Sundar S K <ssundark@amd.com>, craigb@chromium.org, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 7 April 2018 at 00:07, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Commit c31165d7400b ("mmc: sdhci-pci: Add support for HS200 tuning mode
> on AMD, eMMC-4.5.1") added a HS200 tuning method for use with AMD SDHCI
> controllers.  As described in the commit subject, this tuning is specific
> for HS200.  However, as implemented, this method is used for all host
> timings, because platform_execute_tuning, if it exists, is called
> unconditionally by sdhci_execute_tuning().  This breaks tuning when using
> the AMD controller with, for example, a DDR50 SD card.
>
> Instead, we can implement an amd execute_tuning wrapper callback, and
> then conditionally do the HS200 specific tuning for HS200, and otherwise
> call back to the standard sdhci_execute_tuning().
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Thanks, applied for fixes!

Added a fixes tag and stable tag.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 787434e5589d..78c25ad35fd2 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1312,7 +1312,7 @@ static void amd_enable_manual_tuning(struct pci_dev *pdev)
>         pci_write_config_dword(pdev, AMD_SD_MISC_CONTROL, val);
>  }
>
> -static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
> +static int amd_execute_tuning_hs200(struct sdhci_host *host, u32 opcode)
>  {
>         struct sdhci_pci_slot *slot = sdhci_priv(host);
>         struct pci_dev *pdev = slot->chip->pdev;
> @@ -1351,6 +1351,27 @@ static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
>         return 0;
>  }
>
> +static int amd_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       /* AMD requires custom HS200 tuning */
> +       if (host->timing == MMC_TIMING_MMC_HS200)
> +               return amd_execute_tuning_hs200(host, opcode);
> +
> +       /* Otherwise perform standard SDHCI tuning */
> +       return sdhci_execute_tuning(mmc, opcode);
> +}
> +
> +static int amd_probe_slot(struct sdhci_pci_slot *slot)
> +{
> +       struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
> +
> +       ops->execute_tuning = amd_execute_tuning;
> +
> +       return 0;
> +}
> +
>  static int amd_probe(struct sdhci_pci_chip *chip)
>  {
>         struct pci_dev  *smbus_dev;
> @@ -1385,12 +1406,12 @@ static const struct sdhci_ops amd_sdhci_pci_ops = {
>         .set_bus_width                  = sdhci_set_bus_width,
>         .reset                          = sdhci_reset,
>         .set_uhs_signaling              = sdhci_set_uhs_signaling,
> -       .platform_execute_tuning        = amd_execute_tuning,
>  };
>
>  static const struct sdhci_pci_fixes sdhci_amd = {
>         .probe          = amd_probe,
>         .ops            = &amd_sdhci_pci_ops,
> +       .probe_slot     = amd_probe_slot,
>  };
>
>  static const struct pci_device_id pci_ids[] = {
> --
> 2.17.0.484.g0c8726318c-goog
>
