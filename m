From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
Date: Wed, 28 Aug 2019 19:53:40 +0900
Message-ID: <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
 <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
 <20190825011025.GA23410@lst.de> <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
 <20190826073320.GA11712@lst.de> <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
 <20190827075021.GA953@lst.de> <CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
 <20190827115541.GB5921@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827115541.GB5921@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, vdumpa@nvidia.com, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thierry Reding <treding@nvidia.com>, Kees Cook <keescook@chromium.org>, iamjoonsoo.kim@lge.com, Wolfram Sang <wsa+renesas>
List-Id: linux-mmc@vger.kernel.org

Hi Christoph,

On Tue, Aug 27, 2019 at 8:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 27, 2019 at 06:03:14PM +0900, Masahiro Yamada wrote:
> > Yes, this makes my driver working again
> > when CONFIG_DMA_CMA=y.
> >
> >
> > If I apply the following, my driver gets back working
> > irrespective of CONFIG_DMA_CMA.
>
> That sounds a lot like the device simply isn't 64-bit DMA capable, and
> previously always got CMA allocations under the limit it actually
> supported.  I suggest that you submit this quirk to the mmc maintainers.


I tested v5.2 and my MMC host controller works with
dma_address that exceeds 32-bit physical address.

So, I believe my MMC device is 64-bit DMA capable.

I am still looking into the code
to find out what was changed.




--
Best Regards
Masahiro Yamada
