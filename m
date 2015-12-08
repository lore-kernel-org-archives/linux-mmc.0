From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix regression with optional GPIOs
Date: Mon, 7 Dec 2015 16:32:13 -0800
Message-ID: <20151208003213.GU23396@atomide.com>
References: <1449528845-25189-1-git-send-email-tony@atomide.com>
 <CAPDyKFpxiOJJdh-nLXjxv3DYJnW3RAf_9aqMfds46=-oqPd5ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51423 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755578AbbLHAcR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Dec 2015 19:32:17 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpxiOJJdh-nLXjxv3DYJnW3RAf_9aqMfds46=-oqPd5ng@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>

* Ulf Hansson <ulf.hansson@linaro.org> [151207 16:20]:
> +Linus
> 
> On 7 December 2015 at 23:54, Tony Lindgren <tony@atomide.com> wrote:
> > Commit ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
> > changed the handling MMC power sequence so GPIOs no longer are optional.
> >
> > This broke SDIO WLAN at least for omap5 that can't yet use the reset GPIOs
> > with pwrseq_simple as a wait is needed after enabling the SDIO device.
> 
> Can you elaborate on this. Did it break omap5 or not? :-)

Yes it broke WLAN for omap5 that I just got fixed.. It only uses the clocks
art of the pwrseq currently because of the delay needed.

> Also, I am interested to know more about the waiting period you need.
> I assume that's because of the HW's characteristic?

At least TI wl12xx and Marvell 8787 need a delay after enabling the the WLAN.

> Why can't we have that being described in DT and then make
> pwrseq_simple *wait* if needed?

We can, but I'm thinking that we might be better off adding support for
regulators to pwrseq. Both TI wl12xx and Marvell 8787 get power from the
battery, and probably have an integrated regulator.

Also, the delay and the power up sequencey can be more complicated than what
we currently support. In the 8787 case, pdn pin needs to be asserted for 300ms
after power pins are stable and while reset is held high.

> > Let's fix the problem by allocating the GPIO values array during init
> > depending on the optional GPIOs found.
> 
> Certainly it shall be optional! I wonder how I could let that patch
> slip through, my bad!

OK good to hear :)

> Thanks for fixing this!

No problem, thanks,

Tony
