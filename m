From: Simon Horman <horms@verge.net.au>
Subject: Re: Possible regression in next-20150306 due to "mmc: tmio: Fix PIO
 mode with CONFIG_HIGHMEM"
Date: Wed, 11 Mar 2015 09:34:20 +0900
Message-ID: <20150311003419.GC6958@verge.net.au>
References: <20150307060915.GA24323@verge.net.au>
 <20150310072944.GA22869@verge.net.au>
 <CAMuHMdXGnCM_R0bg6+YUNynctqHpAgFqUdj2_visRU4pCLQ-6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXGnCM_R0bg6+YUNynctqHpAgFqUdj2_visRU4pCLQ-6g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: keita kobayashi <keita.kobayashi.ym@renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 10, 2015 at 11:27:29AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Mar 10, 2015 at 8:29 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Sat, Mar 07, 2015 at 03:09:20PM +0900, Simon Horman wrote:
> >> I have noticed what appears to be a regression in next-20150306.  Using
> >> shmobile_defconfig I am unable to boot the koelsch or lager boards to
> >> user-space. However, if I revert be7de0b8a90a0b06d ("mmc: tmio: Fix PIO
> 
> What happens exactly?

I am seeing a NULL pointer dereference which seems to be coming from
tmio_mmc_start_dma.

http://permalink.gmane.org/gmane.linux.ports.sh.devel/44533

Digging a little further it seems the problem is occurring at or around the
following code, where according to my calculations 1333c is the address
reported in the boot log:

static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
{
        struct scatterlist *sg = host->sg_ptr, *sg_tmp;
   13338:       e590501c        ldr     r5, [r0, #28]
        dma_cookie_t cookie;
        int ret, i;
        bool aligned = true, multiple = true;
        unsigned int align = (1 << host->pdata->alignment_shift) - 1;

        for_each_sg(sg, sg_tmp, host->sg_len, i) {
   1333c:       e3a0a000        mov     sl, #0
        struct dma_async_tx_descriptor *desc = NULL;
        struct dma_chan *chan = host->chan_rx;
        dma_cookie_t cookie;
        int ret, i;
        bool aligned = true, multiple = true;
        unsigned int align = (1 << host->pdata->alignment_shift) - 1;
   13340:       e5938020        ldr     r8, [r3, #32]


I wonder if host->sg_ptr is NULL.

The patch in question updates tmio_mmc_init_sg() and tmio_mmc_next_sg()
such that host->sg_ptr is no longer assigned by those functions. Perhaps
some further updates are required to handle the DMA case?

> >> mode with CONFIG_HIGHMEM") then all seems well.
> >
> > Apologies, I seem to have messed up the commit id.
> > It should be 5da0e63e268dc5120
> 
> I can't seem to reproduce this on koelsch. I tried next-20150306,
> renesas-drivers-2015-03-09-v4.0-rc3, and my local tree based on the latter.

After reading the above I noticed that I had a micro SD card present in
the relevant slot on my koelsch board. I have now checked that without that
card present the problem does not seem to manifiest.
