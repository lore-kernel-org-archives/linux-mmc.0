From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO hangs
Date: Mon, 18 Apr 2016 13:21:16 +0200
Message-ID: <CAPDyKFpOG2_MNR4T9k-Gr4qUJWQzVzpH7R7NdftEyJ6yhZaT4g@mail.gmail.com>
References: <1460718417-20920-1-git-send-email-adrian.hunter@intel.com>
	<1460718417-20920-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37989 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbcDRLVX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 07:21:23 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so118869371wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2016 04:21:22 -0700 (PDT)
In-Reply-To: <1460718417-20920-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 15 April 2016 at 13:06, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Baytrail eMMC/SD/SDIO host controllers have been known to
> hang.  A change to a hardware setting has been found to
> reduce the occurrence of such hangs.  This patch ensures
> the correct setting.
>
> This patch applies cleanly to v4.4+.  It could go to
> earlier kernels also, so I will send backports to the
> stable list in due course.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # v4.4+

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig      |  1 +
>  drivers/mmc/host/sdhci-acpi.c | 81 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 04feea8354cb..e657af0e95fa 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -97,6 +97,7 @@ config MMC_RICOH_MMC
>  config MMC_SDHCI_ACPI
>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>         depends on MMC_SDHCI && ACPI
> +       select IOSF_MBI if X86
>         help
>           This selects support for ACPI enumerated SDHCI controllers,
>           identified by ACPI Compatibility ID PNP0D40 or specific
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 6106354c6c17..b2d70ba6caa7 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -41,6 +41,11 @@
>  #include <linux/mmc/pm.h>
>  #include <linux/mmc/slot-gpio.h>
>
> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
> +#include <asm/iosf_mbi.h>
> +#endif
> +
>  #include "sdhci.h"
>
>  enum {
> @@ -116,6 +121,75 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
>         .ops = &sdhci_acpi_ops_int,
>  };
>
> +#ifdef CONFIG_X86
> +
> +static bool sdhci_acpi_byt(void)
> +{
> +       static const struct x86_cpu_id byt[] = {
> +               { X86_VENDOR_INTEL, 6, 0x37 },
> +               {}
> +       };
> +
> +       return x86_match_cpu(byt);
> +}
> +
> +#define BYT_IOSF_SCCEP                 0x63
> +#define BYT_IOSF_OCP_NETCTRL0          0x1078
> +#define BYT_IOSF_OCP_TIMEOUT_BASE      GENMASK(10, 8)
> +
> +static void sdhci_acpi_byt_setting(struct device *dev)
> +{
> +       u32 val = 0;
> +
> +       if (!sdhci_acpi_byt())
> +               return;
> +
> +       if (iosf_mbi_read(BYT_IOSF_SCCEP, MBI_CR_READ, BYT_IOSF_OCP_NETCTRL0,
> +                         &val)) {
> +               dev_err(dev, "%s read error\n", __func__);
> +               return;
> +       }
> +
> +       if (!(val & BYT_IOSF_OCP_TIMEOUT_BASE))
> +               return;
> +
> +       val &= ~BYT_IOSF_OCP_TIMEOUT_BASE;
> +
> +       if (iosf_mbi_write(BYT_IOSF_SCCEP, MBI_CR_WRITE, BYT_IOSF_OCP_NETCTRL0,
> +                          val)) {
> +               dev_err(dev, "%s write error\n", __func__);
> +               return;
> +       }
> +
> +       dev_dbg(dev, "%s completed\n", __func__);
> +}
> +
> +static bool sdhci_acpi_byt_defer(struct device *dev)
> +{
> +       if (!sdhci_acpi_byt())
> +               return false;
> +
> +       if (!iosf_mbi_available())
> +               return true;
> +
> +       sdhci_acpi_byt_setting(dev);
> +
> +       return false;
> +}
> +
> +#else
> +
> +static inline void sdhci_acpi_byt_setting(struct device *dev)
> +{
> +}
> +
> +static inline bool sdhci_acpi_byt_defer(struct device *dev)
> +{
> +       return false;
> +}
> +
> +#endif
> +
>  static int bxt_get_cd(struct mmc_host *mmc)
>  {
>         int gpio_cd = mmc_gpio_get_cd(mmc);
> @@ -319,6 +393,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>         if (acpi_bus_get_status(device) || !device->status.present)
>                 return -ENODEV;
>
> +       if (sdhci_acpi_byt_defer(dev))
> +               return -EPROBE_DEFER;
> +
>         hid = acpi_device_hid(device);
>         uid = device->pnp.unique_id;
>
> @@ -444,6 +521,8 @@ static int sdhci_acpi_resume(struct device *dev)
>  {
>         struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>
> +       sdhci_acpi_byt_setting(&c->pdev->dev);
> +
>         return sdhci_resume_host(c->host);
>  }
>
> @@ -467,6 +546,8 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
>  {
>         struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>
> +       sdhci_acpi_byt_setting(&c->pdev->dev);
> +
>         return sdhci_runtime_resume_host(c->host);
>  }
>
> --
> 1.9.1
>
