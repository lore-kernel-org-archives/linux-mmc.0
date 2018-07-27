From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH] mmc: host: iproc: Add ACPI support to IPROC SDHCI
Date: Fri, 27 Jul 2018 20:00:31 +0530
Message-ID: <CABe79T7aLSXm3tjv9JQzD2Ku-0JrJTboUh3YGd9GFFJc0iV=WQ@mail.gmail.com>
References: <1531845907-26213-1-git-send-email-srinath.mannam@broadcom.com>
 <b8bc96ee-e035-7a51-499f-b16dc3c7edd0@intel.com> <CABe79T6w11k_=OVf=LdTmGNS+sQcueL_fqp9ipi_zNyHgXVxsQ@mail.gmail.com>
 <9365e83f-e638-7f83-c520-f27f5c9ca532@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9365e83f-e638-7f83-c520-f27f5c9ca532@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian Hunter,

Thank you very much for your inputs.
I will send next patch set with all your suggested modifications.

Regards,
Srinath.

On Fri, Jul 27, 2018 at 4:45 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 27/07/18 11:59, Srinath Mannam wrote:
>> Hi Adrian Hunter,
>>
>> Thank you very much for review and feedback.
>> Please find my comments inline..
>>
>> On Fri, Jul 27, 2018 at 11:50 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 17/07/18 19:45, Srinath Mannam wrote:
>>>> Add ACPI support to all IPROC SDHCI varients
>>>>
>>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>>>> ---
>>>>  drivers/mmc/host/Kconfig       |   1 +
>>>>  drivers/mmc/host/sdhci-iproc.c | 187 ++++++++++++++++++++++++++++-------------
>>>>  2 files changed, 128 insertions(+), 60 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index 0581c19..bc6702e 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -334,6 +334,7 @@ config MMC_SDHCI_IPROC
>>>>       tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
>>>>       depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
>>>>       depends on MMC_SDHCI_PLTFM
>>>> +     depends on OF || ACPI
>>>>       default ARCH_BCM_IPROC
>>>>       select MMC_SDHCI_IO_ACCESSORS
>>>>       help
>>>> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>>>> index d0e83db..7c5c923 100644
>>>> --- a/drivers/mmc/host/sdhci-iproc.c
>>>> +++ b/drivers/mmc/host/sdhci-iproc.c
>>>> @@ -15,6 +15,7 @@
>>>>   * iProc SDHCI platform driver
>>>>   */
>>>>
>>>> +#include <linux/acpi.h>
>>>>  #include <linux/delay.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/mmc/host.h>
>>>> @@ -162,9 +163,19 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
>>>>       sdhci_iproc_writel(host, newval, reg & ~3);
>>>>  }
>>>>
>>>> +static unsigned int sdhci_iproc_get_max_clock(struct sdhci_host *host)
>>>> +{
>>>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +
>>>> +     if (pltfm_host->clk)
>>>> +             return sdhci_pltfm_clk_get_max_clock(host);
>>>> +     else
>>>> +             return pltfm_host->clock;
>>>> +}
>>>> +
>>>>  static const struct sdhci_ops sdhci_iproc_ops = {
>>>>       .set_clock = sdhci_set_clock,
>>>> -     .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>>> +     .get_max_clock = sdhci_iproc_get_max_clock,
>>>>       .set_bus_width = sdhci_set_bus_width,
>>>>       .reset = sdhci_reset,
>>>>       .set_uhs_signaling = sdhci_set_uhs_signaling,
>>>> @@ -178,34 +189,24 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
>>>>       .write_w = sdhci_iproc_writew,
>>>>       .write_b = sdhci_iproc_writeb,
>>>>       .set_clock = sdhci_set_clock,
>>>> -     .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>>> +     .get_max_clock = sdhci_iproc_get_max_clock,
>>>>       .set_bus_width = sdhci_set_bus_width,
>>>>       .reset = sdhci_reset,
>>>>       .set_uhs_signaling = sdhci_set_uhs_signaling,
>>>>  };
>>>>
>>>> +enum sdhci_pltfm_type {
>>>> +     SDHCI_PLTFM_IPROC_CYGNUS,
>>>> +     SDHCI_PLTFM_IPROC,
>>>> +     SDHCI_PLTFM_BCM2835,
>>>> +};
>>>> +
>>>>  static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
>>>>       .quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
>>>>       .quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
>>>>       .ops = &sdhci_iproc_32only_ops,
>>>>  };
>>>>
>>>> -static const struct sdhci_iproc_data iproc_cygnus_data = {
>>>> -     .pdata = &sdhci_iproc_cygnus_pltfm_data,
>>>> -     .caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
>>>> -                     & SDHCI_MAX_BLOCK_MASK) |
>>>> -             SDHCI_CAN_VDD_330 |
>>>> -             SDHCI_CAN_VDD_180 |
>>>> -             SDHCI_CAN_DO_SUSPEND |
>>>> -             SDHCI_CAN_DO_HISPD |
>>>> -             SDHCI_CAN_DO_ADMA2 |
>>>> -             SDHCI_CAN_DO_SDMA,
>>>> -     .caps1 = SDHCI_DRIVER_TYPE_C |
>>>> -              SDHCI_DRIVER_TYPE_D |
>>>> -              SDHCI_SUPPORT_DDR50,
>>>> -     .mmc_caps = MMC_CAP_1_8V_DDR,
>>>> -};
>>>> -
>>>>  static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
>>>>       .quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>>>>                 SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>>>> @@ -213,21 +214,6 @@ static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
>>>>       .ops = &sdhci_iproc_ops,
>>>>  };
>>>>
>>>> -static const struct sdhci_iproc_data iproc_data = {
>>>> -     .pdata = &sdhci_iproc_pltfm_data,
>>>> -     .caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
>>>> -                     & SDHCI_MAX_BLOCK_MASK) |
>>>> -             SDHCI_CAN_VDD_330 |
>>>> -             SDHCI_CAN_VDD_180 |
>>>> -             SDHCI_CAN_DO_SUSPEND |
>>>> -             SDHCI_CAN_DO_HISPD |
>>>> -             SDHCI_CAN_DO_ADMA2 |
>>>> -             SDHCI_CAN_DO_SDMA,
>>>> -     .caps1 = SDHCI_DRIVER_TYPE_C |
>>>> -              SDHCI_DRIVER_TYPE_D |
>>>> -              SDHCI_SUPPORT_DDR50,
>>>> -};
>>>> -
>>>>  static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
>>>>       .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>>>>                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>>>> @@ -237,38 +223,104 @@ static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
>>>>       .ops = &sdhci_iproc_32only_ops,
>>>>  };
>>>>
>>>> -static const struct sdhci_iproc_data bcm2835_data = {
>>>> -     .pdata = &sdhci_bcm2835_pltfm_data,
>>>> -     .caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
>>>> -                     & SDHCI_MAX_BLOCK_MASK) |
>>>> -             SDHCI_CAN_VDD_330 |
>>>> -             SDHCI_CAN_DO_HISPD,
>>>> -     .caps1 = SDHCI_DRIVER_TYPE_A |
>>>> -              SDHCI_DRIVER_TYPE_C,
>>>> -     .mmc_caps = 0x00000000,
>>>> +static const struct sdhci_iproc_data sdhci_iproc_data_list[] = {
>>>
>>> Why change to an array?  Also would need to be a separate patch.
>> In the existing device tree support, data parameter of of_device_id
>> list contains pointers of "sdhci_iproc_data" structure.
>> But driver_data parameter in acpi_device_id list is ulong. so we can't
>> assign "sdhci_iproc_data" structure pointer which can be 64bit.
>
> kernel_ulong_t is always the same size as a pointer.
>
>> Hence, it is required to take array of "sdhci_iproc_data" structures,
>> so that array index can assign to both data and driver_data
>> parameters of of_device_id and acpi_device_id lists respectively. same
>> pattern found in some other drivers.
>> This method is required to use in the part of adding ACPI support. so
>> I keep in single patch.
>>
>>>
>>>> +     [SDHCI_PLTFM_IPROC_CYGNUS] = {
>>>> +             /* SDHCI IPROC CYGNUS */
>>>> +             .pdata = &sdhci_iproc_cygnus_pltfm_data,
>>>> +             .caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
>>>> +                             & SDHCI_MAX_BLOCK_MASK) |
>>>> +                     SDHCI_CAN_VDD_330 |
>>>> +                     SDHCI_CAN_VDD_180 |
>>>> +                     SDHCI_CAN_DO_SUSPEND |
>>>> +                     SDHCI_CAN_DO_HISPD |
>>>> +                     SDHCI_CAN_DO_ADMA2 |
>>>> +                     SDHCI_CAN_DO_SDMA,
>>>> +             .caps1 = SDHCI_DRIVER_TYPE_C |
>>>> +                     SDHCI_DRIVER_TYPE_D |
>>>> +                     SDHCI_SUPPORT_DDR50,
>>>> +             .mmc_caps = MMC_CAP_1_8V_DDR,
>>>> +     },
>>>> +     [SDHCI_PLTFM_IPROC] = {
>>>> +             /* SDHCI IPROC */
>>>> +             .pdata = &sdhci_iproc_pltfm_data,
>>>> +             .caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
>>>> +                             & SDHCI_MAX_BLOCK_MASK) |
>>>> +                     SDHCI_CAN_VDD_330 |
>>>> +                     SDHCI_CAN_VDD_180 |
>>>> +                     SDHCI_CAN_DO_SUSPEND |
>>>> +                     SDHCI_CAN_DO_HISPD |
>>>> +                     SDHCI_CAN_DO_ADMA2 |
>>>> +                     SDHCI_CAN_DO_SDMA,
>>>> +             .caps1 = SDHCI_DRIVER_TYPE_C |
>>>> +                     SDHCI_DRIVER_TYPE_D |
>>>> +                     SDHCI_SUPPORT_DDR50,
>>>> +     },
>>>> +     [SDHCI_PLTFM_BCM2835] = {
>>>> +             /* SDHCI BCM2835 */
>>>> +             .pdata = &sdhci_bcm2835_pltfm_data,
>>>> +             .caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
>>>> +                             & SDHCI_MAX_BLOCK_MASK) |
>>>> +                     SDHCI_CAN_VDD_330 |
>>>> +                     SDHCI_CAN_DO_HISPD,
>>>> +             .caps1 = SDHCI_DRIVER_TYPE_A |
>>>> +                     SDHCI_DRIVER_TYPE_C,
>>>> +             .mmc_caps = 0x00000000,
>>>> +
>>>> +     },
>>>>  };
>>>>
>>>>  static const struct of_device_id sdhci_iproc_of_match[] = {
>>>> -     { .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
>>>> -     { .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
>>>> -     { .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
>>>> +     {
>>>> +             .compatible = "brcm,bcm2835-sdhci",
>>>> +             .data = (void *)SDHCI_PLTFM_BCM2835
>>>> +     },
>>>> +     {
>>>> +             .compatible = "brcm,sdhci-iproc-cygnus",
>>>> +             .data = (void *)SDHCI_PLTFM_IPROC_CYGNUS
>>>> +     },
>>>> +     {
>>>> +             .compatible = "brcm,sdhci-iproc",
>>>> +             .data = (void *)SDHCI_PLTFM_IPROC
>>>> +     },
>>>>       { }
>>>>  };
>>>>  MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>>>>
>>>> +static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
>>>> +     { .id = "BRCM5871", .driver_data = SDHCI_PLTFM_IPROC_CYGNUS },
>>>> +     { .id = "BRCM5872", .driver_data = SDHCI_PLTFM_IPROC },
>>>> +     { /* sentinel */ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
>>>> +
>>>>  static int sdhci_iproc_probe(struct platform_device *pdev)
>>>>  {
>>>> +     struct device *dev = &pdev->dev;
>>>>       const struct of_device_id *match;
>>>> +     const struct acpi_device_id *acpi_id;
>>>>       const struct sdhci_iproc_data *iproc_data;
>>>>       struct sdhci_host *host;
>>>>       struct sdhci_iproc_host *iproc_host;
>>>>       struct sdhci_pltfm_host *pltfm_host;
>>>>       int ret;
>>>> +     enum sdhci_pltfm_type plat_type;
>>>> +
>>>> +     if (dev->of_node) {
>>>> +             match = of_match_device(sdhci_iproc_of_match, dev);
>>>> +             if (match)
>>>> +                     plat_type = (enum sdhci_pltfm_type)match->data;
>>>> +             else
>>>> +                     return -ENODEV;
>>>> +     } else if (has_acpi_companion(dev)) {
>>>> +             acpi_id = acpi_match_device(sdhci_iproc_acpi_ids, dev);
>>>> +             if (acpi_id)
>>>> +                     plat_type = (enum sdhci_pltfm_type)acpi_id->driver_data;
>>>> +             else
>>>> +                     return -ENODEV;
>>>> +     } else
>>>> +             return -ENODEV;
>>>>
>>>> -     match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
>>>> -     if (!match)
>>>> -             return -EINVAL;
>>>> -     iproc_data = match->data;
>>>> +     iproc_data = &sdhci_iproc_data_list[plat_type];
>>>>
>>>>       host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));
>>>>       if (IS_ERR(host))
>>>> @@ -284,17 +336,30 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>>>>
>>>>       host->mmc->caps |= iproc_host->data->mmc_caps;
>>>>
>>>> -     pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
>>>> -     if (IS_ERR(pltfm_host->clk)) {
>>>> -             ret = PTR_ERR(pltfm_host->clk);
>>>> -             goto err;
>>>> -     }
>>>> -     ret = clk_prepare_enable(pltfm_host->clk);
>>>> -     if (ret) {
>>>> -             dev_err(&pdev->dev, "failed to enable host clk\n");
>>>> -             goto err;
>>>> +     if (dev->of_node) {
>>>> +             pltfm_host->clk = devm_clk_get(dev, NULL);
>>>> +             if (IS_ERR(pltfm_host->clk)) {
>>>> +                     ret = PTR_ERR(pltfm_host->clk);
>>>> +                     goto err;
>>>> +             }
>>>> +             ret = clk_prepare_enable(pltfm_host->clk);
>>>> +             if (ret) {
>>>> +                     dev_err(dev, "failed to enable host clk\n");
>>>> +                     goto err;
>>>> +             }
>>>> +     } else if (has_acpi_companion(dev)) {
>>>> +             /*
>>>> +              * When Driver probe with ACPI device, clock devices
>>>> +              * are not available, so sdhci clock get from
>>>> +              * clock-frequency property given in _DSD object.
>>>> +              */
>>>> +             device_property_read_u32(dev, "clock-frequency",
>>>> +                                      &pltfm_host->clock);
>>>
>>> Is this a new property, or is it documented?  Did you consider enhancing
>>> __sdhci_read_caps() and using the existing "sdhci-caps" and
>>> "sdhci-caps-mask" properties?
>>>
>> "clock-frequency" is not a new property also used in "sdhci-pltfm.c"
>> to get clock
>> frequency and use in the case of clock device node is not passed from
>> device tree node.
>> But In the case of ACPI support, ACPI does not support common clock framework.
>> so clock frequency get by "clock-frequency" property given in _DSD
>> object of ACPI device node.
>
> So we should convert to generic device properties i.e. add the patch below and
> call sdhci_get_property(pdev):
>
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Fri, 27 Jul 2018 13:52:02 +0300
> Subject: [PATCH] mmc: sdhci-pltfm: Convert DT properties to generic device
>  properties
>
> Convert DT properties to generic device properties so that drivers can get
> properties from DT or ACPI.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 68 +++++++++++++++++++++++++-----------------
>  drivers/mmc/host/sdhci-pltfm.h |  7 ++++-
>  2 files changed, 46 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 02bea6159d79..b231c9a3f888 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -30,6 +30,7 @@
>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/of.h>
>  #ifdef CONFIG_PPC
>  #include <asm/machdep.h>
> @@ -51,11 +52,10 @@ unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host)
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>
> -#ifdef CONFIG_OF
> -static bool sdhci_of_wp_inverted(struct device_node *np)
> +static bool sdhci_wp_inverted(struct device *dev)
>  {
> -       if (of_get_property(np, "sdhci,wp-inverted", NULL) ||
> -           of_get_property(np, "wp-inverted", NULL))
> +       if (device_property_present(dev, "sdhci,wp-inverted") ||
> +           device_property_present(dev, "wp-inverted"))
>                 return true;
>
>         /* Old device trees don't have the wp-inverted property. */
> @@ -66,52 +66,64 @@ static bool sdhci_of_wp_inverted(struct device_node *np)
>  #endif /* CONFIG_PPC */
>  }
>
> -void sdhci_get_of_property(struct platform_device *pdev)
> +#ifdef CONFIG_OF
> +static void sdhci_get_compatibility(struct platform_device *pdev)
>  {
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct device_node *np = pdev->dev.of_node;
> +
> +       if (!np)
> +               return;
> +
> +       if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
> +               host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +
> +       if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
> +           of_device_is_compatible(np, "fsl,p1010-esdhc") ||
> +           of_device_is_compatible(np, "fsl,t4240-esdhc") ||
> +           of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> +               host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +}
> +#else
> +void sdhci_get_compatibility(struct platform_device *pdev) {}
> +#endif /* CONFIG_OF */
> +
> +void sdhci_get_property(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         u32 bus_width;
>
> -       if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> +       if (device_property_present(dev, "sdhci,auto-cmd12"))
>                 host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>
> -       if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
> -           (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
> +       if (device_property_present(dev, "sdhci,1-bit-only") ||
> +           (device_property_read_u32(dev, "bus-width", &bus_width) == 0 &&
>             bus_width == 1))
>                 host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
>
> -       if (sdhci_of_wp_inverted(np))
> +       if (sdhci_wp_inverted(dev))
>                 host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
>
> -       if (of_get_property(np, "broken-cd", NULL))
> +       if (device_property_present(dev, "broken-cd"))
>                 host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>
> -       if (of_get_property(np, "no-1-8-v", NULL))
> +       if (device_property_present(dev, "no-1-8-v"))
>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>
> -       if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
> -               host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> -
> -       if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
> -           of_device_is_compatible(np, "fsl,p1010-esdhc") ||
> -           of_device_is_compatible(np, "fsl,t4240-esdhc") ||
> -           of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> -               host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +       sdhci_get_compatibility(pdev);
>
> -       of_property_read_u32(np, "clock-frequency", &pltfm_host->clock);
> +       device_property_read_u32(dev, "clock-frequency", &pltfm_host->clock);
>
> -       if (of_find_property(np, "keep-power-in-suspend", NULL))
> +       if (device_property_present(dev, "keep-power-in-suspend"))
>                 host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
>
> -       if (of_property_read_bool(np, "wakeup-source") ||
> -           of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
> +       if (device_property_read_bool(dev, "wakeup-source") ||
> +           device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
>                 host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>  }
> -#else
> -void sdhci_get_of_property(struct platform_device *pdev) {}
> -#endif /* CONFIG_OF */
> -EXPORT_SYMBOL_GPL(sdhci_get_of_property);
> +EXPORT_SYMBOL_GPL(sdhci_get_property);
>
>  struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                                     const struct sdhci_pltfm_data *pdata,
> @@ -184,7 +196,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>
> -       sdhci_get_of_property(pdev);
> +       sdhci_get_property(pdev);
>
>         ret = sdhci_add_host(host);
>         if (ret)
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 1e91fb1c020e..6109987fc3b5 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -90,7 +90,12 @@ static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
>  }
>  #endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
>
> -extern void sdhci_get_of_property(struct platform_device *pdev);
> +void sdhci_get_property(struct platform_device *pdev);
> +
> +static inline void sdhci_get_of_property(struct platform_device *pdev)
> +{
> +       return sdhci_get_property(pdev);
> +}
>
>  extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                                           const struct sdhci_pltfm_data *pdata,
> --
> 1.9.1
>
>
>
>>
>>>> +             if (!pltfm_host->clock) {
>>>> +                     ret = -ENODEV;
>>>> +                     goto err;
>>>> +             }
>>>>       }
>>>> -
>>>>       if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>>>>               host->caps = iproc_host->data->caps;
>>>>               host->caps1 = iproc_host->data->caps1;
>>>> @@ -307,7 +372,8 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>>>>       return 0;
>>>>
>>>>  err_clk:
>>>> -     clk_disable_unprepare(pltfm_host->clk);
>>>> +     if (dev->of_node)
>>>> +             clk_disable_unprepare(pltfm_host->clk);
>>>>  err:
>>>>       sdhci_pltfm_free(pdev);
>>>>       return ret;
>>>> @@ -317,6 +383,7 @@ static struct platform_driver sdhci_iproc_driver = {
>>>>       .driver = {
>>>>               .name = "sdhci-iproc",
>>>>               .of_match_table = sdhci_iproc_of_match,
>>>> +             .acpi_match_table = ACPI_PTR(sdhci_iproc_acpi_ids),
>>>>               .pm = &sdhci_pltfm_pmops,
>>>>       },
>>>>       .probe = sdhci_iproc_probe,
>>>>
>>>
>> Regards,
>> Srinath.
>>
>
