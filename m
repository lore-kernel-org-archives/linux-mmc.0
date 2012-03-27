From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] mmc: sh_mmcif: mmc->f_max should be half of the bus
 clock
Date: Tue, 27 Mar 2012 16:12:37 +0900
Message-ID: <20120327071233.GA23003@verge.net.au>
References: <20120325223033.GA6860@verge.net.au>
 <4F70027A.9020203@renesas.com>
 <20120326055256.GE2347@verge.net.au>
 <CANqRtoSrg5Niezq5tLA+a3j9PUoTGoBUBtEBazjEKbCFXHhX1g@mail.gmail.com>
 <20120327014343.GA28782@verge.net.au>
 <CANqRtoTtXSess2UQAj1K80xmSuubrK5gw+YkWnBiyNyiY5mQfQ@mail.gmail.com>
 <87limmybjo.fsf@laptop.org>
 <CANqRtoQ7z3YVujA0hmiZoubpD-3vK4kemXWWtVq6DH9Fe82tyA@mail.gmail.com>
 <20120327060127.GB21697@verge.net.au>
 <CANqRtoRE_gWqCOBxPKW39MRY=QPvhKQG6rVz=LreYt0BcP8FPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:35180 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab2C0HMm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 03:12:42 -0400
Content-Disposition: inline
In-Reply-To: <CANqRtoRE_gWqCOBxPKW39MRY=QPvhKQG6rVz=LreYt0BcP8FPg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

Hi Magnus,

On Tue, Mar 27, 2012 at 03:37:42PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Tue, Mar 27, 2012 at 3:01 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Mar 27, 2012 at 01:02:38PM +0900, Magnus Damm wrote:

[snip]

> >> Anyway, I was mainly wondering about the setup of the clocks in the
> >> driver for the MMC host hardware. I got the impression that f_min and
> >> f_max are supposed to be used to point out the minimum and maximum
> >> allowed frequencies that the hardware supports. On our SoCs this
> >> depends on the rate of the parent clock and the number of bits used
> >> for the MMC host hardware divider.
> >>
> >> So the parent clock rate may be rather high, and if it happens to be
> >> set too high on a board level then the MMC hardware block won't be
> >> able to program the frequencies as low as 400 kHz. So my point is only
> >> that we need to make sure that the parent clock rate is set in such a
> >> way that we can have some at least half-high clock frequency for
> >> decent general purpose throughput but if we try to increase the clock
> >> rate too much then we may force the lowest clock rate to go above 400
> >> kHz and then I suspect we may be out of spec. All this is based on
> >> that the parent clock is set statically to some frequency during boot
> >> by the SoC or board code.
> >
> > The current code assumes that the maximum divisor is 512.
> 
> That's good!
> 
> > This may lead to f_min being greater than 400Hz if the parent
> > clock is greater than 200MHz. It seems to me that empirically this
> > has not being occurring else the WARN_ON() in __mmc_set_clock() would
> > be activated. Though perhaps no one notices it.
> 
> Sure, 400 kHz * 512 = 204.8 MHz.
> 
> The reason why we don't hit WARN_ON() may be that mmc_power_up()
> blindly sets host->ios.clock to 400 kHz, 200 kHz and so on - this
> without checking against f_min.
> 
> > In any case, in the context of the current code it seems that changing
> > sh_mmcif_probe() to set f_min to host->clk / 512 will not alter the current
> > behaviour and will simplify the code.
> 
> Yep. It seems to me (only checked sh7372 data sheet) that f_min and
> f_max should be set like this:
> 
> f_min = parent_clk / 512
> f_max = parent_clk / 2
> 
> The real question is in my opinion is how to select a good parent
> clock rate, but that's sort of out of scope here.

Agreed on all counts. I will refresh my outstanding patch series
to set f_min accordingly, the series already sets f_max as you describe.
