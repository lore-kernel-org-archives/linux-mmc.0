From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Status of tmio_mmc DMA support for SDIO
Date: Fri, 14 May 2010 10:35:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005140843320.6147@axis700.grange>
References: <A0C4AD4CC48F4CAAA4C9CB027472149D@RSI45>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:41399 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932080Ab0ENIfB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 14 May 2010 04:35:01 -0400
In-Reply-To: <A0C4AD4CC48F4CAAA4C9CB027472149D@RSI45>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Charles D. Krebs" <ckrebs@therealtimegroup.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, sailaja.sdn@redpinesignals.com, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

(added linux-mmc and tmio_mmc maintainer to CC)

Hi Charles

On Thu, 13 May 2010, Charles D. Krebs wrote:

> Guennadi,
> 
> I'm currently using the BSP 2.0 release (2.6.33) for the Renesas 7724 
> Ecovec platform.  I have two patches (see attached) that enable MMC 
> support and SDIO support in that version of the Kernel.

Great, thanks for the patches!

Regarding MMCIF, have you seen these patches:

http://article.gmane.org/gmane.linux.kernel.mmc/1712
http://article.gmane.org/gmane.linux.ports.sh.devel/7860

> I've seen quite a bit of traffic lately over the linux-sh mailing list 
> regarding the addition of DMA to the tmio driver.  Unfortunately, I 
> really have no good idea as to what the status is of that development, 
> and whether or not it would apply to both MMC and SDIO modes of 
> operation.

The status is: it passes my tests, as long as cache is in write-through 
mode. However, on ecovec I seem to have problems with SD: a simple 
mount-compare-overwrite-umount loop aborts even without DMA after a few 
hundreds of iterations (under 600 in one of my tests) and it happens even 
faster with DMA. However, I haven't repeated this test with the latest 
version of the patches, will do it at some point.

> That said, it looks like at least patch [4/b9 v4] has a few 
> parts that accomplish both MMC and SDIO support separately.

Really? I was unaware of that;) I don't think there is any SDIO specific 
code in that or in any other of my patches for tmio_mmc.

> We have an SDIO based 802.11 b/g/n radio that could definitely benefit 
> from DMA support.  At this point, what patches I would need to apply, 
> and what configuration changes to the kernel are necessary to test this 
> functionality out?  Are there any known limitations to the new code for 
> SDIO support?

This is the basis patch series:

http://thread.gmane.org/gmane.linux.kernel.mmc/1780

in which patch 4/9 you replace with these three patches:

http://thread.gmane.org/gmane.linux.ports.sh.devel/8068

As for SDIO, there's only one limitation: it's not implemented yet;) But 
looking at your patch, it looks like it doesn't touch data paths, only 
command paths. So, so far I don't see any reason, why DMA shouldn't work 
for you out of the box... However, you seem to have much more knowledge 
about tmio unit internals, so, maybe you can just check with your 
documentation. As for changes - do not forget to enable the shdma 
dmaengine driver. And look in /proc/interrupts during your tests to see if 
you're getting any DMA interrupts. You shall see two DMA channels, used 
per SDHI controller - for Tx and Rx.

