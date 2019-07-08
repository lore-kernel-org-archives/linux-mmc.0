From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: let the dma map ops handle bouncing
Date: Mon, 8 Jul 2019 13:55:48 +0200
Message-ID: <CAPDyKFotnDCpt9k-r3D2uYRAzpFVA3woRQENLcNcDY0q8+8SVg@mail.gmail.com>
References: <20190625092042.19320-1-hch@lst.de>
 <20190625092042.19320-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190625092042.19320-2-hch@lst.de>
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
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 25 Jun 2019 at 11:21, Christoph Hellwig <hch@lst.de> wrote:
>
> Just like we do for all other block drivers.  Especially as the limit
> imposed at the moment might be way to pessimistic for iommus.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>From your earlier reply, I decided to fold in the following
information to the changelog, as to clarify things a bit:

"This also means we are not going to set a bounce limit for the queue, in
case we have a dma mask. On most architectures it was never needed, the
major hold out was x86-32 with PAE, but that has been fixed by now."

Please tell, if you want me to change something.

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 3557d5c51141..e327f80ebe70 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -350,18 +350,15 @@ static const struct blk_mq_ops mmc_mq_ops = {
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
>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         blk_queue_max_segments(mq->queue, host->max_segs);
> --
> 2.20.1
>
