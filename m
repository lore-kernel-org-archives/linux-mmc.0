From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH 1/2] MMC Agressive clocking framework v7
Date: Wed, 3 Nov 2010 14:18:39 +0100
Message-ID: <4CD1612F.10507@stericsson.com>
References: <1288541169-16054-1-git-send-email-linus.walleij@stericsson.com> <AANLkTims3RhKmPxxxL_T32DN96kSrEE415FE1320fbNO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:52097 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753073Ab0KCNTg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2010 09:19:36 -0400
In-Reply-To: <AANLkTims3RhKmPxxxL_T32DN96kSrEE415FE1320fbNO@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, Kyungmin Park <kmpark@infradead.org>, "arm-kernel@lists.infradead.org" <arm-kernel@lists.infradead.org>

Ohad Ben-Cohen wrote:

> Have you considered migrating this to runtime PM API ?
>
> Runtime PM core already provides most of the necessary plumbing:
> referred work, reference counting, tunable delay, active/suspended
> status, etc..

Doesn't it require a struct device* to be used?

I cannot use the host controller struct because that may be using
dev_pm_ops for some other scheme.

> It will also allow you to avoid overloading the set_ios() operation:
> once suspended, host controllers will receive an idle notification
> from runtime PM core. also CONFIG_MMC_CLKGATE will probably not be
> needed anymore (no API changes so everything should just work as
> before. only difference is that now hosts can start supporting  these
> runtime PM notifications).

Then you must mean that it should be implemented in each and every
driver instead, like it is today. We had a long discussion about
that already.

This means replicating the knowledge of the last card operation,
the 8 MCI cycles required for the timeout and the check
that the card is not sdio into every single driver instead of
moving it up in the core (as was Pierre Ossmans original
suggestion some two years ago or so).

Right now the way I see it the host driver can support
dev_pm_ops and simply call runtime_pm_put() when it recieves an
ios with clock frequency 0, so it's not like it contradicts
runtime PM.

The plumbing used in runtime PM is however very applicable to the
task, so if it could be made to work in a subsystem without any
struct device* anchor, it would be very reusable. Is this
feasible?

Yours,
Linus Walleij
