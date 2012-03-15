From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: assume maintainership
Date: Thu, 15 Mar 2012 18:42:10 +0100
Message-ID: <CACRpkda3O1S4Y8atqYjYe8jY1s13XBa2xoDxJ99hAWQG=cQCtg@mail.gmail.com>
References: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com>
	<20120315173047.GB17243@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43345 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032048Ab2CORmL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:42:11 -0400
Received: by ghrr11 with SMTP id r11so3303583ghr.19
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 10:42:10 -0700 (PDT)
In-Reply-To: <20120315173047.GB17243@flint.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Pawel Moll <pawel.moll@arm.com>

On Thu, Mar 15, 2012 at 6:30 PM, Russell King <rmk@arm.linux.org.uk> wrote:

> Actually, I still want to be involved because I'm far from convinced with
> some of the patches coming from Ulf are correct for ARMs implementation.

OK fine with me.

> That's why I'm purposely not applying the MMCI patches in the patch system
> in a particularly fast manner - I want there to be a decent amount of
> testing between each set of patches.

I understand this. I will try to help out more then, I have
the following systems:

- ARM Integrator/CP (PL181!)
- ARM RealView PB1176 (PL180)
- U300 (PL180 derivate)
- U8500 (PL180 derivate)

For the next round of series from Ulf I'll be happy to stress
these a bit.

> For example, the next patch in the series to be applied is:
>
> "mmc: mmci: Decrease current consumption in suspend"
(...)
> As there's an interdependence between the various patches, I can't apply
> any of the later patches even if I wanted to without these "power saving"
> patches.

OK Ulf, can you reorder your patch queue pushing that patch
towards the end so Russell can (hopefully) apply the less
controversial stuff (like the SDIO fixes and so on)?

> So, it's not really unmaintained or orphaned...

OK, shall I propose a patch simply adding you as maintainer?

Yours,
Linus Walleij
