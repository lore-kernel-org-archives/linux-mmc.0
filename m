From: Attila Kinali <attila@kinali.ch>
Subject: Re: mmc: mxs: DEADLOCK
Date: Thu, 12 Jul 2012 17:13:50 +0200
Message-ID: <20120712171350.011ee50f582c10f962ba1e48@kinali.ch>
References: <4FFC367A.8020100@bluegiga.com>
	<20120711060607.GE14060@S2101-09.ap.freescale.net>
	<20120712160008.03731746cdc5cf4bb0548256@kinali.ch>
	<20120712143950.GA16343@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.opencsw.org ([82.220.5.51]:34224 "EHLO mail.opencsw.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932679Ab2GLPNx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jul 2012 11:13:53 -0400
In-Reply-To: <20120712143950.GA16343@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Lauri Hintsala <lauri.hintsala@bluegiga.com>, Marek Vasut <marex@denx.de>, Koen Beel <koen.beel@barco.com>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 12 Jul 2012 22:39:53 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> > 
> > I ran into the same problem today, but the proposed fix doesn't seem
> > to work for me:
> > 
> It's a different problem from what Lauri reported and fixed.  

Ok... 

> I haven't
> played SDIO card that much, so I'm not completely clear about the SDIO
> calling sequence, but is it reasonable that mxs_mmc_enable_sdio_irq is
> being called recursively?

I don't know. I dont know the code at all and not how the sdio system
works. But a quick check shows, that mxs_mmc_enable_sdio_irq does not
call any other function (besides readel, writel) and hence cannot call itself.

For me it rather looks like that there seem to be two consequtive
irqs that get passed to sdio_irq_thread which then calls 
mxs_mmc_enable_sdio_irq.

But with my limited knowledge i cannot check this theory.
Can anyone give me some hints how i could verify this?

			Attila Kinali

-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
