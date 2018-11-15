From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 14/16] mmc: stop abusing the request
	queue_lock pointer
Date: Thu, 15 Nov 2018 10:03:10 +0100
Message-ID: <20181115090310.GB14284@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
	<20181114160219.28328-15-hch@lst.de>
	<CAPDyKFrEWQdOKHu2FeyzPvLCDrRa+QouG6OjEzf=JF1yxoTRgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrEWQdOKHu2FeyzPvLCDrRa+QouG6OjEzf=JF1yxoTRgw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
List-Help: <mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=subscribe>
Sender: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
Errors-To: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, linux-block <linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 14, 2018 at 06:56:41PM +0100, Ulf Hansson wrote:
> >         } else {
> > @@ -397,6 +397,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
> >         int ret;
> >
> >         mq->card = card;
> > +       mq->lock = lock;
> 
> Unless I am mistaken, it seems like the "lock" can also be removed as
> an in-parameter to mmc_init_queue() - and instead do the
> spin_lock_init() in here.
> 
> Moreover, that means we should drop the "lock" from the struct
> mmc_blk_data and instead move it to struct mmc_queue (rather than
> having a pointer to it.)

Which sounds like a sensible idead indeed, I'll look into it.
