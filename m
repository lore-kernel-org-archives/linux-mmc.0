From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Thu, 26 Aug 2010 23:30:23 +0100
Message-ID: <20100826223023.GB11300@console-pimps.org>
References: <20100715132552.fcb5791b.akpm@linux-foundation.org>
 <20100825231107.45227d6a@linux-g6p1.site>
 <20100825160722.9c9c38c8.akpm@linux-foundation.org>
 <4C75BB0D.2030202@renesas.com>
 <20100826075320.0538043b@linux-g6p1.site>
 <AANLkTim2_8UU62hnvSrPK94MgaM35K0PbppGe8yeW-bC@mail.gmail.com>
 <20100826072642.GB19339@console-pimps.org>
 <20100826141237.c31bc1ed.akpm@linux-foundation.org>
 <20100826221024.GA11300@console-pimps.org>
 <20100826151640.04d11be0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:40343 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752432Ab0HZWaZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 18:30:25 -0400
Content-Disposition: inline
In-Reply-To: <20100826151640.04d11be0.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Paul Mundt <lethal@linux-sh.org>

On Thu, Aug 26, 2010 at 03:16:40PM -0700, Andrew Morton wrote:
> On Thu, 26 Aug 2010 23:10:24 +0100
> Matt Fleming <matt@console-pimps.org> wrote:
> 
> > I've stuck my oar in and confused everybody now, it seems.
> 
> I've just unconfused myself my dropping the patch ;) Please send new
> one(s) when the dust has settled?

Sure thing.

> The only tmio_mmc patch in my tree at present is
> tmio_mmc-dont-clear-unhandled-pending-interrupts:
> 
> 
> 
> 
> From: Yusuke Goda <yusuke.goda.sx@renesas.com>
> 
> Previously, it was possible for ack_mmc_irqs() to clear pending interrupt
> bits in the CTL_STATUS register, even though the interrupt handler had not
> been called.  This was because of a race that existed when doing a
> read-modify-write sequence on CTL_STATUS.  After the read step in this
> sequence, if an interrupt occurred (causing one of the bits in CTL_STATUS
> to be set) the write step would inadvertently clear it.
> 
> This patch eliminates this race by only writing to CTL_STATUS and clearing
> the interrupts that were passed as an argument to ack_mmc_irqs()."
> 

Would you mind adding this snippet to the end of the changelog?

"Observed with the TMIO_STAT_RXRDY bit together with CMD53
on AR6002 and BCM4318 SDIO cards in polled mode."

And these tags,

     Acked-by: Magnus Damm <damm@opensource.se>"
     Tested-by: Arnd Hannemann <arnd@arndnet.de>"
     Acked-by: Ian Molton <ian@mnementh.co.uk>