> We have a team at Redpine Signals in India that is currently working on 
> the implementation of the radio driver.  I'd like to introduce Sailaja 
> Sankabathula, Applications Engineering Manager, who is managing the 
> project.  I know that the Redpine team is eager to work through a couple 
> of issues that they are seeing with the current code that we have, and 
> that they are more than happy to help debug the new DMA enabled driver 
> code and share the results with the community via any means you think 
> best (I'd presume at least by copying the linux-sh mailing list).

That right, and also the mmc list and the driver maintainer.

> I'm still rather new to the community development aspect of the Linux kernel -
> Is there somewhere I can read up about the general development procedure 
> here and how to best interface with the mailing lists?

There are a couple of documents in the Linux kernel source tree, that you 
might find useful:

Documentation/SubmitChecklist
Documentation/SubmittingPatches
Documentation/SubmittingDrivers
Documentation/CodingStyle
Documentation/email-clients.txt

> I tend to feel a little lost in not knowing what version of the kernel 
> these patches are referenced to, if the patches are regularly checked 
> into the kernel repository, etc.

Documents under

Documentation/development-process/

should give you an idea. In short: kernel is being developed in multiple 
topic trees, dedicated to various architectures, drivers, subsystems, etc. 
You work with one or several of those trees, relevant for your 
development, submit your patches to respective mailing lists and 
maintainers, and during the merge window (first two weeks after a final 
kernel version release) those trees get merged into the central kernel 
tree. Bug-fixes can be merged in at any time, of course.

As for your patch, I think, Ian will have a good look at it, so far a 
couple of quick comments:

> diff -Naur sh-2.6_bsp/arch/sh/kernel/cpu/sh4a/setup-sh7724.c sh-2.6_presdio/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> --- sh-2.6_bsp/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2010-03-25 04:48:00.000000000 +0000
> +++ sh-2.6_presdio/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2010-04-06 07:48:37.000000000 +0000
> @@ -890,7 +890,7 @@
>  static struct intc_mask_reg mask_registers[] __initdata = {
>  	{ 0xa4080080, 0xa40800c0, 8, /* IMR0 / IMCR0 */
>  	  { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
> -	    0, DISABLED, ENABLED, ENABLED } },
> +	    0, ENABLED, ENABLED, ENABLED } },
>  	{ 0xa4080084, 0xa40800c4, 8, /* IMR1 / IMCR1 */
>  	  { VIO_VOU, VIO_VEU1, VIO_BEU0, VIO_CEU0,
>  	    DMAC0A_DEI3, DMAC0A_DEI2, DMAC0A_DEI1, DMAC0A_DEI0 } },
> diff -Naur sh-2.6_bsp/drivers/mfd/sh_mobile_sdhi.c sh-2.6_presdio/drivers/mfd/sh_mobile_sdhi.c
> --- sh-2.6_bsp/drivers/mfd/sh_mobile_sdhi.c	2010-03-25 04:48:00.000000000 +0000
> +++ sh-2.6_presdio/drivers/mfd/sh_mobile_sdhi.c	2010-04-06 07:48:37.000000000 +0000
> @@ -97,7 +97,7 @@
>  
>  	priv->mmc_data.hclk = clk_get_rate(priv->clk);
>  	priv->mmc_data.set_pwr = sh_mobile_sdhi_set_pwr;
> -	priv->mmc_data.capabilities = MMC_CAP_MMC_HIGHSPEED;
> +	priv->mmc_data.capabilities = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SDIO_IRQ;
>  
>  	memcpy(&priv->cell_mmc, &sh_mobile_sdhi_cell, sizeof(priv->cell_mmc));
>  	priv->cell_mmc.driver_data = &priv->mmc_data;
> diff -Naur sh-2.6_bsp/drivers/mmc/host/tmio_mmc.c sh-2.6_presdio/drivers/mmc/host/tmio_mmc.c
> --- sh-2.6_bsp/drivers/mmc/host/tmio_mmc.c	2010-03-25 04:48:00.000000000 +0000
> +++ sh-2.6_presdio/drivers/mmc/host/tmio_mmc.c	2010-04-06 07:48:37.000000000 +0000
> @@ -30,6 +30,7 @@
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/sdio.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/tmio.h>
>  
> @@ -146,6 +147,28 @@
>  			c |= TRANSFER_READ;
>  	}
>  
> +	switch (cmd->opcode) {
> +	case SD_IO_RW_DIRECT:
> +		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
> +		enable_mmc_sdio_irqs(host, TMIO_SDIO_STAT_IOIRQ);
> +		break;
> +	case SD_IO_RW_EXTENDED:
> +		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
> +		enable_mmc_sdio_irqs(host, TMIO_SDIO_STAT_IOIRQ);
> +		if (data->flags & MMC_DATA_READ) {
> +			if (data->sg->length <= 512)
> +				c = CMD_SD_IO_RW_EXTENDED_SREAD;
> +			else
> +				c = CMD_SD_IO_RW_EXTENDED_MREAD;
> +		} else { /* MMC_DATA_WRITE */
> +			if (data->sg->length <= 512)
> +				c = CMD_SD_IO_RW_EXTENDED_SWRITE;
> +			else
> +				c = CMD_SD_IO_RW_EXTENDED_MWRITE;
> +		}
> +		break;
> +	}
> +
>  	enable_mmc_irqs(host, TMIO_MASK_CMD);
>  
>  	/* Fire off the command */
> @@ -235,8 +258,13 @@
>  	if (stop) {
>  		if (stop->opcode == 12 && !stop->arg)
>  			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x000);
> +#if 0

