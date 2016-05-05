From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC v2 10/13] usb: hub: Power sequence the ports on activation
Date: Thu, 5 May 2016 19:37:03 +0200
Message-ID: <20160505173703.GA3034@kozik-lap>
References: <1462451666-17945-11-git-send-email-k.kozlowski@samsung.com>
 <Pine.LNX.4.44L0.1605051007040.2008-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34323 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcEERhK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2016 13:37:10 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1605051007040.2008-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Thu, May 05, 2016 at 10:09:47AM -0400, Alan Stern wrote:
> On Thu, 5 May 2016, Krzysztof Kozlowski wrote:
> 
> > The autodetection of attached USB device might not work on certain
> > boards where the power is delivered externally. These devices also might
> > require a hard reset. Use pwrseq for that in USB hub.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/usb/core/hub.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 1c82fcc448f5..0fddaacc62bf 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/random.h>
> >  #include <linux/pm_qos.h>
> > +#include <linux/pwrseq.h>
> >  
> >  #include <asm/uaccess.h>
> >  #include <asm/byteorder.h>
> > @@ -1661,7 +1662,17 @@ static int hub_configure(struct usb_hub *hub,
> >  
> >  	usb_hub_adjust_deviceremovable(hdev, hub->descriptor);
> >  
> > +	/* FIXME: When do the pre-power-on? */
> 
> It's hard to answer this without knowing what pre-power-on involves.

In my particular case, I want to achieve a full reset through regulator (off
and on) because the bootloader left it in initialized state. I assume
that if bootloader did not configure the device, the reset won't be
harmful.

In a MMC case, this pre-power-on on is setting the 'reset' GPIO (thus
triggering the reset) and post-power-on is clearing the 'reset'.

> Why not create a pwrseq_power_on() routine that does pre_power_on 
> followed by post_power_on?

For my purpose it seems sensible.

> 
> > +	/*
> > +	for (i = 0; i < maxchild; i++)
> > +		pwrseq_pre_power_on(hub->ports[i]->pwrseq);
> > +	*/
> > +
> > +	for (i = 0; i < maxchild; i++)
> > +		pwrseq_post_power_on(hub->ports[i]->pwrseq);
> 
> This is patch 10/13.  hub->ports[i]->pwrseq doesn't get added until 
> 11/13.  Obviously you never tried compiling each patch in the series.

Ahh yes, I forgot to reorder them. Thanks for spotting this.

> 
> > +
> >  	hub_activate(hub, HUB_INIT);
> > +
> 
> Unnecessary blank line added.

Thanks for feedback,
Krzysztof

