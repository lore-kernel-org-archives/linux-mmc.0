From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH PoC 0/7] mmc: switch to blk-mq
Date: Thu, 29 Sep 2016 17:50:16 -0700
Message-ID: <CACRpkdZNh07A_g4E=CnNggYVa8Z2BTkhWezshszzbJdE0Rs7Dw@mail.gmail.com>
References: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 22, 2016 at 6:57 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> Since Linus Walleij is also working on that and I won't
> probably have time to touch this code till the end of
> upcoming month, here it is (basically a code dump of my
> proof-of-concept work).  I hope that it would be useful
> to somebody.
>
> It is extremely ugly & full of bogus debug code but boots
> fine on my Odroid-XU3 and benchmarks can be run.

Haha, it is still good discussion material.

FWIW your patchset is way more advanced than whatever I
cooked up, and the approach taken: first rip out async requests,
then adding a mq callback block and add async requests back
after adding a function to monitor if the queue is busy is a way
better approach.

I sat down with Ulf Hansson and Arnd Bergmann to discuss the
material and issues we face if/when migrating the MMC/SD code
to blk-mq.

Just for context to everyone: MMC/SD has an asynchronous
request handling that achieves a call all the way into the driver
to do some DMA mapping (flush) of SGlists with dma_map_sg()
before the hardware start processing the actual request. There
is a post_req() callback as well performing dma_unmap_sg().

This is mostly a non-issue on coherent memory architectures
like x86, but gives a nice performance boost on ARM (etc)
systems. In theory the callback could be used for other stuff
but all current drivers ultimately call
dma_map_sg()/dma_unmap_sg().

The interesting solution to achieve asynchronous requests,
a.k.a. double-buffering a.k.a. request pipelining is basically this
from the last patch:

-       mq->qdepth = 1;
+       mq->qdepth = 2;

So we claim that the hardware queue has a depth of two
requests but well... that is not really true. If we start confusing
concepts like this to get parallelism, what shall we set this
to when we exploit command queueing and actually have a
queue depth of say 64? that will result in a pile of hacks.

The proper solution would be to augment struct blk_mq_ops
vtable with a .pre_queue_rq() and .post_complete_rq() or
something.

The way I read the code the init_request() and exit_request()
callbacks cannot be used as they only deal with allocating the
struct and this seems to happen before the request is actually
filled in with the data (correct me if I don't understand this right!)
this seems to be confirmed by the presence of a .reinit_request()
callback. So we can't map/unmap the requests in these
callbacks.

We noted that this dma map/upmap optimization can also be
applicable for USB mass storage, so we get an optimization
from the MQ block layer that we can reuse in more than
MMC/SD.

After this we will still run into the same issue that you find after
this patchset: regressions in performance because of the
absence of an elevator/scheduler algorithm in blk-mq. So we
cannot really apply the patch set before or at the same time
as we're fixing that.

Apart from that we saw some really arcane things in the
MMC/SD core, mmc_claim_host() being the most obvious
example, as far as we can tell some kind of reimplementation of
mutex_trylock(). Some serious cleanup may be needed here.
It's nice that your first patch rips out the quirky kthread that
polls the block queue for new requests and send them down
to the mmc core, including picking out a few NULL requests
and flusing it's asynch work queue with that.

Yours,
Linus Walleij
