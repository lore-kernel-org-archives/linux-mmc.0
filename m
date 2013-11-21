From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/16] ARM: shmobile: SDHI support for r8a7790
Date: Thu, 21 Nov 2013 17:48:53 +0900
Message-ID: <20131121084851.GB16004@verge.net.au>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
 <87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
 <87a9h6o2gi.wl%kuninori.morimoto.gx@renesas.com>
 <20131118072111.GG27935@verge.net.au>
 <878uwm6tru.wl%kuninori.morimoto.gx@renesas.com>
 <20131121035351.GA5429@verge.net.au>
 <87li0ixreh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87li0ixreh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent <laurent.pinchart@ideasonboard.com>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 20, 2013 at 09:20:10PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > > These are v2 of SDHI support for r8a7790.
> > > > > 
> > > > > Kuninori Morimoto (2):
> > > > >       ARM: shmobile: lager: add gpio/fixed regulator for SDHI
> > > > >       ARM: shmobile: lager: add SDHI0/2 support
> > > > > 
> > > > >  arch/arm/mach-shmobile/board-lager.c |  149 +++++++++++++++++++++++++++++++++-
> > > > 
> > > > Hi Morimoto-san,
> > > > 
> > > > I assume that these two patches depend on at least
> > > > some of the first 14 patches. Is that correct?
> > > 
> > > Compile itself is not depend on first 14 patches,
> > > but, it doesn't work correctly without these patches.
> > > So, yes, it depend on 14 patches.
> > 
> > What is the run-time effect of these 2 patches without the other 14.
> > Is it
> > 
> > a) Things get worse and will only get better with the other 14 patches or;
> > b) Things stay the same and will  get better with the other 14 patches?
> > 
> > In the case of b I am inclined to queue these patches up once/if
> > Chris has indicated that the other 14 patches are ok.
> > 
> > In the case of a I would like to wait and queue up these patches
> > on top of the other 14 patches once/if they are available in a
> > stable branch.
> 
> Thank you. I think b)
> But, my current plan is that I will re-send these patches
> again in good-timing (when I can indicate the necessary branch).
> I guess it doesn't have complex relationship.
> What do you think ?

Sure, that is fine for me.
