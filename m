From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 05/29] regulator: use IS_ERR_OR_NULL() instead of
 open-coding
Date: Fri, 18 May 2012 18:19:53 +0900
Message-ID: <20120518091953.GG24355@linux-sh.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
 <20120503153239.GN3955@opensource.wolfsonmicro.com>
 <20120518085749.GE24355@linux-sh.org>
 <Pine.LNX.4.64.1205181104360.23140@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1205181104360.23140@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, May 18, 2012 at 11:18:21AM +0200, Guennadi Liakhovetski wrote:
> On Fri, 18 May 2012, Paul Mundt wrote:
> 
> > On Thu, May 03, 2012 at 04:32:39PM +0100, Mark Brown wrote:
> > > On Thu, May 03, 2012 at 05:05:34PM +0200, Guennadi Liakhovetski wrote:
> > > 
> > > > -	if (regulator == NULL || IS_ERR(regulator))
> > > > +	if (IS_ERR_OR_NULL(regulator))
> > > 
> > > The bigger question here is why we're accepting NULL in the first place.
> > 
> > I'm not sure about the regulator case, but it's been useful to support
> > passing NULL around in the clock framework case. There are plenty of
> > cases where a struct clk is optional and if we fail to find the clock we
> > just set clk to NULL and continue on without having to constantly check
> > the value of the clk pointer, which helps considerably when you consider
> > the number of clk_enable/disable() pairs some drivers have.
> > 
> > Presumably the same applies for regulators?
> 
> Right, but you normally do something like
> 
> 	priv->regulator = regulator_get();
> 	...
> 	regulator_put(priv->regulator);
> 
> Since regulator_get() only returns either a valid pointer or an ERR_PTR() 
> value, priv->regulator won't be NULL. Doing something like
> 
> 	priv->regulator = regulator_get();
> 	if (IS_ERR(priv->regulator))
> 		priv->regulator = NULL;
> 
> would seem too weird to me.
> 
Perhaps, but that's precisely what we do for struct clk in the case where
it not existing is non-fatal.
