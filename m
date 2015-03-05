From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] tmio: mmc: replace sh_mobile_sdhi_info to
 tmio_mmc_data
Date: Thu, 5 Mar 2015 14:06:30 +0530
Message-ID: <20150305083630.GZ2613@intel.com>
References: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
 <20150224162312.GG5208@intel.com>
 <87wq2vc40g.wl%kuninori.morimoto.gx@renesas.com>
 <CAPDyKFqJ7bbfaQgYnhHerFbre9mPzj7i6QGPQZo54ukuHaD32g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqJ7bbfaQgYnhHerFbre9mPzj7i6QGPQZo54ukuHaD32g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 05, 2015 at 09:33:10AM +0100, Ulf Hansson wrote:
> On 5 March 2015 at 08:11, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >
> > Hi Ulf
> >
> >> > Hi Ulf, Vinod, Simon
> >> >
> >> > DMAEngine cleanup patches are accepted in v4.0-rc1
> >> >
> >> > As I mentioned in
> >> > http://thread.gmane.org/gmane.linux.ports.sh.devel/42669
> >> > these are last of sh_mobile_sdhi DMA patches.
> >> >
> >> > These patches uses tmio_mmc_data on platform,
> >> > and remove sh_mobile_sdhi
> >> >
> >> > These are based on
> >> >  - linus's v4.0-rc1
> >> >  - Vinod's dma/next (git://git.infradead.org/users/vkoul/slave-dma.git :: next)
> >> >
> >> > Vinod
> >> >
> >> > please let us know if it has stable tag or branch
No my next is not stable, I will rebase that.
I think you want to pick topic/sh, that is an immutable branch
Can you check that has all the patches you need for this?

> >> Please use topic/sh. I will not rebase that, my next would be rebased
> >> frequently...
> >
> > Please let me know if you want me to re-send these patches
> 
> I have no issues with the patches as such. Though, I wonder about the
> dependency here.
> 
> Does these patches depend on an immutable branch hosted from Vinod's tree?
>
> 
> Do you want me to take the patches through my mmc tree or just request
> an ack so Vinod can carry this?
Either ways is okay with me..

-- 
~Vinod

