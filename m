From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] MMC: move regulator handling closer to core v2
Date: Sun, 5 Sep 2010 09:48:06 +0100
Message-ID: <20100905084806.GB24817@opensource.wolfsonmicro.com>
References: <1283268367-3525-1-git-send-email-linus.walleij@stericsson.com> <AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46526 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752693Ab0IEIsH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Sep 2010 04:48:07 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Sundar Iyer <sundar.iyer@stericsson.com>, Daniel Mack <daniel@caiaq.de>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Cliff Brake <cbrake@bec-systems.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 03, 2010 at 09:38:45PM +0200, Linus Walleij wrote:

> This has an Reveiwed-by from the regulator maintainer and
> seems to address all comments, noone is objection so Andrew
> can you pick it up?

Just to clarify, I'm only one of the regulator maintainers - Liam also
maintains the regulator API.
