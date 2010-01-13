From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] omap_hsmmc: RX51: set padconfs to pull down when
 powering off eMMC
Date: Wed, 13 Jan 2010 12:37:45 -0800
Message-ID: <20100113203745.GK2986@atomide.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
 <20100113114048.7615.51097.sendpatchset@ahunter-work.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100113114048.7615.51097.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Some comments and a fix to the omap mux code below.

* Adrian Hunter <adrian.hunter@nokia.com> [100113 03:39]:
> From 060702bca6c60dd0f63f4e82e381ae1b8b112dec Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Tue, 5 Jan 2010 13:46:57 +0200
> Subject: [PATCH] omap_hsmmc: RX51: set padconfs to pull down when powering off eMMC
> 
> It has been discovered that, when eMMC is powered off, current
> will flow from OMAP eMMC data pull-ups to the eMMC voltage supply.
> Configuring pads for off-mode does not help because eMMC is
> powered off independently of off-mode.  Hence the pads are now
> re-configured when eMMC is powered on or off.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   27 +++++++++++++++++++++++++-
>  arch/arm/mach-omap2/hsmmc.c                  |    2 +
>  arch/arm/mach-omap2/hsmmc.h                  |    2 +
>  arch/arm/plat-omap/include/plat/control.h    |    6 +++++
>  arch/arm/plat-omap/include/plat/mmc.h        |    1 +
>  drivers/mmc/host/omap_hsmmc.c                |    8 +++++++
>  6 files changed, 45 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index b6318b1..4d9dbb4 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -32,6 +32,7 @@
>  #include <plat/gpmc.h>
>  #include <plat/onenand.h>
>  #include <plat/gpmc-smc91x.h>
> +#include <plat/control.h>
>  
>  #include "mux.h"
>  #include "hsmmc.h"
> @@ -225,6 +226,29 @@ static void rx51_mmc_set_pm_constraints(struct device *dev, int on)
>  #define rx51_mmc_set_pm_constraints NULL
>  #endif
>  
> +/*
> + * Current flows to eMMC when eMMC is off and the data lines are pulled up,
> + * so pull them down. N.B. we pull 8 lines because we are using 8 lines.
> + */
> +static void rx51_mmc_2_pad_conf(struct device *dev, int slot, int power_on)
> +{
> +	if (power_on) {
> +		/* Pull up */
> +		omap_ctrl_writew(    0x118, OMAP343X_PADCONF_MMC2_CMD);
> +		omap_ctrl_writel(0x1180118, OMAP343X_PADCONF_MMC2_DAT0);
> +		omap_ctrl_writel(0x1180118, OMAP343X_PADCONF_MMC2_DAT2);
> +		omap_ctrl_writel(0x1180118, OMAP343X_PADCONF_MMC2_DAT4);
> +		omap_ctrl_writel(0x1180118, OMAP343X_PADCONF_MMC2_DAT6);
> +	} else {
> +		/* Pull down */
> +		omap_ctrl_writew(    0x108, OMAP343X_PADCONF_MMC2_CMD);
> +		omap_ctrl_writel(0x1080108, OMAP343X_PADCONF_MMC2_DAT0);
> +		omap_ctrl_writel(0x1080108, OMAP343X_PADCONF_MMC2_DAT2);
> +		omap_ctrl_writel(0x1080108, OMAP343X_PADCONF_MMC2_DAT4);
> +		omap_ctrl_writel(0x1080108, OMAP343X_PADCONF_MMC2_DAT6);
> +	}
> +}
> +
>  static struct omap2_hsmmc_info mmc[] __initdata = {
>  	{
>  		.name		= "external",

We really want to do all the dynamic muxing using the mux code
instead of adding custom code. But as the mux signal names are dropped
during __init, we cannot use omap_mux_init_signal().

So could you please give the attached patch a try? With this patch
you should be able to do the dynamic remuxing like this:

/*
 * Enable input logic and pull all lines up when eMMC is on.
 *
 * REVISIT: Are the defaul values OK for omap off-idle, or is
 * OMAP_PIN_OFF_OUTPUT_LOW also needed to keep the pins down?
 */
static struct omap_board_mux mmc2_on_mux[] = {
	OMAP3_MUX(SDMMC2_CMD, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT0, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT1, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT2, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT3, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT4, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT5, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT6, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT7, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
	{ .reg_offset = OMAP_MUX_TERMINATOR },
};

/*
 * Disable input logic and pull all lines down when eMMC is off.
 *
 * REVISIT1: The input logic should not be needed here, just
 * OMAP_PULL_ENA to pull the lines down. If that does not work,
 * use OMAP_PIN_INPUT_PULLUP.
 *
 * REVISIT2: Are the default values OK for omap off-idle, or is
 * OMAP_PIN_OFF_OUTPUT_LOW also needed to keep the pins down?
 */
static struct omap_board_mux mmc2_off_mux[] = {
	OMAP3_MUX(SDMMC2_CMD, OMAP_PULL_ENA | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT0, OMAP_PULL_ENA | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT1, OMAP_PULL_ENA | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT2, OMAP_PULL_ENA | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT3, OMAP_PULL_ENA | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT4, OMAP_PULL_ENA | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT5, OMAP_PULL_ENA | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT6, OMAP_PULL_ENA | OMAP_MUX_MODE0),
	OMAP3_MUX(SDMMC2_DAT7, OMAP_PULL_ENA | OMAP_MUX_MODE0),
	{ .reg_offset = OMAP_MUX_TERMINATOR },
};

static void mmc2_remux(struct device *dev, int slot, int power_on)
{
	if (power_on)
		omap_mux_write_array(mmc2_on_mux);
	else
		omap_mux_write_array(mmc2_off_mux);
}

You might want to check what happens in omap off-idle mode in these cases
and see if enabling OMAP_PIN_OFF_INPUT_PULLDOWN makes any difference in
power consumption in off state. That probably does not matter unless the
floating lines cause the eMMC to do something on it's own :)

Note that I've used "remux" instead of "pad_conf" to make it easier to
grep all the code for muxing, so maybe use "remux" instead in your updated
patch too?

> --- a/arch/arm/plat-omap/include/plat/control.h
> +++ b/arch/arm/plat-omap/include/plat/control.h
> @@ -183,6 +183,12 @@
>  #define OMAP343X_PADCONF_ETK_D14	OMAP343X_PADCONF_ETK(16)
>  #define OMAP343X_PADCONF_ETK_D15	OMAP343X_PADCONF_ETK(17)
>  
> +#define OMAP343X_PADCONF_MMC2_CMD	(OMAP2_CONTROL_PADCONFS + 0x12A)
> +#define OMAP343X_PADCONF_MMC2_DAT0	(OMAP2_CONTROL_PADCONFS + 0x12C)
> +#define OMAP343X_PADCONF_MMC2_DAT2	(OMAP2_CONTROL_PADCONFS + 0x130)
> +#define OMAP343X_PADCONF_MMC2_DAT4	(OMAP2_CONTROL_PADCONFS + 0x134)
> +#define OMAP343X_PADCONF_MMC2_DAT6	(OMAP2_CONTROL_PADCONFS + 0x138)
> +
>  /* 34xx GENERAL_WKUP regist offsets */
>  #define OMAP343X_CONTROL_WKUP_DEBOBSMUX(i) (OMAP343X_CONTROL_GENERAL_WKUP + \
>  						0x008 + (i))

No need for these, they are all defined already in mux34xx.h, and
available via mux.h.

Regards,

Tony

--ibTvN161/egqYuK8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap3-mux-dynamic-signals.patch"

>From bafb6a3d19149a4344e9e927f036df5411b9819a Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 13 Jan 2010 10:27:17 -0800
Subject: [PATCH] omap: Add functions for dynamic remuxing of pins

Make the omap_mux_read and write available for board code,
and rename omap_mux_set_board_signals into omap_mux_write_array.

In some cases we want to change the signals dynamically,
mostly for power management.

Note that we cannot use the signal names as they are set
__init to save memory.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 459ef23..28722a7 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -51,7 +51,7 @@ struct omap_mux_entry {
 static unsigned long mux_phys;
 static void __iomem *mux_base;
 
-static inline u16 omap_mux_read(u16 reg)
+u16 omap_mux_read(u16 reg)
 {
 	if (cpu_is_omap24xx())
 		return __raw_readb(mux_base + reg);
@@ -59,7 +59,7 @@ static inline u16 omap_mux_read(u16 reg)
 		return __raw_readw(mux_base + reg);
 }
 
-static inline void omap_mux_write(u16 val, u16 reg)
+void omap_mux_write(u16 val, u16 reg)
 {
 	if (cpu_is_omap24xx())
 		__raw_writeb(val, mux_base + reg);
@@ -67,6 +67,14 @@ static inline void omap_mux_write(u16 val, u16 reg)
 		__raw_writew(val, mux_base + reg);
 }
 
+void omap_mux_write_array(struct omap_board_mux *board_mux)
+{
+	while (board_mux->reg_offset !=  OMAP_MUX_TERMINATOR) {
+		omap_mux_write(board_mux->value, board_mux->reg_offset);
+		board_mux++;
+	}
+}
+
 #if defined(CONFIG_ARCH_OMAP24XX) && defined(CONFIG_OMAP_MUX)
 
 static struct omap_mux_cfg arch_mux_cfg;
@@ -833,14 +841,6 @@ static void __init omap_mux_set_cmdline_signals(void)
 	kfree(options);
 }
 
-static void __init omap_mux_set_board_signals(struct omap_board_mux *board_mux)
-{
-	while (board_mux->reg_offset !=  OMAP_MUX_TERMINATOR) {
-		omap_mux_write(board_mux->value, board_mux->reg_offset);
-		board_mux++;
-	}
-}
-
 static int __init omap_mux_copy_names(struct omap_mux *src,
 					struct omap_mux *dst)
 {
@@ -999,7 +999,7 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 	if (package_balls)
 		omap_mux_package_init_balls(package_balls, superset);
 	omap_mux_set_cmdline_signals();
-	omap_mux_set_board_signals(board_mux);
+	omap_mux_write_array(board_mux);
 #endif
 
 	omap_mux_init_list(superset);
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index d8b4d5a..f8c2e7a 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -147,6 +147,30 @@ u16 omap_mux_get_gpio(int gpio);
 void omap_mux_set_gpio(u16 val, int gpio);
 
 /**
+ * omap_mux_read() - read mux register
+ * @mux_offset:		Offset of the mux register
+ *
+ */
+u16 omap_mux_read(u16 mux_offset);
+
+/**
+ * omap_mux_write() - write mux register
+ * @val:		New mux register value
+ * @mux_offset:		Offset of the mux register
+ *
+ * This should be only needed for dynamic remuxing of non-gpio signals.
+ */
+void omap_mux_write(u16 val, u16 mux_offset);
+
+/**
+ * omap_mux_write_array() - write an array of mux registers
+ * @board_mux:		Array of mux registers terminated by MAP_MUX_TERMINATOR
+ *
+ * This should be only needed for dynamic remuxing of non-gpio signals.
+ */
+void omap_mux_write_array(struct omap_board_mux *board_mux);
+
+/**
  * omap3_mux_init() - initialize mux system with board specific set
  * @board_mux:		Board specific mux table
  * @flags:		OMAP package type used for the board

--ibTvN161/egqYuK8--
