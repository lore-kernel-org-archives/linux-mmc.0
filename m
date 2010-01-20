From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH V2 2/10] omap: Rename mmc-twl4030 files to hsmmc
Date: Wed, 20 Jan 2010 17:41:39 -0600
Message-ID: <017601ca9a2a$1d1e7640$544ff780@am.dhcp.ti.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com> <20100117013306.17308.2282.sendpatchset@ahunter-work.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58447 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924Ab0ATXlv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jan 2010 18:41:51 -0500
In-Reply-To: <20100117013306.17308.2282.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Adrian Hunter' <adrian.hunter@nokia.com>, 'Tony Lindgren' <tony@atomide.com>
Cc: 'Paul Walmsley' <paul@pwsan.com>, 'linux-omap Mailing List' <linux-omap@vger.kernel.org>, 'linux-mmc Mailing List' <linux-mmc@vger.kernel.org>, 'Andrew Morton' <akpm@linux-foundation.org>



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Saturday, January 16, 2010 7:33 PM
> To: Tony Lindgren
> Cc: Adrian Hunter; Madhusudhan Chikkature; Paul Walmsley; linux-omap
> Mailing List; linux-mmc Mailing List; Andrew Morton
> Subject: [PATCH V2 2/10] omap: Rename mmc-twl4030 files to hsmmc
> 
> From a65fae702aa81d4596d6fbefd2ab3c8ea87c244a Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Sun, 17 Jan 2010 02:34:22 +0200
> Subject: [PATCH] omap: Rename mmc-twl4030 files to hsmmc
> 
> mmc-twl4030.[ch] no longer has any dependency on twl4030
> and should be renamed to reflect that.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
>  arch/arm/mach-omap2/Makefile                 |   28 ++--
>  arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
>  arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
>  arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
>  arch/arm/mach-omap2/board-igep0020.c         |    2 +-
>  arch/arm/mach-omap2/board-ldp.c              |    2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
>  arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
>  arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
>  arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
>  arch/arm/mach-omap2/board-overo.c            |    2 +-
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
>  arch/arm/mach-omap2/hsmmc.c                  |  247
> ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/hsmmc.h                  |   34 ++++
>  arch/arm/mach-omap2/mmc-twl4030.c            |  247 ---------------------
> -----
>  arch/arm/mach-omap2/mmc-twl4030.h            |   34 ----
>  17 files changed, 307 insertions(+), 307 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/hsmmc.c
>  create mode 100644 arch/arm/mach-omap2/hsmmc.h
>  delete mode 100644 arch/arm/mach-omap2/mmc-twl4030.c
>  delete mode 100644 arch/arm/mach-omap2/mmc-twl4030.h
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index b32678b..a7e4c5a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -71,42 +71,42 @@ obj-y					+=
$(i2c-omap-m)
> $(i2c-omap-y)
>  obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
>  obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
>  obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
>  obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
>  obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
>  					   board-rx51-sdram.o \
>  					   board-rx51-peripherals.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
>  					   board-zoom-peripherals.o \
> -					   mmc-twl4030.o \
> +					   hsmmc.o \
>  					   board-zoom-debugboard.o
>  obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
>  					   board-zoom-peripherals.o \
> -					   mmc-twl4030.o \
> +					   hsmmc.o \
>  					   board-zoom-debugboard.o
>  obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
>  					   board-zoom-peripherals.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
> -					   mmc-twl4030.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
> 
>  obj-$(CONFIG_MACH_OMAP3517EVM)     += board-am3517evm.o
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-
> omap2/board-2430sdp.c
> index 31042ee..e42848d 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -38,7 +38,7 @@
>  #include <plat/usb.h>
>  #include <plat/gpmc-smc91x.h>
> 
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define SDP2430_CS0_BASE	0x04000000
>  #define SECONDARY_LCD_GPIO		147
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-
> omap2/board-3430sdp.c
> index c90b0d0..a0cf00f 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -43,7 +43,7 @@
> 
>  #include "mux.h"
>  #include "sdram-qimonda-hyb18m512160af-6.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define CONFIG_DISABLE_HFCLK 1
> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-
> omap2/board-cm-t35.c
> index 2626a9f..214a2a8 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -46,7 +46,7 @@
> 
>  #include "mux.h"
>  #include "sdram-micron-mt46h32m32lf-6.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define CM_T35_GPIO_PENDOWN	57
> 
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-
> omap2/board-igep0020.c
> index 117b8fd..9db061f 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -30,7 +30,7 @@
>  #include <plat/usb.h>
> 
>  #include "mux.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define IGEP2_SMSC911X_CS       5
>  #define IGEP2_SMSC911X_GPIO     176
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-
> ldp.c
> index 995d4a2..635f54d 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -44,7 +44,7 @@
>  #include <plat/usb.h>
> 
>  #include "mux.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define LDP_SMSC911X_CS		1
>  #define LDP_SMSC911X_GPIO	152
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-
> omap2/board-omap3beagle.c
> index 231cb4e..aaa9760 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -45,7 +45,7 @@
>  #include <plat/timer-gp.h>
> 
>  #include "mux.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define GPMC_CS0_BASE  0x60
>  #define GPMC_CS_SIZE   0x30
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index 34de178..2dd52ad 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -44,7 +44,7 @@
> 
>  #include "mux.h"
>  #include "sdram-micron-mt46h32m32lf-6.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define OMAP3_EVM_TS_GPIO	175
>  #define OMAP3_EVM_EHCI_VBUS	22
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-
> omap2/board-omap3pandora.c
> index ef17cf1..3a11506 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -43,7 +43,7 @@
> 
>  #include "mux.h"
>  #include "sdram-micron-mt46h32m32lf-6.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define OMAP3_PANDORA_TS_GPIO		94
> 
> diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-
> omap2/board-omap3touchbook.c
> index fe3d22c..8efef51 100644
> --- a/arch/arm/mach-omap2/board-omap3touchbook.c
> +++ b/arch/arm/mach-omap2/board-omap3touchbook.c
> @@ -50,7 +50,7 @@
>  #include <plat/timer-gp.h>
> 
>  #include "mux.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #include <asm/setup.h>
> 
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-
> omap2/board-overo.c
> index d192dd9..8a9d439 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -48,7 +48,7 @@
> 
>  #include "mux.h"
>  #include "sdram-micron-mt46h32m32lf-6.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define OVERO_GPIO_BT_XGATE	15
>  #define OVERO_GPIO_W2W_NRESET	16
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-
> omap2/board-rx51-peripherals.c
> index acafdbc..b2de206 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -34,7 +34,7 @@
>  #include <plat/gpmc-smc91x.h>
> 
>  #include "mux.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  #define SYSTEM_REV_B_USES_VAUX3	0x1699
>  #define SYSTEM_REV_S_USES_VAUX3 0x8
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-
> omap2/board-zoom-peripherals.c
> index 5c8474c..671dd06 100755
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -25,7 +25,7 @@
>  #include <plat/usb.h>
> 
>  #include "mux.h"
> -#include "mmc-twl4030.h"
> +#include "hsmmc.h"
> 
>  /* Zoom2 has Qwerty keyboard*/
>  static int board_keymap[] = {
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> new file mode 100644
> index 0000000..b88c538
> --- /dev/null
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -0,0 +1,247 @@
> +/*
> + * linux/arch/arm/mach-omap2/hsmmc.c
> + *
> + * Copyright (C) 2007-2008 Texas Instruments
> + * Copyright (C) 2008 Nokia Corporation
> + * Author: Texas Instruments
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <mach/hardware.h>
> +#include <plat/control.h>
> +#include <plat/mmc.h>
> +
> +#include "hsmmc.h"
> +
> +#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> +
> +static u16 control_pbias_offset;
> +static u16 control_devconf1_offset;
> +
> +#define HSMMC_NAME_LEN	9
> +
> +static struct twl_mmc_controller {

Now that this file is hsmmc specific, how about renaming this as
"hsmmc_controller"?
 
> +	char				name[HSMMC_NAME_LEN + 1];
> +} hsmmc[OMAP34XX_NR_MMC];
> +
> +#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
> +
> +static int twl4030_mmc_get_context_loss(struct device *dev)

Ditto, hsmmc_get_context_loss?

> +{
> +	/* FIXME: PM DPS not implemented yet */
> +	return 0;
> +}
> +
> +#else
> +#define twl4030_mmc_get_context_loss NULL
> +#endif
> +
> +static void hsmmc1_before_set_reg(struct device *dev, int slot,
> +				  int power_on, int vdd)
> +{
> +	u32 reg, prog_io;
> +	struct omap_mmc_platform_data *mmc = dev->platform_data;
> +
> +	/*
> +	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
> +	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has
> both
> +	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
> +	 *
> +	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
> +	 * is most naturally TWL VSIM; those pins also use PBIAS.
> +	 *
> +	 * FIXME handle VMMC1A as needed ...
> +	 */
> +	if (power_on) {
> +		if (cpu_is_omap2430()) {
> +			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
> +			if ((1 << vdd) >= MMC_VDD_30_31)
> +				reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
> +			else
> +				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
> +			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
> +		}
> +
> +		if (mmc->slots[0].internal_clock) {
> +			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> +			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
> +			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
> +		}
> +
> +		reg = omap_ctrl_readl(control_pbias_offset);
> +		if (cpu_is_omap3630()) {
> +			/* Set MMC I/O to 52Mhz */
> +			prog_io =
omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
> +			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
> +			omap_ctrl_writel(prog_io,
OMAP343X_CONTROL_PROG_IO1);
> +		} else {
> +			reg |= OMAP2_PBIASSPEEDCTRL0;
> +		}
> +		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
> +		omap_ctrl_writel(reg, control_pbias_offset);
> +	} else {
> +		reg = omap_ctrl_readl(control_pbias_offset);
> +		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
> +		omap_ctrl_writel(reg, control_pbias_offset);
> +	}
> +}
> +
> +static void hsmmc1_after_set_reg(struct device *dev, int slot,
> +				 int power_on, int vdd)
> +{
> +	u32 reg;
> +
> +	/* 100ms delay required for PBIAS configuration */
> +	msleep(100);
> +
> +	if (power_on) {
> +		reg = omap_ctrl_readl(control_pbias_offset);
> +		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
> +		if ((1 << vdd) <= MMC_VDD_165_195)
> +			reg &= ~OMAP2_PBIASLITEVMODE0;
> +		else
> +			reg |= OMAP2_PBIASLITEVMODE0;
> +		omap_ctrl_writel(reg, control_pbias_offset);
> +	} else {
> +		reg = omap_ctrl_readl(control_pbias_offset);
> +		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
> +			OMAP2_PBIASLITEVMODE0);
> +		omap_ctrl_writel(reg, control_pbias_offset);
> +	}
> +}
> +
> +static void hsmmc23_before_set_reg(struct device *dev, int slot,
> +				   int power_on, int vdd)
> +{
> +	struct omap_mmc_platform_data *mmc = dev->platform_data;
> +
> +	if (power_on) {
> +		/* Only MMC2 supports a CLKIN */
> +		if (mmc->slots[0].internal_clock) {
> +			u32 reg;
> +
> +			reg = omap_ctrl_readl(control_devconf1_offset);
> +			reg |= OMAP2_MMCSDIO2ADPCLKISEL;
> +			omap_ctrl_writel(reg, control_devconf1_offset);
> +		}
> +	}
> +}
> +
> +static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC]
> __initdata;
> +
> +void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)

