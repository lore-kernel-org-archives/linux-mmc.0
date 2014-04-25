From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
	compliant with UHS-1
Date: Fri, 25 Apr 2014 14:15:30 +0100
Message-ID: <20140425131529.GN26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk> <20140425123820.GA15179@pengutronix.de> <20140425124945.GM26756@n2100.arm.linux.org.uk> <20140425130849.GB15179@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50621 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751891AbaDYNQZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 09:16:25 -0400
Content-Disposition: inline
In-Reply-To: <20140425130849.GB15179@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org

On Fri, Apr 25, 2014 at 03:08:49PM +0200, Markus Pargmann wrote:
> I just tried the different parts of the patch. Without the following
> change, emmc works:
> 
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1507,12 +1507,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  			host->ops->set_clock(host, host->clock);
>  		}
>  
> -
> -		/* Reset SD Clock Enable */
> -		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -		clk &= ~SDHCI_CLOCK_CARD_EN;
> -		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -

So the bit which stops us violating the SD spec stops eMMC from working...
that's... just great.

Okay, I'll look deeper at this and see what can be done, but I suspect it
will turn out to require more patches and be more invasive.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
