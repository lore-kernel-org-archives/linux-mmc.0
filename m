From: Simon Horman <horms@verge.net.au>
Subject: Re: mmc: sh_mobile_sdhi: DT update for R-Car
Date: Thu, 30 Jan 2014 15:43:59 +0900
Message-ID: <20140130064350.GA1449@verge.net.au>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
 <87y51yghc9.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y51yghc9.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 29, 2014 at 09:38:02PM -0800, Kuninori Morimoto wrote:
> 
> Hi Chris, Simon
> 
> > These patches updates code for R-Car.
> > Basically, these clarifies chip dependent settings
> > inside driver, and, removed unneeded settings from dtsi file.
> > These are based on latest linus/master branch
> > (ba635f8cd20ebc7bddf1eb8e1f4eae28a034e916)
> > 
> > Kuninori Morimoto (4):
> >       mmc: SDHI: tidyup sh_mobile_sdhi_of_match position
> >       mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7778
> >       mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7779
> >       mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7790
> > 
> >  arch/arm/boot/dts/r8a7778-bockw-reference.dts |    4 ++-
> >  arch/arm/boot/dts/r8a7778.dtsi                |    6 ----
> >  arch/arm/boot/dts/r8a7779.dtsi                |    8 -----
> >  arch/arm/boot/dts/r8a7790.dtsi                |    4 ---
> >  drivers/mmc/host/sh_mobile_sdhi.c             |   41 +++++++++++++++++--------
> >  5 files changed, 31 insertions(+), 32 deletions(-)
> 
> These patches modify both mmc driver and sh-arm.
> Should I separate these ?
> Or Chris can apply these with Simon's Ack ?
> 
> Basically, modify both files are the best way,
> but it is possible to separate

Hi Morimoto-san,

Previously I was somewhat ambivalent to this but experience has shown me
that taking shmobile patches through my tree is best. The reason is that it
reduces (eliminates?) merge conflicts. Conflicts that have to be resolved by
third parties, such as Linus. And we want to make the lives of those people
as easy as possible.

So please make sure that the patches are split up such that there are
patches for the driver and patches for shmobile.  Ideally post them in
separate series but if you prefer they can go in a single series. But
regardless please note that the driver patches are for the driver
maintainer to pick up and the shmobile patches are for me.

I hope this clarifies things for you.

Thanks
