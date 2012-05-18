From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 05/29] regulator: use IS_ERR_OR_NULL() instead of
 open-coding
Date: Fri, 18 May 2012 10:44:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205181041551.23140@axis700.grange>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
 <20120503153239.GN3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120503153239.GN3955@opensource.wolfsonmicro.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 3 May 2012, Mark Brown wrote:

> On Thu, May 03, 2012 at 05:05:34PM +0200, Guennadi Liakhovetski wrote:
> 
> > -	if (regulator == NULL || IS_ERR(regulator))
> > +	if (IS_ERR_OR_NULL(regulator))
> 
> The bigger question here is why we're accepting NULL in the first place.

No idea, you seem to be right - regulator_get() never returns NULL, so, it 
shouldn't be needed here. We could either remove this check altogether or 
change it to a BUG_OG().

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
