From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 12/14] mmc: mmci: Decrease current consumption in
	suspend
Date: Sun, 8 Jan 2012 10:38:23 +0000
Message-ID: <20120108103823.GB21765@n2100.arm.linux.org.uk>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com> <1323106560-5218-13-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58791 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab2AHKib (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jan 2012 05:38:31 -0500
Content-Disposition: inline
In-Reply-To: <1323106560-5218-13-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>

On Mon, Dec 05, 2011 at 06:35:58PM +0100, Ulf Hansson wrote:
> To decrease current consumption in suspend state the
> VCORE regulator, the MCLK and PCLK for the ARM PL18x
> are now disabled.
> 
> When resuming the resourses are re-enabled and
> register values for MMCICLOCK, MMCIPOWER and MMCIMASK0
> are restored.

I still do not agree with this.  The MMC core driver should be shutting
down the interface (turning off the MMC clock, disabling the MMC power).
And indeed it does:

int mmc_suspend_host(struct mmc_host *host)
{
...
        if (!err && !mmc_card_keep_power(host))
                mmc_power_off(host);
}

void mmc_power_off(struct mmc_host *host)
{
...
        host->ios.power_mode = MMC_POWER_OFF;
        host->ios.bus_width = MMC_BUS_WIDTH_1;
        host->ios.timing = MMC_TIMING_LEGACY;
        mmc_set_ios(host);
...
}

On ARM primecells we can _not_ go from power off to power on without
first going through the power up state, so this simple save-and-restore
will not do - we have to go through the proper power up sequence.

Why do you think that the MMC core is not shutting down the power and
clock registers on suspend?
