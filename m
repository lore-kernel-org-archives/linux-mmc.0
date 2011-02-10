From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH 5/5] OMAP: devices: Modify HSMMC device to adapt to hwmod framework
Date: Thu, 10 Feb 2011 22:38:16 +0530
Message-ID: <AANLkTimN68yMC6BxHOvsJSu_Ddw8Lxr9oxzpx3vy7gxP@mail.gmail.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
 <1296660462-28489-6-git-send-email-kishore.kadiyala@ti.com> <878vxqi0un.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <878vxqi0un.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Feb 9, 2011 at 4:35 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kishore Kadiyala <kishore.kadiyala@ti.com> writes:
>
>> Changes involves:
>> 1) Remove controller reset in devices.c which is taken care
>> =A0 =A0by hwmod framework.
>> 2) Removing all base address macro defines.
>> 3) Using omap-device layer to register device and utilizing data fro=
m
>> =A0 =A0hwmod data file for base address, dma channel number, Irq_num=
ber,
>> =A0 =A0device attribute.
>> 4) Update the driver to use dev_attr to find whether controller
>> =A0 =A0supports dual volt cards.
>> 5) Moving "omap_mmc_add" api from plat-omap/devices.c to mach-omap1/=
devices.c
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> This seems to still be largely based on work originally done by Paul
> with minor changes from me. =A0You should mention that here and Cc hi=
m
> here as well. =A0My contributions were minimal here, so this s-o-b ca=
n
> just be a Cc for now until I have given an acked-by.

Sure, I will take care of this in my next revision V3

