From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: Linux v5.0-rc7: bcm2835 MMC issues
Date: Sat, 30 Mar 2019 16:53:00 +0200
Message-ID: <20190330145300.GI16484@darkstar.musicnaut.iki.fi>
References: <20190224150746.GC26495@darkstar.musicnaut.iki.fi>
 <155745885.93258.1551034990363@email.ionos.de>
 <20190226011509.GB31163@darkstar.musicnaut.iki.fi>
 <06528ceb-ff1d-626b-f520-477b0ea49d6f@i2se.com>
 <20190227185101.GA28051@darkstar.musicnaut.iki.fi>
 <1685719010.348465.1552129077871@email.ionos.de>
 <20190310005131.GF30189@darkstar.musicnaut.iki.fi>
 <20190328225818.GE16484@darkstar.musicnaut.iki.fi>
 <20190329191926.GG16484@darkstar.musicnaut.iki.fi>
 <1632685811.158736.1553951733181@email.ionos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1632685811.158736.1553951733181-uEpKuDZ350hmhno068Nerg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sat, Mar 30, 2019 at 02:15:33PM +0100, Stefan Wahren wrote:
> > > [ 1164.390902] 
> > > [ 1164.398302] ======================================================
> > > [ 1164.416501] WARNING: possible circular locking dependency detected
> > > [ 1164.434710] 5.1.0-rc2-rpi3-los_6ba38c+-00247-g9936328b41ce-dirty #1 Not tainted
> > > [ 1164.454495] ------------------------------------------------------
> > > [ 1164.472908] cc1plus/30873 is trying to acquire lock:
> > > [ 1164.489750] 0000000040a8ff57 (&mq->complete_lock){+.+.}, at: mmc_blk_mq_complete_prev_req.part.12+0x3c/0x220
> > > [ 1164.518548] 
> > > [ 1164.518548] but task is already holding lock:
> > > [ 1164.541662] 0000000059d7e9bb (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part.19+0x0/0x40
> > > [ 1164.567105] 
> > > [ 1164.567105] which lock already depends on the new lock.
> > > [ 1164.567105] 
> > > [ 1164.595691] 
> > > [ 1164.595691] the existing dependency chain (in reverse order) is:
> > > [ 1164.616711] 
> > > [ 1164.616711] -> #2 (fs_reclaim){+.+.}:
> > > [ 1164.630507]        lock_acquire+0xe8/0x250
> > > [ 1164.638922]        fs_reclaim_acquire.part.19+0x34/0x40
> > > [ 1164.652170]        fs_reclaim_acquire+0x20/0x28
> > > [ 1164.665139]        __kmalloc+0x50/0x390
> > > [ 1164.673717]        bcm2835_dma_create_cb_chain+0x70/0x270
> >
> > I think the bug is that it's using GFP_KERNEL here.
> 
> Hm, i'm not sure about how to solve this properly. Can you try this,
> because i wasn't able to reproduce this:

Steps to reproduce:
- Enable LOCKDEP (Kernel hacking -> Lock debugging -> prove locking correctness)
- File system and swap on MMC
- Disable watchdog if it's running
- Create a process that eats all memory:

  perl -e ' $x = "foo"; while (1) { $x .= $x } '

The warning shows up almost instantly. Also beware, the system gets
totally stuck in a while, so it seems the deadlock actually happens
(if you enable CONFIG_DETECT_HUNG_TASK it shows MMC is stuck).

> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index ec8a291..54093ff 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -671,7 +671,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
>         d = bcm2835_dma_create_cb_chain(chan, direction, false,
>                                         info, extra,
>                                         frames, src, dst, 0, 0,
> -                                       GFP_KERNEL);
> +                                       GFP_NOWAIT);
>         if (!d)
>                 return NULL;

Yeah, that helps. I think bcm2835_dma_prep_dma_memcpy needs it as well,
so bcm2835_dma_create_cb_chain could just always use GFP_NOWAIT. 

A.
