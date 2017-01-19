From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/9] mmc: mmci: add support for not-amba, but still
 compatible, variants
Date: Thu, 19 Jan 2017 17:58:10 +0100
Message-ID: <CAPDyKFqX+_ZPWm__FQqNqBDxWnmVCHTBaMN=Tbbeh+E=kuGMMg@mail.gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com> <1484552238-23171-3-git-send-email-andrea.merello@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36545 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdASRYQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 12:24:16 -0500
Received: by mail-wm0-f49.google.com with SMTP id c85so3066512wmi.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 09:23:34 -0800 (PST)
In-Reply-To: <1484552238-23171-3-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Merello <andrea.merello@gmail.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, bruherrera@gmail.com, Russell King <rmk+kernel@arm.linux.org.uk>

+ Russell

On 16 January 2017 at 08:37, Andrea Merello <andrea.merello@gmail.com> wrote:
> The STM32F4xx family contain a SDIO IP that looks like a variant of
> the PL180, however, inspite it's actually attached to a APB bus, it
> cannot be handled by the AMBA bus code, because it lacks of the ID
> registers that AMBA primecell IPs have.
>
> This patch prepares for supporting the STM32 variant by letting the
> driver register also as a platform driver, that can be matched from
> the OF with specific "compatible" strings

NAK!

Too much code are depending on the amba bus in the driver. I sincerely
hope you haven't tried this approach for other amba drivers, because
it will screw them up and they will become a nightmare to maintain!

Moreover, there is a way to override the use of the AMBA IDs
registers. I think you can use that instead! No?

Kind regards
Uffe

