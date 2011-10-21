From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Fri, 21 Oct 2011 18:36:38 +0100
Message-ID: <20111021173637.GG21648@n2100.arm.linux.org.uk>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56533 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab1JURgq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2011 13:36:46 -0400
Content-Disposition: inline
In-Reply-To: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>

On Fri, Oct 21, 2011 at 05:25:54PM +0200, Ulf Hansson wrote:
> +#ifdef CONFIG_PM_RUNTIME
> +static int mmci_runtime_suspend(struct device *dev)
> +{
> +	struct amba_device *adev = to_amba_device(dev);
> +	struct mmc_host *mmc = amba_get_drvdata(adev);
> +	unsigned long flags;
> +
> +	if (mmc) {
> +		struct mmci_host *host = mmc_priv(mmc);
> +
> +		spin_lock_irqsave(&host->lock, flags);
> +
> +		/* Save registers for POWER, CLOCK and IRQMASK0 */
> +		host->irqmask0_reg = readl(host->base + MMCIMASK0);
> +		host->pwr_reg = readl(host->base + MMCIPOWER);
> +		host->clk_reg = readl(host->base + MMCICLOCK);
> +
> +		/*
> +		 * Make sure we do not get any interrupts when we disabled the
> +		 * clock and the regulator and as well make sure to clear the
> +		 * registers for clock and power.
> +		 */
> +		writel(0, host->base + MMCIMASK0);
> +		writel(0, host->base + MMCIPOWER);
> +		writel(0, host->base + MMCICLOCK);

Err, no.  You're not allowed to power down the card between commands
unless the card has been removed or been has finished with.

If you power down the card (which you _are_ doing by writing zero to
the MMCIPOWER register), then you have to do a full setup of the card
when you resume.

This is completely unsuitable for runtime-PM usage.
