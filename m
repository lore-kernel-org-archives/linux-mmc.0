From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
Date: Mon, 26 Aug 2019 11:05:00 +0900
Message-ID: <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
 <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com> <20190825011025.GA23410@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190825011025.GA23410@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, vdumpa@nvidia.com, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thierry Reding <treding@nvidia.com>, Kees Cook <keescook@chromium.org>, iamjoonsoo.kim@lge.com, Wolfram Sang <wsa+renesas>
List-Id: linux-mmc@vger.kernel.org

Christoph,

On Sun, Aug 25, 2019 at 10:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 23, 2019 at 09:56:52PM +0900, Masahiro Yamada wrote:
> > + linux-mmc, Ulf Hansson, Adrian Hunter,
> >
> >
> > ADMA of SDHCI is not working
> > since bd2e75633c8012fc8a7431c82fda66237133bf7e
>
> Does it work for you with this commit:
>
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/90ae409f9eb3bcaf38688f9ec22375816053a08e


This is included in v5.3-rc6
so I tested it.

No, it did not fix the problem.


--
Best Regards
Masahiro Yamada
