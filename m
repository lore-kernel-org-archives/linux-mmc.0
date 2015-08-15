From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sh_mmcif: Silence DMA slave ID compile warnings on 64-bit
Date: Sat, 15 Aug 2015 22:26:39 +0200
Message-ID: <2503249.0HMJqMtNHP@wuerfel>
References: <1439297314-29118-1-git-send-email-geert+renesas@glider.be> <1539991.LpcThZV47z@wuerfel> <CAMuHMdWR0u9X36Dsw0QufmGO0phiY_w-tn1f-EmnL69FZ7NhMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWR0u9X36Dsw0QufmGO0phiY_w-tn1f-EmnL69FZ7NhMQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 12 August 2015 17:13:31 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Wed, Aug 12, 2015 at 4:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 11 August 2015 14:48:34 Geert Uytterhoeven wrote:
> >>         dma_cap_mask_t mask;
> >> @@ -413,12 +413,11 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
> >>         dma_cap_set(DMA_SLAVE, mask);
> >>
> >>         if (pdata)
> >> -               slave_data = direction == DMA_MEM_TO_DEV ?
> >> -                       (void *)pdata->slave_id_tx :
> >> -                       (void *)pdata->slave_id_rx;
> >> +               slave_id = direction == DMA_MEM_TO_DEV ?
> >> +                       pdata->slave_id_tx : pdata->slave_id_rx;
> >>
> >>         chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> >> -                               slave_data, dev,
> >> +                               (void *)(uintptr_t)slave_id, dev,
> >>                                 direction == DMA_MEM_TO_DEV ? "tx" : "rx");
> >>
> >>         dev_dbg(dev, "%s: %s: got channel %p\n", __func__,
> >
> > How about changing the type of the slave_id_rx/slave_id_tx fields
> > to void*? That way, the hack can be moved to arch/sh/boards/board-sh7757lcr.c,
> > which is now the only file passing data this way. Ideally, we'd also
> 
> And to the other SH boards... This is not limited to the mmcif driver.
> 
> Ah, I see tmio_mmc_data already does it this way.

I probably made a similar comment there, now I just did 'git grep slave_id_.x'

> This will break out-of-tree boards at compile-time though. Given the limited
> number of wired up DMA channels under arch/sh/, they may actually be
> more in use out-of-tree than in-tree?
> 
> Alternatively, perhaps we should just drop pdata DMA configuration from
> some drivers?

I think that would be helpful, but it would not work for this driver as
long as we keep arch/sh/boards/board-sh7757lcr.c in the kernel.

> > pass the shdma_chan_filter function pointer in pdata to avoid the link
> > time dependency on a particular dmaengine driver.
> 
> That's actually more tricky, as a NULL filter function means something
> completely different, and causes funny failures if the DTS lacks "dmas"
> properties, cfr. "dmaengine: shdma: Make dummy shdma_chan_filter() always
> return false".
> https://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/commit/?h=next&id=056f6c87028544de934f27caf95aa1545d585767

Ah, this is nasty, I had not thought of that case. This makes the entire
dma_request_slave_channel_compat() interface (which I never liked, fwiw)
dangerous to use, because a lot of other drivers will get the filter
function pointer from pdata already (any driver that works with more
than one dmaengine master has to).

I wonder if we should enforce this in __dma_request_slave_channel_compat()
by checking both the fn and fn_param arguments to ensure they are not
NULL before calling the legacy fallback using __dma_request_channel.

	Arnd
