From: Philip Rakity <prakity@marvell.com>
Subject: [RFC]:  sdhci.c  set_ios -- reduce spin_lock so mdelay is not
 called in spiin_lock
Date: Mon, 10 Jan 2011 06:51:03 -0800
Message-ID: <28E42EFB-C3E7-4741-BD63-29B603F05B99@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:43244 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751800Ab1AJOvO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Jan 2011 09:51:14 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Mark Brown <markb@marvell.com>



In the current implementation of set_ios -- spin_lock with interrupts disabled is held when mdelay is called.  This is considered bad form.

This code changes how set_ios works to mask out interrupts on the sdhci device rather than disable interrupts.

This code has been tested on mmp2 - linux-next.  The code is posted as a RFC for review since no amount of testing can
verify interrupt handling is really correct.

I can post a patch if that is desired as well.

Philip

> 
> static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> {
> 	struct sdhci_host *host;
> 	unsigned long flags;
> 	u8 ctrl;
> 	u32 ier;
> 
> 	host = mmc_priv(mmc);
> 
> 	if (host->flags & SDHCI_DEVICE_DEAD)
> 		goto out;
> 
> 	/*
> 	 * Reset the chip on each power off.
> 	 * Should clear out any weird states.
> 	 */
> 	spin_lock_irqsave(&host->lock, flags);
> 	if (ios->power_mode == MMC_POWER_OFF) {
> 		sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> 		sdhci_reinit(host);
> 	}
> 
> 	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
> 	sdhci_mask_irqs(host, ier);
> 	spin_unlock_irqrestore(&host->lock, flags);
> 
> 	sdhci_set_clock(host, ios->clock);
> 	sdhci_set_ddr(host, ios->ddr);
> 
> 	if (ios->power_mode == MMC_POWER_OFF)
> 		sdhci_set_power(host, -1);
> 	else
> 		sdhci_set_power(host, ios->vdd);
> 
> 	if (host->ops->platform_send_init_74_clocks)
> 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> 
> #ifdef CONFIG_MMC_CLKGATE
> 	if ((mmc->caps & MMC_CAP_HW_CLOCK_GATING)
> 		&& host->ops->platform_hw_clk_gate)
> 			host->ops->platform_hw_clk_gate(host);
> #endif
> 
> 	/*
> 	 * If your platform has 8-bit width support but is not a v3 controller,
> 	 * or if it requires special setup code, you should implement that in
> 	 * platform_8bit_width().
> 	 */
> 	if (host->ops->platform_8bit_width)
> 		host->ops->platform_8bit_width(host, ios->bus_width);
> 	else {
> 		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> 		if (ios->bus_width == MMC_BUS_WIDTH_8) {
> 			ctrl &= ~SDHCI_CTRL_4BITBUS;
> 			if (host->version >= SDHCI_SPEC_300)
> 				ctrl |= SDHCI_CTRL_8BITBUS;
> 		} else {
> 			if (host->version >= SDHCI_SPEC_300)
> 				ctrl &= ~SDHCI_CTRL_8BITBUS;
> 			if (ios->bus_width == MMC_BUS_WIDTH_4)
> 				ctrl |= SDHCI_CTRL_4BITBUS;
> 			else
> 				ctrl &= ~SDHCI_CTRL_4BITBUS;
> 		}
> 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> 	}
> 
> 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> 
> 	if ((ios->timing == MMC_TIMING_SD_HS ||
> 	     ios->timing == MMC_TIMING_MMC_HS)
> 	    && !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
> 		ctrl |= SDHCI_CTRL_HISPD;
> 	else
> 		ctrl &= ~SDHCI_CTRL_HISPD;
> 
> 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> 	sdhci_unmask_irqs(host, ier);
> 
> 	/*
> 	 * Some (ENE) controllers go apeshit on some ios operation,
> 	 * signalling timeout and CRC errors even on CMD0. Resetting
> 	 * it on each ios seems to solve the problem.
> 	 */
> 	if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS) {
> 		spin_lock_irqsave(&host->lock, flags);
> 		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> 		spin_unlock_irqrestore(&host->lock, flags);
> 	}
> 		
> out:
> 	mmiowb();
> }
> <sdhci.c>

