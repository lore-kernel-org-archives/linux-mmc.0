From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] mmc: move regulator handling to core
Date: Thu, 3 Dec 2009 14:43:24 +0100
Message-ID: <20091203134324.GB14091@buzzloop.caiaq.de>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
 <20091203130627.GA31254@rakim.wolfsonmicro.main>
 <20091203131423.GV14091@buzzloop.caiaq.de>
 <20091203132241.GB31533@rakim.wolfsonmicro.main>
 <20091203133200.GX14091@buzzloop.caiaq.de>
 <20091203134031.GA1311@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756081AbZLCNnY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091203134031.GA1311@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Pierre Ossman <pierre@ossman.eu>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, Adrian Hunter <adrian.hunter@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Cliff Brake <cbrake@bec-systems.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 03, 2009 at 01:40:32PM +0000, Mark Brown wrote:
> On Thu, Dec 03, 2009 at 02:32:00PM +0100, Daniel Mack wrote:

[...]

> > The mmci people would need to answer that. To me, the code just looked
> > like a power saving feature.
> 
> > If this driver needs it, the only tweak to my patch to let that
> > particular call site use regulator_get_exclusive, and the core will
> > still do the right thing. For this case, the behaviour should be exactly
> > the same than it currently is, correct?
> 
> No, you'll also need to update the way the driver bootstraps the
> reference count since with regulator_get_exclusive() the reference count
> is initialised to 1 if the regulator is enabled when it is claimed.

Ok, fine. It's still just the driver which would need amendment, not the
core. Thanks for explaining this.

Let's wait for the mmci maintainers to speak up on this particular
point.

Thanks,
Daniel
