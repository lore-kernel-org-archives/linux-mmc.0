From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: outstanding TMIO MMC patches
Date: Thu, 6 Jan 2011 08:08:57 +0900
Message-ID: <20110105230857.GH23889@linux-sh.org>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange> <AANLkTi=NWFmskvAosK9fO65OGNLrqEY-_PdvKydyn=G2@mail.gmail.com> <20110105045347.GA23889@linux-sh.org> <20110105165757.GA7876@void.printf.net> <20110105173029.GG23889@linux-sh.org> <20110105185717.GA9016@void.printf.net> <4D24DFA8.3030201@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D24DFA8.3030201@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 05, 2011 at 10:16:24PM +0100, Arnd Hannemann wrote:
> Am 05.01.2011 19:57, schrieb Chris Ball:
> > Arnd, can I take just patches 1/2 from your six-part series, and have
> > you send the rest through the arch/ maintainers later?
> 
> Sure, should be no problem.
> Ah, just saw that you already pushed those two, thanks.
> 
> @Paul: 
> Maybe it would be best that you ACK those arch patches (if you think
> they are ok) and that they also go in via the mmc-next tree?
> Otherwise we would need to wait until mmc-next for .38 is merged in your trees,
> right?
> 
If Chris prefers they go through the architecture side then that's not a
problem either. I'll be doing at least 2 merges during the merge window,
and this stuff is just adding in platform data, so it doesn't really
matter when it gets rolled in. Optionally if the MMC tree doesn't rebase
I can just set up a topic branch that branches off of that, roll these
patches on top of that, and you can just test that directly.
