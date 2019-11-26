From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
Date: Tue, 26 Nov 2019 10:54:01 +0100
Message-ID: <CAK8P3a27PLB_rXkxuyOuK_eKvSSi29fekebcwsoTRLSAOmRX+w@mail.gmail.com>
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com> <1C0831B6-CA26-4794-9686-E7384713C756@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1C0831B6-CA26-4794-9686-E7384713C756@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Valente <paolo.valente@linaro.org>
Cc: "(Exiting) Baolin Wang" <baolin.wang@linaro.org>, Baolin Wang <baolin.wang7@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>, Orson Zhai <orsonzhai@gmail.com>, Lyra Zhang <zhang.lyra@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>, linux-block <linux-block@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 26, 2019 at 8:41 AM Paolo Valente <paolo.valente@linaro.org> wrote:
> > Il giorno 22 nov 2019, alle ore 10:50, Arnd Bergmann <arnd@arndb.de> ha scritto:
> > On Mon, Nov 18, 2019 at 11:04 AM (Exiting) Baolin Wang <baolin.wang@linaro.org> wrote:
> > Paolo, can you comment on why this is currently done, or if it can
> > be changed? It seems to me that sending multiple requests at
> > once would also have a significant benefit on the per-request overhead
> > on NVMe devices with with bfq.
> >
>
> Hi,
> actually, "one request dispatched at a time" is not a peculiarity of
> bfq.  Any scheduler can provide only one request at a time, with the
> current blk-mq API for I/O schedulers.
>
> Yet, when it is time to refill an hardware queue, blk-mq pulls as many
> requests as it deems appropriate from the scheduler, by invoking the
> latter multiple times.  See blk_mq_do_dispatch_sched() in
> block/blk-mq-sched.c.
>
> I don't know where the glitch for MMC is with respect to this scheme.

Right, this is what is puzzling me as well: in both blk_mq_do_dispatch_sched()
and blk_mq_do_dispatch_ctx(), we seem to always take one request from
the scheduler and dispatch it to the device, regardless of the driver or
the scheduler, so there should only ever be one request in the local list.

Yet, both the blk_mq_dispatch_rq_list() function and the NVMe driver
appear to be written based on the idea that there are multiple entries
in this list. The one place that I see putting multiple requests on the
local list before dispatching them is the end of
blk_mq_sched_dispatch_requests():

        if (!list_empty(&rq_list)) {
              ...
                }
        } else if (has_sched_dispatch) {
                blk_mq_do_dispatch_sched(hctx);
        } else if (hctx->dispatch_busy) {
                /* dequeue request one by one from sw queue if queue is busy */
                blk_mq_do_dispatch_ctx(hctx);
        } else {
->             blk_mq_flush_busy_ctxs(hctx, &rq_list);        <----
                blk_mq_dispatch_rq_list(q, &rq_list, false);
        }

So as you said, if we use an elevator (has_sched_dispatch == true),
we only get one request, but without an elevator, we get into this
optimized path.

Could we perhaps change the ops.dispatch_request() function to pass
down the list as in https://paste.ubuntu.com/p/MfSRwKqFCs/ ?

      Arnd