>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  drivers/mmc/host/Kconfig |   8 +-
>  drivers/mmc/host/mmci.c  | 297 ++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 236 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2eb9701..f8f7f289 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -5,12 +5,12 @@
>  comment "MMC/SD/SDIO Host Controller Drivers"
>
>  config MMC_ARMMMCI
> -       tristate "ARM AMBA Multimedia Card Interface support"
> -       depends on ARM_AMBA
> +       tristate "ARM AMBA Multimedia Card Interface and compatible support"
>         help
>           This selects the ARM(R) AMBA(R) PrimeCell Multimedia Card
> -         Interface (PL180 and PL181) support.  If you have an ARM(R)
> -         platform with a Multimedia Card slot, say Y or M here.
> +         Interface (PL180, PL181 and compatible) support.
> +         If you have an ARM(R) platform with a Multimedia Card slot,
> +         say Y or M here.
>
>           If unsure, say N.
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 597fab8..54c2fc3 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1,5 +1,6 @@
>  /*
> - *  linux/drivers/mmc/host/mmci.c - ARM PrimeCell MMCI PL180/1 driver
> + *  linux/drivers/mmc/host/mmci.c - ARM PrimeCell MMCI PL180/1 and
> + *  comaptible driver
>   *
>   *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
>   *  Copyright (C) 2010 ST-Ericsson SA
> @@ -37,6 +38,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/types.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
>
>  #include <asm/div64.h>
>  #include <asm/io.h>
> @@ -113,7 +116,7 @@ struct variant_data {
>         bool                    reversed_irq_handling;
>  };
>
> -static struct variant_data variant_arm = {
> +static __maybe_unused struct variant_data variant_arm = {
>         .fifosize               = 16 * 4,
>         .fifohalfsize           = 8 * 4,
>         .datalength_bits        = 16,
> @@ -122,7 +125,7 @@ static struct variant_data variant_arm = {
>         .reversed_irq_handling  = true,
>  };
>
> -static struct variant_data variant_arm_extended_fifo = {
> +static __maybe_unused struct variant_data variant_arm_extended_fifo = {
>         .fifosize               = 128 * 4,
>         .fifohalfsize           = 64 * 4,
>         .datalength_bits        = 16,
> @@ -130,7 +133,7 @@ static struct variant_data variant_arm_extended_fifo = {
>         .f_max                  = 100000000,
>  };
>
> -static struct variant_data variant_arm_extended_fifo_hwfc = {
> +static __maybe_unused struct variant_data variant_arm_extended_fifo_hwfc = {
>         .fifosize               = 128 * 4,
>         .fifohalfsize           = 64 * 4,
>         .clkreg_enable          = MCI_ARM_HWFCEN,
> @@ -139,7 +142,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
>         .f_max                  = 100000000,
>  };
>
> -static struct variant_data variant_u300 = {
> +static __maybe_unused struct variant_data variant_u300 = {
>         .fifosize               = 16 * 4,
>         .fifohalfsize           = 8 * 4,
>         .clkreg_enable          = MCI_ST_U300_HWFCEN,
> @@ -154,7 +157,7 @@ static struct variant_data variant_u300 = {
>         .pwrreg_nopower         = true,
>  };
>
> -static struct variant_data variant_nomadik = {
> +static __maybe_unused struct variant_data variant_nomadik = {
>         .fifosize               = 16 * 4,
>         .fifohalfsize           = 8 * 4,
>         .clkreg                 = MCI_CLK_ENABLE,
> @@ -170,7 +173,7 @@ static struct variant_data variant_nomadik = {
>         .pwrreg_nopower         = true,
>  };
>
> -static struct variant_data variant_ux500 = {
> +static __maybe_unused struct variant_data variant_ux500 = {
>         .fifosize               = 30 * 4,
>         .fifohalfsize           = 8 * 4,
>         .clkreg                 = MCI_CLK_ENABLE,
> @@ -192,7 +195,7 @@ static struct variant_data variant_ux500 = {
>         .pwrreg_nopower         = true,
>  };
>
> -static struct variant_data variant_ux500v2 = {
> +static __maybe_unused struct variant_data variant_ux500v2 = {
>         .fifosize               = 30 * 4,
>         .fifohalfsize           = 8 * 4,
>         .clkreg                 = MCI_CLK_ENABLE,
> @@ -216,7 +219,7 @@ static struct variant_data variant_ux500v2 = {
>         .pwrreg_nopower         = true,
>  };
>
> -static struct variant_data variant_qcom = {
> +static __maybe_unused struct variant_data variant_qcom = {
>         .fifosize               = 16 * 4,
>         .fifohalfsize           = 8 * 4,
>         .clkreg                 = MCI_CLK_ENABLE,
> @@ -1528,31 +1531,32 @@ static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
>         return 0;
>  }
>
> -static int mmci_probe(struct amba_device *dev,
> -       const struct amba_id *id)
> +static struct mmci_host *mmci_probe(struct device *dev,
> +                                   struct variant_data *variant,
> +                                   struct resource *res,
> +                                   unsigned int irq0, unsigned int irq1)
>  {
> -       struct mmci_platform_data *plat = dev->dev.platform_data;
> -       struct device_node *np = dev->dev.of_node;
> -       struct variant_data *variant = id->data;
> -       struct mmci_host *host;
> +       struct device_node *np = dev->of_node;
> +       struct mmci_platform_data *plat = dev->platform_data;
>         struct mmc_host *mmc;
> +       struct mmci_host *host;
>         int ret;
>
>         /* Must have platform data or Device Tree. */
>         if (!plat && !np) {
> -               dev_err(&dev->dev, "No plat data or DT found\n");
> -               return -EINVAL;
> +               dev_err(dev, "No plat data or DT found\n");
> +               return ERR_PTR(-EINVAL);
>         }
>
>         if (!plat) {
> -               plat = devm_kzalloc(&dev->dev, sizeof(*plat), GFP_KERNEL);
> +               plat = devm_kzalloc(dev, sizeof(*plat), GFP_KERNEL);
>                 if (!plat)
> -                       return -ENOMEM;
> +                       return ERR_PTR(-ENOMEM);
>         }
>
> -       mmc = mmc_alloc_host(sizeof(struct mmci_host), &dev->dev);
> +       mmc = mmc_alloc_host(sizeof(struct mmci_host), dev);
>         if (!mmc)
> -               return -ENOMEM;
> +               return ERR_PTR(-ENOMEM);
>
>         ret = mmci_of_parse(np, mmc);
>         if (ret)
> @@ -1561,12 +1565,7 @@ static int mmci_probe(struct amba_device *dev,
>         host = mmc_priv(mmc);
>         host->mmc = mmc;
>
> -       host->hw_designer = amba_manf(dev);
> -       host->hw_revision = amba_rev(dev);
> -       dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
> -       dev_dbg(mmc_dev(mmc), "revision = 0x%01x\n", host->hw_revision);
> -
> -       host->clk = devm_clk_get(&dev->dev, NULL);
> +       host->clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(host->clk)) {
>                 ret = PTR_ERR(host->clk);
>                 goto host_free;
> @@ -1598,8 +1597,8 @@ static int mmci_probe(struct amba_device *dev,
>                         host->mclk);
>         }
>
> -       host->phybase = dev->res.start;
> -       host->base = devm_ioremap_resource(&dev->dev, &dev->res);
> +       host->phybase = res->start;
> +       host->base = devm_ioremap_resource(dev, res);
>         if (IS_ERR(host->base)) {
>                 ret = PTR_ERR(host->base);
>                 goto clk_disable;
> @@ -1742,49 +1741,41 @@ static int mmci_probe(struct amba_device *dev,
>                 }
>         }
>
> -       ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
> -                       DRIVER_NAME " (cmd)", host);
> +       ret = devm_request_irq(dev, irq0, mmci_irq, IRQF_SHARED,
> +                              DRIVER_NAME " (cmd)", host);
>         if (ret)
>                 goto clk_disable;
>
> -       if (!dev->irq[1])
> +       if (!irq1) {
>                 host->singleirq = true;
> -       else {
> -               ret = devm_request_irq(&dev->dev, dev->irq[1], mmci_pio_irq,
> -                               IRQF_SHARED, DRIVER_NAME " (pio)", host);
> +       } else {
> +               ret = devm_request_irq(dev, irq1, mmci_pio_irq,
> +                                      IRQF_SHARED, DRIVER_NAME " (pio)", host);
>                 if (ret)
>                         goto clk_disable;
>         }
>
>         writel(MCI_IRQENABLE, host->base + MMCIMASK0);
>
> -       amba_set_drvdata(dev, mmc);
> -
> -       dev_info(&dev->dev, "%s: PL%03x manf %x rev%u at 0x%08llx irq %d,%d (pio)\n",
> -                mmc_hostname(mmc), amba_part(dev), amba_manf(dev),
> -                amba_rev(dev), (unsigned long long)dev->res.start,
> -                dev->irq[0], dev->irq[1]);
> -
>         mmci_dma_setup(host);
>
> -       pm_runtime_set_autosuspend_delay(&dev->dev, 50);
> -       pm_runtime_use_autosuspend(&dev->dev);
> +       pm_runtime_set_autosuspend_delay(dev, 50);
> +       pm_runtime_use_autosuspend(dev);
>
>         mmc_add_host(mmc);
>
> -       pm_runtime_put(&dev->dev);
> -       return 0;
> +       pm_runtime_put(dev);
> +       return host;
>
>   clk_disable:
>         clk_disable_unprepare(host->clk);
>   host_free:
>         mmc_free_host(mmc);
> -       return ret;
> +       return ERR_PTR(ret);
>  }
>
> -static int mmci_remove(struct amba_device *dev)
> +static int mmc_remove(struct mmc_host *mmc)
>  {
> -       struct mmc_host *mmc = amba_get_drvdata(dev);
>
>         if (mmc) {
>                 struct mmci_host *host = mmc_priv(mmc);
> @@ -1793,7 +1784,7 @@ static int mmci_remove(struct amba_device *dev)
>                  * Undo pm_runtime_put() in probe.  We use the _sync
>                  * version here so that we can access the primecell.
>                  */
> -               pm_runtime_get_sync(&dev->dev);
> +               pm_runtime_get_sync(mmc->parent);
>
>                 mmc_remove_host(mmc);
>
> @@ -1847,14 +1838,11 @@ static void mmci_restore(struct mmci_host *host)
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> -static int mmci_runtime_suspend(struct device *dev)
> +static int mmci_runtime_suspend(struct mmc_host *mmc)
>  {
> -       struct amba_device *adev = to_amba_device(dev);
> -       struct mmc_host *mmc = amba_get_drvdata(adev);
> -
>         if (mmc) {
>                 struct mmci_host *host = mmc_priv(mmc);
> -               pinctrl_pm_select_sleep_state(dev);
> +               pinctrl_pm_select_sleep_state(mmc->parent);
>                 mmci_save(host);
>                 clk_disable_unprepare(host->clk);
>         }
> @@ -1862,28 +1850,77 @@ static int mmci_runtime_suspend(struct device *dev)
>         return 0;
>  }
>
> -static int mmci_runtime_resume(struct device *dev)
> +static int mmci_runtime_resume(struct mmc_host *mmc)
>  {
> -       struct amba_device *adev = to_amba_device(dev);
> -       struct mmc_host *mmc = amba_get_drvdata(adev);
>
>         if (mmc) {
>                 struct mmci_host *host = mmc_priv(mmc);
>                 clk_prepare_enable(host->clk);
>                 mmci_restore(host);
> -               pinctrl_pm_select_default_state(dev);
> +               pinctrl_pm_select_default_state(mmc->parent);
>         }
>
>         return 0;
>  }
>  #endif
>
> -static const struct dev_pm_ops mmci_dev_pm_ops = {
> +#ifdef CONFIG_ARM_AMBA
> +static int mmci_remove_amba(struct amba_device *dev)
> +{
> +       struct mmc_host *mmc = amba_get_drvdata(dev);
> +
> +       return mmc_remove(mmc);
> +}
> +
> +static int mmci_runtime_resume_amba(struct device *dev)
> +{
> +       struct amba_device *adev = to_amba_device(dev);
> +       struct mmc_host *mmc = amba_get_drvdata(adev);
> +
> +       return mmci_runtime_resume(mmc);
> +}
> +
> +static int mmci_runtime_suspend_amba(struct device *dev)
> +{
> +       struct amba_device *adev = to_amba_device(dev);
> +       struct mmc_host *mmc = amba_get_drvdata(adev);
> +
> +       return mmci_runtime_suspend(mmc);
> +}
> +
> +static const struct dev_pm_ops mmci_dev_pm_ops_amba = {
>         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>                                 pm_runtime_force_resume)
> -       SET_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
> +       SET_RUNTIME_PM_OPS(mmci_runtime_suspend_amba, mmci_runtime_resume_amba,
> +                          NULL)
>  };
>
> +static int mmci_probe_amba(struct amba_device *dev, const struct amba_id *id)
> +{
> +       struct mmci_host *host;
> +       struct variant_data *variant = id->data;
> +
> +       host = mmci_probe(&dev->dev, variant, &dev->res,
> +                         dev->irq[0], dev->irq[1]);
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       host->hw_designer = amba_manf(dev);
> +       host->hw_revision = amba_rev(dev);
> +       dev_dbg(mmc_dev(host->mmc), "designer ID = 0x%02x\n",
> +               host->hw_designer);
> +       dev_dbg(mmc_dev(host->mmc), "revision = 0x%01x\n", host->hw_revision);
> +
> +       amba_set_drvdata(dev, host->mmc);
> +
> +       dev_info(&dev->dev, "%s: PL%03x manf %x rev%u at 0x%08llx irq %d,%d (pio)\n",
> +                mmc_hostname(host->mmc), amba_part(dev), amba_manf(dev),
> +                amba_rev(dev), (unsigned long long)dev->res.start,
> +                dev->irq[0], dev->irq[1]);
> +
> +       return 0;
> +}
> +
>  static struct amba_id mmci_ids[] = {
>         {
>                 .id     = 0x00041180,
> @@ -1945,14 +1982,144 @@ MODULE_DEVICE_TABLE(amba, mmci_ids);
>  static struct amba_driver mmci_driver = {
>         .drv            = {
>                 .name   = DRIVER_NAME,
> -               .pm     = &mmci_dev_pm_ops,
> +               .pm     = &mmci_dev_pm_ops_amba,
>         },
> -       .probe          = mmci_probe,
> -       .remove         = mmci_remove,
> +       .probe          = mmci_probe_amba,
> +       .remove         = mmci_remove_amba,
>         .id_table       = mmci_ids,
>  };
> +#endif
> +
> +static const struct of_device_id mmci_pltfm_match[] = {
> +       {},
> +};
> +
> +static int mmci_probe_pltfm(struct platform_device *pdev)
> +{
> +       struct mmci_host *host;
> +       struct variant_data *variant;
> +       const struct of_device_id *match;
> +       int irq0, irq1;
> +       struct resource *res;
> +
> +       irq0 = platform_get_irq(pdev, 0);
> +       if (irq0 < 0) {
> +               dev_err(&pdev->dev, "Can't get IRQ");
> +               return -EINVAL;
> +       }
> +
> +       irq1 = platform_get_irq(pdev, 1);
> +       /* optional. set to 0 to be compatible with original amba probe code */
> +       if (irq1 < 0)
> +               irq1 = 0;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(&pdev->dev, "Can't get MMIO range");
> +               return -EINVAL;
> +       }
> +
> +       match = of_match_device(mmci_pltfm_match, &pdev->dev);
> +       if (!match) {
> +               dev_err(&pdev->dev, "Can't get variant data\n");
> +               return -EINVAL;
> +       }
> +       variant = (struct variant_data *)match->data;
> +
> +       host = mmci_probe(&pdev->dev, variant, res,
> +                         irq0, irq1);
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       platform_set_drvdata(pdev, host->mmc);
> +       dev_info(&pdev->dev, "%s: PL81x compatible SDIO at 0x%08llx irq %d,%d (pio)\n",
> +                mmc_hostname(host->mmc),
> +                (unsigned long long)res->start, irq0, irq1);
> +
> +       return 0;
> +}
> +
> +static int mmci_remove_pltfm(struct platform_device *pdev)
> +{
> +       struct mmc_host *mmc = platform_get_drvdata(pdev);
> +
> +       return mmc_remove(mmc);
> +}
> +
> +static int mmci_runtime_resume_pltfm(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct mmc_host *mmc = platform_get_drvdata(pdev);
> +
> +       return mmci_runtime_resume(mmc);
> +}
> +
> +static int mmci_runtime_suspend_pltfm(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct mmc_host *mmc = platform_get_drvdata(pdev);
> +
> +       return mmci_runtime_suspend(mmc);
> +}
> +
> +MODULE_DEVICE_TABLE(of, mmci_pltfm_match);
> +
> +static const struct dev_pm_ops mmci_dev_pm_ops_pltfm = {
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
> +       SET_RUNTIME_PM_OPS(mmci_runtime_suspend_pltfm,
> +                          mmci_runtime_resume_pltfm, NULL)
> +};
> +
> +static struct platform_driver mmci_pltfm_driver = {
> +       .probe          = mmci_probe_pltfm,
> +       .remove         = mmci_remove_pltfm,
> +       .driver         = {
> +               .name           = DRIVER_NAME,
> +               .of_match_table = mmci_pltfm_match,
> +               .pm             = &mmci_dev_pm_ops_pltfm,
> +       },
> +};
> +
> +static int __init mmci_init(void)
> +{
> +       int ret;
> +       __maybe_unused int ret_amba;
> +
> +       ret = platform_driver_register(&mmci_pltfm_driver);
> +
> +#ifdef CONFIG_ARM_AMBA
> +       ret_amba = amba_driver_register(&mmci_driver);
> +
> +       /* if both plaform and amba failed. Just fail. */
> +       if (ret && ret_amba)
> +               return ret;
> +
> +       /*
> +        * If only one of the two succeeded, don't fail here, because the
> +        * other one is probably usable, but spit a warning..
> +        */
> +       if (ret_amba)
> +               pr_warn("could not register MMCI amba driver");
> +
> +       if (ret)
> +               pr_warn("could not register MMCI platform driver");
> +
> +       return 0;
> +#endif
> +       return ret;
> +}
> +
> +static void __exit mmci_exit(void)
> +{
> +       platform_driver_unregister(&mmci_pltfm_driver);
> +#ifdef CONFIG_ARM_AMBA
> +       amba_driver_unregister(&mmci_driver);
> +#endif
> +}
>
> -module_amba_driver(mmci_driver);
> +module_init(mmci_init);
> +module_exit(mmci_exit);
>
>  module_param(fmax, uint, 0444);
>
> --
> 2.7.4
>
