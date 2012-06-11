From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Mon, 11 Jun 2012 14:39:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206111321120.29799@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
 <Pine.LNX.4.64.1205251230540.13353@axis700.grange>
 <CAPDyKFrrxyk-JpLFge5+0xbYjJ=-24avWn8Optfg88-i006-Ng@mail.gmail.com>
 <1925406B-D680-40BB-890A-78447EEB4583@marvell.com> <4FC33362.4010806@intel.com>
 <20120528144317.GF4032@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54094 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab2FKMji (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jun 2012 08:39:38 -0400
In-Reply-To: <20120528144317.GF4032@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On Mon, 28 May 2012, Mark Brown wrote:

> On Mon, May 28, 2012 at 11:12:18AM +0300, Adrian Hunter wrote:
> > On 28/05/12 06:32, Philip Rakity wrote:
> 
> > > I have started looking at this area and I am rather confused.  It 
> > > seems to me two "dedicated" regulators are required.
> 
> > It probably pays not to assume too much about regulators.  For example:
> 
> > Sometimes vccq is always on, so there may be just 1 regulator for vcc.
> 
> Even if the supply is always on you can easily provide an always on
> regulator.  From the point of view of the consumer if there are two
> physical supplies needed it's much clearer and easier to just code that
> and deal with the fact that we might have no control over them
> externally, there's nothing device specific about that process.

Mark, I'm not sure I understand your above comment correctly. The 
function, that I add in this patch doesn't do much now, that we removed 
all the "smart" regulator capability checking and the automatic MMC flag 
assignment from it. But still it does something rather important: it fixes 
a standard name for MMC Vdd regulators and initialises the ocr-mask 
automatically, if a regulator has been found.

IIUC, to satisfy Philip's requirement for a second regulator it would 
suffice to just issue one more devm_regulator_get() and let the caller 
deal with any errors. Is this what you're suggesting or are you against 
adding the second regulator? We could of course also add it later, but 
that would change the function prototype (unless we add regulator pointers 
to struct mmc_host itself). Whith existing users such changes are a bit 
messy...

Thanks
Guennadi

> > wl12xx/SDIO is setup with a fake regulator that actually controls
> > the enable line.
> 
> Which enable line is this?  If it's not for the regulator why wouldn't
> other boards control this line?
> 
> > There is a case where power is supplied at a different voltage than
> > spec'ed i.e. commit 6e8201f57c9359c9c5dc8f9805c15a4392492a10
> 
> The commit message there is really unclear so it's very hard to
> understand what the commit is supposed to do...  for one thing it's not
> entirely obvious what the connection with fixed voltage regulators is or
> why there might be an intermittent issue.

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
