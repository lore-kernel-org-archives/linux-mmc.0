From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: adapt hsmmc to hwmod framework
Date: Thu, 24 Feb 2011 19:25:07 +0530
Message-ID: <AANLkTimKG_B7LxAf4Ci8mTh8-guYqBfgD2nDN0gA3EQE@mail.gmail.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
 <1298483231-29622-6-git-send-email-kishore.kadiyala@ti.com> <4D6645AE.5080506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44385 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754025Ab1BXNz3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 08:55:29 -0500
In-Reply-To: <4D6645AE.5080506@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

On Thu, Feb 24, 2011 at 5:19 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 2/23/2011 6:47 PM, Kadiyala, Kishore wrote:
>>
>> Changes involves:
>> 1) Remove controller reset in devices.c which is taken care of
>> =A0 =A0by hwmod framework.
>> 2) Removing all base address macro defines except keeping one for
>> OMAP2420.
>> 3) Using omap-device layer to register device and utilizing data fro=
m
>> =A0 =A0hwmod data file for base address, dma channel number, Irq_num=
ber,
>> =A0 =A0device attribute.
>>
>> Signed-off-by: Paul Walmsley<paul@pwsan.com>
>> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> CC: Kevin Hilman<khilman@deeprootsystems.com>
>> ---
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 | =A0251
>> ---------------------------------
>> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0153 ++++++++=
++++++++++--
>> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 14 --
>> =A03 files changed, 141 insertions(+), 277 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/dev=
ices.c
>> index 7b35c87..2d2deb6 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -503,112 +503,6 @@ static inline void omap_init_aes(void) { }
>>
>>
>> =A0/*---------------------------------------------------------------=
----------*/
>>
>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> -
>> -#define MMCHS_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x0010
>> -#define MMCHS_SYSCONFIG_SWRESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<=
 =A01)
>> -#define MMCHS_SYSSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x0014
>> -#define MMCHS_SYSSTATUS_RESETDONE =A0 =A0 =A0(1<< =A00)
>> -
>> -static struct platform_device dummy_pdev =3D {
>> - =A0 =A0 =A0 .dev =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus =3D&platform_bus_type,
>> - =A0 =A0 =A0 },
>> -};
>> -
>> -/**
>> - * omap_hsmmc_reset() - Full reset of each HS-MMC controller
>> - *
>> - * Ensure that each MMC controller is fully reset. =A0Controllers
>> - * left in an unknown state (by bootloader) may prevent retention
>> - * or OFF-mode. =A0This is especially important in cases where the
>> - * MMC driver is not enabled, _or_ built as a module.
>> - *
>> - * In order for reset to work, interface, functional and debounce
>> - * clocks must be enabled. =A0The debounce clock comes from func_32=
k_clk
>> - * and is not under SW control, so we only enable i- and f-clocks.
>> - **/
>> -static void __init omap_hsmmc_reset(void)
>> -{
>> - =A0 =A0 =A0 u32 i, nr_controllers;
>> - =A0 =A0 =A0 struct clk *iclk, *fclk;
>> -
>> - =A0 =A0 =A0 if (cpu_is_omap242x())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> -
>> - =A0 =A0 =A0 nr_controllers =3D cpu_is_omap44xx() ? OMAP44XX_NR_MMC=
 :
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cpu_is_omap34xx() ? OMAP34XX_NR_MMC :=
 OMAP24XX_NR_MMC);
