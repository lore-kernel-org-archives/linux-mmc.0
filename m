From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 05/29] regulator: use IS_ERR_OR_NULL() instead of
 open-coding
Date: Mon, 11 Jun 2012 13:38:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206111332310.29799@axis700.grange>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
 <20120503153239.GN3955@opensource.wolfsonmicro.com> <20120518085749.GE24355@linux-sh.org>
 <20120518150417.GA4039@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120518150417.GA4039@opensource.wolfsonmicro.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Mark

On Fri, 18 May 2012, Mark Brown wrote:

> On Fri, May 18, 2012 at 05:57:50PM +0900, Paul Mundt wrote:
> > On Thu, May 03, 2012 at 04:32:39PM +0100, Mark Brown wrote:
> > > On Thu, May 03, 2012 at 05:05:34PM +0200, Guennadi Liakhovetski wrote:
> 
> > > > -	if (regulator == NULL || IS_ERR(regulator))
> > > > +	if (IS_ERR_OR_NULL(regulator))
> 
> > > The bigger question here is why we're accepting NULL in the first place.
> 
> > I'm not sure about the regulator case, but it's been useful to support
> > passing NULL around in the clock framework case. There are plenty of
> > cases where a struct clk is optional and if we fail to find the clock we
> > just set clk to NULL and continue on without having to constantly check
> > the value of the clk pointer, which helps considerably when you consider
> > the number of clk_enable/disable() pairs some drivers have.
> 
> > Presumably the same applies for regulators?
> 
> This is checking the value of regulator_get(), NULL is a perfectly valid
> regulator value to get passed back.

Sorry, could you clarify, how it is valid? No, I'm not proposing to revive 
this patch, just curious, what exactly you meant by this. AFAICS NULL is 
never returned from regulator_get(). The value, that's returned by it is 
then directly dereferenced in other regulator API calls, for which you 
don't normally want a NULL. So, having a regulator pointer == NULL seems 
to be as valid to me as causing a BUG() is? :-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
