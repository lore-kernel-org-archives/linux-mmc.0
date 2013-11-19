From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to
 support SDIO interrupt on AM335x.
Date: Tue, 19 Nov 2013 08:19:32 -0800
Message-ID: <20131119161932.GE10317@atomide.com>
References: <1384761240-11005-1-git-send-email-afenkart@gmail.com>
 <1384761240-11005-3-git-send-email-afenkart@gmail.com>
 <CAOf5uw=9KJ312PVzMVEHX-Lj=iYpeZOYFduB8iOu9o+-863CYw@mail.gmail.com>
 <CALtMJEBfeww=ymGMXWtwjtZrpqpFrkRPEOti_uPrE63SBk3Dtw@mail.gmail.com>
 <528A3EB2.1010103@ti.com>
 <20131119154909.GD10317@atomide.com>
 <528B8ADA.6030703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528B8ADA.6030703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Michael Trimarchi <michael@amarulasolutions.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [131119 08:00]:
> On Tuesday 19 November 2013 09:19 PM, Tony Lindgren wrote:
> >* Balaji T K <balajitk@ti.com> [131118 08:23]:
> >>
> >>few params were passed via platform data in non-DT case and never cached
> >>in internal data structure, with non-dt support going away soon, I am
> >>planning to cleanup pdata usage in the driver when it gets to DT only support.
> >
> >The issue of pdata tinkering needs to be fixed first as it will cause nasty
> >issues when the module is reprobed.
> 
> Agree that pdata usage needs to be fixed, but currently module
> reprobe is working fine.

OK. The sdio_irq should be just set in struct omap_hsmmc_host instead.

> >Note that it's still possible to pass platform data in the device tree case
> >as auxdata. And we probably need to do that for the pbias register handling
> >until we have a driver for that.
> >
> >Talking of the pbias driver, any news on it?
> 
> Almost there, will post the patches soon.
> Do you have a branch with updated board files, for me to base pbias patches on
> else I can base the patches on rc1 too.

Great. How about make the pbias driver DT only? Let's not touch the board-*.c
files any longer as those will be going away for v3.14. We can probably keep
the old callback support in place also, and then remove it for v3.15.

And after that it would certainly make sense to rip out the platform data
fomr hsmmc driver just to get rid of the legacy support for multiplexing slots
that's not needed in this driver. That would allow replacing all mmc->slots[0]
accesses with something more standard.

Regards,

Tony
