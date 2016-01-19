From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto tuning
 mode.
Date: Tue, 19 Jan 2016 17:57:58 +0000
Message-ID: <20160119175757.GR19062@n2100.arm.linux.org.uk>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:49768 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbcASR62 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 12:58:28 -0500
Content-Disposition: inline
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>, Emil Lenchak <emill@xilinx.com>, Tobias Klauser <tklauser@distanz.ch>, Sudeep Holla <Sudeep.Holla@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Haibo Chen <haibo.chen@freescale.com>, Marek Vasut <marex@denx.de>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Suman Tripathi <stripathi@apm.com>, Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger

On Tue, Jan 19, 2016 at 07:47:31PM +0530, P L Sai Krishna wrote:
> +void arasan_tune_sdclk(struct sdhci_host *host)

static?

> +{
> +	unsigned int clock;
> +
> +	clock = host->clock;

Maybe combine the above two lines:

	unsigned int clock = host->clock;

?

> +
> +	/*
> +	 * As per controller erratum, program the SDCLK Frequency
> +	 * Select of clock control register with a value, say
> +	 * clock/2. Wait for the Internal clock stable and program
> +	 * the desired frequency.
> +	 */
> +	host->ops->set_clock(host, clock/2);

The comment above says "wait for the internal clock stable" - I see
no wait in here.  Does the code actually conform with the comment?

Please also use "clock / 2" as per coding style, thanks

> +
> +	host->ops->set_clock(host, host->clock);

Maybe replace host->clock with clock?

> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d622435..8b064cd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2043,6 +2043,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		err = -EIO;
>  	}
>  
> +	if ((host->quirks2 & SDHCI_QUIRK2_BROKEN_TUNING) &&
> +		(tuning_loop_counter >= 0) && (ctrl & SDHCI_CTRL_TUNED_CLK)) {
> +		host->ops->tune_clk(host);
> +	}

Do we need this "SDHCI_QUIRK2_BROKEN_TUNING" quirk at all?  What's wrong
with:

	if (host->ops->tune_clk && tuning_loop_counter >= 0 &&
	    ctrl & SDHCI_CTRL_TUNED_CLK)
		host->ops->tune_clk(host);

here?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
