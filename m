From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: outstanding ARM patches
Date: Mon, 16 Apr 2012 23:08:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204162303080.29915@axis700.grange>
References: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1204081328100.29005@axis700.grange>
 <Pine.LNX.4.64.1204131439000.16773@axis700.grange> <201204161824.03746.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201204161824.03746.rjw@sisk.pl>
Sender: linux-media-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 16 Apr 2012, Rafael J. Wysocki wrote:

> On Friday, April 13, 2012, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > Just confirming, that the 3 outstanding ARM patches, that I mentioned in 
> > recent emails:
> > 
> > http://article.gmane.org/gmane.linux.kernel.mmc/12748
> > http://article.gmane.org/gmane.linux.ports.sh.devel/13535
> > http://article.gmane.org/gmane.linux.ports.sh.devel/13975
> > 
> > still apply to the current Linus' tree, though, the former 2 with a fuzz, 
> > if needed, I can provide a version, that applies cleanly. Compile-tested.
> 
> Can you please repost them in one series on top of v3.2-rc3?

Sure, this is not really a series, but for your convenience I'll post them 
in reply to this mail. I'll also drop all recepients from the cc-list 
except linux-sh to not bother others.

Thanks
Guennadi

> Rafael
> 
>  
> > On Sun, 8 Apr 2012, Guennadi Liakhovetski wrote:
> > 
> > > On Wed, 14 Mar 2012, Guennadi Liakhovetski wrote:
> > > 
> > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > > ---
> > > > 
> > > > This patch we can push some time after the first one in this series gets 
> > > > in, no breakage is caused.
> > > 
> > > Patch 1/2 from this series is now in the mainline, so, also this patch can 
> > > be applied now. Not sure whether this qualifies as a fix (in the sense, 
> > > that the default maximum sizes of 2560x1920, used without this patch are 
> > > wrong for sh7372). Please, either push for 3.4 or queue for 3.5 
> > > accordingly.
> > ...
> > > >  arch/arm/mach-shmobile/board-ap4evb.c   |    2 ++
> > > >  arch/arm/mach-shmobile/board-mackerel.c |    2 ++
> > > >  2 files changed, 4 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> > > > index aab0a34..f67aa03 100644
> > > > --- a/arch/arm/mach-shmobile/board-ap4evb.c
> > > > +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> > > > @@ -1009,6 +1009,8 @@ static struct sh_mobile_ceu_companion csi2 = {
> > > >  
> > > >  static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
> > > >  	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
> > > > +	.max_width = 8188,
> > > > +	.max_height = 8188,
> > > >  	.csi2 = &csi2,
> > > >  };
> > > >  
> > > > diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> > > > index 9b42fbd..f790772 100644
> > > > --- a/arch/arm/mach-shmobile/board-mackerel.c
> > > > +++ b/arch/arm/mach-shmobile/board-mackerel.c
> > > > @@ -1270,6 +1270,8 @@ static void mackerel_camera_del(struct soc_camera_device *icd)
> > > >  
> > > >  static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
> > > >  	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
> > > > +	.max_width = 8188,
> > > > +	.max_height = 8188,
> > > >  };
> > > >  
> > > >  static struct resource ceu_resources[] = {
> > 
> > On Sun, 8 Apr 2012, Guennadi Liakhovetski wrote:
> > 
> > > Now that MMC patches from this series are in the mainline, also 
> > > architecture patches can and should be applied. These are patches 5 and 6 
> > > from this series:
> > > 
> > > http://article.gmane.org/gmane.linux.kernel.mmc/12748
> > > http://article.gmane.org/gmane.linux.ports.sh.devel/13535
> > > 
> > > Would be good to have them in 3.4 since they fix modular MMC builds on 
> > > ag5evm and mackerel.
> > 
> > ---
> > Guennadi Liakhovetski, Ph.D.
> > Freelance Open-Source Software Developer
> > http://www.open-technology.de/
> > 
> > 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