>> -
>> - =A0 =A0 =A0 for (i =3D 0; i< =A0nr_controllers; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 v, base =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *dev =3D&dummy_pdev.dev;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (i) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC1_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC2_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP3_MMC3_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 3:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx()=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC4_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx()=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC5_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base +=3D OMAP4_MMC_RE=
G_OFFSET;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy_pdev.id =3D i;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_set_name(&dummy_pdev.dev, "mmci-om=
ap-hs.%d", i);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iclk =3D clk_get(dev, "ick");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(iclk))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (clk_enable(iclk))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk =3D clk_get(dev, "fck");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(fclk))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (clk_enable(fclk))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(MMCHS_SYSCONFIG_SWRESET, b=
ase +
>> MMCHS_SYSCONFIG);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D omap_readl(base + MMCHS_SYSSTATU=
S);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(omap_readl(base + MMCHS_SYSST=
ATUS)&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMCHS_SYSSTATUS_RES=
ETDONE))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(iclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(iclk);
>> - =A0 =A0 =A0 }
>> - =A0 =A0 =A0 return;
>> -
>> -err4:
>> - =A0 =A0 =A0 clk_put(fclk);
>> -err3:
>> - =A0 =A0 =A0 clk_disable(iclk);
>> -err2:
>> - =A0 =A0 =A0 clk_put(iclk);
>> -err1:
>> - =A0 =A0 =A0 printk(KERN_WARNING "%s: Unable to enable clocks for M=
MC%d, "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cannot reset.=
\n", =A0__func__, i);
>> -}
>> -#else
>> -static inline void omap_hsmmc_reset(void) {}
>> -#endif
>> -
>> =A0#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>>
>> =A0static inline void omap242x_mmc_mux(struct omap_mmc_platform_data
>> @@ -665,150 +559,6 @@ void __init omap242x_init_mmc(struct
>> omap_mmc_platform_data **mmc_data)
>>
>> =A0#endif
>>
>> -#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODUL=
E)
>> -
>> -static inline void omap2_mmc_mux(struct omap_mmc_platform_data
>> *mmc_controller,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int controller_nr)
>> -{
>> - =A0 =A0 =A0 if ((mmc_controller->slots[0].switch_pin> =A00)&& =A0\
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_controller->slots[0].switch_pin<
>> =A0OMAP_MAX_GPIO_LINES))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(mmc_controller->slo=
ts[0].switch_pin,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 if ((mmc_controller->slots[0].gpio_wp> =A00)&& =A0\
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_controller->slots[0].gpio_wp< =A0=
OMAP_MAX_GPIO_LINES))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(mmc_controller->slo=
ts[0].gpio_wp,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 if (cpu_is_omap34xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (controller_nr =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc1_clk",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc1_cmd",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc1_dat0",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_C=
AP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))
>> {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat1",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat2",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat3",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_8_BIT_DATA) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat4",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat5",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat6",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat7",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (controller_nr =3D=3D 1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MMC2 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc2_clk",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc2_cmd",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc2_dat0",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For 8 wire config=
urations, Lines DAT4, 5, 6 and
>> 7 need to be muxed
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in the board-*.c =
files
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_C=
AP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))
>> {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat1",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat2",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat3",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps&
>> -
>> MMC_CAP_8_BIT_DATA) {
>> -
>> omap_mux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> -
>> omap_mux_init_signal("sdmmc2_dat5.sdmmc2_dat5",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> -
>> omap_mux_init_signal("sdmmc2_dat6.sdmmc2_dat6",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> -
>> omap_mux_init_signal("sdmmc2_dat7.sdmmc2_dat7",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For MMC3 the pins need to be muxe=
d in the board-*.c
>> files
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 }
>> -}
>> -
>> -void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int nr_controllers)
>> -{
>> - =A0 =A0 =A0 int i;
>> - =A0 =A0 =A0 char *name;
>> -
>> - =A0 =A0 =A0 for (i =3D 0; i< =A0nr_controllers; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long base, size;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int irq =3D 0;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mmc_data[i])
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mmc_mux(mmc_data[i], i);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (i) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC1_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D INT_24XX_MMC_I=
RQ;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC2_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D INT_24XX_MMC2_=
IRQ;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx()=
&& =A0!cpu_is_omap34xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP3_MMC3_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D INT_34XX_MMC3_=
IRQ;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 3:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx()=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC4_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D OMAP44XX_IRQ_M=
MC4;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx()=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC5_BA=
SE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D OMAP44XX_IRQ_M=
MC5;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i< =A03)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq +=3D=
 OMAP44XX_IRQ_GIC_START;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP4_HSMMC_S=
IZE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap-hs=
";
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP3_HSMMC_S=
IZE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap-hs=
";
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mmc_add(name, i, base, size, irq,=
 mmc_data[i]);
>> - =A0 =A0 =A0 };
>> -}
>> -
>> -#endif
>> -
>>
>> =A0/*---------------------------------------------------------------=
----------*/
>>
>> =A0#if defined(CONFIG_HDQ_MASTER_OMAP) ||
>> defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
>> @@ -878,7 +628,6 @@ static int __init omap2_init_devices(void)
>> =A0 =A0 =A0 =A0 =A0* please keep these calls, and their implementati=
ons above,
>> =A0 =A0 =A0 =A0 =A0* in alphabetical order so they're easier to sort=
 through.
