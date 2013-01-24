From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: add barriers to IO operations
Date: Thu, 24 Jan 2013 12:52:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301241248530.7826@axis700.grange>
References: <Pine.LNX.4.64.1301231745130.26301@axis700.grange>
 <20130124111018.GC5724@linux-sh.org> <Pine.LNX.4.64.1301241219290.5625@axis700.grange>
 <20130124114205.GD5724@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130124114205.GD5724@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 24 Jan 2013, Paul Mundt wrote:

> On Thu, Jan 24, 2013 at 12:20:19PM +0100, Guennadi Liakhovetski wrote:
> > On Thu, 24 Jan 2013, Paul Mundt wrote:
> > 
> > > On Wed, Jan 23, 2013 at 05:46:18PM +0100, Guennadi Liakhovetski wrote:
> > > > Without barriers SDIO operations fail with runtime PM enabled.
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > > ---
> > > >  drivers/mmc/host/tmio_mmc.h |   14 ++++++++------
> > > >  1 files changed, 8 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > > > index d857f5c..ad1a1c6 100644
> > > > --- a/drivers/mmc/host/tmio_mmc.h
> > > > +++ b/drivers/mmc/host/tmio_mmc.h
> > > > @@ -159,19 +159,20 @@ int tmio_mmc_host_runtime_resume(struct device *dev);
> > > >  
> > > >  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
> > > >  {
> > > > -	return readw(host->ctl + (addr << host->bus_shift));
> > > > +	return ioread16(host->ctl + (addr << host->bus_shift));
> > > >  }
> > > >  
> > > >  static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
> > > >  		u16 *buf, int count)
> > > >  {
> > > > +	wmb();
> > > >  	readsw(host->ctl + (addr << host->bus_shift), buf, count);
> > > >  }
> > > >  
> > > Some reason to not use ioread16_rep() and friends?
> > 
> > Aren't they "raw," i.e. without barriers:
> > 
> > #define ioread16_rep(p,d,c)	__raw_readsw(p,d,c)
> 
> I wasn't talking about the barrier semantics, I meant for consistency, as
> you are converting to the ioread/write API for everything else.

Ok, I see. But the reason to replace readw() / writew() ops with io* was 
to add barriers, whereas this change wouldn't actually do any good. So, 
yeah, we could do that for consistency, but otherwise it wouldn't bring 
any more benefits and explicit barriers would have to be kept anyway.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
