From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 5/5] SDIO: put active devices into 1-bit mode during suspend
Date: Wed, 10 Feb 2010 16:03:24 +0000
Message-ID: <4B72D8CC.9030605@csr.com>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>	<1265747366-6676-6-git-send-email-nico@fluxnic.net>	<4B7298EF.4070604@csr.com> <m38wb115nk.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:37651 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab0BJQDh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2010 11:03:37 -0500
Received: from rly30g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly30g.srv.mailcontrol.com (MailControl) with ESMTP id o1AG3al6028244
	for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2010 16:03:37 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly30g.srv.mailcontrol.com (MailControl) id o1AG3TVW027953
	for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2010 16:03:29 GMT
In-Reply-To: <m38wb115nk.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Chris Ball wrote:
> Hi David,
> 
>    > Why?  Is this for a specific card that doesn't support
>    > asynchronous card interrupts while in 4-bit mode?  If so, I'd
>    > suggest a card quirk for this and only switch modes for these
>    > cards.
> 
> (As a check that we're on the same page -- sdio_disable_wide() is only
> called if MMC_PM_KEEP_POWER is true, which means the system is going
> to be suspended but the card will remain externally powered without
> its clock.)
> 
> Under the circumstances above, it's a requirement of the SDIO spec
> that moving to 1-bit mode must happen before stopping the clock if
> the interrupt mechanism is to be used to wake the host, and the
> chipset we've been using (Via VX855) fails to generate a wakeup if
> the switch isn't made.  Do you have experience of another chipset
> that doesn't need the switch to 1-bit mode for a clockless wakeup?

I couldn't find anything in the SDIO specification (you know the section
number?).  Part A2 has a requirement that the controller be placed into
1-bit mode but this doesn't mean that the card has to be.

Maybe it's not really a big deal, a single command only costs a few 10s
of microseconds anyway.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
