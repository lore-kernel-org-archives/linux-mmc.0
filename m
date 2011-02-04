From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] tmio_mmc: Improve readability of the output of
 pr_debug_status()
Date: Sat, 5 Feb 2011 06:41:24 +0900
Message-ID: <20110204214124.GH21870@verge.net.au>
References: <1296808387-21935-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1102042028120.14717@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:37148 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab1BDVl2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Feb 2011 16:41:28 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1102042028120.14717@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>

On Fri, Feb 04, 2011 at 08:34:54PM +0100, Guennadi Liakhovetski wrote:
> On Fri, 4 Feb 2011, Simon Horman wrote:
> 
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  drivers/mmc/host/tmio_mmc.h |    6 +++++-
> >  1 files changed, 5 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > index 6f724de..811427d 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -237,12 +237,16 @@ static inline void tmio_mmc_kunmap_atomic(void *virt,
> >  
> >  #define STATUS_TO_TEXT(a) \
> >  	do { \
> > -		if (status & TMIO_STAT_##a) \
> > +		if (status & TMIO_STAT_##a) { \
> > +			if (i++) \
> > +				printk("|"); \
> >  			printk(#a); \
> > +		} \
> 
> Personally, I find it a bad idea to use variables in macros without 
> explicitly passing them in the parameter list. Yes, this macro is already 
> using "status" in that way, still, I don't think, that adding more such 
> variables is good. Why not make it STATUS_TO_TEXT(a, status, i) and also 
> add spaces for better yet readability like printk(" | ")?

Point taken, I will send v2 shortly.
Though the STATUS_TO_TEXT(a, status, i) change
does seem to make pr_debug_status() rather a lot noisier.

