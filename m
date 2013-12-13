From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4] mmc: tmio/SDHI fixup patches
Date: Fri, 13 Dec 2013 09:11:09 +0900
Message-ID: <20131213001104.GA32101@verge.net.au>
References: <87iovn8ohs.wl%kuninori.morimoto.gx@renesas.com>
 <87txee6dvk.fsf@octavius.laptop.org>
 <871u1ifpa8.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871u1ifpa8.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 12, 2013 at 12:26:42AM -0800, Kuninori Morimoto wrote:
> 
> Hi Chris, Simon
> 
> > > Now, our new board would like to use sh_mobile_sdhi driver,
> > > then, it is expecting sh_mobile_sdhi use regulator.
> > > But, this regulator is based on GPIO driver,
> > > and GPIO driver probe timing is after sh_mobile_sdhi.
> > > So, sh_mobile_sdhi (= tmio_mmc_pio) use default ocr_avail,
> > > and it doesn't work for us.
> > > #1 patch returns -EPROBE_DEFER in such case.
> > > it changes tmio_mmc_host_probe() behavior, but
> > > in my check, tmio_mmc_pio driver user is sh_mobile_sdhi/tmio-mmc only,
> > > and, current user has no conflict by this patch.
> > >
> > > sh_mobile_sdhi/tmio-mmc is very similar, but, have some difference.
> > > #2 - #4 cares such case.
> > >
> > > These were part of "SDHI support for r8a7790" patch set,
> > > but was separated
> > 
> > Sorry for the delay, I've pushed all four patches to mmc-next for
> > 3.14.  Thanks,
> 
> Chris
> Thank you for your hard work about this.
> 
> Simon
> Lager SDHI needs these patches.
> Can you use this branch ?
> If yes, I can re-send patches.

Hi Chris,

is it possible for you to provide a branch with stable git commit ids
that I can use as a base? I'm happy to use mmc-next if you think
it is appropriate.