Ditto, hsmmc_init?

> +{
> +	struct twl4030_hsmmc_info *c;
> +	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
> +
> +	if (cpu_is_omap2430()) {
> +		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
> +		control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
> +	} else {
> +		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
> +		control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
> +	}
> +
> +	for (c = controllers; c->mmc; c++) {
> +		struct twl_mmc_controller *twl = hsmmc + c->mmc - 1;
> +		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
> +
> +		if (!c->mmc || c->mmc > nr_hsmmc) {
> +			pr_debug("MMC%d: no such controller\n", c->mmc);
> +			continue;
> +		}
> +		if (mmc) {
> +			pr_debug("MMC%d: already configured\n", c->mmc);
> +			continue;
> +		}
> +
> +		mmc = kzalloc(sizeof(struct omap_mmc_platform_data),
> GFP_KERNEL);
> +		if (!mmc) {
> +			pr_err("Cannot allocate memory for mmc device!\n");
> +			return;
> +		}
> +
> +		if (c->name)
> +			strncpy(twl->name, c->name, HSMMC_NAME_LEN);
> +		else
> +			snprintf(twl->name, ARRAY_SIZE(twl->name),
> +				"mmc%islot%i", c->mmc, 1);
> +		mmc->slots[0].name = twl->name;
> +		mmc->nr_slots = 1;
> +		mmc->slots[0].wires = c->wires;
> +		mmc->slots[0].internal_clock = !c->ext_clock;
> +		mmc->dma_mask = 0xffffffff;
> +
> +		mmc->get_context_loss_count =
> +				twl4030_mmc_get_context_loss;
> +
> +		mmc->slots[0].switch_pin = c->gpio_cd;
> +		mmc->slots[0].gpio_wp = c->gpio_wp;
> +
> +		if (c->cover_only)
> +			mmc->slots[0].cover = 1;
> +
> +		if (c->nonremovable)
> +			mmc->slots[0].nonremovable = 1;
> +
> +		if (c->power_saving)
> +			mmc->slots[0].power_saving = 1;
> +
> +		/* NOTE:  MMC slots should have a Vcc regulator set up.
> +		 * This may be from a TWL4030-family chip, another
> +		 * controllable regulator, or a fixed supply.
> +		 *
> +		 * temporary HACK: ocr_mask instead of fixed supply
> +		 */
> +		mmc->slots[0].ocr_mask = c->ocr_mask;
> +
> +		switch (c->mmc) {
> +		case 1:
> +			/* on-chip level shifting via PBIAS0/PBIAS1 */
> +			mmc->slots[0].before_set_reg =
hsmmc1_before_set_reg;
> +			mmc->slots[0].after_set_reg = hsmmc1_after_set_reg;
> +
> +			/* Omap3630 HSMMC1 supports only 4-bit */
> +			if (cpu_is_omap3630() && c->wires > 4) {
> +				c->wires = 4;
> +				mmc->slots[0].wires = c->wires;
> +			}
> +			break;
> +		case 2:
> +			if (c->ext_clock)
> +				c->transceiver = 1;
> +			if (c->transceiver && c->wires > 4)
> +				c->wires = 4;
> +			/* FALLTHROUGH */
> +		case 3:
> +			/* off-chip level shifting, or none */
> +			mmc->slots[0].before_set_reg =
hsmmc23_before_set_reg;
> +			mmc->slots[0].after_set_reg = NULL;
> +			break;
> +		default:
> +			pr_err("MMC%d configuration not supported!\n",
c->mmc);
> +			kfree(mmc);
> +			continue;
> +		}
> +		hsmmc_data[c->mmc - 1] = mmc;
> +	}
> +
> +	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
> +
> +	/* pass the device nodes back to board setup code */
> +	for (c = controllers; c->mmc; c++) {
> +		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
> +
> +		if (!c->mmc || c->mmc > nr_hsmmc)
> +			continue;
> +		c->dev = mmc->dev;
> +	}
> +}
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
> new file mode 100644
> index 0000000..87d67c1
> --- /dev/null
> +++ b/arch/arm/mach-omap2/hsmmc.h
> @@ -0,0 +1,34 @@
> +/*
> + * MMC definitions for OMAP2
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +struct twl4030_hsmmc_info {
> +	u8	mmc;		/* controller 1/2/3 */
> +	u8	wires;		/* 1/4/8 wires */
> +	bool	transceiver;	/* MMC-2 option */
> +	bool	ext_clock;	/* use external pin for input clock */
> +	bool	cover_only;	/* No card detect - just cover switch */
> +	bool	nonremovable;	/* Nonremovable e.g. eMMC */
> +	bool	power_saving;	/* Try to sleep or power off when possible
> */
> +	int	gpio_cd;	/* or -EINVAL */
> +	int	gpio_wp;	/* or -EINVAL */
> +	char	*name;		/* or NULL for default */
> +	struct device *dev;	/* returned: pointer to mmc adapter */
> +	int	ocr_mask;	/* temporary HACK */
> +};
> +
> +#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> +
> +void twl4030_mmc_init(struct twl4030_hsmmc_info *);

