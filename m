From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/5] SDIO: put active devices into 1-bit mode during suspend
Date: Wed, 10 Feb 2010 10:17:51 -0500
Message-ID: <m38wb115nk.fsf@pullcord.laptop.org>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
	<1265747366-6676-6-git-send-email-nico@fluxnic.net>
	<4B7298EF.4070604@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43808 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702Ab0BJP0J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Feb 2010 10:26:09 -0500
In-Reply-To: <4B7298EF.4070604@csr.com> (David Vrabel's message of "Wed, 10
	Feb 2010 11:30:55 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Hi David,

   > Why?  Is this for a specific card that doesn't support
   > asynchronous card interrupts while in 4-bit mode?  If so, I'd
   > suggest a card quirk for this and only switch modes for these
   > cards.

(As a check that we're on the same page -- sdio_disable_wide() is only
called if MMC_PM_KEEP_POWER is true, which means the system is going
to be suspended but the card will remain externally powered without
its clock.)

Under the circumstances above, it's a requirement of the SDIO spec
that moving to 1-bit mode must happen before stopping the clock if
the interrupt mechanism is to be used to wake the host, and the
chipset we've been using (Via VX855) fails to generate a wakeup if
the switch isn't made.  Do you have experience of another chipset
that doesn't need the switch to 1-bit mode for a clockless wakeup?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
