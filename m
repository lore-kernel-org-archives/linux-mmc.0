From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Tue, 21 Dec 2010 20:24:08 +0000
Message-ID: <20101221202408.GA12006@void.printf.net>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42195 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab0LUUYN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Dec 2010 15:24:13 -0500
Content-Disposition: inline
In-Reply-To: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com

Hi Linus,

On Wed, Nov 03, 2010 at 10:22:50AM +0100, Linus Walleij wrote:
> +/*
> + *	mmc_host_clk_exit - shut down clock gating code
> + *	@host: host with potential clock to control
> + */
> +static inline void mmc_host_clk_exit(struct mmc_host *host)
> +{
> +	/*
> +	 * Wait for any outstanding gate and then make sure we're
> +	 * ungated before exiting.
> +	 */
> +	if (cancel_work_sync(&host->clk_disable_work))
> +		mmc_host_clk_gate_delayed(host);
> +	if (host->clk_gated)
> +		mmc_host_clk_ungate(host);
> +	BUG_ON(host->clk_requests > 0);
> +}

I just hit the BUG_ON() above, when doing "rmmod sdhci-pci" on my x86
laptop running today's linux-next.  There was *no* SD card inserted,
and hadn't been one inserted all boot.

Let me know if you want me to try adding any extra debugging/patches.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