I realise, this wasn't a final patch submission, but just a remark - you 
don't want commented out code in the final version

> +	/* CMD_SD_IO_RW_EXTENDED_MREAD and CMD_SD_IO_RW_EXTENDED_MWRITE
> +	 * are not necessary.
> +	 */

multi-line comment style is wrong. Should have been

+	/*
+	 * CMD_SD_IO_RW_EXTENDED_MREAD and CMD_SD_IO_RW_EXTENDED_MWRITE
+	 * are not necessary.
+	 */

>  		else
>  			BUG();
> +#endif

But essentially, maybe you can preserve this check and just replace:

> - 			BUG();
> + 			BUG_ON(host->cmd->opcode != SD_IO_RW_EXTENDED);

or something similar.

>  	}
>  
>  	tmio_mmc_finish_request(host);
> @@ -298,6 +326,7 @@
>  {
>  	struct tmio_mmc_host *host = devid;
>  	unsigned int ireg, irq_mask, status;
> +	unsigned short ireg_io, irq_mask_io, status_io;

I would use u16 to explicitly specify 16-bit data.

>  
>  	pr_debug("MMC IRQ begin\n");
>  
> @@ -305,15 +334,31 @@
>  	irq_mask = sd_ctrl_read32(host, CTL_IRQ_MASK);
>  	ireg = status & TMIO_MASK_IRQ & ~irq_mask;
>  
> +	status_io = sd_ctrl_read16(host, CTL_SDIO_STATUS);
> +	irq_mask_io = sd_ctrl_read16(host, CTL_SDIO_IRQ_MASK);
> +	ireg_io = status_io & TMIO_SDIO_MASK_IRQ & ~irq_mask_io;
> +
>  	pr_debug_status(status);
>  	pr_debug_status(ireg);
>  
>  	if (!ireg) {
> +		if (ireg_io & TMIO_SDIO_STAT_IOIRQ) {
> +			ack_mmc_sdio_irqs(host, TMIO_SDIO_STAT_IOIRQ);
> +			mmc_signal_sdio_irq(host->mmc);
> +		} else if (ireg_io & TMIO_SDIO_STAT_EXWT)
> +			ack_mmc_sdio_irqs(host, TMIO_SDIO_STAT_EXWT);
> +		else if (ireg_io & TMIO_SDIO_STAT_EXPUB52)
> +			ack_mmc_sdio_irqs(host, TMIO_SDIO_STAT_EXPUB52);
> +		else
> +			ack_mmc_sdio_irqs(host, TMIO_SDIO_STAT_RESERVE);
> +
> +#if 0
>  		disable_mmc_irqs(host, status & ~irq_mask);
>  
>  		pr_debug("tmio_mmc: Spurious irq, disabling! "
>  			"0x%08x 0x%08x 0x%08x\n", status, irq_mask, ireg);
>  		pr_debug_status(status);
> +#endif

Same here, I think, you can preserve this interrupt disabling, if you 
extend the test to mean "no SD and no SDIO bit is set."

>  
>  		goto out;
>  	}
> @@ -321,6 +366,12 @@
>  	while (ireg) {
>  		/* Card insert / remove attempts */
>  		if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
> +			if (ireg & TMIO_STAT_CARD_REMOVE) {
> +				sd_ctrl_write16(host,
> +					CTL_TRANSACTION_CTL, 0x0000);
> +				disable_mmc_sdio_irqs(host,
> +					TMIO_SDIO_STAT_IOIRQ);
> +			}
>  			ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |
>  				TMIO_STAT_CARD_REMOVE);
>  			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
> @@ -462,10 +513,20 @@
>  	return (sd_ctrl_read16(host, CTL_STATUS) & TMIO_STAT_WRPROTECT) ? 0 : 1;
>  }
>  
> +static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +	if (enable)
> +		enable_mmc_sdio_irqs(host, TMIO_SDIO_STAT_IOIRQ);
> +	else
> +		disable_mmc_sdio_irqs(host, TMIO_SDIO_STAT_IOIRQ);
> +}
> +
>  static struct mmc_host_ops tmio_mmc_ops = {
>  	.request	= tmio_mmc_request,
>  	.set_ios	= tmio_mmc_set_ios,
>  	.get_ro         = tmio_mmc_get_ro,
> +	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,

Don't be shy, add one more TAB to all struct members to align them 
properly;)

