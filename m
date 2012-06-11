From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Mon, 11 Jun 2012 13:03:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206111259190.29799@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
 <Pine.LNX.4.64.1205251230540.13353@axis700.grange>
 <20120528144502.GG4032@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59873 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab2FKLDn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jun 2012 07:03:43 -0400
In-Reply-To: <20120528144502.GG4032@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi Mark

On Mon, 28 May 2012, Mark Brown wrote:

> On Fri, May 25, 2012 at 05:14:52PM +0200, Guennadi Liakhovetski wrote:
> > Add a function to get a regulator, supplying card's Vdd on a specific host.
> > If such a regulator is found, the function checks, whether a valid OCR mask
> > can be obtained from this regulator.
> 
> Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks for the review!

> but
> 
> > +EXPORT_SYMBOL(mmc_regulator_get_vmmc);
> 
> regulator is all _GPL...

Yes, but existing mmc-regulator functions use EXPORT_SYMBOL(), e.g.,

EXPORT_SYMBOL(mmc_regulator_get_ocrmask);

which indeed seem to do the "old evil binary-only module trick": re-export 
functions, dropping the "_GPL" suffix. Looks like they should be fixed...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
