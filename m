From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] DT: bindings: mmc: Add property for 3.3V only
 support
Date: Thu, 8 Sep 2016 11:44:33 -0500
Message-ID: <20160908164433.GA32615@rob-hp-laptop>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-2-git-send-email-stefan.wahren@i2se.com>
 <20160810184451.GA13473@rob-hp-laptop>
 <853617027.179290.63a6f478-ad48-40c8-82ca-760dd1afc040.open-xchange@email.1und1.de>
 <CAL_JsqJ09hXYrp_pgAw9FXrBv+=grkm_zip6qB9XefujPECTxQ@mail.gmail.com>
 <468a6704-a9f0-1715-ff64-9e331a6a80b1@rock-chips.com>
 <8f87c885-3c55-cac8-a9f5-e121ae031f90@intel.com>
 <CAPDyKFr8X93oqiPzkQxPnfMGyV9UBEybvfODX5if3VwMbheKcw@mail.gmail.com>
 <1736517218.106027.c3e46c0d-6759-48dd-92a9-ce98ef74d48a.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1736517218.106027.c3e46c0d-6759-48dd-92a9-ce98ef74d48a.open-xchange-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Otavio Salvador <otavio-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>, Holger Schurig <holgerschurig-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 02, 2016 at 08:50:28PM +0200, Stefan Wahren wrote:
> Hi Ulf, hi Rob
> 
> > Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> hat am 30. August 2016 um 11:26
> > geschrieben:
> > 
> > 
> > On 18 August 2016 at 14:25, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > > On 11/08/16 03:48, Shawn Lin wrote:
> > >> + Adrian
> > >>
> > >> Let's queue Adrian here who now maintains SDHCI stuff.
> > >
> > > SDHCI drivers may not implement no-1-8-v in a consistent manner, but as far
> > > as I can see, the meaning is still clear: 1.8V will not be used for either
> > > supply or signaling.
> > 
> > Okay.
> > 
> > >
> > > SDHCI is complicated because the SDHCI specification does not cover eMMC.
> > > From the perspective of SDHCI, the only 1.8V modes are the UHS-I modes, so
> > > support for 1.8V signaling is the same as support for one of those modes
> > > (the spec even says as much).  But what happens is that the host controller
> > > can support those modes but the board can't supply 1.8V so the drivers
> > > remove capability for the modes.  Support for 1.8V supply has a capability
> > > bit which drivers can override if necessary but removable SD cards don't
> > > support 1.8V supply anyway, so the issue doesn't arise if the host
> > > controller is only used for uSD cards.
> > 
> > By looking how SDHCI uses the SDHCI_SUPPORT_DDR50 in conjunction with
> > SDHCI_QUIRK2_NO_1_8_V (which is set when no-1-8-v DT property is
> > provided), this becomes a bit messy.
> > 
> > From Adrian's summary above, it then seems appropriate to limit the
> > no-1-8-v DT property to apply only to capabilities related to SD
> > cards, as I assume that also was the original purpose.
> > 
> > Do you think it's possible to clean up this in sdhci when assigning
> > the caps masks, and then also clarify the no-1-8-v DT binding in the
> > documentation?
> 
> was the question addressed to me? I think this clean up should be a separate
> patch series. Unfortunately i don't have a clue about what exactly and how it
> should be fixed.
> 
> > 
> > Regarding the new DT binding proposed to be added, mmc-ddr-3_3v, it
> > seems we need this to be able to properly describe the HW.
> > Rob, do you have an issue with adding this binding? I am thinking that
> > we already have mmc-ddr-1_8v and mmc-ddr-1_2v, so it just follow
> > existing pattern.
> 
> @Rob: gently ping ...

Yes, this seems fine. I was only the no-1-8-v removal I had issue with.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
