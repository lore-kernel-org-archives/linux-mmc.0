From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: move regulator handling to core
Date: Fri, 27 Aug 2010 20:03:06 +0100
Message-ID: <20100827190306.GB20407@void.printf.net>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Pierre Ossman <pierre@ossman.eu>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, Adrian Hunter <adrian.hunter@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Cliff Brake <cbrake@bec-systems.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Madhusudhan <madhu.cr@ti.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Daniel,

On Thu, Dec 03, 2009 at 01:46:30PM +0100, Daniel Mack wrote:
> At the moment, regulator operations are done from individual mmc host
> drivers. This is a problem because the regulators are not claimed
> exclusively but the mmc core enables and disables them according to the
> return value of regulator_is_enabled(). That can lead to a number of
> problems and warnings when regulators are shared among multiple
> consumers or if regulators are marked as 'always_on'.
> 
> Fix this by moving the some logic to the core, and put the regulator
> reference to the mmc_host struct and let it do its own supply state
> tracking so that the reference counting in the regulator won't get
> confused.

Looks like this patch got dropped because of the missing modifications
to arch/arm/mach-omap2/mmc-twl4030.c.  Are we still interested in the
patch otherwise, and can anyone help with that?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