Ditto

> +
> +#else
> +
> +static inline void twl4030_mmc_init(struct twl4030_hsmmc_info *info)
> +{
> +}
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-
> twl4030.c
> deleted file mode 100644
> index 9d5ad0b..0000000
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ /dev/null
> @@ -1,247 +0,0 @@
> -/*
> - * linux/arch/arm/mach-omap2/mmc-twl4030.c
> - *
> - * Copyright (C) 2007-2008 Texas Instruments
> - * Copyright (C) 2008 Nokia Corporation
> - * Author: Texas Instruments
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/string.h>
> -#include <linux/delay.h>
> -#include <mach/hardware.h>
> -#include <plat/control.h>
> -#include <plat/mmc.h>
> -
> -#include "mmc-twl4030.h"
> -
> -#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> -
> -static u16 control_pbias_offset;
> -static u16 control_devconf1_offset;
> -
> -#define HSMMC_NAME_LEN	9
> -
> -static struct twl_mmc_controller {
> -	char				name[HSMMC_NAME_LEN + 1];
> -} hsmmc[OMAP34XX_NR_MMC];
> -
> -#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
> -
> -static int twl4030_mmc_get_context_loss(struct device *dev)
> -{
> -	/* FIXME: PM DPS not implemented yet */
> -	return 0;
> -}
> -
> -#else
> -#define twl4030_mmc_get_context_loss NULL
> -#endif
> -
> -static void hsmmc1_before_set_reg(struct device *dev, int slot,
> -				  int power_on, int vdd)
> -{
> -	u32 reg, prog_io;
> -	struct omap_mmc_platform_data *mmc = dev->platform_data;
> -
> -	/*
> -	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
> -	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has
> both
> -	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
> -	 *
> -	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
> -	 * is most naturally TWL VSIM; those pins also use PBIAS.
> -	 *
> -	 * FIXME handle VMMC1A as needed ...
> -	 */
> -	if (power_on) {
> -		if (cpu_is_omap2430()) {
> -			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
> -			if ((1 << vdd) >= MMC_VDD_30_31)
> -				reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
> -			else
> -				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
> -			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
> -		}
> -
> -		if (mmc->slots[0].internal_clock) {
> -			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> -			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
> -			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
> -		}
> -
> -		reg = omap_ctrl_readl(control_pbias_offset);
> -		if (cpu_is_omap3630()) {
> -			/* Set MMC I/O to 52Mhz */
> -			prog_io =
omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
> -			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
> -			omap_ctrl_writel(prog_io,
OMAP343X_CONTROL_PROG_IO1);
> -		} else {
> -			reg |= OMAP2_PBIASSPEEDCTRL0;
> -		}
> -		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
> -		omap_ctrl_writel(reg, control_pbias_offset);
> -	} else {
> -		reg = omap_ctrl_readl(control_pbias_offset);
> -		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
> -		omap_ctrl_writel(reg, control_pbias_offset);
> -	}
> -}
> -
> -static void hsmmc1_after_set_reg(struct device *dev, int slot,
> -				 int power_on, int vdd)
> -{
> -	u32 reg;
> -
> -	/* 100ms delay required for PBIAS configuration */
> -	msleep(100);
> -
> -	if (power_on) {
> -		reg = omap_ctrl_readl(control_pbias_offset);
> -		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
> -		if ((1 << vdd) <= MMC_VDD_165_195)
> -			reg &= ~OMAP2_PBIASLITEVMODE0;
> -		else
> -			reg |= OMAP2_PBIASLITEVMODE0;
> -		omap_ctrl_writel(reg, control_pbias_offset);
> -	} else {
> -		reg = omap_ctrl_readl(control_pbias_offset);
> -		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
> -			OMAP2_PBIASLITEVMODE0);
> -		omap_ctrl_writel(reg, control_pbias_offset);
> -	}
> -}
> -
> -static void hsmmc23_before_set_reg(struct device *dev, int slot,
> -				   int power_on, int vdd)
> -{
> -	struct omap_mmc_platform_data *mmc = dev->platform_data;
> -
> -	if (power_on) {
> -		/* Only MMC2 supports a CLKIN */
> -		if (mmc->slots[0].internal_clock) {
> -			u32 reg;
> -
> -			reg = omap_ctrl_readl(control_devconf1_offset);
> -			reg |= OMAP2_MMCSDIO2ADPCLKISEL;
> -			omap_ctrl_writel(reg, control_devconf1_offset);
> -		}
> -	}
> -}
> -
> -static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC]
> __initdata;
> -
> -void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
> -{
> -	struct twl4030_hsmmc_info *c;
> -	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
> -
> -	if (cpu_is_omap2430()) {
> -		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
> -		control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
> -	} else {
> -		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
> -		control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
> -	}
> -
> -	for (c = controllers; c->mmc; c++) {
> -		struct twl_mmc_controller *twl = hsmmc + c->mmc - 1;
> -		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
> -
> -		if (!c->mmc || c->mmc > nr_hsmmc) {
> -			pr_debug("MMC%d: no such controller\n", c->mmc);
> -			continue;
> -		}
> -		if (mmc) {
> -			pr_debug("MMC%d: already configured\n", c->mmc);
> -			continue;
> -		}
> -
> -		mmc = kzalloc(sizeof(struct omap_mmc_platform_data),
> GFP_KERNEL);
> -		if (!mmc) {
> -			pr_err("Cannot allocate memory for mmc device!\n");
> -			return;
> -		}
> -
> -		if (c->name)
> -			strncpy(twl->name, c->name, HSMMC_NAME_LEN);
> -		else
> -			snprintf(twl->name, ARRAY_SIZE(twl->name),
> -				"mmc%islot%i", c->mmc, 1);
> -		mmc->slots[0].name = twl->name;
> -		mmc->nr_slots = 1;
> -		mmc->slots[0].wires = c->wires;
> -		mmc->slots[0].internal_clock = !c->ext_clock;
> -		mmc->dma_mask = 0xffffffff;
> -
> -		mmc->get_context_loss_count =
> -				twl4030_mmc_get_context_loss;
> -
> -		mmc->slots[0].switch_pin = c->gpio_cd;
> -		mmc->slots[0].gpio_wp = c->gpio_wp;
> -
> -		if (c->cover_only)
> -			mmc->slots[0].cover = 1;
> -
> -		if (c->nonremovable)
> -			mmc->slots[0].nonremovable = 1;
> -
> -		if (c->power_saving)
> -			mmc->slots[0].power_saving = 1;
> -
> -		/* NOTE:  MMC slots should have a Vcc regulator set up.
> -		 * This may be from a TWL4030-family chip, another
> -		 * controllable regulator, or a fixed supply.
> -		 *
> -		 * temporary HACK: ocr_mask instead of fixed supply
> -		 */
> -		mmc->slots[0].ocr_mask = c->ocr_mask;
> -
> -		switch (c->mmc) {
> -		case 1:
> -			/* on-chip level shifting via PBIAS0/PBIAS1 */
> -			mmc->slots[0].before_set_reg =
hsmmc1_before_set_reg;
> -			mmc->slots[0].after_set_reg = hsmmc1_after_set_reg;
> -
> -			/* Omap3630 HSMMC1 supports only 4-bit */
> -			if (cpu_is_omap3630() && c->wires > 4) {
> -				c->wires = 4;
> -				mmc->slots[0].wires = c->wires;
> -			}
> -			break;
> -		case 2:
> -			if (c->ext_clock)
> -				c->transceiver = 1;
> -			if (c->transceiver && c->wires > 4)
> -				c->wires = 4;
> -			/* FALLTHROUGH */
> -		case 3:
> -			/* off-chip level shifting, or none */
> -			mmc->slots[0].before_set_reg =
hsmmc23_before_set_reg;
> -			mmc->slots[0].after_set_reg = NULL;
> -			break;
> -		default:
> -			pr_err("MMC%d configuration not supported!\n",
c->mmc);
> -			kfree(mmc);
> -			continue;
> -		}
> -		hsmmc_data[c->mmc - 1] = mmc;
> -	}
> -
> -	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
> -
> -	/* pass the device nodes back to board setup code */
> -	for (c = controllers; c->mmc; c++) {
> -		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
> -
> -		if (!c->mmc || c->mmc > nr_hsmmc)
> -			continue;
> -		c->dev = mmc->dev;
> -	}
> -}
> -
> -#endif
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-
> twl4030.h
> deleted file mode 100644
> index 87d67c1..0000000
> --- a/arch/arm/mach-omap2/mmc-twl4030.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/*
> - * MMC definitions for OMAP2
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -struct twl4030_hsmmc_info {
> -	u8	mmc;		/* controller 1/2/3 */
> -	u8	wires;		/* 1/4/8 wires */
> -	bool	transceiver;	/* MMC-2 option */
> -	bool	ext_clock;	/* use external pin for input clock */
> -	bool	cover_only;	/* No card detect - just cover switch */
> -	bool	nonremovable;	/* Nonremovable e.g. eMMC */
> -	bool	power_saving;	/* Try to sleep or power off when possible
> */
> -	int	gpio_cd;	/* or -EINVAL */
> -	int	gpio_wp;	/* or -EINVAL */
> -	char	*name;		/* or NULL for default */
> -	struct device *dev;	/* returned: pointer to mmc adapter */
> -	int	ocr_mask;	/* temporary HACK */
> -};
> -
> -#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> -
> -void twl4030_mmc_init(struct twl4030_hsmmc_info *);
> -
> -#else
> -
> -static inline void twl4030_mmc_init(struct twl4030_hsmmc_info *info)
> -{
> -}
> -
> -#endif
> --
> 1.6.0.4


