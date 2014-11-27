From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [RFC PATCH] mmc: sdhci: switch from programmable clock mode to
 divided one if needed
Date: Thu, 27 Nov 2014 14:39:45 +0100
Message-ID: <20141127133945.GA2714@ldesroches-Latitude-E6320>
References: <1412669495-5629-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFozT4v4XogoCZ=dbZVgUTzFMb5zKSqjTdQj8mJEErE=TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:40726 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaK0NjZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Nov 2014 08:39:25 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFozT4v4XogoCZ=dbZVgUTzFMb5zKSqjTdQj8mJEErE=TQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>

On Tue, Nov 04, 2014 at 09:06:07AM +0100, Ulf Hansson wrote:
> On 7 October 2014 10:11, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> > In programmable mode, if the clock frequency is too high, the divider
> > can be too small to meet the clock frequency requirement especially to
> > init the SD card. In this case, switch to the divided clock mode.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >
> > Hi all,
> >
> > I would like to know if this patch can be accepted. Use case, I have a base
> > clock at 12 MHz, M is 40. So in programmable mode, using the greater divider,
> > minimum clock frequency will be higher than 400 KHz so it could cause issues to
> > init the card.
> >
> > Thanks for your feedback.
> >
> > Ludovic
> 
> It would be nice if some of the senior sdhci developers could help out
> review patches likes this.
> 
> It touches the core of sdhci, thus affecting many of the sdhci drivers.
> 
> Anybody?
> 

Ping, any feedback?

Regards

Ludovic

> Kind regards
> Uffe
> 
> >
> >  drivers/mmc/host/sdhci.c | 29 ++++++++++++++++++++---------
> >  1 file changed, 20 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index df0e7e1..70d4c18 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1126,6 +1126,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >         int real_div = div, clk_mul = 1;
> >         u16 clk = 0;
> >         unsigned long timeout;
> > +       bool switch_base_clk = false;
> >
> >         host->mmc->actual_clock = 0;
> >
> > @@ -1163,15 +1164,25 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >                                         <= clock)
> >                                         break;
> >                         }
> > -                       /*
> > -                        * Set Programmable Clock Mode in the Clock
> > -                        * Control register.
> > -                        */
> > -                       clk = SDHCI_PROG_CLOCK_MODE;
> > -                       real_div = div;
> > -                       clk_mul = host->clk_mul;
> > -                       div--;
> > -               } else {
> > +                       if ((host->max_clk * host->clk_mul / div) <= clock) {
> > +                               /*
> > +                                * Set Programmable Clock Mode in the Clock
> > +                                * Control register.
> > +                                */
> > +                               clk = SDHCI_PROG_CLOCK_MODE;
> > +                               real_div = div;
> > +                               clk_mul = host->clk_mul;
> > +                               div--;
> > +                       } else {
> > +                               /*
> > +                                * Divisor can be too small to reach clock
> > +                                * speed requirement. Then use the base clock.
> > +                                */
> > +                               switch_base_clk = true;
> > +                       }
> > +               }
> > +
> > +               if (!host->clk_mul || switch_base_clk) {
> >                         /* Version 3.00 divisors must be a multiple of 2. */
> >                         if (host->max_clk <= clock)
> >                                 div = 1;
> > --
> > 2.0.3
> >
