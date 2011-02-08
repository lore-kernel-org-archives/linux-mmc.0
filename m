From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 5/5] OMAP: devices: Modify HSMMC device to adapt to hwmod framework
Date: Tue, 08 Feb 2011 15:05:20 -0800
Message-ID: <878vxqi0un.fsf@ti.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
	<1296660462-28489-6-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36047 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752568Ab1BHXF3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2011 18:05:29 -0500
In-Reply-To: <1296660462-28489-6-git-send-email-kishore.kadiyala@ti.com>
	(Kishore Kadiyala's message of "Wed, 2 Feb 2011 20:57:42 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com

Kishore Kadiyala <kishore.kadiyala@ti.com> writes:

> Changes involves:
> 1) Remove controller reset in devices.c which is taken care
>    by hwmod framework.
> 2) Removing all base address macro defines.
> 3) Using omap-device layer to register device and utilizing data from
>    hwmod data file for base address, dma channel number, Irq_number,
>    device attribute.
> 4) Update the driver to use dev_attr to find whether controller
>    supports dual volt cards.
> 5) Moving "omap_mmc_add" api from plat-omap/devices.c to mach-omap1/devices.c
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

This seems to still be largely based on work originally done by Paul
with minor changes from me.  You should mention that here and Cc him
here as well.  My contributions were minimal here, so this s-o-b can
just be a Cc for now until I have given an acked-by.

> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>


> ---
>  arch/arm/mach-omap1/devices.c         |   41 +++++++
>  arch/arm/mach-omap2/board-n8x0.c      |    6 +-
>  arch/arm/mach-omap2/devices.c         |  207 +++++++--------------------------
>  arch/arm/mach-omap2/hsmmc.c           |    6 +-
>  arch/arm/plat-omap/devices.c          |   50 --------
>  arch/arm/plat-omap/include/plat/mmc.h |   36 ++-----
>  drivers/mmc/host/omap_hsmmc.c         |    4 +-
>  7 files changed, 100 insertions(+), 250 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
> index b0f4c23..eae41b6 100644
> --- a/arch/arm/mach-omap1/devices.c
> +++ b/arch/arm/mach-omap1/devices.c
> @@ -72,6 +72,47 @@ static inline void omap_init_mbox(void) { }
>  
>  #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>  
> +#define OMAP_MMC_NR_RES		2
> +int __init omap_mmc_add(const char *name, int id, unsigned long base,
> +				unsigned long size, unsigned int irq,
> +				struct omap_mmc_platform_data *data)
> +{
> +	struct platform_device *pdev;
> +	struct resource res[OMAP_MMC_NR_RES];
> +	int ret;
> +
> +	pdev = platform_device_alloc(name, id);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	memset(res, 0, OMAP_MMC_NR_RES * sizeof(struct resource));
> +	res[0].start = base;
> +	res[0].end = base + size - 1;
> +	res[0].flags = IORESOURCE_MEM;
> +	res[1].start = irq;
> +	res[1].end = irq;
> +	res[1].flags = IORESOURCE_IRQ;
> +
> +	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
> +	if (ret == 0)
> +		ret = platform_device_add_data(pdev, data, sizeof(*data));
> +	if (ret)
> +		goto fail;
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto fail;
> +
> +	/* return device handle to board setup code */
> +	data->dev = &pdev->dev;
> +	return 0;
> +
> +fail:
> +	platform_device_put(pdev);
> +	return ret;
> +}
> +
>  static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
>  			int controller_nr)
>  {
> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
> index 1cb53bc..5c9cd31 100644
> --- a/arch/arm/mach-omap2/board-n8x0.c
> +++ b/arch/arm/mach-omap2/board-n8x0.c
> @@ -594,8 +594,6 @@ static struct omap_mmc_platform_data mmc1_data = {
>  	},
>  };
>  
> -static struct omap_mmc_platform_data *mmc_data[OMAP24XX_NR_MMC];
> -
>  static void __init n8x0_mmc_init(void)
>  
>  {
> @@ -637,8 +635,8 @@ static void __init n8x0_mmc_init(void)
>  		gpio_direction_output(N810_EMMC_VIO_GPIO, 0);
>  	}
>  
> -	mmc_data[0] = &mmc1_data;
> -	omap2_init_mmc(mmc_data, OMAP24XX_NR_MMC);
> +	hsmmc_data[0] = &mmc1_data;
> +	omap_hwmod_for_each_by_class("mmc", omap2_init_mmc, NULL);

The interface between board code and common code isn't quite right.

The hwmod_for_each should not be done in board code, this should be in
common code available to all boards.

The board code should simply call some mmc init routine optionally
passing int the platform_data, just like is done for hsmmc_init.

With common hwmod data, shouldn't it be possible to unify the init of
MMC and HS-MMC controllers?