>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>
>
>> ---
>> =A0arch/arm/mach-omap1/devices.c =A0 =A0 =A0 =A0 | =A0 41 +++++++
>> =A0arch/arm/mach-omap2/board-n8x0.c =A0 =A0 =A0| =A0 =A06 +-
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 | =A0207 +++++++---=
-----------------------
>> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +-
>> =A0arch/arm/plat-omap/devices.c =A0 =A0 =A0 =A0 =A0| =A0 50 --------
>> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 36 ++-----
>> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 | =A0 =A04 +-
>> =A07 files changed, 100 insertions(+), 250 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/dev=
ices.c
>> index b0f4c23..eae41b6 100644
>> --- a/arch/arm/mach-omap1/devices.c
>> +++ b/arch/arm/mach-omap1/devices.c
>> @@ -72,6 +72,47 @@ static inline void omap_init_mbox(void) { }
>>
>> =A0#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>>
>> +#define OMAP_MMC_NR_RES =A0 =A0 =A0 =A0 =A0 =A0 =A02
>> +int __init omap_mmc_add(const char *name, int id, unsigned long bas=
e,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned l=
ong size, unsigned int irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct oma=
p_mmc_platform_data *data)
>> +{
>> + =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 struct resource res[OMAP_MMC_NR_RES];
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 pdev =3D platform_device_alloc(name, id);
>> + =A0 =A0 if (!pdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 memset(res, 0, OMAP_MMC_NR_RES * sizeof(struct resource));
>> + =A0 =A0 res[0].start =3D base;
>> + =A0 =A0 res[0].end =3D base + size - 1;
>> + =A0 =A0 res[0].flags =3D IORESOURCE_MEM;
>> + =A0 =A0 res[1].start =3D irq;
>> + =A0 =A0 res[1].end =3D irq;
>> + =A0 =A0 res[1].flags =3D IORESOURCE_IRQ;
>> +
>> + =A0 =A0 ret =3D platform_device_add_resources(pdev, res, ARRAY_SIZ=
E(res));
>> + =A0 =A0 if (ret =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D platform_device_add_data(pdev, dat=
a, sizeof(*data));
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> +
>> + =A0 =A0 ret =3D platform_device_add(pdev);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> +
>> + =A0 =A0 /* return device handle to board setup code */
>> + =A0 =A0 data->dev =3D &pdev->dev;
>> + =A0 =A0 return 0;
>> +
>> +fail:
>> + =A0 =A0 platform_device_put(pdev);
>> + =A0 =A0 return ret;
>> +}
>> +
>> =A0static inline void omap1_mmc_mux(struct omap_mmc_platform_data *m=
mc_controller,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int controller_nr)
>> =A0{
>> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/=
board-n8x0.c
>> index 1cb53bc..5c9cd31 100644
>> --- a/arch/arm/mach-omap2/board-n8x0.c
>> +++ b/arch/arm/mach-omap2/board-n8x0.c
>> @@ -594,8 +594,6 @@ static struct omap_mmc_platform_data mmc1_data =3D=
 {
>> =A0 =A0 =A0 },
>> =A0};
>>
>> -static struct omap_mmc_platform_data *mmc_data[OMAP24XX_NR_MMC];
>> -
>> =A0static void __init n8x0_mmc_init(void)
>>
>> =A0{
>> @@ -637,8 +635,8 @@ static void __init n8x0_mmc_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(N810_EMMC_VIO_GPIO=
, 0);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 mmc_data[0] =3D &mmc1_data;
>> - =A0 =A0 omap2_init_mmc(mmc_data, OMAP24XX_NR_MMC);
>> + =A0 =A0 hsmmc_data[0] =3D &mmc1_data;
>> + =A0 =A0 omap_hwmod_for_each_by_class("mmc", omap2_init_mmc, NULL);
>
> The interface between board code and common code isn't quite right.
>
> The hwmod_for_each should not be done in board code, this should be i=
n
> common code available to all boards.

OK

>
> The board code should simply call some mmc init routine optionally
> passing int the platform_data, just like is done for hsmmc_init.
>
> With common hwmod data, shouldn't it be possible to unify the init of
> MMC and HS-MMC controllers?

The init of MMC & HS-MMC are different.
HSMMC supported boards, the board file fills an intermediate structure
omap2_hsmmc_info
which is used by the hsmmc.c file to update the omap_mmc_platform_data.

MMC supported boards, the board file fills the omap_mmc_platform_data.

Ok, will try to keep an API common for init of both MMC & HSMMC

>
>
>> =A0}
>> =A0#else
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/dev=
ices.c
>> index 2c9c912..aa07264 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -610,112 +610,6 @@ static inline void omap_init_aes(void) { }
>>
>> =A0/*---------------------------------------------------------------=
----------*/
>>
>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> -
>> -#define MMCHS_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x0010
>> -#define MMCHS_SYSCONFIG_SWRESET =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>> -#define MMCHS_SYSSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x0014
>> -#define MMCHS_SYSSTATUS_RESETDONE =A0 =A0(1 << 0)
>> -
>> -static struct platform_device dummy_pdev =3D {
>> - =A0 =A0 .dev =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .bus =3D &platform_bus_type,
>> - =A0 =A0 },
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
>> - =A0 =A0 u32 i, nr_controllers;
>> - =A0 =A0 struct clk *iclk, *fclk;
>> -
>> - =A0 =A0 if (cpu_is_omap242x())
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> -
>> - =A0 =A0 nr_controllers =3D cpu_is_omap44xx() ? OMAP44XX_NR_MMC :
>> - =A0 =A0 =A0 =A0 =A0 =A0 (cpu_is_omap34xx() ? OMAP34XX_NR_MMC : OMA=
P24XX_NR_MMC);
>> -
>> - =A0 =A0 for (i =3D 0; i < nr_controllers; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 u32 v, base =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct device *dev =3D &dummy_pdev.dev;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 switch (i) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC1_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC2_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 2:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP3_MMC3_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 3:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC4_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 4:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC5_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base +=3D OMAP4_MMC_REG_OF=
=46SET;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 dummy_pdev.id =3D i;
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_set_name(&dummy_pdev.dev, "mmci-omap-h=
s.%d", i);
>> - =A0 =A0 =A0 =A0 =A0 =A0 iclk =3D clk_get(dev, "ick");
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(iclk))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (clk_enable(iclk))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 fclk =3D clk_get(dev, "fck");
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(fclk))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (clk_enable(fclk))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(MMCHS_SYSCONFIG_SWRESET, base =
+ MMCHS_SYSCONFIG);
>> - =A0 =A0 =A0 =A0 =A0 =A0 v =3D omap_readl(base + MMCHS_SYSSTATUS);
>> - =A0 =A0 =A0 =A0 =A0 =A0 while (!(omap_readl(base + MMCHS_SYSSTATUS=
) &
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMCHS_SYSSTATUS_RESETDO=
NE))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_put(fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(iclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_put(iclk);
>> - =A0 =A0 }
>> - =A0 =A0 return;
>> -
>> -err4:
>> - =A0 =A0 clk_put(fclk);
>> -err3:
>> - =A0 =A0 clk_disable(iclk);
>> -err2:
>> - =A0 =A0 clk_put(iclk);
>> -err1:
>> - =A0 =A0 printk(KERN_WARNING "%s: Unable to enable clocks for MMC%d=
, "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cannot reset.\n",=
 =A0__func__, i);
>> -}
>> -#else
>> -static inline void omap_hsmmc_reset(void) {}
>> -#endif
>> -
>
> Very nice to see this disappear.
>
>> =A0#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) |=
| \
>> =A0 =A0 =A0 defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_H=
S_MODULE)
>>
>> @@ -828,66 +722,54 @@ static inline void omap2_mmc_mux(struct omap_m=
mc_platform_data *mmc_controller,
>> =A0 =A0 =A0 }
>> =A0}
>>
>> -void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int nr_controllers)
>> +struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC];
>> +EXPORT_SYMBOL(hsmmc_data);
>
> This should not be exported. =A0In fact, it should be static. =A0The =
need
> to modify this from board files suggest the interface from board file=
s
> is not correct.

OK, Will try keep it static

