From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] mmc: slot-gpio: use devm_* managed functions to ease
 users
Date: Tue, 11 Dec 2012 08:32:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1212110814330.29758@axis700.grange>
References: <1354887168-3073-1-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1212071438010.24520@axis700.grange>
 <20121207144006.GB30468@S2100-06.ap.freescale.net> <87d2yh4afi.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53559 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2LKHcS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 02:32:18 -0500
In-Reply-To: <87d2yh4afi.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 10 Dec 2012, Chris Ball wrote:

> Hi Shawn, Guennadi,
> 
> On Fri, Dec 07 2012, Shawn Guo wrote:
> >> > Use devm_* managed functions, so that slot-gpio users do not have to
> >> > call mmc_gpio_free_ro/cd to free up resources requested in
> >> > mmc_gpio_request_ro/cd.
> >> > 
> >> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> >> 
> >> Thanks for the patch, but I'm not sure this is a good idea. Firstly, using 
> >> devm_* allocation functions means, that normally you don't have to free 
> >> these resources explicitly any more. So, actually you would have to remove 
> >> free_irq() and gpio_free() calls completely from the API instead of 
> >> replacing them with devm_* analogs.
> >
> > With the changes, most of the slot-gpio users will only need to call
> > mmc_gpio_request_* functions at probe time, nothing else.  That said,
> > they will not call mmc_gpio_free_* functions at all.  I patched
> > mmc_gpio_free_* functions replacing free_irq() and gpio_free() with
> > devm_* versions to 1) ease the migration of exiting users calling
> > mmc_gpio_free_*; 2) provide a mean for users to manually free resources
> > for whatever reasons.
> 
> I'd like to find a way to merge this -- maybe we can compromise by
> adding a comment or some documentation that explains that you need to be
> careful (and use _request_* and _free_*) to avoid allocating more than
> once if you're doing something odd like runtime switching between CD
> methods?

Ok, so, you agree, that the normal case is, when these GPIO functions are 
requested only once during probing and are released during driver 
unbinding, and that it's worth optimisine for this case. In principle I 
agree, and so far all 3 users of this API do that. So, maybe it would be 
good to extend this patch series with a patch (or 3 patches, if per-driver 
is preferred), removing mmc_gpio_free_*() calls from those drivers. I 
think, however, there is one more thing to consider here: the slot-gpio 
API contains a GPIO CD IRQ handler, which after these changes will only be 
freed after the calls to mmc_remove_host() and mmc_free_host(). This 
should be safe, because mmc_remove_host() sets the .rescan_disable flag. 
After the recent patch the GPIO CD ISR also calls host->ops->card_event(), 
so, hosts muct make sure, that this function is safe to call even after 
the driver's .remove() method has completed. With that in mind, I think, 
we're fine with this patch.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
