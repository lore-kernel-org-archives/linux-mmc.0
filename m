From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/9] mmc: tmio: tmio_mmc_host has .dma
Date: Tue, 06 Jan 2015 14:24:50 +0100
Message-ID: <1850128.8f5cDzhtTH@wuerfel>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com> <7306460.62PqiTEhxi@wuerfel> <87vbkkvjw6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87vbkkvjw6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tuesday 06 January 2015 00:20:59 Kuninori Morimoto wrote:
> 
> Hi Arnd, Ulf
> 
> Thank you for your feedback
> 
> > > > The slave_id/chan_priv values are now passed three times into the
> > > > driver, and one should really be enough. I'd suggest removing the
> > > > integer fields from both tmio_mmc_dma and tmio_mmc_data (added in
> > > > patch 9), and instead pass it as a void* argument only to tmio_mmc_data.
> > > 
> > > Hmm. I guess this priv_?x and slave_id are based on filter ?
> > 
> > priv_?x needs to be in a format that matches the filter function,
> > passing slave_id is basically always wrong, but dmaengine drivers
> > generally just ignore it.
> (snip)
> > Maybe we can hide the slave_id field in dma_slave_config within
> > '#if defined(CONFIG_ARCH_SH_MOBILE) && defined(CONFIG_ATAGS)' then?
> > 
> > I would really like to prevent other people from copying the mistake.
> > Apparently it has already happened on MIPS jz4740, but that one seems
> > easy enough to fix. Tegra used to use slave_id as well, but it's been
> > converted to DT-only a while ago and that is just dead code for them.
> > 
> > I've had a closer look at the existing code now and came up with a
> > patch that should work for all out-of-tree drivers you may be worried
> > about.
> 
> I don't want to use #ifdef in driver :P
> OK, I understand your opinion. I can try fix this DMAEngine issue
> (without #ifdef :)

Ok, thanks. I have also posted a patch now for the jz4740 platform
that is the other user of slave_id.

> But, I want "step by step" for this cleanup.
> So, can you please accept about current "header cleanup" patch-set as 1st step ?

Fair enough.

> Then, I want to try "dmaengine cleanup" patch-set as 2nd step if possible.
> I guess [8/9] and [9/9] are not good for "header cleanup" (?) I don't know.
> Arnd, Ulf, what is your opinion ?

Patch 8 looks great to me.

Patch 9 as I mentioned is a bit strange because it duplicates the some
of the data between tmio_mmc_data and tmio_mmc_dma, which are both
visible to the tmio_mmc_dma.c file. Simply folding tmio_mmc_dma into
tmio_mmc_data seems like the simplest solution to that.

	Arnd