>
>> +static struct omap_device_pm_latency omap_hsmmc_latency[] =3D {
>> + =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_hwmo=
ds,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D omap_device_enable_=
hwmods,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =3D OMAP_DEVICE=
_LATENCY_AUTO_ADJUST,
>> + =A0 =A0 },
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* XXX There should also be an entry here to power off/o=
n the
>> + =A0 =A0 =A0* MMC regulators/PBIAS cells, etc.
>> + =A0 =A0 =A0*/
>> +};
>> +
>> +int omap2_init_mmc(struct omap_hwmod *oh, void *nop)
>> =A0{
>> - =A0 =A0 int i;
>> + =A0 =A0 struct omap_device *od;
>> + =A0 =A0 struct omap_device_pm_latency *ohl;
>> =A0 =A0 =A0 char *name;
>> + =A0 =A0 int ohl_cnt =3D 0;
>> + =A0 =A0 static int mmc_num;
>
> With the 'static' here, this function now keeps state of how many
> controllers there are? =A0This is fragile and not good for readabilit=
y.
>
> The common code here should to an omap_hwmod_for_each() and will know
> how many controllers are on the SoC. =A0The board code will then regi=
ster
> its data and now many controllers it wants to use. =A0I don't see any
> reason to have to keep this static state.

OK , Will try to implement as mentioned.

>
>> - =A0 =A0 for (i =3D 0; i < nr_controllers; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 unsigned long base, size;
>> - =A0 =A0 =A0 =A0 =A0 =A0 unsigned int irq =3D 0;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!mmc_data[i])
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap2_mmc_mux(mmc_data[i], i);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 switch (i) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC1_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D INT_24XX_MMC_IRQ;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC2_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D INT_24XX_MMC2_IRQ;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 2:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx() && =
!cpu_is_omap34xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP3_MMC3_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D INT_34XX_MMC3_IRQ;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 3:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC4_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D OMAP44XX_IRQ_MMC4;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 case 4:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC5_BASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D OMAP44XX_IRQ_MMC5;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 if (!hsmmc_data[mmc_num]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_num++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> + =A0 =A0 if (cpu_is_omap2420()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap";
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap-hs";
>> + =A0 =A0 =A0 =A0 =A0 =A0 ohl =3D omap_hsmmc_latency;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ohl_cnt =3D ARRAY_SIZE(omap_hsmmc_latency)=
;
>> + =A0 =A0 }
>
> The naming used here (and in the driver) should match the naming used
> from the hwmod data. =A0We're trying to align theses to the commonly
> defined names.

OK , will correct this in V3

>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap2420()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP2420_MMC_SIZE=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap";
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else if (cpu_is_omap44xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i < 3)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq +=3D O=
MAP44XX_IRQ_GIC_START;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP4_HSMMC_SIZE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap-hs";
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP3_HSMMC_SIZE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap-hs";
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_mmc_add(name, i, base, size, irq, mmc=
_data[i]);
>> - =A0 =A0 };
>> + =A0 =A0 hsmmc_data[mmc_num]->dev_attr =3D oh->dev_attr;
>> + =A0 =A0 omap2_mmc_mux(hsmmc_data[mmc_num], mmc_num);
>> + =A0 =A0 od =3D omap_device_build(name, mmc_num, oh, hsmmc_data[mmc=
_num],
>> + =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct omap_mmc_platform_data), ohl=
, ohl_cnt, false);
>> + =A0 =A0 WARN(IS_ERR(od), "Could not build omap_device for %s %s\n"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, oh->name);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* return device handle to board setup code
>> + =A0 =A0 =A0* required to populate for regulator framework structur=
e
>> + =A0 =A0 =A0*/
>> + =A0 =A0 hsmmc_data[mmc_num]->dev =3D &od->pdev.dev;
>> + =A0 =A0 mmc_num++;
>> + =A0 =A0 return 0;
>> =A0}
>>
>> =A0#endif
>> @@ -961,7 +843,6 @@ static int __init omap2_init_devices(void)
>> =A0 =A0 =A0 =A0* please keep these calls, and their implementations =
above,
>> =A0 =A0 =A0 =A0* in alphabetical order so they're easier to sort thr=
ough.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 omap_hsmmc_reset();
>> =A0 =A0 =A0 omap_init_audio();
>> =A0 =A0 =A0 omap_init_camera();
>> =A0 =A0 =A0 omap_init_mbox();
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc=
=2Ec
>> index 34272e4..8f1a484 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -30,7 +30,7 @@ static u16 control_mmc1;
>>
>> =A0static struct hsmmc_controller {
>> =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0name[HSMMC_NAME_LEN + 1];
>> -} hsmmc[OMAP34XX_NR_MMC];
>> +} hsmmc[OMAP44XX_NR_MMC];
>
> This structure seems unused.

It's used to fill the slot name of each controller's platform data .


<snip>

Regards,
Kishore
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
