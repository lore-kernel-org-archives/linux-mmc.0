From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] sh: ecovec: switch MMC power control to regulator
Date: Tue, 24 Apr 2012 13:46:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204241342590.21239@axis700.grange>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
 <Pine.LNX.4.64.1204201850180.3974@axis700.grange>
 <20120420170744.GC3080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60684 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab2DXLqL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 07:46:11 -0400
In-Reply-To: <20120420170744.GC3080@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi

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

One more question in this respect: I see, that most other MMC drivers use 
"vmmc" as supply name. How important is it for all MMC drivers to use the 
same name? Shall I use it for MMCIF and TMIO-MMC too?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
