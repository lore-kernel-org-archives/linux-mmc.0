From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mmc: move regulator handling to core
Date: Thu, 3 Dec 2009 15:09:55 +0000
Message-ID: <20091203150955.GA10297@rakim.wolfsonmicro.main>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
 <20091203130627.GA31254@rakim.wolfsonmicro.main>
 <20091203131423.GV14091@buzzloop.caiaq.de>
 <20091203132241.GB31533@rakim.wolfsonmicro.main>
 <20091203145825.GA26651@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756338AbZLCPJz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091203145825.GA26651@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Daniel Mack <daniel@caiaq.de>, Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Cliff Brake <cbrake@bec-systems.com>, Pierre Ossman <pierre@ossman.eu>, Liam Girdwood <lrg@slimlogic.co.uk>, Robert Jarzmik <robert.jarzmik@free.fr>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 03, 2009 at 02:58:25PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 03, 2009 at 01:22:41PM +0000, Mark Brown wrote:

> > without power control).  This goes back to the thing about using
> > regulator_get_exclusive(), the message given was that the MMC drivers
> > really needed to be able to guarantee that the power would be removed
> > when that was requested.

> If you take some cards through a series of steps and they stop responding,
> it's normally because you've caused their internal state machine to
> transition to "invalid" mode.

> Further commands are ignored.  The only recovery is to power cycle them.

I assume that this is something it's desirable to be able to do in the
face of poor hardware rather than something that the Linux MMC stack is
actively using in normal operation (modulo issues with the general
quality of implementation of MMC hardware)?