>  }
>  #else
>  
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 2c9c912..aa07264 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -610,112 +610,6 @@ static inline void omap_init_aes(void) { }
>  
>  /*-------------------------------------------------------------------------*/
>  
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> -
> -#define MMCHS_SYSCONFIG			0x0010
> -#define MMCHS_SYSCONFIG_SWRESET		(1 << 1)
> -#define MMCHS_SYSSTATUS			0x0014
> -#define MMCHS_SYSSTATUS_RESETDONE	(1 << 0)
> -
> -static struct platform_device dummy_pdev = {
> -	.dev = {
> -		.bus = &platform_bus_type,
> -	},
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
> -	u32 i, nr_controllers;
> -	struct clk *iclk, *fclk;
> -
> -	if (cpu_is_omap242x())
> -		return;
> -
> -	nr_controllers = cpu_is_omap44xx() ? OMAP44XX_NR_MMC :
> -		(cpu_is_omap34xx() ? OMAP34XX_NR_MMC : OMAP24XX_NR_MMC);
> -
> -	for (i = 0; i < nr_controllers; i++) {
> -		u32 v, base = 0;
> -		struct device *dev = &dummy_pdev.dev;
> -
> -		switch (i) {
> -		case 0:
> -			base = OMAP2_MMC1_BASE;
> -			break;
> -		case 1:
> -			base = OMAP2_MMC2_BASE;
> -			break;
> -		case 2:
> -			base = OMAP3_MMC3_BASE;
> -			break;
> -		case 3:
> -			if (!cpu_is_omap44xx())
> -				return;
> -			base = OMAP4_MMC4_BASE;
> -			break;
> -		case 4:
> -			if (!cpu_is_omap44xx())
> -				return;
> -			base = OMAP4_MMC5_BASE;
> -			break;
> -		}
> -
> -		if (cpu_is_omap44xx())
> -			base += OMAP4_MMC_REG_OFFSET;
> -
> -		dummy_pdev.id = i;
> -		dev_set_name(&dummy_pdev.dev, "mmci-omap-hs.%d", i);
> -		iclk = clk_get(dev, "ick");
> -		if (IS_ERR(iclk))
> -			goto err1;
> -		if (clk_enable(iclk))
> -			goto err2;
> -
> -		fclk = clk_get(dev, "fck");
> -		if (IS_ERR(fclk))
> -			goto err3;
> -		if (clk_enable(fclk))
> -			goto err4;
> -
> -		omap_writel(MMCHS_SYSCONFIG_SWRESET, base + MMCHS_SYSCONFIG);
> -		v = omap_readl(base + MMCHS_SYSSTATUS);
> -		while (!(omap_readl(base + MMCHS_SYSSTATUS) &
> -			 MMCHS_SYSSTATUS_RESETDONE))
> -			cpu_relax();
> -
> -		clk_disable(fclk);
> -		clk_put(fclk);
> -		clk_disable(iclk);
> -		clk_put(iclk);
> -	}
> -	return;
> -
> -err4:
> -	clk_put(fclk);
> -err3:
> -	clk_disable(iclk);
> -err2:
> -	clk_put(iclk);
> -err1:
> -	printk(KERN_WARNING "%s: Unable to enable clocks for MMC%d, "
> -			    "cannot reset.\n",  __func__, i);
> -}
> -#else
> -static inline void omap_hsmmc_reset(void) {}
> -#endif
> -

Very nice to see this disappear.

>  #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
>  	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
>  
> @@ -828,66 +722,54 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
>  	}
>  }
>  
> -void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
> -			int nr_controllers)
> +struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC];
> +EXPORT_SYMBOL(hsmmc_data);

This should not be exported.  In fact, it should be static.  The need
to modify this from board files suggest the interface from board files
is not correct.

