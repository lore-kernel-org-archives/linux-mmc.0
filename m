From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add Support for Command Queuing
 Engine to J721E
Date: Wed, 20 Nov 2019 13:58:49 +0100
Message-ID: <CAPDyKFrBakP8anTp4Uebq9oEJHPF+=HEuJZ-ezLD-P83+RRsMw@mail.gmail.com>
References: <20191118073609.22921-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118073609.22921-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 18 Nov 2019 at 08:35, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add Support for CQHCI (Command Queuing Host Controller Interface)
> for each of the host controllers present in TI's J721E devices.
> Add cqhci_ops and a .irq() callback to handle cqhci specific interrupts.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Applied for next, dropping the reported-by tag, thanks!

Kind regards
Uffe


> ---
>
> v2: Dropped CONFIG_ prefix from select MMC_CQHCI which led to build
> failures. Successfully built with the .config provided by the kbuild test robot.
>
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci_am654.c | 71 +++++++++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c467bf..7c1310ed26c6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1011,6 +1011,7 @@ config MMC_SDHCI_AM654
>         tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
>         depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
>         select MMC_SDHCI_IO_ACCESSORS
> +       select MMC_CQHCI
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           support present in TI's AM654 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index bb90757ecace..b8e897e31e2e 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -12,6 +12,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>
> +#include "cqhci.h"
>  #include "sdhci-pltfm.h"
>
>  /* CTL_CFG Registers */
> @@ -68,6 +69,9 @@
>
>  #define CLOCK_TOO_SLOW_HZ      400000
>
> +/* Command Queue Host Controller Interface Base address */
> +#define SDHCI_AM654_CQE_BASE_ADDR 0x200
> +
>  static struct regmap_config sdhci_am654_regmap_config = {
>         .reg_bits = 32,
>         .val_bits = 32,
> @@ -259,6 +263,19 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
>         .flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
>  };
>
> +static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +       int cmd_error = 0;
> +       int data_error = 0;
> +
> +       if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +               return intmask;
> +
> +       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +       return 0;
> +}
> +
>  static struct sdhci_ops sdhci_j721e_8bit_ops = {
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -267,6 +284,7 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
>         .set_power = sdhci_am654_set_power,
>         .set_clock = sdhci_am654_set_clock,
>         .write_b = sdhci_am654_write_b,
> +       .irq = sdhci_am654_cqhci_irq,
>         .reset = sdhci_reset,
>  };
>
> @@ -290,6 +308,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
>         .set_power = sdhci_am654_set_power,
>         .set_clock = sdhci_j721e_4bit_set_clock,
>         .write_b = sdhci_am654_write_b,
> +       .irq = sdhci_am654_cqhci_irq,
>         .reset = sdhci_reset,
>  };
>
> @@ -304,6 +323,40 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
>         .pdata = &sdhci_j721e_4bit_pdata,
>         .flags = IOMUX_PRESENT,
>  };
> +
> +static void sdhci_am654_dumpregs(struct mmc_host *mmc)
> +{
> +       sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static const struct cqhci_host_ops sdhci_am654_cqhci_ops = {
> +       .enable         = sdhci_cqe_enable,
> +       .disable        = sdhci_cqe_disable,
> +       .dumpregs       = sdhci_am654_dumpregs,
> +};
> +
> +static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
> +{
> +       struct cqhci_host *cq_host;
> +       int ret;
> +
> +       cq_host = devm_kzalloc(host->mmc->parent, sizeof(struct cqhci_host),
> +                              GFP_KERNEL);
> +       if (!cq_host)
> +               return -ENOMEM;
> +
> +       cq_host->mmio = host->ioaddr + SDHCI_AM654_CQE_BASE_ADDR;
> +       cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
> +       cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +       cq_host->ops = &sdhci_am654_cqhci_ops;
> +
> +       host->mmc->caps2 |= MMC_CAP2_CQE;
> +
> +       ret = cqhci_init(cq_host, host->mmc, 1);
> +
> +       return ret;
> +}
> +
>  static int sdhci_am654_init(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -344,7 +397,23 @@ static int sdhci_am654_init(struct sdhci_host *host)
>         regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
>                            ctl_cfg_2);
>
> -       return sdhci_add_host(host);
> +       ret = sdhci_setup_host(host);
> +       if (ret)
> +               return ret;
> +
> +       ret = sdhci_am654_cqe_add_host(host);
> +       if (ret)
> +               goto err_cleanup_host;
> +
> +       ret = __sdhci_add_host(host);
> +       if (ret)
> +               goto err_cleanup_host;
> +
> +       return 0;
> +
> +err_cleanup_host:
> +       sdhci_cleanup_host(host);
> +       return ret;
>  }
>
>  static int sdhci_am654_get_of_property(struct platform_device *pdev,
> --
> 2.19.2
>
