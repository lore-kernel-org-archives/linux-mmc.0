From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 3/3] s5pv210: Aquila: add definitions for sdhci devices
Date: Fri, 11 Jun 2010 07:29:27 +0200
Message-ID: <005a01cb0927$120e4250$362ac6f0$%szyprowski@samsung.com>
References: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
 <1276076345-24370-4-git-send-email-m.szyprowski@samsung.com>
 <20100611051825.GW7248@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26216 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0FKFar (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2010 01:30:47 -0400
In-reply-to: <20100611051825.GW7248@trinity.fluff.org>
Content-language: pl
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ben Dooks' <ben-linux@fluff.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, kgene.kim@samsung.com

Hello,

On Friday, June 11, 2010 7:18 AM Ben Dooks wrote:

> On Wed, Jun 09, 2010 at 11:39:05AM +0200, Marek Szyprowski wrote:
> > This patch add support for SDHCI blocks on Samsung Aquila board. The
> > following host controllers are defined:
> > 1. Internal MoviNAND device (permanently wired to the controller)
> > 2. Internal WiFI SDIO device (card is activated by power regualor)
> > 3. External MMC/SD socket (card detection is provided by external
> > gpio interrupt)
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-s5pv210/Kconfig       |    4 ++
> >  arch/arm/mach-s5pv210/mach-aquila.c |   66
> +++++++++++++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-
> s5pv210/Kconfig
> > index b7a2f38..dcc9d74 100644
> > --- a/arch/arm/mach-s5pv210/Kconfig
> > +++ b/arch/arm/mach-s5pv210/Kconfig
> > @@ -57,7 +57,11 @@ config MACH_AQUILA
> >  	select CPU_S5PV210
> >  	select ARCH_SPARSEMEM_ENABLE
> >  	select S5PV210_SETUP_FB_24BPP
> > +	select S5PV210_SETUP_SDHCI
> >  	select S3C_DEV_FB
> > +	select S3C_DEV_HSMMC
> > +	select S3C_DEV_HSMMC1
> > +	select S3C_DEV_HSMMC2
> >  	select S5PC110_DEV_ONENAND
> >  	help
> >  	  Machine support for the Samsung Aquila target based on S5PC110 SoC
> > diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-
> s5pv210/mach-aquila.c
> > index fb9dbb2..1b7fe79 100644
> > --- a/arch/arm/mach-s5pv210/mach-aquila.c
> > +++ b/arch/arm/mach-s5pv210/mach-aquila.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/init.h>
> >  #include <linux/serial_core.h>
> >  #include <linux/fb.h>
> > +#include <linux/gpio.h>
> >
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach/map.h>
> > @@ -22,12 +23,15 @@
> >  #include <mach/map.h>
> >  #include <mach/regs-clock.h>
> >  #include <mach/regs-fb.h>
> > +#include <mach/regs-gpio.h>
> >
> >  #include <plat/regs-serial.h>
> >  #include <plat/s5pv210.h>
> >  #include <plat/devs.h>
> >  #include <plat/cpu.h>
> >  #include <plat/fb.h>
> > +#include <plat/gpio-cfg.h>
> > +#include <plat/sdhci.h>
> >
> >  /* Following are default values for UCON, ULCON and UFCON UART registers
> */
> >  #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
> > @@ -116,9 +120,66 @@ static struct s3c_fb_platdata aquila_lcd_pdata
> __initdata = {
> >  	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
> >  };
> >
> > +/* MoviNAND */
> > +static struct s3c_sdhci_platdata aquila_hsmmc0_data __initdata = {
> > +	.max_width		= 4,
> > +	.cd_type		= S3C_SDHCI_CD_PERMANENT,
> > +};
> > +
> > +/* Wireless LAN */
> > +static struct s3c_sdhci_platdata aquila_hsmmc1_data __initdata = {
> > +	.max_width		= 4,
> > +	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
> > +	/* ext_cd_{init,cleanup} callbacks will be added later */
> > +};
> > +
> > +/* External Flash */
> > +#define AQUILA_EXT_FLASH_IRQ	IRQ_EINT(28)	/* S5PV210_GPH3(4) */
> > +#define AQUILA_EXT_FLASH_EN	S5PV210_MP05(4)
> > +#define AQUILA_EXT_FLASH_CD	S5PV210_GPH3(4)
> > +
> > +static irqreturn_t aquila_ext_flash_card_detect_isr(int irq, void
> *dev_id)
> > +{
> > +	void (*notify_func)(struct platform_device *, int state) = dev_id;
> > +	notify_func(&s3c_device_hsmmc2, !gpio_get_value(AQUILA_EXT_FLASH_CD));
> > +	return IRQ_HANDLED;
> > +}
> 
> hmm, not very nice this.
> 
> I'd much prefer to see a gpio-based handler in either the sdhci core or
> at-least in the driver's directory since I'm sure that his is (a) something
> Thomas Abrahama has already published patches for (which do need work) and
> (b) probably going to be needed by other boards and/or other architectures.

I thought about adding the external gpio logic directly to sdhci-s3c driver,
but then I realized that it would not cover all our cases. For wifi sdio
card we need different solution - the card will be 'inserted' and 'removed'
by a power regulator glue code (called by rfkill framework). I'm really
convinced that adding support for such special case to sdhci-s3c driver is
not a good idea, that's why I came with the idea of 'external event' support
for card detect. I can move support for the gpio case to the sdhci-s3c driver
(it will be just a new CD type - SDHCI_S3C_GPIO).

I'm really open for the discussion how this can be handled in other ways.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center


