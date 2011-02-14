From: "Tardy, Pierre" <pierre.tardy@intel.com>
Subject: RE: [RFC} sdhci.c set_ios -- disable global interrupts and Question
 on Power Management
Date: Mon, 14 Feb 2011 18:41:47 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69935205E445@irsmsx501.ger.corp.intel.com>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
 <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
 <447896B1-8836-4DFE-A00D-D41C395C79FC@marvell.com>
 <B040EC60-E156-4863-A735-15876F835FA1@marvell.com>
 <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
 <E5D06E6B-BE70-4446-9F56-32982C119FC0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5459 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab1BNSlv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 13:41:51 -0500
In-Reply-To: <E5D06E6B-BE70-4446-9F56-32982C119FC0@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>, Pierre Tardy <tardyp@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Philip,
> > And, more important, you will do cond_resched while holding you
> > spinlock, which is *bad*.
> > What if the mmc stack will call you again from another thread? deadlock...

> Assumptions -- Please Confirm
> -------------------------------------------
No need to do assumptions, schedule while holding spinlocks is bad, your kernel will oops with something like:
BUG: scheduling while in atomic.


> >> @@ -1108,7 +1108,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
> >>         * can apply clock after applying power
> >>         */
> >>        if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
> >> -               mdelay(10);
> >> +               mmc_delay(10);
> > Do you need this quirk in your platform?
> 
> No
Then, you dont have any mdelay in your set_ios, and you are trying to optimize something that never happen.

Pierre

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

