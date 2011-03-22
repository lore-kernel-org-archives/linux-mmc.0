From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/6] mmc: split the tmio driver into several modules
Date: Wed, 23 Mar 2011 07:06:24 +0900
Message-ID: <20110322220623.GJ2423@verge.net.au>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
 <AANLkTi=EBDnRtjqN3eckpt32p-tG8VkcsktLartOEgBp@mail.gmail.com>
 <Pine.LNX.4.64.1103211226110.21013@axis700.grange>
 <20110322053127.GG27346@verge.net.au>
 <20110322122850.GA26099@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110322122850.GA26099@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 22, 2011 at 09:28:50PM +0900, Paul Mundt wrote:
> On Tue, Mar 22, 2011 at 02:31:31PM +0900, Simon Horman wrote:
> > On Mon, Mar 21, 2011 at 12:38:10PM +0100, Guennadi Liakhovetski wrote:
> > > Hi Chris, Ian
> > > 
> > > AFAICS there are currently still a few tmio patch-series outstanding:
> > > 
> > > From: Guennadi Liakhovetski <g.liakhovetski <at> gmx.de>
> > > Subject: [PATCH 0/2] tmio_mmc: improve DMA reliability
> > > 	http://thread.gmane.org/gmane.linux.kernel.mmc/6485
> > > 
> > > From: Simon Horman <horms <at> verge.net.au>
> > > Subject: [PATCH 0/4] [rfc v3] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
> > > 	http://thread.gmane.org/gmane.linux.kernel.mmc/6664
> > 
> > IMHO, Patch 1-3 are ready and can either be merged through the MMC
> > or one of Paul's trees. Although I should note that patches
> > 2 and 3 include changes to arch/arm/boot/compressed/mmcif-sh7372.c and
> > arch/sh/boot/romimage/mmcif-sh7724.c.
> > 
> I'm having a hard time working out what these arbitrary 1-3 numbers map
> to in terms of actual series and patch numbers. As far as things with an
> sh or rmobile impact I see:
> 
> sh: ecovec: use the CONFIG_MMC_TMIO symbols instead of MFD
> 
> and
> 
> [rfc v3] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
> 
> although it's not obvious how the latter is tied to a TMIO dependency
> (some SDHI header thing?).
> 
> I'm happy to take the ecovec patch whenever, since it doesn't really hurt
> anything. Anything touching drivers/mmc I obviously prefer to go via Chris.
> 
> I got buried in the fbdev patch queue today, so I'll be catching up on sh and
> rmobile stuff tomorrow. You're free to work out amongst yourselves what gets
> applied where in which order, or I'll simply guess.

Hi Paul,

By 1-3 I was referring to the first three patches of
[PATCH 0/4] [rfc v3] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM

That is:
[PATCH 1/4] mmc: tmio_mmc: Move some defines into a shared header
[PATCH 2/4] mmc, ARM: Rename SuperH Mobile ARM zboot helpers
[PATCH 3/4] mmc: Add MMC_PROGRESS_*

And by patch 4 I was referring to
[PATCH 4/4 v5] mmc, ARM: Add zboot from eSD support for SuperH Mobile

I apologise for that being as clear as mud.

Magnus raised a build issue with the series since my previous email.
I will investigate that and reply to him ASAP. Its probably best
to hold all the patches until then.

With regards to 
[PATCH 2/6] sh: ecovec: use the CONFIG_MMC_TMIO symbols instead of MFD
it looks like Magnus raised a few issues and Guennadi is going to repost
the patch. But I could be wrong.

