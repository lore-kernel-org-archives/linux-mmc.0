From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC 5/5] sh: ecovec: switch MMC power control to regulator
Date: Fri, 20 Apr 2012 21:56:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204202155160.3974@axis700.grange>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
 <Pine.LNX.4.64.1204201850180.3974@axis700.grange>
 <20120420170744.GC3080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120420170744.GC3080@opensource.wolfsonmicro.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

(this patch should have been 5/5, as you have guessed:-))

On Fri, 20 Apr 2012, Mark Brown wrote:

> On Fri, Apr 20, 2012 at 06:59:41PM +0200, Guennadi Liakhovetski wrote:
> 
> > +static struct gpio_regulator_state mmcif_power_states[] = {
> > +	{ .value = 3300000, .gpios = 0 },
> > +};
> 
> It doesn't make much odds but if you've only got one voltage the fixed
> voltage regulator is a little more idiomatic here (there's some overlap
> as they've been evolving separately.  No harm in gpio-regulator though.

Indeed, that would have been even easier, thanks for the suggestion, Mark!

Regards
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
