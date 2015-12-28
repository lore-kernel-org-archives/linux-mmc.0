From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix regression with optional GPIOs
Date: Mon, 28 Dec 2015 13:28:02 -0800
Message-ID: <20151228212802.GA6414@atomide.com>
References: <1449528845-25189-1-git-send-email-tony@atomide.com>
 <CAPDyKFpxiOJJdh-nLXjxv3DYJnW3RAf_9aqMfds46=-oqPd5ng@mail.gmail.com>
 <20151218161406.GL23396@atomide.com>
 <CAPDyKFr8e6wDxkGwnOwijQiOgF7oq6gCoHmqbubv6oSbpYbwqg@mail.gmail.com>
 <20151218223156.GP23396@atomide.com>
 <CAPDyKFpUWyZj99upK8Q_vNtwpZ67q3pD1229qG4yQ6+OmtCBUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52189 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbbL1V2G (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Dec 2015 16:28:06 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpUWyZj99upK8Q_vNtwpZ67q3pD1229qG4yQ6+OmtCBUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>

* Ulf Hansson <ulf.hansson@linaro.org> [151228 04:18]:
> On 18 December 2015 at 23:31, Tony Lindgren <tony@atomide.com> wrote:
> > * Ulf Hansson <ulf.hansson@linaro.org> [151218 14:20]:
> >> On 18 December 2015 at 17:14, Tony Lindgren <tony@atomide.com> wrote:
> >> > * Ulf Hansson <ulf.hansson@linaro.org> [151207 16:20]:
> >> >> +Linus
> >> >>
> >> >> On 7 December 2015 at 23:54, Tony Lindgren <tony@atomide.com> wrote:
> >> >> > Commit ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
> >> >> > changed the handling MMC power sequence so GPIOs no longer are optional.
> >> >> >
> >> >> > This broke SDIO WLAN at least for omap5 that can't yet use the reset GPIOs
> >> >> > with pwrseq_simple as a wait is needed after enabling the SDIO device.
> >> >>
> >> >> Can you elaborate on this. Did it break omap5 or not? :-)
> >> >
> >> > Ulf, is this patch queued for v4.4 as a regression fix? I don't see it
> >> > in Linux next or mainline trees?
> >>
> >> Ohh, I guess there where some misunderstanding. I made a bunch of
> >> comments on your patch as well, so I have been expecting a new
> >> version.
> >
> > Well this $subject patch was intended as a regression fix for v4.4-rc cycle.
> > All the other things discussed are not fixes but new features instead.
> >
> >> Sorry if that was unclear!
> >
> > I think this patch should be still fine as is, care to take a look again?
> 
> No, the patch have issues that needs to be fixed.
> http://www.spinics.net/lists/linux-mmc/msg34399.html

Oh sorry, somehow I did not notice those comments earlier, will take a look.

Tony
