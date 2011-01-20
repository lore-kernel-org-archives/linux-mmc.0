From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: SDHC Read Performance
Date: Thu, 20 Jan 2011 17:38:01 +0900
Message-ID: <20110120083801.GB13114@linux-sh.org>
References: <20110119000909.GA9412@verge.net.au> <AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com> <20110119080542.GE1960@verge.net.au> <20110120033020.GA32120@verge.net.au> <AANLkTi=fw1C0cj9U9=c0PxvOPHZtM66pDc+zpR9p=68c@mail.gmail.com> <20110120070738.GA32495@verge.net.au> <AANLkTi=159EcbXdahL+jzeuA5O7dBp=9b6N6y9BY466P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=159EcbXdahL+jzeuA5O7dBp=9b6N6y9BY466P@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 20, 2011 at 05:28:55PM +0900, Magnus Damm wrote:
> On Thu, Jan 20, 2011 at 4:07 PM, Simon Horman <horms@verge.net.au> wrote:
> > As we discussed (offline) yesterday, it ought to be possible
> > to change the frequency of the clock source. And in the case of
> > the mackerel this can probably be done without disturbing anything
> > else as there are per SHDI clock sources.
> 
> Uhm, this is not entirely correct. The sh7372 used by Mackerel is in
> this case similar to most older SH processors and shares a clock
> between all SDHI hardware blocks. This clock is also shared with a
> bunch of other peripherals, so we can't adjust it freely during
> runtime.
> 
> The sh73a0 processor has per-SDHI block clock control.
> 
Or at least the driver would need to have some logic for attempting to
make the change and being rejected by the clock framework for the shared
clock case. It should be pretty trivial to make this behaviour
configurable anyways, given that the driver is largely impervious to the
clock refcount otherwise.

If the blocks in question are optionally capable of driving their own
clocks and exposing a wider range of frequencies, then that's something
that should be looked in to as well. For older blocks we're likely not
going to have a lot of flexibility with regards to the clock source,
though.

> > I imagine it would be possible to manipulate the frequency
> > such that MMC can be run closer to 20Mhz than 12Mhz.
> >
> > However, I am unsure if this would improve performance in any way.
> 
> It most likely would. Perhaps it's worth adjusting the shared clock a
> bit to support 20MHz?
> 
"Most likely" isn't a constructive performance metric. It's worth trying
out, and if it helps then of course it makes sense to try and support.
It's not really worth going through and adding in additional complexity
in order to support every possible frequency just becase we can, however.

It would also be good to see what's going on with class 2 and 10 here,
given that we still aren't seeing expected class 10 numbers, regardless
of frequency.
