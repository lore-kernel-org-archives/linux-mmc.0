From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Thu, 15 Jul 2010 13:25:52 -0700
Message-ID: <20100715132552.fcb5791b.akpm@linux-foundation.org>
References: <4C33DF98.10409@renesas.com>
	<20100708144626.2091f6c1.akpm@linux-foundation.org>
	<4C3BBE77.8080000@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50306 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934652Ab0GOU01 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jul 2010 16:26:27 -0400
In-Reply-To: <4C3BBE77.8080000@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Tue, 13 Jul 2010 10:16:39 +0900
Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:

> Hi Andrew
> 
> Thank you for your comment.
> 
> >>  #define ack_mmc_irqs(host, i) \
> >>  	do { \
> >> -		u32 mask;\
> >> -		mask  = sd_ctrl_read32((host), CTL_STATUS); \
> >> -		mask &= ~((i) & TMIO_MASK_IRQ); \
> >> -		sd_ctrl_write32((host), CTL_STATUS, mask); \
> >> +		sd_ctrl_write32((host), CTL_STATUS, ~(i)); \
> >>  	} while (0)
> > 
> > Can we have a better changelog please?
> > 
> > What was wrong with the old code?
> > 
> > How does the patch fix it?
> > 
> > What are the user-visible runtime effects of the bug?
> > 
> > (It looks like that was a pretty gross bug - how did it pass testing??)
> Example
>  - CMD53(Single block read / Received data size : 64Byte)
> 
>  1) Send CMD53
>  2) Receive "CMD53 response"
>  3) Call tmio_mmc_cmd_irq(host, status);
> -- original code ----------------------------------------------------
>  #define ack_mmc_irqs(host, i) \
> 	do { \
> 		u32 mask;\
> 		mask  = sd_ctrl_read32((host), CTL_STATUS); \
> 	< case 1 >
> 		mask &= ~((i) & TMIO_MASK_IRQ); \
> 	< case 2 >
> 		sd_ctrl_write32((host), CTL_STATUS, mask); \
> 	} while (0)
> ---------------------------------------------------------------------
> 
> TMIO_STAT_RXRDY status will be cleared by "sd_ctrl_write32((host), CTL_STATUS, mask);"
> if TMIO_STAT_RXRDY becomes effective between "< case 1 >" and "< case 2 >".
> 
> This causes the phenomenon that a TMIO_STAT_RXRDY interrupt does not occur.
> When received data are small, it rarely occurs.
> 

OK..

But with both this patch and "tmio_mmc-revise-limit-on-data-size.patch"
the changelogs fail to describe the impact of the bug upon our users. 
So when I sit here trying to work out whether the patches should be
applied to 2.6.35 and whether they should be backported into -stable, I
don't have enough information.

What are your thoughts on this?
