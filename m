From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] mmc: move regulator handling to core
Date: Sat, 12 Dec 2009 08:58:54 +0800
Message-ID: <20091212005854.GV28375@buzzloop.caiaq.de>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
 <4B17CADB.1070406@nokia.com>
 <20091203192044.GJ14091@buzzloop.caiaq.de>
 <4B181BB4.1020800@nokia.com>
 <20091204115805.GS14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:54021 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445AbZLLA6w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2009 19:58:52 -0500
Content-Disposition: inline
In-Reply-To: <20091204115805.GS14091@buzzloop.caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "madhu.cr@ti.com >> Madhusudhan Chikkature" <madhu.cr@ti.com>, Cliff Brake <cbrake@bec-systems.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Pierre Ossman <pierre@ossman.eu>, Robert Jarzmik <robert.jarzmik@free.fr>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, Dec 04, 2009 at 12:58:05PM +0100, Daniel Mack wrote:
> > >On Thu, Dec 03, 2009 at 04:27:39PM +0200, Adrian Hunter wrote:
> 
> > >>What about arch/arm/mach-omap2/mmc-twl4030.c ?
> > >
> > >Argh, missed that one. And this particular case doesn't fit to my
> > >modifications. I don't know the code well ...  We would need to
> > >have a struct mmc_host * in all the functions there calling
> > >mmc_regulator_{set,get}_ocr. Any idea how to resolve that?
> > >
> > 
> > Pass it down from the omap_hsmmc driver.
> 
> It's not that easy, unfortunately, because this code does not conform to
> all the other mmc host drivers in tree.
> 
> I don't understand why things are done the way it is currently
> implemented. Why isn't there a mmc_host for each slot, and why is a
> regulator reference acquired for each slot, and not once for the whole
> device?
> 
> Even with the default 'vcc' supply factored out to the mmc core, the
> 'vmmc_aux' regulator would still need some extra attention, but I would
> also do that from the omap_hsmmc driver rather than in the plaform
> support code.
> 
> Moving the regulator handling to the mmc core would require a major
> cleanup to all this code, but I don't have such hardware to test my
> modifications. Can anyone help here?

Can anyone of the OMAP people help sort this out?

Thanks,
Daniel
