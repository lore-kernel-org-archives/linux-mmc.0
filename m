From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Gate the clock when freq is 0
Date: Fri, 21 Dec 2012 16:21:32 +0000
Message-ID: <20121221162132.GI14363@n2100.arm.linux.org.uk>
References: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35659 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab2LUQVm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Dec 2012 11:21:42 -0500
Content-Disposition: inline
In-Reply-To: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Dec 12, 2012 at 04:50:21PM +0100, Ulf Hansson wrote:
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index edc3e9b..bf07823 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1147,6 +1147,15 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		}
>  	}
>  
> +	/*
> +	 * If clock = 0 and the block needs a certain value in the clreg
> +	 * to function, we need to gate the clock by removing MCI_PWR_ON.
> +	 * This is a special case for ST Micro variants, since the power
> +	 * register in the ARM legacy case is used for powering the cards.

I wish you'd stop using "legacy" when talking about the ARM primecell.
How can it be legacy when ARMs current development boards still use this
primecell?

> +	 */
> +	if (!ios->clock && variant->clkreg)
> +		pwr &= ~MCI_PWR_ON;

This is horrid.  You're overloading the clkreg default value with another
meaning here - "if we have any bits set in the default value for the
MCICLOCK register, the MCIPOWER register has special meanings for the
power control bits".

When you think about it as I've described it above, do you think this is
an acceptable solution to this problem?
