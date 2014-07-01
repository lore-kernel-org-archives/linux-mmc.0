From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: mwifiex card reset
Date: Tue, 1 Jul 2014 10:41:02 +0300
Message-ID: <20140701074101.GA8806@atomide.com>
References: <CALtMJEBWPM+75wxM2Mp5EX_o6NWtZUJdYRCv6psbvdUn4k295w@mail.gmail.com>
 <20140628052220.GG10407@us.netrek.org>
 <20140628072322.GC7410@atomide.com>
 <CALtMJED5vfgkAhMBXKaDP6u9U9n41c-wziyTxt6e_7XTSxG3oQ@mail.gmail.com>
 <20140630061912.GA2461@atomide.com>
 <53B1BAC1.3090902@zonque.org>
 <477F20668A386D41ADCC57781B1F70430FE5F37540@SC-VEXCH1.marvell.com>
 <20140701065721.GM24891@us.netrek.org>
 <477F20668A386D41ADCC57781B1F70430FE5F3754E@SC-VEXCH1.marvell.com>
 <20140701070349.GN24891@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140701070349.GN24891-kJBlkiJxCS/dtAWm4Da02A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Cameron <quozl-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Bing Zhao <bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Andreas Fenkart <afenkart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

* James Cameron <quozl-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> [140701 10:05]:
> On Tue, Jul 01, 2014 at 12:02:25AM -0700, Bing Zhao wrote:
> > Hi James,
> > 
> > > On Mon, Jun 30, 2014 at 11:44:29PM -0700, Bing Zhao wrote:
> > > > I may have missed something, but doesn't the MMC_POWER_OFF and
> > > > MMC_POWER_ON|UP handling in controller driver help?
> > > > Anyway the clocks/GPIOs/regulators are sort of platform dependent.
> > > > Would it be better putting it in /arch/arm/mach-xxxxx/?
> > > 
> > > Wouldn't device tree for mmc be better?
> > 
> > Yes, device tree is better for defining clocks/GPIO/regulators, etc.
> > But I guess the reset logic (making use of these definitions) cannot
> > be device tree?
> 
> I think the reset logic can exist, but does nothing unless the device
> tree definitions are present.

It might be possible to support the SDIO card specific
clocks/GPIOs/regulators the MMC bus driver. But that may not
work well in the long run as those pins are not connected to
the MMC bus at all. If we wanted to explore adding card
specific features to the MMC bus, I guess we should have:

- Card reset-gpios

- Card specific regulators on the card controlled by
  a GPIO

- External card specific regulators

- Card specific idle status pin (no idea what these pins
  do on some of the mwifiex cards though?)

And then these would have to be configured to get the
SDIO card to probe. And they should be controllable also
from user space to reset a card or to power it off.

Then if we get a device that muxes two different SDIO cards
on the same bus, then what do we do? They may both have
their own regulators and reset GPIO pins.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
