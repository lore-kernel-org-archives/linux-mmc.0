From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] mmc: move regulator handling to core
Date: Fri, 4 Dec 2009 12:58:05 +0100
Message-ID: <20091204115805.GS14091@buzzloop.caiaq.de>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
 <4B17CADB.1070406@nokia.com>
 <20091203192044.GJ14091@buzzloop.caiaq.de>
 <4B181BB4.1020800@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:35932 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbZLDL6G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2009 06:58:06 -0500
Content-Disposition: inline
In-Reply-To: <4B181BB4.1020800@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Pierre Ossman <pierre@ossman.eu>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Cliff Brake <cbrake@bec-systems.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "madhu.cr@ti.com >> Madhusudhan Chikkature" <madhu.cr@ti.com>

On Thu, Dec 03, 2009 at 10:12:36PM +0200, Adrian Hunter wrote:
> Daniel Mack wrote:
> >On Thu, Dec 03, 2009 at 04:27:39PM +0200, Adrian Hunter wrote:

> >>What about arch/arm/mach-omap2/mmc-twl4030.c ?
> >
> >Argh, missed that one. And this particular case doesn't fit to my
> >modifications. I don't know the code well ...  We would need to
> >have a struct mmc_host * in all the functions there calling
> >mmc_regulator_{set,get}_ocr. Any idea how to resolve that?
> >
> 
> Pass it down from the omap_hsmmc driver.

It's not that easy, unfortunately, because this code does not conform to
all the other mmc host drivers in tree.

I don't understand why things are done the way it is currently
implemented. Why isn't there a mmc_host for each slot, and why is a
regulator reference acquired for each slot, and not once for the whole
device?

Even with the default 'vcc' supply factored out to the mmc core, the
'vmmc_aux' regulator would still need some extra attention, but I would
also do that from the omap_hsmmc driver rather than in the plaform
support code.

Moving the regulator handling to the mmc core would require a major
cleanup to all this code, but I don't have such hardware to test my
modifications. Can anyone help here?

Thanks,
Daniel

