From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: let the dma map ops handle bouncing
Date: Thu, 11 Apr 2019 11:00:56 +0200
Message-ID: <CAPDyKFqHrvz_5taNTx7k6Skx=Ox+9XgQHHz0LZyr4QNV9orvRw@mail.gmail.com>
References: <20190411070948.29564-1-hch@lst.de> <20190411070948.29564-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411070948.29564-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Christoph,

On Thu, 11 Apr 2019 at 09:10, Christoph Hellwig <hch@lst.de> wrote:
>
> Just like we do for all other block drivers.  Especially as the limit
> imposed at the moment might be way to pessimistic for iommus.

I would appreciate some information in the changelog, as it's quite
unclear of what this change really means.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mmc/core/queue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 7c364a9c4eeb..eb9c0692062c 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -354,18 +354,15 @@ static const struct blk_mq_ops mmc_mq_ops = {
>  static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> -       u64 limit = BLK_BOUNCE_HIGH;
>         unsigned block_size = 512;
>
> -       if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
> -               limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
> -
>         blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
>         blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
>         if (mmc_can_erase(card))
>                 mmc_queue_setup_discard(mq->queue, card);
>
> -       blk_queue_bounce_limit(mq->queue, limit);
> +       if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> +               blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);

So this means we are not going to set a bounce limit for the queue, in
case we have a dma mask.

Why isn't that needed no more? Whats has changed?

>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         blk_queue_max_segments(mq->queue, host->max_segs);
> --
> 2.20.1
>

Kind regards
Uffe
