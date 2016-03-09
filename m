From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix wakeup issue when using runtime
 pm
Date: Wed, 9 Mar 2016 17:38:09 +0100
Message-ID: <20160309163809.GM2690@odux.rfo.atmel.com>
References: <20160212120415.GJ14937@odux.rfo.atmel.com>
 <1455357400-32145-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFroVY0ZdqPScpGiJ8Y_QhhZ7asf0R0MzSx0WzVi5c2neg@mail.gmail.com>
 <20160216152204.GE2607@odux.rfo.atmel.com>
 <20160217103515.GM2607@odux.rfo.atmel.com>
 <CAPDyKFpovsOMVSxifefFcvHFoNL-AaBH_tbWbN7QRQqv2hrSnw@mail.gmail.com>
 <20160304134830.GG2690@odux.rfo.atmel.com>
 <CAPDyKFrDmWGiMF2fOt1kGyp03mRiTV2ug-i3mg=yYr5UF=WLeQ@mail.gmail.com>
 <CAPDyKFpDHooacBrTXQzinO4U10SeoedybN5HZ5y1bwbO-F04ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:2528 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbcCIQib (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2016 11:38:31 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpDHooacBrTXQzinO4U10SeoedybN5HZ5y1bwbO-F04ug@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org

+ PM mailing list since the discussion is mixing PM and sdhci

On Tue, Mar 08, 2016 at 10:56:31PM +0100, Ulf Hansson wrote:
> +Ludovic
> 
> On 8 March 2016 at 22:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 4 March 2016 at 14:48, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:

[snip]

> >>
> >> Coming back to the initial discussion and patch which were motivated by
> >> the fact that after runtime suspend I can't wake-up on card detect event,
> >> I have the feeling we don't have the same assumption about runtime PM.
> >>
> >> From what you and Adrian told me, I should not use runtime PM if I have
> >> no way to wake-up. In your minds, the way to wake-up is to use an
> >> externel GPIO because the controller will be 'totally' disabled, isn't it?
> >
> > I agree to the first part here.
> >
> > Although, as you also have the option to use polling for card detect,
> > this actually means you don't really *need* to have a wakeup
> > configured. Especially in the case where you don't have GPIO card
> > detect.
> >
> > In that way, *all* the clocks can gated in between the polling
> > attempts, thus you will save power even in the polling mode
> > configuration and when runtime PM is enabled.
> >

As you said, I can gate all the clocks but only between attempts.
Regularly, I will resume and suspend my controller to perform the card
detection. I don't know if it is a better solution than keeping one
clock enabled and waiting for an interrupt to enable the other ones.

> >>
> >> On my side, runtime PM allows me to save power when the sdhci controller
> >> is not used. If I can disable two clocks out of three, I should use
> >> runtime PM. Do you agree?
> >>
> >> If not, tell me how I can convince you :) Otherwise, next step is to rework
> >> my patch but I think I have no other solution that not calling
> >> sdhci_runtime_suspend_host if I expect to use the card detect irq of the
> >> controller.
> >
> > So, to summarize.
> >
> > I think the best fix is to add a clever check in ->probe() and then
> > enable polling when you can't rely on GPIO card detect IRQ.
> >
> > Moreover, to have a robust solution, you also need to clear
> > SDHCI_QUIRK_BROKEN_CARD_DETECTION for your sdhci variant, as otherwise
> > the "broken-cd" DT binding could wrongly be used for this variant.
> >
> > Does that make sense?


Well I don't agree totally because I have the feeling to use a
workaround because if sdhci_runtime_suspend_host has been called the
controlled is considered as 'disabled' then we won't deal with its IRQs.

I would like to move forward on this issue so it could be a trade-off.

Since the sdhci layer is going to be reworked, maybe it could be
interesting to have another approach of runtime PM to get more
flexibility.


Regards

Ludovic
