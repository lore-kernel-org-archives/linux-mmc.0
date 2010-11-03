From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] MMC Agressive clocking framework v7
Date: Wed, 3 Nov 2010 13:44:50 +0000
Message-ID: <20101103134450.0c88e4ed@lxorguk.ukuu.org.uk>
References: <1288541169-16054-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTims3RhKmPxxxL_T32DN96kSrEE415FE1320fbNO@mail.gmail.com>
	<4CD1612F.10507@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57339 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752321Ab0KCNq1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2010 09:46:27 -0400
In-Reply-To: <4CD1612F.10507@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, Kyungmin Park <kmpark@infradead.org>, "arm-kernel@lists.infradead.org" <arm-kernel@lists.infradead.org>

> Doesn't it require a struct device* to be used?

Yes but the sdhci port can be a device even if its wired via a controller
which is its parent. The device layer is designed that way
> 
> I cannot use the host controller struct because that may be using
> dev_pm_ops for some other scheme.

Such as ?

> Then you must mean that it should be implemented in each and every
> driver instead, like it is today. We had a long discussion about
> that already.

Why - it simply means you need the core to contain a library routine
which is the default behaviour. This is how scsi works, how ATA works,
etc for just about everything it does. Standardising something in the
core code shouldn't mean hardwiring it to work that way or having a
million copies of it.

> Right now the way I see it the host driver can support
> dev_pm_ops and simply call runtime_pm_put() when it recieves an
> ios with clock frequency 0, so it's not like it contradicts
> runtime PM.

This makes sense - for one it means that devices with more complex rules
- eg not being able to do card insertion detects with power off can
  handle it themselves.
> 
> The plumbing used in runtime PM is however very applicable to the
> task, so if it could be made to work in a subsystem without any
> struct device* anchor, it would be very reusable. Is this
> feasible?

I think its the wrong question. The right question is why can't the
device be used, and if not why can't it have subdevices as the device
tree is meant to work (and runtime pm understands)
