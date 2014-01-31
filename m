From: Simon Horman <horms@verge.net.au>
Subject: Re: mmc: sh_mobile_sdhi: DT update for R-Car
Date: Fri, 31 Jan 2014 09:16:23 +0900
Message-ID: <20140131001621.GG14663@verge.net.au>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
 <87y51yghc9.wl%kuninori.morimoto.gx@gmail.com>
 <20140130064350.GA1449@verge.net.au>
 <87vbx2gd6a.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87vbx2gd6a.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 29, 2014 at 11:08:00PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon, Chris
> 
> > Previously I was somewhat ambivalent to this but experience has shown me
> > that taking shmobile patches through my tree is best. The reason is that it
> > reduces (eliminates?) merge conflicts. Conflicts that have to be resolved by
> > third parties, such as Linus. And we want to make the lives of those people
> > as easy as possible.
> > 
> > So please make sure that the patches are split up such that there are
> > patches for the driver and patches for shmobile.  Ideally post them in
> > separate series but if you prefer they can go in a single series. But
> > regardless please note that the driver patches are for the driver
> > maintainer to pick up and the shmobile patches are for me.
> 
> Thank you !
> OK, I will do my best
> 
> I would like to get Chris's review
> before sending v2 patch if possible.

That is fine by me :)
