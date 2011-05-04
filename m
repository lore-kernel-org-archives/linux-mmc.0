From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2] sdio: optimized SDIO IRQ handling for single irq
Date: Wed, 4 May 2011 16:22:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1105041618400.24613@xanadu.home>
References: <1304525161-14448-1-git-send-email-per.forlin@linaro.org> <1304525161-14448-2-git-send-email-per.forlin@linaro.org> <alpine.LFD.2.00.1105041217380.24613@xanadu.home> <BANLkTik+LWiYYPTqR5pNKsZfSMGGE3xCZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1710998774-1304540573=:24613"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58590 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab1EDUWz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2011 16:22:55 -0400
In-Reply-To: <BANLkTik+LWiYYPTqR5pNKsZfSMGGE3xCZg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, linaro-dev@lists.linaro.org, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1710998774-1304540573=:24613
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 4 May 2011, Per Forlin wrote:

> On 4 May 2011 19:34, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Wed, 4 May 2011, Per Forlin wrote:
> >
> >> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> >>
> >> If there is only 1 function registered it is possible to
> >> improve performance by directly calling the irq handler
> >> and avoiding the overhead of reading the CCCR registers.
> >>
> >> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> >> Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>
> >> ---
> >>  drivers/mmc/core/sdio_irq.c |   30 ++++++++++++++++++++++++++++++
> >>  include/linux/mmc/card.h    |    1 +
> >>  2 files changed, 31 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> >> index b300161..64c4409 100644
> >> --- a/drivers/mmc/core/sdio_irq.c
> >> +++ b/drivers/mmc/core/sdio_irq.c
> >> @@ -32,6 +32,16 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
> >>       int i, ret, count;
> >>       unsigned char pending;
> >>
> >> +     /*
> >> +      * Optimization, if there is only 1 function registered
> >> +      * call irq handler directly
> >> +      */
> >> +     if (card->sdio_single_irq && card->sdio_single_irq->irq_handler) {
> >> +             struct sdio_func *func = card->sdio_single_irq;
> >> +             func->irq_handler(func);
> >
> > I think there is little point using a func variable here, especially
> > since you already reference the handler pointer in the if() statement.
> > Hence:
> >
> >        if (card->sdio_single_irq && card->sdio_single_irq->irq_handler) {
> >                card->sdio_single_irq->irq_handler();
> >                return 1;
> >        }
> >
> What do you think about:
> +       struct sdio_func *func = card->sdio_single_irq;
> +
> +       /*
> +        * Optimization, if there is only 1 function interrupt registered
> +        * call irq handler directly
> +        */
> +       if (func) {
> +               func->irq_handler(func);
> +               return 1;
> +       }

Sure, but I'd move the assignment right before the if() in that case for 
clarity:

       struct sdio_func *func;

       /*
        * Optimization, if there is only 1 function interrupt registered
        * call irq handler directly
        */
       func = card->sdio_single_irq;
       if (func) {
               func->irq_handler(func);
               return 1;
       }
       [...]


Nicolas
--8323328-1710998774-1304540573=:24613--