>> =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 omap_hsmmc_reset();
>> =A0 =A0 =A0 =A0 omap_init_audio();
>> =A0 =A0 =A0 =A0 omap_init_camera();
>> =A0 =A0 =A0 =A0 omap_init_mbox();
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc=
=2Ec
>> index 34272e4..b6e1eae 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -16,7 +16,11 @@
>> =A0#include<mach/hardware.h>
>> =A0#include<plat/mmc.h>
>> =A0#include<plat/omap-pm.h>
>> +#include<plat/mux.h>
>> +#include<plat/omap_hwmod.h>
>> +#include<plat/omap_device.h>
>>
>> +#include "mux.h"
>> =A0#include "hsmmc.h"
>> =A0#include "control.h"
>>
>> @@ -30,7 +34,7 @@ static u16 control_mmc1;
>>
>> =A0static struct hsmmc_controller {
>> =A0 =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0name[HSMMC_NAME_LEN + 1];
>> -} hsmmc[OMAP34XX_NR_MMC];
>> +} hsmmc[OMAP44XX_NR_MMC];
>
> I do not know the details of that driver, so this comment might be
> completely irrelevant, but in theory, such static table should not be
> necessary since the driver core already maintain a list of all instan=
ces
> bound to it.

I agree, but this is used in slot data for the controller and is used
in the driver
to create a /sys entry. I will try to avoid the "OMAP44XX_NR_MMC" depen=
dency.


