From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] mmci: adjust calculation of f_min
Date: Tue, 5 Jul 2011 12:20:49 +0100
Message-ID: <20110705112049.GX8286@n2100.arm.linux.org.uk>
References: <1309247853-17143-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50594 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156Ab1GELU5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 07:20:57 -0400
Content-Disposition: inline
In-Reply-To: <1309247853-17143-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On Tue, Jun 28, 2011 at 09:57:33AM +0200, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> For the st_clkdiv variant f_min is too low for practical cases,
> there is a heuristic calculation that appear to set the min
> frequency to mclk rounded up with 512, for our practical use
> cases dividing by 257 gives a reasonable floor value on the
> ST Micro version of the clock divider.

The only requirement with f_min is that the hardware is capable of
producing a clock at that rate.  Having it smaller than 'practical'
is not a problem, and may help some cards be detected.

The core tries clocks at 400kHz, 300, 200 and 100kHz during probe,
and that's the lowest frequency that will be attempted (provided
the card doesn't actualy say it wants something slower.)

So unless there is a reason not to (eg, divisors above 257 are invalid)
its better to leave it as is.
