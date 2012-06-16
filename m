From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci.c: Defer probe() in case of missing GPIOs
Date: Sat, 16 Jun 2012 16:01:25 +0100
Message-ID: <20120616150125.GD7628@n2100.arm.linux.org.uk>
References: <1339856099-9313-1-git-send-email-stigge@antcom.de> <20120616142652.GC7628@n2100.arm.linux.org.uk> <4FDC9EEC.1070509@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57259 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab2FPPCA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jun 2012 11:02:00 -0400
Content-Disposition: inline
In-Reply-To: <4FDC9EEC.1070509@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, ulf.hansson@stericsson.com, linus.walleij@linaro.org, sebastian.rasmussen@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org

On Sat, Jun 16, 2012 at 04:57:48PM +0200, Roland Stigge wrote:
> On 16/06/12 16:26, Russell King - ARM Linux wrote:
> > On Sat, Jun 16, 2012 at 04:14:59PM +0200, Roland Stigge wrote:
> >> If the GPIOs used by the MMCI driver are not registered yet when the
> >> driver is probe()d, they can't be used. This happens if the mmci driver
> >> is probed before the respective GPIO controller (e.g. on the LPC32xx
> >> EA3250 board, the PCA9532 GPIO controller would be initialized via DT
> >> after mmci). Therefore, we defer mmci in this case.
> > 
> > This code is wrong.  There are platforms where plat->gpio_cd is negative
> > (because there isn't an associated GPIO) and we still expect the driver
> > to successfully bind.  In that case, the driver gets the CD and WP
> > information via the status callback.
> > 
> > So this is an incompatible change with existing (and required) driver
> > behaviour.
> 
> As someone just told me, in the case of no GPIO, we would have gpio_cd
> == -ENODEV. Would it be sufficient to check for -ENODEV (in which case
> we would do without GPIO), and otherwise return -EPROBE_DEFER?

Sigh.  New rules which jump up when no one's read the bloody code.
That's intensely frustrating.

Why can't the *new* DT parsing code set the GPIOs to -EPROBE_DEFER when
*it* wants them to mean "we should defer" ?  Why should the DT code
have sole use over "-1" ?  That would be *far* more logical and wouldn't
clash with anything in existing use.