> Because of that, you will have to modify this code for every new OMAP
> generation each time we add a new instance.
>
>>
>> =A0#if defined(CONFIG_ARCH_OMAP3)&& =A0defined(CONFIG_PM)
>>
>> @@ -204,7 +208,141 @@ static int nop_mmc_set_power(struct device *de=
v, int
>> slot, int power_on,
>> =A0 =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC]
>> __initdata;
>> +static inline void omap2_mmc_mux(struct omap_mmc_platform_data
>> *mmc_controller,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int controller_nr)
>> +{
>> + =A0 =A0 =A0 if ((mmc_controller->slots[0].switch_pin> =A00)&& =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_controller->slots[0].switch_pin<
>> =A0OMAP_MAX_GPIO_LINES))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(mmc_controller->slo=
ts[0].switch_pin,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 if ((mmc_controller->slots[0].gpio_wp> =A00)&& =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_controller->slots[0].gpio_wp< =A0=
OMAP_MAX_GPIO_LINES))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(mmc_controller->slo=
ts[0].gpio_wp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 if (cpu_is_omap34xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (controller_nr =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc1_clk",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc1_cmd",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc1_dat0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_C=
AP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))
>> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat3",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_8_BIT_DATA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat4",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat5",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat6",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat7",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (controller_nr =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MMC2 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc2_clk",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc2_cmd",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc2_dat0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For 8 wire config=
urations, Lines DAT4, 5, 6 and
>> 7
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* need to be muxed =
in the board-*.c files
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_C=
AP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))
>> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat3",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps&
>> +
>> MMC_CAP_8_BIT_DATA) {
>> +
>> omap_mux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> +
>> omap_mux_init_signal("sdmmc2_dat5.sdmmc2_dat5",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> +
>> omap_mux_init_signal("sdmmc2_dat6.sdmmc2_dat6",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> +
>> omap_mux_init_signal("sdmmc2_dat7.sdmmc2_dat7",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For MMC3 the pins need to be muxe=
d in the board-*.c
>> files
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 }
>> +}
>> +
>> +static struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC]
>> __initdata;
>
> Same concern than for hsmmc, why do you need static table here?

Agree, will remove static declaration.

> And why do you need another structure? The omap2_hsmmc_info should al=
ready
> be in a pdata kind of structure.
> The board file should just populate a table of pdata that you will us=
e
> during init.

No, omap2_hsmmc_info is intermediate structure used by the boards
files to update
some basic info of the controller, based on which the pdata is
populated in hsmmc.c.

>
>> +
>> +static struct omap_device_pm_latency omap_hsmmc_latency[] =3D {
>> + =A0 =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_=
hwmods,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D omap_device_ena=
ble_hwmods,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =3D OMAP_DE=
VICE_LATENCY_AUTO_ADJUST,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* XXX There should also be an entry here to power o=
ff/on the
>> + =A0 =A0 =A0 =A0* MMC regulators/PBIAS cells, etc.
>> + =A0 =A0 =A0 =A0*/
>> +};
>> +
>> +static int omap2_mmc_init(struct omap_hwmod *oh, void *hsmmcinfo)
>> +{
>> + =A0 =A0 =A0 struct omap_device *od;
>> + =A0 =A0 =A0 struct omap_device_pm_latency *ohl;
>> + =A0 =A0 =A0 char *name;
>> + =A0 =A0 =A0 int ohl_cnt =3D 0;
>> + =A0 =A0 =A0 struct mmc_dev_attr *mmc_dattr =3D oh->dev_attr;
>> + =A0 =A0 =A0 struct omap2_hsmmc_info *c =3D (struct omap2_hsmmc_inf=
o *)
>> hsmmcinfo;
>> + =A0 =A0 =A0 int idx;
>> + =A0 =A0 =A0 static int mmc_num;
>> +
>> + =A0 =A0 =A0 /* Initialization of controllers which are not updated
>> + =A0 =A0 =A0 =A0* in board file will be skipped here.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 c +=3D mmc_num;
>> + =A0 =A0 =A0 if (!c->mmc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hsmmc_info is not updated=
 in board file\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 idx =3D c->mmc - 1 ;
>> + =A0 =A0 =A0 name =3D "mmci-omap-hs";
>
> Could you please rename the device to have something in the form: oma=
p_XXXX?
> In that case "omap_mmc" should be good. The "hs" is just a indication=
 of one
> of the mmc instance capability and does not have to be in the device =
name
> since there is no none-hs instance.

I understood your concern but omap1,omap2420 uses mmc driver while
omap2430, omap3 , omap4 has hsmmc driver.

omap1, omap2420 boards have device name as "mmci-omap" currently, but
if they undergo
the similar change as proposed above then it looks like "omap_mmc"

Therefore for hsmmc driver, I will be happy to have something like "oma=
p_hsmmc"

please let me know if this is fine.

>
> I know that this is not in your patch and was already there before, b=
ut that
> code is happily mixing MMC or HSMMC everywhere, so having a little bi=
t of
> consistency will be good. I vote to stick to MMC only.
> The "omap2_" prefix does not seems necessary too for my point of view=
=2E
> "omap_" is good enough.
>
>> + =A0 =A0 =A0 ohl =3D omap_hsmmc_latency;
>> + =A0 =A0 =A0 ohl_cnt =3D ARRAY_SIZE(omap_hsmmc_latency);
>> + =A0 =A0 =A0 omap2_mmc_mux(hsmmc_data[idx], idx);
>> + =A0 =A0 =A0 hsmmc_data[idx]->controller_dev_attr =3D mmc_dattr->fl=
ags;
>
> You should copy the data and not keep a reference to internal hwmod
> structure. In your case, you should check if dev_attr is not null. It=
 will
> avoid adding some empty dev_attr structure in the hwmod_data files.

Ok, will make changes.

>
>> + =A0 =A0 =A0 od =3D omap_device_build(name, idx, oh, hsmmc_data[idx=
],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct omap_mmc_platform_data),=
 ohl, ohl_cnt,
>> false);
>> + =A0 =A0 =A0 if (IS_ERR(od)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "Cant build omap_device for %s=
:%s.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 name, oh->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(od);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* return device handle to board setup code
>> + =A0 =A0 =A0 =A0* required to populate for regulator framework stru=
cture
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 c->dev =3D&od->pdev.dev;
>> + =A0 =A0 =A0 mmc_num++;
>> + =A0 =A0 =A0 return 0;
>> +}
>
> Regards,
> Benoit
>
