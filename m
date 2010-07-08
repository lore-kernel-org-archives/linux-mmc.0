From: Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 11/15] wireless: wl1271: introduce platform device support
Date: Thu, 08 Jul 2010 00:34:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007072327380.6020@xanadu.home>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
 <1278376666-3509-12-git-send-email-ohad@wizery.com>
 <4C32EF19.1000604@nokia.com>
 <AANLkTintIz-N7MwwtqhVq2LR3Ln5JTNYSbJUBSSClcA-@mail.gmail.com>
 <4C3306F4.8060907@nokia.com>
 <AANLkTin5W52fPzWToRrAzm56SLZI-taSuI16rCEhLWqH@mail.gmail.com>
 <4C333E0D.2070601@nokia.com> <alpine.LFD.2.00.1007061316010.6020@xanadu.home>
 <4C338927.5020400@nokia.com> <4C34347F.8030000@nokia.com>
 <alpine.LFD.2.00.1007070954010.6020@xanadu.home> <4C34DC92.80908@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4C34DC92.80908-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 7 Jul 2010, Adrian Hunter wrote:

> Nicolas Pitre wrote:
> > On Wed, 7 Jul 2010, Roger Quadros wrote:
> > 
> > > On 07/06/2010 10:51 PM, Hunter Adrian (Nokia-MS/Helsinki) wrote:
> > > > For eMMC in omap_hsmmc, this is all done via claim_host / release_host
> > > > which call ->enable() / ->disable() methods.  omap_hsmmc makes use of
> > > > mmc_power_restore_host() which calls host->bus_ops->power_restore()
> > > > which is not implemented for SDIO, but for MMC and SD it reinitializes
> > > > the card.
> > 
> > This is IMHO a really bad design.  The power control decision has to come
> > from the top, not from the bottom.  And certainly not with a U-turn
> > dependency the omap_hsmmc is using.
> 
> The power control decision does come from the top via mmc_claim_host /
> mmc_release_host.

NO!!!  THIS IS NOT ABOUT POWER!

To the risk of repeating myself, mmc_claim_host and mmc_release_host are 
about getting exclusive access to the host controller.  This should not 
have any relationship with power.  If anything, you might infer some 
idleness of the host through that, but only to save power at the host 
controller level, but not at the card level.

> > I regret to say this, but the omap_hsmmc driver is becoming a total mess.
> > The host controller driver has to be a dumb interface serving requests from
> > the hardware used by the upper layer stack, not the place where decisions
> > such as power handling should be made.  Think of it like an ethernet driver.
> > No ethernet driver in Linux is telling the IP stack when to shut down.
> 
> The omap_hsmmc driver does not tell the core to shut down the upper layers.

What is this call to mmc_power_save_host() and mmc_power_restore_host() 
then?

> Instead the core tells the omap_hsmmc driver that it is "disabled" i.e.
> not currently being used so it can start taking steps to save power.

That's not how I see things implemented right now.

> That is sensible because not even the upper layers know when the next
> activity will be.

I don't agree with you.  The upper layer, even if it cannot predict 
exactly when the next activity will occur, still has a hell of a better 
visibility on what is going on.  In the context of an MMC/SD card, 
the upper layer knows about the block subsystem and it can look for 
dirty blocks that might be flushed in a near future.  In the context of 
a SDIO card, it is the SDIO function driver that knows when it is 
important to preserve power to the card and when it is not.

All the host controller driver must do is to simply and dumbly process 
requests from the core MMC code, including power control requests.

> > > Shouldn't the power control intelligence (i.e. when to turn power ON/OFF)
> > > lie
> > > with the bus drivers?
> > 
> > Absolutely!  And in the SDIO case that should lie with each function
> > drivers.  Please let's stop this omap_hsmmc madness.
> 
> You are dealing with a trivial case - turn off the power when not in use.

And apparently this cannot be implemented sanely on OMAP without faking 
a card removal.

> We have 3 power saving actions: enable DPS, put the card to sleep,
> and finally power it off.  Each increases the latency to start up
> again and so must be staggered.  With DPS-enabled the host controller can
> be powered off at any time.  In that case the controller registers must be
> restored.

You could implement the first one based on some idle period.  The core 
code probably doesn't need to know as this should be transparent to the 
upper layer.  But the other two definitely should be handled by the core 
code.

> There are numerous entry points to the driver.  Checking whether
> to restore registers at every entry point is error prone and messy.

Please give me something else than this lame excuse.  There is 
effectively only _one_ main entry point, namely the request method of 
the mmc_host_ops structure.  You might need to poke at the hardware when 
the set_ios or the enable_sdio_irq methods are called, and if the 
controller is latent then you'd only have to update the register cache.  
This is certainly not what I would call numerous.

> Instead we require that the core tells the driver when to enable and
> disable.

No you don't.  You are abusing the mmc_claim_host interface with power 
management issues.  Those power issues are then guessed in the host 
controller driver, and then it eventually calls back into the core to 
tell the upper layer to shut off.

What I'm telling you is that:

1) If you want to save power after some idle period you don't need 
   host->ops->enable and host->ops->disable at all.  Simply keep a timer 
   alive in your host driver and reset it when a new request comes in.  
   The code for mmc_host_enable() looks rather redundant, and fishy to 
   me with its flag to prevent recursion, so this all could be removed.

2) Putting the card to sleep and/or removing power to it must be 
   completely managed by the core code and certainly not from the host 
   controller driver.  The fact that mmc_power_save_host() is currently 
   called from a host driver and not from the core code or function 
   drivers is completely backward.  Contrary to the suspend/resume 
   requests which come from the machine bus where the host controller is 
   attached (yes, this concept applies to you even if you don't have 
   PCI), the possibility for shutting down power to the card when not in 
   use must come from the so called "MMC bus driver" like the MMC 
   block driver, or the SDIO function driver.  Putting a SDIO card to 
   sleep is card dependent anyway, and that knowledge has to live in the 
   SDIO function driver for that card, and certainly not in the host 
   driver nor in the platform code.

3) And yet that does _not_ require any new capability or method to be 
   implemented in the host controller driver as mmc_set_ios() can do 
   power handling already.

And incidentally, implementing 3 and 4 would suddenly work for all hosts 
without any change to the existing host controller drivers and prevent a 
whole lot of functionality duplications.


Nicolas
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
