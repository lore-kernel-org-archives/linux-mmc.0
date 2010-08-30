From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: failure of block read wait for long time
Date: Tue, 31 Aug 2010 00:39:57 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B031584E884@dbde02.ent.ti.com>
References: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
 <20100827205954.GA27804@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60304 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab0H3TKQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 15:10:16 -0400
In-Reply-To: <20100827205954.GA27804@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>



> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Saturday, August 28, 2010 2:30 AM
> To: Ghorai, Sukumar
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Adrian Hunter
> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> 
> Hi,
> 
> On Tue, Jul 27, 2010 at 04:57:46PM +0530, Sukumar Ghorai wrote:
> >  multi-block read failure retries in single block read one by one. It
> continues
> >  retry of subsequent blocks, even after failure. Application will not be
> able
> >  to decode the interleave data (even if few single block read success).
> >  This patch fixes this problem by returning at the first failure instead
> of
> >  waiting for long duration.
> >
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> > ---
> >  drivers/mmc/card/block.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> > index cb9fbc8..cfb0827 100644
> > --- a/drivers/mmc/card/block.c
> > +++ b/drivers/mmc/card/block.c
> > @@ -419,7 +419,6 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
> struct request *req)
> >  				spin_lock_irq(&md->lock);
> >  				ret = __blk_end_request(req, -EIO,
> brq.data.blksz);
> >  				spin_unlock_irq(&md->lock);
> > -				continue;
> >  			}
> >  			goto cmd_err;
> >  		}
> > --
> 
> Sukumar/Adrian, any thoughts on a new version of this patch containing
> Adrian's retry-segments idea?
[Ghorai] I am checked and tested the suggestion from Adrian. But was thinking it's just reducing the retry by 1/4 time; mean -
1. Each segment is size of 4K. and multi-block-write failed move to next segment(4k);
2. i.e. original code it was retrying for each 512 bytes. Now it's retrying for 8*512 bytes. So retry reduce by 1/8 times.

So I will post the 2nd version as suggested by Adrian; but let's see others input.

> 
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
