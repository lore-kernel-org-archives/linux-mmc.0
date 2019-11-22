From: Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: Add MMC host software queue support
Date: Fri, 22 Nov 2019 18:42:22 +0800
Message-ID: <CADBw62qW46KyEuj-YOw21sKxLB_uWxxWa_0-0JOXi-6Y48g0hw@mail.gmail.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com> <81d66ceaa2763cfc1e5ccb605bb3a4194b947f0d.1574073572.git.baolin.wang7@gmail.com>
 <CAK8P3a1bUt+HERWtGEKmhdD9ctX0GRQQbXHxtUnJ8KNu=v87aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1bUt+HERWtGEKmhdD9ctX0GRQQbXHxtUnJ8KNu=v87aw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>, Lyra Zhang <zhang.lyra@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paolo Valente <paolo.valente@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On Fri, Nov 22, 2019 at 6:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Nov 18, 2019 at 11:43 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > From: Baolin Wang <baolin.wang@linaro.org>
> >
> > Now the MMC read/write stack will always wait for previous request is
> > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > or queue a work to complete request, that will bring context switching
> > overhead, especially for high I/O per second rates, to affect the IO
> > performance.
> >
> > Thus this patch introduces MMC software queue interface based on the
> > hardware command queue engine's interfaces, which is similar with the
> > hardware command queue engine's idea, that can remove the context
> > switching. Moreover we set the default queue depth as 32 for software
> > queue, which allows more requests to be prepared, merged and inserted
> > into IO scheduler to improve performance, but we only allow 2 requests
> > in flight, that is enough to let the irq handler always trigger the
> > next request without a context switch, as well as avoiding a long latency.
> >
> > From the fio testing data in cover letter, we can see the software
> > queue can improve some performance with 4K block size, increasing
> > about 16% for random read, increasing about 90% for random write,
> > though no obvious improvement for sequential read and write.
> >
> > Moreover we can expand the software queue interface to support MMC
> > packed request or packed command in future.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>
> Overall, this looks like enough of a win that I think we should just
> use the current version for the moment, while still working on all the
> other improvements.
>
> My biggest concern is the naming of "software queue", which is
> a concept that runs against the idea of doing all the heavy lifting,
> in particular the queueing in bfq.
>
> Then again, it does not /actually/ do much queuing at all, beyond
> preparing a single request so it can fire it off early. Even with the
> packed command support added in, there is not really any queuing
> beyond what it has to do anyway.

Yes. But can not find any better name until now and 'software queue'
was suggested by Adrian.

>
> Using the infrastructure that was added for cqe seems like a good
> compromise, as this already has a way to hand down multiple
> requests to the hardware and is overall more modern than the
> existing support.
>
> I still think we should do all the other things I mentioned in my
> earlier reply today, but they can be done as add-ons:
>
> - remove all blocking calls from the queue_rq() function:
>   partition-change, retune, etc should become non-blocking
>   operations that return busy in the queue_rq function.
>
> - get bfq to send down multiple requests all the way into
>   the device driver, so we don't have to actually queue them
>   here at all to do packed commands
>
> - add packed command support
>
> - submit cmds from hardirq context if this is advantageous,
>   and move everything else in the irq handler into irqthread
>   context in order to remove all other workqueue and softirq
>   processing from the request processing path.
>
> If we can agree on this as the rough plan for the future,
> feel free to add my

Yes, I agree with your plan. Thast's what we should do in future.

>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your reviewing and good suggestion.

Ulf,

I am not sure if there is any chance to merge this patch set into
V5.5, I've tested for a long time and did not find any resession.
Thanks.