>  };
>  
>  #ifdef CONFIG_PM
> diff -Naur sh-2.6_bsp/drivers/mmc/host/tmio_mmc.h sh-2.6_presdio/drivers/mmc/host/tmio_mmc.h
> --- sh-2.6_bsp/drivers/mmc/host/tmio_mmc.h	2010-03-25 04:48:00.000000000 +0000
> +++ sh-2.6_presdio/drivers/mmc/host/tmio_mmc.h	2010-04-06 07:48:37.000000000 +0000
> @@ -24,6 +24,8 @@
>  #define CTL_SD_ERROR_DETAIL_STATUS 0x2c
>  #define CTL_SD_DATA_PORT 0x30
>  #define CTL_TRANSACTION_CTL 0x34
> +#define CTL_SDIO_STATUS 0x36
> +#define CTL_SDIO_IRQ_MASK 0x38
>  #define CTL_RESET_SD 0xe0
>  #define CTL_SDIO_REGS 0x100
>  #define CTL_CLK_AND_WAIT_CTL 0x138
> @@ -62,6 +64,23 @@
>  #define TMIO_MASK_IRQ     (TMIO_MASK_READOP | TMIO_MASK_WRITEOP | TMIO_MASK_CMD)
>  
>  
> +/* Definitions for values the CTRL_SDIO_STATUS register can take. */
> +#define TMIO_SDIO_STAT_RESERVE	0x0006 /* reserve bit */
> +#define TMIO_SDIO_STAT_IOIRQ	0x0001
> +#define TMIO_SDIO_STAT_EXPUB52	0x4000
> +#define TMIO_SDIO_STAT_EXWT	0x8000
> +
> +#define CMD_SD_IO_RW_EXTENDED_SREAD	0x1C35
> +#define CMD_SD_IO_RW_EXTENDED_MREAD	0x7C35
> +#define CMD_SD_IO_RW_EXTENDED_SWRITE	0x0C35
> +#define CMD_SD_IO_RW_EXTENDED_MWRITE	0x6C35

You can put these four lines in tmio_mmc.c, and maybe "SDIO" without an 
underscore?

> +
> +/* Define some SDIO IRQ masks */
> +#define TMIO_SDIO_MASK_IRQ	(TMIO_SDIO_STAT_IOIRQ	| \
> +				 TMIO_SDIO_STAT_EXPUB52 | \
> +				 TMIO_SDIO_STAT_EXWT	| \
> +				 TMIO_SDIO_STAT_RESERVE)
> +
>  #define enable_mmc_irqs(host, i) \
>  	do { \
>  		u32 mask;\
> @@ -86,6 +105,29 @@
>  		sd_ctrl_write32((host), CTL_STATUS, mask); \
>  	} while (0)
>  
> +#define enable_mmc_sdio_irqs(host, i) \
> +	do { \
> +		u16 mask;\
> +		mask  = sd_ctrl_read16((host), CTL_SDIO_IRQ_MASK); \
> +		mask &= ~((i) & TMIO_SDIO_MASK_IRQ); \
> +		sd_ctrl_write16((host), CTL_SDIO_IRQ_MASK, mask); \
> +	} while (0)
> +
> +#define disable_mmc_sdio_irqs(host, i) \
> +	do { \
> +		u16 mask;\
> +		mask  = sd_ctrl_read16((host), CTL_SDIO_IRQ_MASK); \
> +		mask |= ((i) & TMIO_SDIO_MASK_IRQ); \
> +		sd_ctrl_write16((host), CTL_SDIO_IRQ_MASK, mask); \
> +	} while (0)
> +
> +#define ack_mmc_sdio_irqs(host, i) \
> +	do { \
> +		u16 mask;\
> +		mask  = sd_ctrl_read16((host), CTL_SDIO_STATUS); \
> +		mask &= ~((i) & TMIO_SDIO_MASK_IRQ); \
> +		sd_ctrl_write16((host), CTL_SDIO_STATUS, mask); \
> +	} while (0)
>  
>  struct tmio_mmc_host {
>  	void __iomem *ctl;

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