> +static struct omap_device_pm_latency omap_hsmmc_latency[] = {
> +	[0] = {
> +		.deactivate_func = omap_device_idle_hwmods,
> +		.activate_func	 = omap_device_enable_hwmods,
> +		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	},
> +	/*
> +	 * XXX There should also be an entry here to power off/on the
> +	 * MMC regulators/PBIAS cells, etc.
> +	 */
> +};
> +
> +int omap2_init_mmc(struct omap_hwmod *oh, void *nop)
>  {
> -	int i;
> +	struct omap_device *od;
> +	struct omap_device_pm_latency *ohl;
>  	char *name;
> +	int ohl_cnt = 0;
> +	static int mmc_num;

With the 'static' here, this function now keeps state of how many
controllers there are?  This is fragile and not good for readability.

The common code here should to an omap_hwmod_for_each() and will know
how many controllers are on the SoC.  The board code will then register
its data and now many controllers it wants to use.  I don't see any
reason to have to keep this static state.

> -	for (i = 0; i < nr_controllers; i++) {
> -		unsigned long base, size;
> -		unsigned int irq = 0;
> -
> -		if (!mmc_data[i])
> -			continue;
> -
> -		omap2_mmc_mux(mmc_data[i], i);
> -
> -		switch (i) {
> -		case 0:
> -			base = OMAP2_MMC1_BASE;
> -			irq = INT_24XX_MMC_IRQ;
> -			break;
> -		case 1:
> -			base = OMAP2_MMC2_BASE;
> -			irq = INT_24XX_MMC2_IRQ;
> -			break;
> -		case 2:
> -			if (!cpu_is_omap44xx() && !cpu_is_omap34xx())
> -				return;
> -			base = OMAP3_MMC3_BASE;
> -			irq = INT_34XX_MMC3_IRQ;
> -			break;
> -		case 3:
> -			if (!cpu_is_omap44xx())
> -				return;
> -			base = OMAP4_MMC4_BASE;
> -			irq = OMAP44XX_IRQ_MMC4;
> -			break;
> -		case 4:
> -			if (!cpu_is_omap44xx())
> -				return;
> -			base = OMAP4_MMC5_BASE;
> -			irq = OMAP44XX_IRQ_MMC5;
> -			break;
> -		default:
> -			continue;
> -		}
> +	if (!hsmmc_data[mmc_num]) {
> +		mmc_num++;
> +		return 0;
> +	}
> +	if (cpu_is_omap2420()) {
> +		name = "mmci-omap";
> +	} else {
> +		name = "mmci-omap-hs";
> +		ohl = omap_hsmmc_latency;
> +		ohl_cnt = ARRAY_SIZE(omap_hsmmc_latency);
> +	}

The naming used here (and in the driver) should match the naming used
from the hwmod data.  We're trying to align theses to the commonly
defined names.

> -		if (cpu_is_omap2420()) {
> -			size = OMAP2420_MMC_SIZE;
> -			name = "mmci-omap";
> -		} else if (cpu_is_omap44xx()) {
> -			if (i < 3)
> -				irq += OMAP44XX_IRQ_GIC_START;
> -			size = OMAP4_HSMMC_SIZE;
> -			name = "mmci-omap-hs";
> -		} else {
> -			size = OMAP3_HSMMC_SIZE;
> -			name = "mmci-omap-hs";
> -		}
> -		omap_mmc_add(name, i, base, size, irq, mmc_data[i]);
> -	};
> +	hsmmc_data[mmc_num]->dev_attr = oh->dev_attr;
> +	omap2_mmc_mux(hsmmc_data[mmc_num], mmc_num);
> +	od = omap_device_build(name, mmc_num, oh, hsmmc_data[mmc_num],
> +		sizeof(struct omap_mmc_platform_data), ohl, ohl_cnt, false);
> +	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
> +							name, oh->name);
> +	/*
> +	 * return device handle to board setup code
> +	 * required to populate for regulator framework structure
> +	 */
> +	hsmmc_data[mmc_num]->dev = &od->pdev.dev;
> +	mmc_num++;
> +	return 0;
>  }
>  
>  #endif
> @@ -961,7 +843,6 @@ static int __init omap2_init_devices(void)
>  	 * please keep these calls, and their implementations above,
>  	 * in alphabetical order so they're easier to sort through.
>  	 */
> -	omap_hsmmc_reset();
>  	omap_init_audio();
>  	omap_init_camera();
>  	omap_init_mbox();
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 34272e4..8f1a484 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -30,7 +30,7 @@ static u16 control_mmc1;
>  
>  static struct hsmmc_controller {
>  	char				name[HSMMC_NAME_LEN + 1];
> -} hsmmc[OMAP34XX_NR_MMC];
> +} hsmmc[OMAP44XX_NR_MMC];

This structure seems unused.

