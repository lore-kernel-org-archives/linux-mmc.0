From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 5/6] mmc: sdhci-of-esdhc: factor out common stuff
Date: Mon, 11 Oct 2010 19:33:00 +0100
Message-ID: <20101011183300.GC21335@void.printf.net>
References: <1286806866-19258-6-git-send-email-w.sang@pengutronix.de> <1286817032-21219-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52061 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755684Ab0JKSdC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Oct 2010 14:33:02 -0400
Content-Disposition: inline
In-Reply-To: <1286817032-21219-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>

Hi Wolfram,

On Mon, Oct 11, 2010 at 07:10:32PM +0200, Wolfram Sang wrote:
> +static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	int pre_div = 2;
> +	int div = 1;
> +	u32 temp;
> +
> +	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> +	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
> +		| ESDHC_CLOCK_MASK);
> +	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> +
> +	if (clock == 0)
> +		goto out;
> +
> +	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
> +		pre_div *= 2;
> +
> +	while (host->max_clk / pre_div / div > clock && div < 16)
> +		div++;
> +
> +	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
> +		clock, host->max_clk / pre_div / div);
> +
> +	pre_div >>= 1;
> +	div--;
> +
> +	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> +	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
> +		| (div << ESDHC_DIVIDER_SHIFT)
> +		| (pre_div << ESDHC_PREDIV_SHIFT));
> +	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> +	mdelay(100);

This isn't directly related to this patchset (the code was there 
beforehand), but it would be nice to rework the mdelay(100).

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
