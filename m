From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: adapt hsmmc to hwmod framework
Date: Thu, 24 Feb 2011 12:49:02 +0100
Message-ID: <4D6645AE.5080506@ti.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com> <1298483231-29622-6-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44618 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab1BXLtK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 06:49:10 -0500
In-Reply-To: <1298483231-29622-6-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

On 2/23/2011 6:47 PM, Kadiyala, Kishore wrote:
> Changes involves:
> 1) Remove controller reset in devices.c which is taken care of
>     by hwmod framework.
> 2) Removing all base address macro defines except keeping one for OMAP2420.
> 3) Using omap-device layer to register device and utilizing data from
>     hwmod data file for base address, dma channel number, Irq_number,
>     device attribute.
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> CC: Kevin Hilman<khilman@deeprootsystems.com>
> ---
>   arch/arm/mach-omap2/devices.c         |  251 ---------------------------------
>   arch/arm/mach-omap2/hsmmc.c           |  153 ++++++++++++++++++--
>   arch/arm/plat-omap/include/plat/mmc.h |   14 --
>   3 files changed, 141 insertions(+), 277 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 7b35c87..2d2deb6 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -503,112 +503,6 @@ static inline void omap_init_aes(void) { }
>
>   /*-------------------------------------------------------------------------*/
>
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> -
> -#define MMCHS_SYSCONFIG                        0x0010
> -#define MMCHS_SYSCONFIG_SWRESET                (1<<  1)
> -#define MMCHS_SYSSTATUS                        0x0014
> -#define MMCHS_SYSSTATUS_RESETDONE      (1<<  0)
> -
> -static struct platform_device dummy_pdev = {
> -       .dev = {
> -               .bus =&platform_bus_type,
> -       },
> -};
> -
> -/**
> - * omap_hsmmc_reset() - Full reset of each HS-MMC controller
> - *
> - * Ensure that each MMC controller is fully reset.  Controllers
> - * left in an unknown state (by bootloader) may prevent retention
> - * or OFF-mode.  This is especially important in cases where the
> - * MMC driver is not enabled, _or_ built as a module.
> - *
> - * In order for reset to work, interface, functional and debounce
> - * clocks must be enabled.  The debounce clock comes from func_32k_clk
> - * and is not under SW control, so we only enable i- and f-clocks.
> - **/
> -static void __init omap_hsmmc_reset(void)
> -{
> -       u32 i, nr_controllers;
> -       struct clk *iclk, *fclk;
> -
> -       if (cpu_is_omap242x())
> -               return;
> -
> -       nr_controllers = cpu_is_omap44xx() ? OMAP44XX_NR_MMC :
> -               (cpu_is_omap34xx() ? OMAP34XX_NR_MMC : OMAP24XX_NR_MMC);
> -
> -       for (i = 0; i<  nr_controllers; i++) {
> -               u32 v, base = 0;
> -               struct device *dev =&dummy_pdev.dev;
> -
> -               switch (i) {
> -               case 0:
> -                       base = OMAP2_MMC1_BASE;
> -                       break;
> -               case 1:
> -                       base = OMAP2_MMC2_BASE;
> -                       break;
> -               case 2:
> -                       base = OMAP3_MMC3_BASE;
> -                       break;
> -               case 3:
> -                       if (!cpu_is_omap44xx())
> -                               return;
> -                       base = OMAP4_MMC4_BASE;
> -                       break;
> -               case 4:
> -                       if (!cpu_is_omap44xx())
> -                               return;
> -                       base = OMAP4_MMC5_BASE;
> -                       break;
> -               }
> -
> -               if (cpu_is_omap44xx())
> -                       base += OMAP4_MMC_REG_OFFSET;
> -
> -               dummy_pdev.id = i;
> -               dev_set_name(&dummy_pdev.dev, "mmci-omap-hs.%d", i);
> -               iclk = clk_get(dev, "ick");
> -               if (IS_ERR(iclk))
> -                       goto err1;
> -               if (clk_enable(iclk))
> -                       goto err2;
> -
> -               fclk = clk_get(dev, "fck");
> -               if (IS_ERR(fclk))
> -                       goto err3;
> -               if (clk_enable(fclk))
> -                       goto err4;
> -
> -               omap_writel(MMCHS_SYSCONFIG_SWRESET, base + MMCHS_SYSCONFIG);
> -               v = omap_readl(base + MMCHS_SYSSTATUS);
> -               while (!(omap_readl(base + MMCHS_SYSSTATUS)&
> -                        MMCHS_SYSSTATUS_RESETDONE))
> -                       cpu_relax();
> -
> -               clk_disable(fclk);
> -               clk_put(fclk);
> -               clk_disable(iclk);
> -               clk_put(iclk);
> -       }
> -       return;
> -
> -err4:
> -       clk_put(fclk);
> -err3:
> -       clk_disable(iclk);
> -err2:
> -       clk_put(iclk);
> -err1:
> -       printk(KERN_WARNING "%s: Unable to enable clocks for MMC%d, "
> -                           "cannot reset.\n",  __func__, i);
> -}
> -#else
> -static inline void omap_hsmmc_reset(void) {}
> -#endif
> -
>   #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>
>   static inline void omap242x_mmc_mux(struct omap_mmc_platform_data
> @@ -665,150 +559,6 @@ void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
>
>   #endif
>
> -#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> -
> -static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
> -                       int controller_nr)
> -{
> -       if ((mmc_controller->slots[0].switch_pin>  0)&&  \
> -               (mmc_controller->slots[0].switch_pin<  OMAP_MAX_GPIO_LINES))
> -               omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
> -                                       OMAP_PIN_INPUT_PULLUP);
> -       if ((mmc_controller->slots[0].gpio_wp>  0)&&  \
> -               (mmc_controller->slots[0].gpio_wp<  OMAP_MAX_GPIO_LINES))
> -               omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
> -                                       OMAP_PIN_INPUT_PULLUP);
> -       if (cpu_is_omap34xx()) {
> -               if (controller_nr == 0) {
> -                       omap_mux_init_signal("sdmmc1_clk",
> -                               OMAP_PIN_INPUT_PULLUP);
> -                       omap_mux_init_signal("sdmmc1_cmd",
> -                               OMAP_PIN_INPUT_PULLUP);
> -                       omap_mux_init_signal("sdmmc1_dat0",
> -                               OMAP_PIN_INPUT_PULLUP);
> -                       if (mmc_controller->slots[0].caps&
> -                               (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
> -                               omap_mux_init_signal("sdmmc1_dat1",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc1_dat2",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc1_dat3",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                       }
> -                       if (mmc_controller->slots[0].caps&
> -                                               MMC_CAP_8_BIT_DATA) {
> -                               omap_mux_init_signal("sdmmc1_dat4",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc1_dat5",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc1_dat6",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc1_dat7",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                       }
> -               }
> -               if (controller_nr == 1) {
> -                       /* MMC2 */
> -                       omap_mux_init_signal("sdmmc2_clk",
> -                               OMAP_PIN_INPUT_PULLUP);
> -                       omap_mux_init_signal("sdmmc2_cmd",
> -                               OMAP_PIN_INPUT_PULLUP);
> -                       omap_mux_init_signal("sdmmc2_dat0",
> -                               OMAP_PIN_INPUT_PULLUP);
> -
> -                       /*
> -                        * For 8 wire configurations, Lines DAT4, 5, 6 and 7 need to be muxed
> -                        * in the board-*.c files
> -                        */
> -                       if (mmc_controller->slots[0].caps&
> -                               (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
> -                               omap_mux_init_signal("sdmmc2_dat1",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc2_dat2",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc2_dat3",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                       }
> -                       if (mmc_controller->slots[0].caps&
> -                                                       MMC_CAP_8_BIT_DATA) {
> -                               omap_mux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc2_dat5.sdmmc2_dat5",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc2_dat6.sdmmc2_dat6",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                               omap_mux_init_signal("sdmmc2_dat7.sdmmc2_dat7",
> -                                       OMAP_PIN_INPUT_PULLUP);
> -                       }
> -               }
> -
> -               /*
> -                * For MMC3 the pins need to be muxed in the board-*.c files
> -                */
> -       }
> -}
> -
> -void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
> -                       int nr_controllers)
> -{
> -       int i;
> -       char *name;
> -
> -       for (i = 0; i<  nr_controllers; i++) {
> -               unsigned long base, size;
> -               unsigned int irq = 0;
> -
> -               if (!mmc_data[i])
> -                       continue;
> -
> -               omap2_mmc_mux(mmc_data[i], i);
> -
> -               switch (i) {
> -               case 0:
> -                       base = OMAP2_MMC1_BASE;
> -                       irq = INT_24XX_MMC_IRQ;
> -                       break;
> -               case 1:
> -                       base = OMAP2_MMC2_BASE;
> -                       irq = INT_24XX_MMC2_IRQ;
> -                       break;
> -               case 2:
> -                       if (!cpu_is_omap44xx()&&  !cpu_is_omap34xx())
> -                               return;
> -                       base = OMAP3_MMC3_BASE;
> -                       irq = INT_34XX_MMC3_IRQ;
> -                       break;
> -               case 3:
> -                       if (!cpu_is_omap44xx())
> -                               return;
> -                       base = OMAP4_MMC4_BASE;
> -                       irq = OMAP44XX_IRQ_MMC4;
> -                       break;
> -               case 4:
> -                       if (!cpu_is_omap44xx())
> -                               return;
> -                       base = OMAP4_MMC5_BASE;
> -                       irq = OMAP44XX_IRQ_MMC5;
> -                       break;
> -               default:
> -                       continue;
> -               }
> -
> -               if (cpu_is_omap44xx()) {
> -                       if (i<  3)
> -                               irq += OMAP44XX_IRQ_GIC_START;
> -                       size = OMAP4_HSMMC_SIZE;
> -                       name = "mmci-omap-hs";
> -               } else {
> -                       size = OMAP3_HSMMC_SIZE;
> -                       name = "mmci-omap-hs";
> -               }
> -               omap_mmc_add(name, i, base, size, irq, mmc_data[i]);
> -       };
> -}
> -
> -#endif
> -
>   /*-------------------------------------------------------------------------*/
>
>   #if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
> @@ -878,7 +628,6 @@ static int __init omap2_init_devices(void)
>           * please keep these calls, and their implementations above,
>           * in alphabetical order so they're easier to sort through.
>           */
> -       omap_hsmmc_reset();
>          omap_init_audio();
>          omap_init_camera();
>          omap_init_mbox();
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 34272e4..b6e1eae 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -16,7 +16,11 @@
>   #include<mach/hardware.h>
>   #include<plat/mmc.h>
>   #include<plat/omap-pm.h>
> +#include<plat/mux.h>
> +#include<plat/omap_hwmod.h>
> +#include<plat/omap_device.h>
>
> +#include "mux.h"
>   #include "hsmmc.h"
>   #include "control.h"
>
> @@ -30,7 +34,7 @@ static u16 control_mmc1;
>
>   static struct hsmmc_controller {
>          char                            name[HSMMC_NAME_LEN + 1];
> -} hsmmc[OMAP34XX_NR_MMC];
> +} hsmmc[OMAP44XX_NR_MMC];

I do not know the details of that driver, so this comment might be 
completely irrelevant, but in theory, such static table should not be 
necessary since the driver core already maintain a list of all instances 
bound to it.
Because of that, you will have to modify this code for every new OMAP 
generation each time we add a new instance.

>
>   #if defined(CONFIG_ARCH_OMAP3)&&  defined(CONFIG_PM)
>
> @@ -204,7 +208,141 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
>          return 0;
>   }
>
> -static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
> +static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
> +                       int controller_nr)
> +{
> +       if ((mmc_controller->slots[0].switch_pin>  0)&&  \
> +               (mmc_controller->slots[0].switch_pin<  OMAP_MAX_GPIO_LINES))
> +               omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
> +                                       OMAP_PIN_INPUT_PULLUP);
> +       if ((mmc_controller->slots[0].gpio_wp>  0)&&  \
> +               (mmc_controller->slots[0].gpio_wp<  OMAP_MAX_GPIO_LINES))
> +               omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
> +                                       OMAP_PIN_INPUT_PULLUP);
> +       if (cpu_is_omap34xx()) {
> +               if (controller_nr == 0) {
> +                       omap_mux_init_signal("sdmmc1_clk",
> +                               OMAP_PIN_INPUT_PULLUP);
> +                       omap_mux_init_signal("sdmmc1_cmd",
> +                               OMAP_PIN_INPUT_PULLUP);
> +                       omap_mux_init_signal("sdmmc1_dat0",
> +                               OMAP_PIN_INPUT_PULLUP);
> +                       if (mmc_controller->slots[0].caps&
> +                               (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
> +                               omap_mux_init_signal("sdmmc1_dat1",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc1_dat2",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc1_dat3",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                       }
> +                       if (mmc_controller->slots[0].caps&
> +                                               MMC_CAP_8_BIT_DATA) {
> +                               omap_mux_init_signal("sdmmc1_dat4",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc1_dat5",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc1_dat6",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc1_dat7",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                       }
> +               }
> +               if (controller_nr == 1) {
> +                       /* MMC2 */
> +                       omap_mux_init_signal("sdmmc2_clk",
> +                               OMAP_PIN_INPUT_PULLUP);
> +                       omap_mux_init_signal("sdmmc2_cmd",
> +                               OMAP_PIN_INPUT_PULLUP);
> +                       omap_mux_init_signal("sdmmc2_dat0",
> +                               OMAP_PIN_INPUT_PULLUP);
> +
> +                       /*
> +                        * For 8 wire configurations, Lines DAT4, 5, 6 and 7
> +                        * need to be muxed in the board-*.c files
> +                        */
> +                       if (mmc_controller->slots[0].caps&
> +                               (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
> +                               omap_mux_init_signal("sdmmc2_dat1",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc2_dat2",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc2_dat3",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                       }
> +                       if (mmc_controller->slots[0].caps&
> +                                                       MMC_CAP_8_BIT_DATA) {
> +                               omap_mux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc2_dat5.sdmmc2_dat5",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc2_dat6.sdmmc2_dat6",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                               omap_mux_init_signal("sdmmc2_dat7.sdmmc2_dat7",
> +                                       OMAP_PIN_INPUT_PULLUP);
> +                       }
> +               }
> +
> +               /*
> +                * For MMC3 the pins need to be muxed in the board-*.c files
> +                */
> +       }
> +}
> +
> +static struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC] __initdata;

Same concern than for hsmmc, why do you need static table here?
And why do you need another structure? The omap2_hsmmc_info should 
already be in a pdata kind of structure.
The board file should just populate a table of pdata that you will use 
during init.

> +
> +static struct omap_device_pm_latency omap_hsmmc_latency[] = {
> +       [0] = {
> +               .deactivate_func = omap_device_idle_hwmods,
> +               .activate_func   = omap_device_enable_hwmods,
> +               .flags           = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +       },
> +       /*
> +        * XXX There should also be an entry here to power off/on the
> +        * MMC regulators/PBIAS cells, etc.
> +        */
> +};
> +
> +static int omap2_mmc_init(struct omap_hwmod *oh, void *hsmmcinfo)
> +{
> +       struct omap_device *od;
> +       struct omap_device_pm_latency *ohl;
> +       char *name;
> +       int ohl_cnt = 0;
> +       struct mmc_dev_attr *mmc_dattr = oh->dev_attr;
> +       struct omap2_hsmmc_info *c = (struct omap2_hsmmc_info *) hsmmcinfo;
> +       int idx;
> +       static int mmc_num;
> +
> +       /* Initialization of controllers which are not updated
> +        * in board file will be skipped here.
> +        */
> +       c += mmc_num;
> +       if (!c->mmc) {
> +               pr_err("omap_hsmmc_info is not updated in board file\n");
> +               return 0;
> +       }
> +       idx = c->mmc - 1 ;
> +       name = "mmci-omap-hs";

Could you please rename the device to have something in the form: 
omap_XXXX? In that case "omap_mmc" should be good. The "hs" is just a 
indication of one of the mmc instance capability and does not have to be 
in the device name since there is no none-hs instance.

I know that this is not in your patch and was already there before, but 
that code is happily mixing MMC or HSMMC everywhere, so having a little 
bit of consistency will be good. I vote to stick to MMC only.
The "omap2_" prefix does not seems necessary too for my point of view. 
"omap_" is good enough.

> +       ohl = omap_hsmmc_latency;
> +       ohl_cnt = ARRAY_SIZE(omap_hsmmc_latency);
> +       omap2_mmc_mux(hsmmc_data[idx], idx);
> +       hsmmc_data[idx]->controller_dev_attr = mmc_dattr->flags;

You should copy the data and not keep a reference to internal hwmod 
structure. In your case, you should check if dev_attr is not null. It 
will avoid adding some empty dev_attr structure in the hwmod_data files.

> +       od = omap_device_build(name, idx, oh, hsmmc_data[idx],
> +               sizeof(struct omap_mmc_platform_data), ohl, ohl_cnt, false);
> +       if (IS_ERR(od)) {
> +               WARN(1, "Cant build omap_device for %s:%s.\n",
> +                                       name, oh->name);
> +               return PTR_ERR(od);
> +       }
> +       /*
> +        * return device handle to board setup code
> +        * required to populate for regulator framework structure
> +        */
> +       c->dev =&od->pdev.dev;
> +       mmc_num++;
> +       return 0;
> +}

Regards,
Benoit
