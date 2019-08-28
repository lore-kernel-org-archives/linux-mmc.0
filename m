From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
Date: Wed, 28 Aug 2019 21:23:43 +0900
Message-ID: <CAK7LNATvz=TTe+3OyLrtUqDuTUTn1dg9Sk-t3BD_OFZfViCPMw@mail.gmail.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
 <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
 <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
 <20190825011025.GA23410@lst.de>
 <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
 <20190826073320.GA11712@lst.de>
 <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
 <20190827075021.GA953@lst.de>
 <CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
 <20190827115541.GB5921@lst.de>
 <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Joerg Roedel <joro@8bytes.org>, Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Wolfram Sang <wsa+renesas@sang-engineering.com>, David Woodhouse <dwmw2@infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, iommu@lists.linux-foundation.org, iamjoo
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 28, 2019 at 7:53 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Christoph,
>
> On Tue, Aug 27, 2019 at 8:55 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Aug 27, 2019 at 06:03:14PM +0900, Masahiro Yamada wrote:
> > > Yes, this makes my driver working again
> > > when CONFIG_DMA_CMA=y.
> > >
> > >
> > > If I apply the following, my driver gets back working
> > > irrespective of CONFIG_DMA_CMA.
> >
> > That sounds a lot like the device simply isn't 64-bit DMA capable, and
> > previously always got CMA allocations under the limit it actually
> > supported.  I suggest that you submit this quirk to the mmc maintainers.
>
>
> I tested v5.2 and my MMC host controller works with
> dma_address that exceeds 32-bit physical address.
>
> So, I believe my MMC device is 64-bit DMA capable.
>
> I am still looking into the code
> to find out what was changed.


I retract this comment.

Prior to bd2e75633c8012fc8a7431c82fda66237133bf7e,
the descriptor table for ADMA is placed within the
32-bit phys address range, not exceeds the 32-bit limit.

Probably, my device is not 64-bit capable.

I will talk to the hardware engineer,
and check the hardware spec just in case.

Thanks.

-- 
Best Regards
Masahiro Yamada
