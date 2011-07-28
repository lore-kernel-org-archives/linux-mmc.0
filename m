From: Chris Ball <cjb@laptop.org>
Subject: Re: [Bug 39822] SDHC cards no longer recognized on AT91 based board
Date: Thu, 28 Jul 2011 19:48:27 -0400
Message-ID: <m28vridl10.fsf@bob.laptop.org>
References: <bug-39822-26132@https.bugzilla.kernel.org/>
	<201107282323.p6SNN9Jk026454@demeter1.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38139 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213Ab1G1XtN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 19:49:13 -0400
In-Reply-To: <201107282323.p6SNN9Jk026454@demeter1.kernel.org>
	(bugzilla-daemon@bugzilla.kernel.org's message of "Thu, 28 Jul 2011
	23:23:09 GMT")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dgilbert@interlog.com
Cc: linux-mmc@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, ludovic.desroches@atmel.com, akpm@linux-foundation.org

Hi, thanks for the bug report.  Adding linux-mmc@ and some atmel driver
folks to CC.

On Thu, Jul 28 2011, bugzilla-daemon@bugzilla.kernel.org wrote:
> Prior to 3.0.0 the FoxG20 board (Atmel AT91SAM9G20) could boot and use
> both micro SD and SDHC card to contain its root file system. With the
> advent of the 3.0.0 kernel the micro SDHC card is unable to mount the
> root file system.
> 
> Comparing the relevant part of dmesg for 2.6.38.6 (and it worked on
> 2.6.39):
> ...
> Waiting for root device /dev/mmcblk0p2...
> mmc0: host does not support reading read-only switch. assuming write-enable.
> at91_mci at91_mci: Timeout waiting end of packet
> mmc0: new SDHC card at address 1234
> mmcblk0: mmc0:1234 SA04G 3.67 GiB
>  mmcblk0: p1 p2 p3
> ...
>
> to the same dmesg section for 3.0.0 :
> ...
> Waiting for root device /dev/mmcblk0p2...
> mmc0: error -110 whilst initialising SD card
> at91_mci at91_mci: Timeout waiting end of packet
> mmc0: error -110 whilst initialising SD card
> [no further progress]
>
> Non "HC" SD cards work as expected in 3.0.0

If no-one on the CC list has any ideas, would you be interested in
trying to bisect this change?

Another possibility would be adding printks before all of the -ETIMEDOUT
lines in core/* and host/at*, in order to see which one you're hitting
(and therefore which operation is causing the initialization to fail).
But a full bisection would be more conclusive.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
