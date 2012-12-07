From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] mmc: slot-gpio: use devm_* managed functions to ease
 users
Date: Fri, 7 Dec 2012 22:40:10 +0800
Message-ID: <20121207144006.GB30468@S2100-06.ap.freescale.net>
References: <1354887168-3073-1-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1212071438010.24520@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:35584
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030606Ab2LGONU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 09:13:20 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1212071438010.24520@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Fri, Dec 07, 2012 at 02:49:43PM +0100, Guennadi Liakhovetski wrote:
> Hi Shawn
> 
> On Fri, 7 Dec 2012, Shawn Guo wrote:
> 
> > Use devm_* managed functions, so that slot-gpio users do not have to
> > call mmc_gpio_free_ro/cd to free up resources requested in
> > mmc_gpio_request_ro/cd.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Thanks for the patch, but I'm not sure this is a good idea. Firstly, using 
> devm_* allocation functions means, that normally you don't have to free 
> these resources explicitly any more. So, actually you would have to remove 
> free_irq() and gpio_free() calls completely from the API instead of 
> replacing them with devm_* analogs.

With the changes, most of the slot-gpio users will only need to call
mmc_gpio_request_* functions at probe time, nothing else.  That said,
they will not call mmc_gpio_free_* functions at all.  I patched
mmc_gpio_free_* functions replacing free_irq() and gpio_free() with
devm_* versions to 1) ease the migration of exiting users calling
mmc_gpio_free_*; 2) provide a mean for users to manually free resources
for whatever reasons.

> Secondly, I do use devm_kzalloc() in 
> the API because I really want that allocated memory to just be allocated 
> once and stay there until the device is freed. Whereas with with card 
> detection and write-protect pins - usually you're right, you would only 
> allocate those once during the lifetime of your host device. But - are we 
> sure there cannot be exceptions? What if someone decides to switch between 
> CD-IRQ and CD-polling at runtime? Or do something equally weird with their 
> GPIOs... At least I personally don't think I have sufficient knowledge of 
> all possible configurations to make such a decision. Think about pinctrl 
> etc. What if at runtime the CD pin has to be released by mmc to be used 
> by some other device?

mmc_gpio_request_* and mmc_gpio_free_* pair are still there anyway.
Users can manually call them in any way they want.

> Anyway, I'm fine either way, but I'm just not sure 
> how reasonable this change is.

My intension is to save slot-gpio users from checking GPIO CD/WP cases
and calling mmc_gpio_request_* functions, so that we can have a cleaner
.probe error path and .remove function.

Shawn

