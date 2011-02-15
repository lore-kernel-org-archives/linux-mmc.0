From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC} sdhci.c set_ios -- disable global interrupts and
 Question on Power Management
Date: Tue, 15 Feb 2011 09:39:17 +0100
Message-ID: <20110215083917.GB3517@pengutronix.de>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
 <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
 <447896B1-8836-4DFE-A00D-D41C395C79FC@marvell.com>
 <B040EC60-E156-4863-A735-15876F835FA1@marvell.com>
 <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
 <E5D06E6B-BE70-4446-9F56-32982C119FC0@marvell.com>
 <8250E4885F9967469CAC3FB5CBA2CE69935205E445@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51590 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab1BOIjX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 03:39:23 -0500
Content-Disposition: inline
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69935205E445@irsmsx501.ger.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Tardy, Pierre" <pierre.tardy@intel.com>
Cc: Philip Rakity <prakity@marvell.com>, Pierre Tardy <tardyp@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Feb 14, 2011 at 06:41:47PM +0000, Tardy, Pierre wrote:
> Philip,
> > > And, more important, you will do cond_resched while holding you
> > > spinlock, which is *bad*.
> > > What if the mmc stack will call you again from another thread? deadlock...
> 
> > Assumptions -- Please Confirm
> > -------------------------------------------
> No need to do assumptions, schedule while holding spinlocks is bad, your kernel will oops with something like:
> BUG: scheduling while in atomic.

I thought the assumptions were made in order to check where the spinlock is
_really_ needed. Thinking in that direction is a good aproach IMO.

> > >> @@ -1108,7 +1108,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
> > >>         * can apply clock after applying power
> > >>         */
> > >>        if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
> > >> -               mdelay(10);
> > >> +               mmc_delay(10);
> > > Do you need this quirk in your platform?
> > 
> > No
> Then, you dont have any mdelay in your set_ios, and you are trying to optimize something that never happen.

There are some more mdelays in error-conditions which could happen occasionally
(see sdhci_send_command, spinlocked by sdhci_request for example).

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
