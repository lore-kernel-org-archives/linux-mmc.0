From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
Date: Tue, 27 Aug 2019 09:50:21 +0200
Message-ID: <20190827075021.GA953@lst.de>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com> <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com> <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com> <20190825011025.GA23410@lst.de> <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com> <20190826073320.GA11712@lst.de> <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Christoph Hellwig <hch@lst.de>, Nicolin Chen <nicoleotsuka@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, vdumpa@nvidia.com, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thierry Reding <treding@nvidia.com>, Kees Cook <keescook@chromium.org>, iamjoonsoo.kim@lg
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 27, 2019 at 04:45:20PM +0900, Masahiro Yamada wrote:
> On Mon, Aug 26, 2019 at 4:33 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Aug 26, 2019 at 11:05:00AM +0900, Masahiro Yamada wrote:
> > > This is included in v5.3-rc6
> > > so I tested it.
> >
> > So there is no allocation failure, but you get I/O errors later?
> 
> Right.
> 
> >
> > Does the device use a device-private CMA area?
> 
> Not sure.
> My driver is drivers/mmc/host/sdhci-cadence.c
> It reuses routines in drivers/mmc/host/sdhci.c
> 
> 
> 
> >  Does it work with Linux
> > 5.2 if CONFIG_DMA_CMA is disabled?
> 
> No.
> 5.2 + disable CONFIG_DMA_CMA
> failed in the same way.

So it seems like the device wants CMA memory.   I guess the patch
below will fix it, but that isn't the solution.  Can you try it
to confirm?  In the end it probably assumes a dma mask it doesn't
set that the CMA memory satisfies or something similar.

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 69cfb4345388..bd2f24aa7f19 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -236,7 +236,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 
 	if (dev && dev->cma_area)
 		cma = dev->cma_area;
-	else if (count > 1)
+	else
 		cma = dma_contiguous_default_area;
 
 	/* CMA can be used only in the context which permits sleeping */
