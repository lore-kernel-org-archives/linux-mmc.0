From: Ming Lei <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/7] blk-mq: Export blk_mq_hctx_has_pending() function
Date: Tue, 23 Jul 2019 11:31:04 +0800
Message-ID: <20190723033103.GA13829@ming.t460p>
References: <cover.1563782844.git.baolin.wang@linaro.org>
 <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
 <20190722141940.GA26528@ming.t460p>
 <CAMz4ku+R8OdAQ2S91Xe=V-nZL1Nu5g=_xpHqQCzNF6JeBHY3rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4ku+R8OdAQ2S91Xe=V-nZL1Nu5g=_xpHqQCzNF6JeBHY3rw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 23, 2019 at 11:12:57AM +0800, Baolin Wang wrote:
> Hi Ming,
> 
> On Mon, 22 Jul 2019 at 22:19, Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jul 22, 2019 at 09:09:36PM +0800, Baolin Wang wrote:
> > > Some SD/MMC host controllers can support packed command or packed request,
> > > that means we can package several requests to host controller at one time
> > > to improve performence. And this patch set will introduce MMC packed function
> > > to support this feature by following patches.
> > >
> > > To support MMC packed function, the MMC layer need to know if there are
> > > requests are pending now in hardware queue to help to combine requests
> > > as much as possible. If we know there are requests pending in hardware
> > > queue, then we should not package requests to host controller immediately,
> > > instead we should collect more requests into MMC packed queue to be packed
> > > to host controller with packed condition.
> > >
> > > Thus export this function for MMC packed function.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  block/blk-mq.c         |    3 ++-
> > >  include/linux/blk-mq.h |    1 +
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index b038ec6..5bd4ef9 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -63,12 +63,13 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
> > >   * Check if any of the ctx, dispatch list or elevator
> > >   * have pending work in this hardware queue.
> > >   */
> > > -static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> > > +bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> > >  {
> > >       return !list_empty_careful(&hctx->dispatch) ||
> > >               sbitmap_any_bit_set(&hctx->ctx_map) ||
> > >                       blk_mq_sched_has_work(hctx);
> > >  }
> > > +EXPORT_SYMBOL_GPL(blk_mq_hctx_has_pending);
> >
> > Just wondering why you don't use the 'last' field of 'struct blk_mq_queue_data',
> > which is passed to .queue_rq(), and supposed for implementing batch submission.
> 
> The 'last' field of 'struct blk_mq_queue_data' does not indicate the
> last request in the hardware queue, since we want to collect more
> requests from block layer as much as possible to be packed later.
> 
> And from blk_mq_do_dispatch_sched()--->blk_mq_dispatch_rq_list()--->
> queue_rq(), I always get 'bd.last = true', which is not useful to
> combine requests for MMC packed queue. Maybe I missed anything?

That is one flaw of current implementation, and we may improve it,
so other drivers(virtio-io, ...) can benefit from it too.


Thanks,
Ming
