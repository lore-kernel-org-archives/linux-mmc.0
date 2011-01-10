From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile
 ARM
Date: Tue, 11 Jan 2011 07:41:34 +0900
Message-ID: <20110110224134.GA7420@verge.net.au>
References: <20110109124928.GC25591@verge.net.au>
 <1294589548.8897.1.camel@rojo>
 <20110109225042.GB29257@verge.net.au>
 <c1e9db480d82d1804930ddcc7bb0db02@rootnode.net>
 <20110110154514.GC3760@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110110154514.GC3760@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Pawel Moll <mail@pawelmoll.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 11, 2011 at 12:45:14AM +0900, Paul Mundt wrote:
> On Mon, Jan 10, 2011 at 10:10:19AM +0000, Pawel Moll wrote:
> > On Mon, 10 Jan 2011 07:50:42 +0900, Simon Horman <horms@verge.net.au> 
> > wrote:
> > >>>  Documentation/arm/SH-Mobile/Makefile              |    8 +
> > >>>  Documentation/arm/SH-Mobile/vrl4.c                |  169 
> > >>+++++++++++++++++++++
> > >>How about putting those two into "tools" (in particular "tools/arm")
> > >>instead of "Documentation"?
> > >>Just a thought... ;-)
> > >
> > >Thats fine by me except that tools/arm doesn't exist yet.
> > >It would be good to get some consensus before creating it.
> > 
> > I think there is consensus regarding "tools" as a place for user-space 
> > tools - eg. perf tools used to live in "Documentation/..." and then were 
> > moved to "tools/perf".
> > 
> > Now, whether your stuff should be in "tools/SH-Mobile" or 
> > "tools/arm/SH-Mobile", I have no opinion ;-)
> > 
> I agree that this is a worthwhile direction to move to, but we're a long
> way from a consensus. x86 has traditionally littered scripts/ and others
> have sunk to arch/<foo>/tools hostprogs abuse and so forth. perf is a bit
> of a special case in that it's fairly architecture agnostic. 

I would prefer to leave the code in Documentation/arm/SH-Mobile/ as
it complements the document that is in the same directory - weather
its more code or documentation is debatable IMHO.

I'm happy to move things later if a consensus is reached.

