From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Thu, 26 Aug 2010 07:53:20 +0100
Message-ID: <20100826075320.0538043b@linux-g6p1.site>
References: <4C33DF98.10409@renesas.com>
	<20100708144626.2091f6c1.akpm@linux-foundation.org>
	<4C3BBE77.8080000@renesas.com>
	<20100715132552.fcb5791b.akpm@linux-foundation.org>
	<20100825231107.45227d6a@linux-g6p1.site>
	<20100825160722.9c9c38c8.akpm@linux-foundation.org>
	<4C75BB0D.2030202@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:51876 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752239Ab0HZGxW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 02:53:22 -0400
In-Reply-To: <4C75BB0D.2030202@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Ian Molton <ian@mnementh.co.uk>, Paul Mundt <lethal@linux-sh.org>

On Thu, 26 Aug 2010 09:53:33 +0900
Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:

> Hi Matt, Andrew
> 
> Andrew Morton wrote:
> > On Wed, 25 Aug 2010 23:11:07 +0100
> > Matt Fleming <matt@console-pimps.org> wrote:
> > 
> >> On Thu, 15 Jul 2010 13:25:52 -0700
> >> Andrew Morton <akpm@linux-foundation.org> wrote:
> >>
> >>> On Tue, 13 Jul 2010 10:16:39 +0900
> >>> Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:
> >>>
> >>>> Hi Andrew
> >>>>
> >>>> Thank you for your comment.
> >>>>
> >>>>>>  #define ack_mmc_irqs(host, i) \
> >>>>>>  	do { \
> >>>>>> -		u32 mask;\
> >>>>>> -		mask  = sd_ctrl_read32((host), CTL_STATUS); \
> >>>>>> -		mask &= ~((i) & TMIO_MASK_IRQ); \
> >>>>>> -		sd_ctrl_write32((host), CTL_STATUS, mask); \
> >>>>>> +		sd_ctrl_write32((host), CTL_STATUS, ~(i)); \
> >>>>>>  	} while (0)
> >>>>> Can we have a better changelog please?
> >>>>>
> >>>>> What was wrong with the old code?
> >>>>>
> >>>>> How does the patch fix it?
> >>>>>
> >>>>> What are the user-visible runtime effects of the bug?
> >>>>>
> >>>>> (It looks like that was a pretty gross bug - how did it pass testing??)
> >>>> Example
> >>>>  - CMD53(Single block read / Received data size : 64Byte)
> >>>>
> >>>>  1) Send CMD53
> >>>>  2) Receive "CMD53 response"
> >>>>  3) Call tmio_mmc_cmd_irq(host, status);
> >>>> -- original code ----------------------------------------------------
> >>>>  #define ack_mmc_irqs(host, i) \
> >>>> 	do { \
> >>>> 		u32 mask;\
> >>>> 		mask  = sd_ctrl_read32((host), CTL_STATUS); \
> >>>> 	< case 1 >
> >>>> 		mask &= ~((i) & TMIO_MASK_IRQ); \
> >>>> 	< case 2 >
> >>>> 		sd_ctrl_write32((host), CTL_STATUS, mask); \
> >>>> 	} while (0)
> >>>> ---------------------------------------------------------------------
> >>>>
> >>>> TMIO_STAT_RXRDY status will be cleared by "sd_ctrl_write32((host), CTL_STATUS, mask);"
> >>>> if TMIO_STAT_RXRDY becomes effective between "< case 1 >" and "< case 2 >".
> >>>>
> >>>> This causes the phenomenon that a TMIO_STAT_RXRDY interrupt does not occur.
> >>>> When received data are small, it rarely occurs.
> >>>>
> >>> OK..
> >>>
> >>> But with both this patch and "tmio_mmc-revise-limit-on-data-size.patch"
> >>> the changelogs fail to describe the impact of the bug upon our users. 
> >>> So when I sit here trying to work out whether the patches should be
> >>> applied to 2.6.35 and whether they should be backported into -stable, I
> >>> don't have enough information.
> >>>
> >>> What are your thoughts on this?
> >> Goda, do you have any more ideas on updating the changelog for this
> >> patch? It looks to me like this patch is a candidate for stable
> >> (whereas the "tmio_mmc-revise-limit-on-data-size.patch" is not, sorry
> >> about replying to that one first, I'm reading my mail backwards)
> >> because, without this patch, it's possible to miss interrupts because
> >> the ack_mmc_irqs() macro clears bit in the CTL_STATUS register that it
> >> should not do? Is that correct?
> >>
> >> If that is the case then would this be a more appropriate changelog,
> >>
> >> "tmio_mmc: Don't clear unhandled pending interrupts
> >>
> >> Previously, it was possible for ack_mmc_irqs() to clear pending
> >> interrupt bits in the CTL_STATUS register, even though the interrupt
> >> handler had not been called. This was because of a race that existed
> >> when doing a read-modify-write sequence on CTL_STATUS. After the
> >> read step in this sequence, if an interrupt occurred (causing one of the
> >> bits in CTL_STATUS to be set) the write step would inadvertently clear
> >> it.
> >>
> >> This patch eliminates this race by only writing to CTL_STATUS and
> >> clearing the interrupts that were passed as an argument to
> >> ack_mmc_irqs()."
> > 
> > hm, I seem to have secretly dropped this patch as well.
> > 
> > Oh well.  I restored it as
> > tmio_mmc-dont-clear-unhandled-pending-interrupts.patch and tagged it
> > for a -stable backport.  Unless I hear otherwise I'll send it in to
> > Linus when we return from Brazil a couple of weeks from now.
> 
> Thank you for your actions.
> I agree to new changelog.
> 
> In fact, I contributed the patch which changed changelog.
>  http://www.spinics.net/lists/linux-mmc/msg02623.html
>  http://www.spinics.net/lists/linux-mmc/msg02624.html
> However, these will not be necessary.

Oh, I missed these. Sorry!

Andrew, this bit of Goda's changelog is worth adding to
"tmio_mmc-dont-clear-unhandled-pending-interrupts.patch" 

"Observed with the TMIO_STAT_RXRDY bit together with CMD53
on AR6002 and BCM4318 SDIO cards in polled mode."
