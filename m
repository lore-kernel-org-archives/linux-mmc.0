From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/12] treewide: Fix GENMASK misuses
Date: Wed, 10 Jul 2019 08:45:53 -0700
Message-ID: <b9c3b83c9be50286062ae8cefd5d38e2baa0fb22.camel@perches.com>
References: <cover.1562734889.git.joe@perches.com>
         <5fa1fa6998332642c49e2d5209193ffe2713f333.camel@sipsolutions.net>
         <20190710094337.wf2lftxzfjq2etro@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190710094337.wf2lftxzfjq2etro@shell.armlinux.org.uk>
Sender: netdev-owner@vger.kernel.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-wireless@vger.kernel.org, linux-media@vger.kernel.org, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 2019-07-10 at 10:43 +0100, Russell King - ARM Linux admin wrote:
> On Wed, Jul 10, 2019 at 11:17:31AM +0200, Johannes Berg wrote:
> > On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> > > These GENMASK uses are inverted argument order and the
> > > actual masks produced are incorrect.  Fix them.
> > > 
> > > Add checkpatch tests to help avoid more misuses too.
> > > 
> > > Joe Perches (12):
> > >   checkpatch: Add GENMASK tests
> > 
> > IMHO this doesn't make a lot of sense as a checkpatch test - just throw
> > in a BUILD_BUG_ON()?

I tried that.

It'd can't be done as it's used in declarations
and included in asm files and it uses the UL()
macro.

I also tried just making it do the right thing
whatever the argument order.

Oh well.

> My personal take on this is that GENMASK() is really not useful, it's
> just pure obfuscation and leads to exactly these kinds of mistakes.
> 
> Yes, I fully understand the argument that you can just specify the
> start and end bits, and it _in theory_ makes the code more readable.
> 
> However, the problem is when writing code.  GENMASK(a, b).  Is a the
> starting bit or ending bit?  Is b the number of bits?  It's confusing
> and causes mistakes resulting in incorrect code.  A BUILD_BUG_ON()
> can catch some of the cases, but not all of them.

It's a horrid little macro and I agree with Russell.

I also think if it existed at all it should have been
GENMASK(low, high) not GENMASK(high, low).

I
