From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save
	power
Date: Tue, 11 Dec 2012 14:52:43 +0000
Message-ID: <20121211145243.GQ14363@n2100.arm.linux.org.uk>
References: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58259 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab2LKOwv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 09:52:51 -0500
Content-Disposition: inline
In-Reply-To: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Dec 11, 2012 at 03:17:54PM +0100, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> The amba bus is already performing same actions but for the apb_pclk.
> So here we just make sure the clock to card is gated as well to save
> more power. At runtime resume we will thus restore the clock again.

And how exactly do you ensure the requirement that a certain number of
clocks is supplied to the card after the last command before you cut
the clock?
