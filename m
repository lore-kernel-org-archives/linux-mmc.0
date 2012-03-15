From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: assume maintainership
Date: Thu, 15 Mar 2012 17:30:47 +0000
Message-ID: <20120315173047.GB17243@flint.arm.linux.org.uk>
References: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39324 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab2CORbA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:31:00 -0400
Content-Disposition: inline
In-Reply-To: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Pawel Moll <pawel.moll@arm.com>

On Thu, Mar 15, 2012 at 03:30:36PM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> So since this driver is crucial for us (as in ST-Ericsson)
> to have actively maintained, and since it is marked orphaned
> I will assume maintainership for it starting with the 3.5
> integration cycle. The idea is to collect patches and send
> either patch sets of pull requests to Chris.

Actually, I still want to be involved because I'm far from convinced with
some of the patches coming from Ulf are correct for ARMs implementation.
That's why I'm purposely not applying the MMCI patches in the patch system
in a particularly fast manner - I want there to be a decent amount of
testing between each set of patches.

For example, the next patch in the series to be applied is:

"mmc: mmci: Decrease current consumption in suspend"

and as I've explained before, it does this by saving the MMCI power and
clock registers and clearing them.  This has the effect of stopping the
clock, and in the case of ARMs hardware, removing power from the card.
Therefore, the card will require full bring up, including reassigning
the card address for MMC cards on resume, and simply starting the next
command will not be possible.

As I've already tried to explain, on the normal power management suspend
callback, these registers should _already_ have been placed into their
"card not present" state, so saving and zeroing them has no useful effect.

Moreover, saving and restoring them across suspend is wrong because on
ARM hardware there's a sequence of power-off, power-up, power-on which
needs to be gone through to restore power.

So, I've queued up the 10 patches which I'm happy to take for v3.4, and
that's all I'm taking for v3.4 until I can find the strength to have
another discussion with Ulf over this issue.

As there's an interdependence between the various patches, I can't apply
any of the later patches even if I wanted to without these "power saving"
patches.

So, it's not really unmaintained or orphaned...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
