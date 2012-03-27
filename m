From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] mmc: sh_mmcif: mmc->f_max should be half of the bus
 clock
Date: Tue, 27 Mar 2012 10:43:51 +0900
Message-ID: <20120327014343.GA28782@verge.net.au>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
 <1332320549-28584-3-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1203241904150.19427@axis700.grange>
 <20120325223033.GA6860@verge.net.au>
 <4F70027A.9020203@renesas.com>
 <20120326055256.GE2347@verge.net.au>
 <CANqRtoSrg5Niezq5tLA+a3j9PUoTGoBUBtEBazjEKbCFXHhX1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56367 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab2C0Bnz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Mar 2012 21:43:55 -0400
Content-Disposition: inline
In-Reply-To: <CANqRtoSrg5Niezq5tLA+a3j9PUoTGoBUBtEBazjEKbCFXHhX1g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

On Mon, Mar 26, 2012 at 03:17:21PM +0900, Magnus Damm wrote:
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

Thanks, got it.

Do you have a feeling of if it it worth trying to start with a value close
to 400kHz or if it would be better to simplify the code? I can try and
measure the difference in start up time for particular hardware
combinations, but I'm not sure how far that will get us.
