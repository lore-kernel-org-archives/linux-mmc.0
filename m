From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: TRIM timeout calculation
Date: Tue, 6 May 2014 09:17:26 +0200
Message-ID: <OF5C054324.0517D62C-ONC1257CD0.0025B7D9-C1257CD0.00280C60@transmode.se>
References: <OF5115E52C.11615B85-ONC1257CCF.005BB35E-C1257CCF.005CF8B5@transmode.se> <CAPDyKFo8ir0aKCE9HgEQj2jbNQVxSt2ENPdEshDpuuy7MYE6CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:55687 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934055AbaEFHR3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 May 2014 03:17:29 -0400
In-Reply-To: <CAPDyKFo8ir0aKCE9HgEQj2jbNQVxSt2ENPdEshDpuuy7MYE6CQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Ulf Hansson <ulf.hansson@linaro.org> wrote on 2014/05/05 22:50:39:
> 
> On 5 May 2014 18:55, Joakim Tjernlund <joakim.tjernlund@transmode.se> 
wrote:
> > I got a Micron eMMC 4.41 memory and I am trying to use the TRIM 
function.
> > my EXT_CSD_TRIM_MULT is 15 which gets me a tmo of 15*300=4500 ms
> > Then in  mmc_calc_max_discard() I have:
> >         max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
> >         if (mmc_can_trim(card)) {
> >                 max_trim = mmc_do_calc_max_discard(card, 
MMC_TRIM_ARG);
> >                 if (max_trim < max_discard)
> >                         max_discard = max_trim;
> >         } else if (max_discard < card->erase_size) {
> >                 max_discard = 0;
> >         }
> >         pr_debug("%s: calculated max. discard sectors %u for timeout 
%u
> > ms\n",
> >                  mmc_hostname(host), max_discard, 
host->max_busy_timeout);
> > Now  mmc_do_calc_max_discard(card, MMC_TRIM_ARG) returns 0 because the
> > initial trim
> > timeout is so high, 4500 ms:
> >   mmc0: calculated max. discard sectors 0 for timeout 2684 ms
> >
> > How is this supposed to work?
> 
> This piece of code in the mmc core/block layer is somewhat broken :-(

:) good to know. I got the impression that it is the eMMC tmo spec that
is broken. How can TRIM have 4.5 s tmo when ERASE is way, way below that?

> 
> For 3.15 we merged quite some patches to fixup the hardware busy
> detection mechanism supported by some host drivers/controllers.
> Trim/erase may utilize hardware busy detections, it's therefore I
> gives you this background.

I did browse the linus tree but I didn't really see this, but I am new to 
MMC
so I don't really know what to look for.

> 
> Now, those fixes did not mean any improvements immediately for
> erase/trim, but made some preparations for us to fix it. :-) I have it
> on the top of my mmc-TODO list - that's all I can give you sorry. :-)

Top of mmc TODO list is great( I hope you don't have several TODO lists :) 


> 
> Anyway, what host driver / controller are you using?

Freescale's esdhc driver/controller for P2040. This controller is
compliant to eMMC 4.2 but I don't think that should be a problem?
As far as I can tell a 4.2 controller should be able to drive a 4.5 eMMC
memory without loss of 4.5 functionality sans the new 4.5 speeds, do you 
agree?

> 
> Kind regards
> Ulf Hansson


