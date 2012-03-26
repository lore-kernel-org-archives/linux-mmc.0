From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/2] mmc: sh_mmcif: mmc->f_max should be half of the bus
 clock
Date: Mon, 26 Mar 2012 09:04:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1203260855140.17487@axis700.grange>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
 <1332320549-28584-3-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1203241904150.19427@axis700.grange> <20120325223033.GA6860@verge.net.au>
 <4F70027A.9020203@renesas.com> <20120326055256.GE2347@verge.net.au>
 <CANqRtoSrg5Niezq5tLA+a3j9PUoTGoBUBtEBazjEKbCFXHhX1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59647 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733Ab2C0HRf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 03:17:35 -0400
In-Reply-To: <CANqRtoSrg5Niezq5tLA+a3j9PUoTGoBUBtEBazjEKbCFXHhX1g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

On Mon, 26 Mar 2012, Magnus Damm wrote:

> On Mon, Mar 26, 2012 at 2:52 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Mar 26, 2012 at 02:45:30PM +0900, Yusuke Goda wrote:
> >> Hi Simon-san, Guennadi-san
> >>
> >> (2012/03/26 7:30), Simon Horman wrote:
> >> > On Sat, Mar 24, 2012 at 07:06:31PM +0100, Guennadi Liakhovetski wrote:
> >> >> On Wed, 21 Mar 2012, Simon Horman wrote:
> >> >>
> >> >>> mmc->f_max should be half of the bus clock.
> >> >>> And now that mmc->f_max is not equal to the bus clock the
> >> >>> latter should be used directly to calculate mmc->f_min.
> >> >>
> >> >> The patch seems correct as it stands, however, looking at it - does anyone
> >> >> understands why that "close to 400kHz" comment and such a complicated
> >> >> calculation? Shouldn't it be just host->clk / 512 always? Maybe this
> >> >> should be a separate patch, so, for this one
> >> >>
> >> >> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >> >
> >> > Hi Guennadi,
> >> >
> >> > that code seems to date back to the original driver submission
> >> > made by Goda-san. I have CCed him as perhaps he recalls why
> >> > the code is like it is.
> >> I thought to get closer to 400kHz if possible.
> >> Probably even host->clk / 512 does not have any problem.
> >
> > Sorry for my ignorance, is ~400kHz desirable for some reason?
> 
> The 400kHz frequency is used during initialization of the SD card.
> Simply put, the SD frequency starts low out low and is then changed to
> something higher depending on the capability of the memory card and
> the host controller. Please have a look at the simplified SD
> specification for more details.

I see, so, we want something like

	shift = fls(host->clk / 400000 - 1);
	mmc->f_min = host->clk >> shift;

eventually with some rounding, depending on our preferences.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
