From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: add quirk
 SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST
Date: Tue, 13 Oct 2015 16:09:46 +0200
Message-ID: <20151013140946.GE11227@odux.rfo.atmel.com>
References: <1442477780-30994-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFp1+d1ouaq-ftheDn+fT1ssHDwde2orAndUrMW0iyqqww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:25680 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbJMOJs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2015 10:09:48 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFp1+d1ouaq-ftheDn+fT1ssHDwde2orAndUrMW0iyqqww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On Thu, Oct 08, 2015 at 08:01:23PM +0200, Ulf Hansson wrote:
> +Russell
> 
> On 17 September 2015 at 10:16, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > The Atmel sdhci device needs a new quirk. sdhci_set_clock set the Clock
> > Control Register to 0 before computing the new value and writing it.
> > It disables the internal clock which causes a reset mecanism. If we
> > write the new value before this reset mecanism is done, it will prevent
> > the stabilisation of the internal clock, so a delay is needed. This
> > delay is about 2-3 cycles of the base clock. To be safe, a 1 ms delay is
> > used.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> > Hi Ulf,
> >
> > Can you take these patches as fixes? I thought it was better to introduce a
> > quirk instead of duplicating a part of the sdhci_set_clock function to
> > implement my own set_clock function.
> 
> Hi Ludovic,
> 
> Sorry for the delay!
> 
> I have been thinking of how to address patches for sdhci that adds
> more quirks/callbacks. To be honest, I am fed up with such patches as
> I think it keeps the development of sdhci going in the wrong
> direction.
> 
> Instead, I have been hoping for someone to have stab into turning
> sdhci into a library as Russell King pointed out several times as
> well.
> 
> Now, as my response too you had a big delay for these patches and
> because it's a fix intended for the rc, I am going to apply patch1 and
> patch2 anyway. Although, you and everybody else that contributes to
> the sdhci development, please consider this as the *last* time for
> adding quirks/callbacks, unless you have *very good* reasons.

Thanks Ulf, it seems it is my lucky day! I understand and share your
point of view about quirks but it was so easy to manage controller
issues with them...

Regards

Ludovic
