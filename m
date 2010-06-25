From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] MMC: remove regulator refcount fiddling in mmc core
Date: Fri, 25 Jun 2010 12:22:32 +0100
Message-ID: <20100625112232.GA21217@opensource.wolfsonmicro.com>
References: <1277392337-27627-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54178 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753206Ab0FYLWe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Jun 2010 07:22:34 -0400
Content-Disposition: inline
In-Reply-To: <1277392337-27627-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Sundar Iyer <sundar.iyer@stericsson.com>, Bengt Jonsson <bengt.jonsson@stericsson.com>

On Thu, Jun 24, 2010 at 05:12:17PM +0200, Linus Walleij wrote:

> Currently the mmc_regulator_set_ocr() fiddles with the regulator
> refcount by selectively calling regulator_[enable|disable]
> depending on the state of the regulator. This will confuse the
> reference count if case the regulator is for example shared with
> other MMC slots or user for other stuff than the MMC card.

> Push regulator_[enable|disable] out into the MMC host drivers
> and remove this from the MMC core so the reference count can be
> trusted.

So, the feedback from folks at the time this was originally written was
that the MMC code was unable to cope with sharing regulators since it
really needs to be able to set specific voltages.  This needn't be a
showstopper since people can force a single voltage in the constraints
but it does need to be considered here.
