From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmci: reset voltage after power off.
Date: Sun, 7 Nov 2010 17:15:59 +0000
Message-ID: <20101107171559.GE1759@n2100.arm.linux.org.uk>
References: <1288949741-9712-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47288 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab0KGRQL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2010 12:16:11 -0500
Content-Disposition: inline
In-Reply-To: <1288949741-9712-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Ulf Hansson <ulf.hansson@stericsson.com>

On Fri, Nov 05, 2010 at 10:35:41AM +0100, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> At power off, reset OCR mask to be the highest possible voltage
> supported for the current mmc host.
> 
> This solves the re-initialization during the power up sequence.
> The voltage may have been decreased due to the card accepts a lower
> voltage than the voltage used during the initialization sequence.
> We need to reset the voltage to by the host highest possible value
> since according to specification the initialization must always be
> done at high voltage.

Surely this should already be done by:

        /* If ocr is set, we use it */
        if (host->ocr)
                bit = ffs(host->ocr) - 1;
        else
                bit = fls(host->ocr_avail) - 1;

in mmc_power_up ?
