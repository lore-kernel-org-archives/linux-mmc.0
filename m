From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmci: corrected calculation of clock div for ux500
Date: Thu, 2 Dec 2010 17:45:50 +0000
Message-ID: <20101202174550.GJ29347@n2100.arm.linux.org.uk>
References: <1291308678-15497-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54072 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab0LBRp7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 12:45:59 -0500
Content-Disposition: inline
In-Reply-To: <1291308678-15497-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@stericsson.com>

On Thu, Dec 02, 2010 at 05:51:18PM +0100, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> The Ux500 variant of this block has a different divider.
> The value used right now is too big and which means a loss
> in performance. This fix corrects it.

Err.

> +		} else if (variant->st_clkdiv) {
> +			clk = ((host->mclk + desired - 1) / desired) - 2;
> +			if (clk >= 256)
> +				clk = 255;
> +			host->cclk = host->mclk / (clk + 2);

This causes the divider to be selected for the 'nearest' frequency.
You are not allowed to _exceed_ the desired frequency - you must
always round down.

IOW, if 10MHz is requested and you can't do 10MHz, 10.5MHz will not
do - you must select a frequency below 10MHz.
