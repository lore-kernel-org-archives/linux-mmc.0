From: Chris Ball <cjb@laptop.org>
Subject: Re: outstanding TMIO MMC patches
Date: Wed, 5 Jan 2011 16:57:57 +0000
Message-ID: <20110105165757.GA7876@void.printf.net>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange> <AANLkTi=NWFmskvAosK9fO65OGNLrqEY-_PdvKydyn=G2@mail.gmail.com> <20110105045347.GA23889@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110105045347.GA23889@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jan 05, 2011 at 01:53:47PM +0900, Paul Mundt wrote:
> The MMC subsystem has been pretty much a disaster in terms of maintenance
> for as long as I can remember, so this is certainly not a new situation,
> but I had hoped that the situation had rather improved recently with at
> least some people stepping up and being a bit more active. For now, -mm
> is probably the only way for these to make any sort of forward progress,
> but it's a bit counter-intuitive to have to sideline an allegedly
> maintained subsystem in order for anything to happen at all.

Wow, how hostile -- insult first, ask questions later?  I do review and
merge MMC patches; all it takes is a ping to let me know that the tmio
maintainer is absent and that you'd like me to start picking these up.
I'd seen them being taken into other trees, and no-one's asked me about
merging any of them into the MMC tree before, so I didn't realize there
was a problem.  We just need more communication.

So, let's come up with a workflow.  With Ian absent, it would be good to
have someone with TMIO hardware (I don't have any) who's willing to help
test and review/ACK patches.  I don't generally like to take arch code
in through the MMC tree, so it would also be good to break up some of
the patchsets into MMC-only if possible.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
