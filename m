From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/6] mmc: renesas-sdhi: refactor DMA support
Date: Mon, 22 May 2017 13:50:18 +0200
Message-ID: <20170522115017.GI16822@verge.net.au>
References: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
 <20170518201436.umh3d22rf25cqh2b@ninjato>
 <CAPDyKFpTfT=ftio2t957SjpL6wd3S1tztPfBB+SOnW4TsGuB3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpTfT=ftio2t957SjpL6wd3S1tztPfBB+SOnW4TsGuB3A@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, May 19, 2017 at 10:30:07AM +0200, Ulf Hansson wrote:
> On 18 May 2017 at 22:14, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Wed, May 10, 2017 at 11:25:24AM +0200, Simon Horman wrote:
> >> Hi Wolfram, Hi Ulf, Hi Arnd, Hi all,
> >>
> >> the intention of this patch-set is to refactor the DMA support in
> >> the Renesas SDHI driver in order to make it easier to add support
> >> for using the SDHI hardware with different DMA implementations.
> >>
> >> This is based on earlier work, posted as "[PATCH/RFC v3 0/6] mmc:
> >> renesas_sdhi: add R-Car Gen-3 DMA support". It attempts to implement
> >> the reworking of the driver proposed by Arnd[1] in his review of that
> >> patch-set.
> >>
> >> [1] http://www.spinics.net/lists/linux-mmc/msg38004.html
> >>
> >> Unlike that patch-set this patch-set does not add support for
> >> R-Car Gen-3 DMA. Rather it focuses on refactoring the code.
> >>
> >> Changes between RFC and v2:
> >>
> >> * Drop filenames from comment at top of source
> >> * Consistently check for if (host->dma_ops) before using dma_ops.
> >>
> >>
> >> Simon Horman (6):
> >>   mmc: tmio: drop filenames from comment at top of source
> >>   mmc: renesas-sdhi, tmio: make dma more modular
> >>   mmc: tmio: rename tmio_mmc_{pio => core}.c
> >>   mmc: renesas-sdhi: rename tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c
> >>   mmc: renesas-sdhi: rename sh_mobile_sdhi.c => renesas_sdhi_core.c
> >>   mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file
> >
> > Thanks Simon for this series! The file layout looks in deed much better
> > now. And some light testing on my Lager didn't show any regressions. I
> > have only minor comments which do not have anything to do with the code,
> > so already here:
> >
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > The comments:
> >
> > * MAINTAINERS file needs updating because of the new filenames
> > * I'd prefer the _GPL variant of EXPORT_SYMBOL unless we have a reason
> >   to not use it?
> > * maybe this is also a good time to update the Renesas copyrights in
> >   file headers?
> > * checkpatch reports some whitespace errors on patch 6. I assume they
> >   were already there in the code you moved around. Still, it might be
> >   a nice occasion to fix those?
> >
> > Thanks again, nice work!
> >
> >    Wolfram
> >
> 
> I have applied this for next, assuming Simon addresses Wolfram's
> comments on top.

Thanks a lot! I will follow-up on Wolfram's comments.