>  #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
>  
> @@ -204,8 +204,6 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
>  	return 0;
>  }
>  
> -static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
> -
>  void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  {
>  	struct omap2_hsmmc_info *c;
> @@ -358,7 +356,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  		hsmmc_data[c->mmc - 1] = mmc;
>  	}
>  
> -	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
> +	omap_hwmod_for_each_by_class("mmc", omap2_init_mmc, NULL);
>  
>  	/* pass the device nodes back to board setup code */
>  	for (c = controllers; c->mmc; c++) {
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index 10245b8..a126e37 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -107,56 +107,6 @@ static inline void omap_init_mcpdm(void) {}
>  
>  /*-------------------------------------------------------------------------*/
>  
> -#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
> -	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> -
> -#define OMAP_MMC_NR_RES		2
> -
> -/*
> - * Register MMC devices. Called from mach-omap1 and mach-omap2 device init.
> - */
> -int __init omap_mmc_add(const char *name, int id, unsigned long base,
> -				unsigned long size, unsigned int irq,
> -				struct omap_mmc_platform_data *data)
> -{
> -	struct platform_device *pdev;
> -	struct resource res[OMAP_MMC_NR_RES];
> -	int ret;
> -
> -	pdev = platform_device_alloc(name, id);
> -	if (!pdev)
> -		return -ENOMEM;
> -
> -	memset(res, 0, OMAP_MMC_NR_RES * sizeof(struct resource));
> -	res[0].start = base;
> -	res[0].end = base + size - 1;
> -	res[0].flags = IORESOURCE_MEM;
> -	res[1].start = res[1].end = irq;
> -	res[1].flags = IORESOURCE_IRQ;
> -
> -	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
> -	if (ret == 0)
> -		ret = platform_device_add_data(pdev, data, sizeof(*data));
> -	if (ret)
> -		goto fail;
> -
> -	ret = platform_device_add(pdev);
> -	if (ret)
> -		goto fail;
> -
> -	/* return device handle to board setup code */
> -	data->dev = &pdev->dev;
> -	return 0;
> -
> -fail:
> -	platform_device_put(pdev);
> -	return ret;
> -}
> -
> -#endif
> -
> -/*-------------------------------------------------------------------------*/
> -
>  #if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
>  
>  #ifdef CONFIG_ARCH_OMAP2
> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
> index 7821344..08b7503 100644
> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -16,6 +16,7 @@
>  #include <linux/mmc/host.h>
>  
>  #include <plat/board.h>
> +#include <plat/omap_hwmod.h>
>  
>  #define OMAP15XX_NR_MMC		1
>  #define OMAP16XX_NR_MMC		2
> @@ -23,23 +24,8 @@
>  #define OMAP1_MMC1_BASE		0xfffb7800
>  #define OMAP1_MMC2_BASE		0xfffb7c00	/* omap16xx only */
>  
> -#define OMAP24XX_NR_MMC		2
> -#define OMAP34XX_NR_MMC		3
>  #define OMAP44XX_NR_MMC		5
> -#define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
> -#define OMAP3_HSMMC_SIZE	0x200
> -#define OMAP4_HSMMC_SIZE	0x1000
> -#define OMAP2_MMC1_BASE		0x4809c000
> -#define OMAP2_MMC2_BASE		0x480b4000
> -#define OMAP3_MMC3_BASE		0x480ad000
> -#define OMAP4_MMC4_BASE		0x480d1000
> -#define OMAP4_MMC5_BASE		0x480d5000
>  #define OMAP4_MMC_REG_OFFSET	0x100
> -#define HSMMC5			(1 << 4)
> -#define HSMMC4			(1 << 3)
> -#define HSMMC3			(1 << 2)
> -#define HSMMC2			(1 << 1)
> -#define HSMMC1			(1 << 0)
>  
>  #define OMAP_MMC_MAX_SLOTS	2
>  
> @@ -78,6 +64,9 @@ struct omap_mmc_platform_data {
>  
>  	u64 dma_mask;
>  
> +	/* Integrating attributes from the omap_hwmod layer */
> +	struct mmc_dev_attr *dev_attr;
> +
>  	/* Register offset deviation */
>  	u16 reg_offset;
>  
> @@ -164,25 +153,18 @@ extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
>  
>  #if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
>  	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> +
> +extern struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC];
> +
>  void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
>  				int nr_controllers);
> -void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
> -				int nr_controllers);
> -int omap_mmc_add(const char *name, int id, unsigned long base,
> -				unsigned long size, unsigned int irq,
> -				struct omap_mmc_platform_data *data);
> +extern int omap2_init_mmc(struct omap_hwmod *oh, void *nop);
>  #else
>  static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
>  				int nr_controllers)
>  {
>  }
> -static inline void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
> -				int nr_controllers)
> -{
> -}
> -static inline int omap_mmc_add(const char *name, int id, unsigned long base,
> -				unsigned long size, unsigned int irq,
> -				struct omap_mmc_platform_data *data)
> +int omap2_init_mmc(struct omap_hwmod *oh, void *mmc_pdata)
>  {
>  	return 0;
>  }
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 078fdf1..f59f8da 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1555,7 +1555,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		break;
>  	}
>  
> -	if (host->id == OMAP_MMC1_DEVID) {
> +	if (host->pdata->dev_attr->flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
>  		/* Only MMC1 can interface at 3V without some flavor
>  		 * of external transceiver; but they all handle 1.8V.
>  		 */
> @@ -1647,7 +1647,7 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>  	u32 hctl, capa, value;
>  
>  	/* Only MMC1 supports 3.0V */
> -	if (host->id == OMAP_MMC1_DEVID) {
> +	if (host->pdata->dev_attr->flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
>  		hctl = SDVS30;
>  		capa = VS30 | VS18;
>  	} else {

Kevin
