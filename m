From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] mmc: let the dma map ops handle bouncing
Date: Thu, 11 Apr 2019 16:34:30 +0200
Message-ID: <20190411143430.GA17371@lst.de>
References: <20190411070948.29564-1-hch@lst.de> <20190411070948.29564-2-hch@lst.de> <CAPDyKFqHrvz_5taNTx7k6Skx=Ox+9XgQHHz0LZyr4QNV9orvRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqHrvz_5taNTx7k6Skx=Ox+9XgQHHz0LZyr4QNV9orvRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Russell King <linux@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 11, 2019 at 11:00:56AM +0200, Ulf Hansson wrote:
> >         blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
> >         if (mmc_can_erase(card))
> >                 mmc_queue_setup_discard(mq->queue, card);
> >
> > -       blk_queue_bounce_limit(mq->queue, limit);
> > +       if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> > +               blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
> 
> So this means we are not going to set a bounce limit for the queue, in
> case we have a dma mask.
> 
> Why isn't that needed no more? Whats has changed?

On most architectures it was never needed, the major hold out was x86-32
with PAE.  In general the dma_mask tells the DMA API layer what is
supported, and if the physical addressing doesn't support that it has to
use bounce buffering like swiotlb (or dmabounce on arm32).  A couple
month ago I finally fixes x86-32 to also properly set up swiotlb,
and remove the block layerer bounce buffering that wasn't for highmem
(which is about having a kernel mapping, not addressing), and ISA DMA
(which is not handled like everything else, but we'll get there).
But for some reason I missed mmc back then, so mmc right now is the
only remaining user of address based block layer bouncing.
