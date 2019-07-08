From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v7 5/5] mmc: queue: Use bigger segments if DMA MAP
	layer can merge the segments
Date: Mon, 8 Jul 2019 13:45:50 +0200
Message-ID: <CAPDyKFpuRzmZUK730FMnh0hf3WRFb9aA=o9ciNt2ei8n803vsQ@mail.gmail.com>
References: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1561020610-953-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190624062414.GD2989@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190624062414.GD2989-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-block <linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 24 Jun 2019 at 08:24, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>
> On Thu, Jun 20, 2019 at 05:50:10PM +0900, Yoshihiro Shimoda wrote:
> > When the max_segs of a mmc host is smaller than 512, the mmc
> > subsystem tries to use 512 segments if DMA MAP layer can merge
> > the segments, and then the mmc subsystem exposes such information
> > to the block layer by using blk_queue_can_use_dma_map_merging().
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/mmc/core/queue.c | 35 ++++++++++++++++++++++++++++++++---
> >  include/linux/mmc/host.h |  1 +
> >  2 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > index 92900a0..ab0ecc6 100644
> > --- a/drivers/mmc/core/queue.c
> > +++ b/drivers/mmc/core/queue.c
> > @@ -24,6 +24,8 @@
> >  #include "card.h"
> >  #include "host.h"
> >
> > +#define MMC_DMA_MAP_MERGE_SEGMENTS   512
> > +
> >  static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
> >  {
> >       /* Allow only 1 DCMD at a time */
> > @@ -196,6 +198,12 @@ static void mmc_queue_setup_discard(struct request_queue *q,
> >               blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
> >  }
> >
> > +static unsigned int mmc_get_max_segments(struct mmc_host *host)
> > +{
> > +     return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
> > +                                      host->max_segs;
>
> I personally don't like superflous use of ? : if an if would be more
> obvious:
>
>         if (host->can_dma_map_merge)
>                 return MMC_DMA_MAP_MERGE_SEGMENTS;
>         return host->max_segs;
>
> but that is really just a nitpick and for the mmc maintainer to decide.

I have no strong opinions, both formats are used in mmc code, so I am
fine as is.

>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kind regards
Uffe
