From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [Bug 39822] SDHC cards no longer recognized on AT91 based board
Date: Sun, 29 Jan 2012 18:22:58 +0100
Message-ID: <20120129172258.GE705@game.jcrosoft.org>
References: <bug-39822-26132@https.bugzilla.kernel.org/>
 <201107282323.p6SNN9Jk026454@demeter1.kernel.org>
 <m28vridl10.fsf@bob.laptop.org>
 <4EA616E4.2060405@interlog.com>
 <4F2494C2.1070609@interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:59885 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752674Ab2A2VEX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jan 2012 16:04:23 -0500
Received: from mail617.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 38922FFCB06
	for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2012 18:28:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F2494C2.1070609@interlog.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Gilbert <dgilbert@interlog.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, ludovic.desroches@atmel.com, akpm@linux-foundation.org

On 19:37 Sat 28 Jan     , Douglas Gilbert wrote:
> On 11-10-24 09:54 PM, Douglas Gilbert wrote:
> >On 11-07-28 07:48 PM, Chris Ball wrote:
> >>Hi, thanks for the bug report. Adding linux-mmc@ and some atmel driver
> >>folks to CC.
> >>
> >>On Thu, Jul 28 2011, bugzilla-daemon@bugzilla.kernel.org wrote:
> >>>Prior to 3.0.0 the FoxG20 board (Atmel AT91SAM9G20) could boot and use
> >>>both micro SD and SDHC card to contain its root file system. With the
> >>>advent of the 3.0.0 kernel the micro SDHC card is unable to mount the
> >>>root file system.
> >>>
> >>>Comparing the relevant part of dmesg for 2.6.38.6 (and it worked on
> >>>2.6.39):
> >>>...
> >>>Waiting for root device /dev/mmcblk0p2...
> >>>mmc0: host does not support reading read-only switch. assuming write-enable.
> >>>at91_mci at91_mci: Timeout waiting end of packet
> >>>mmc0: new SDHC card at address 1234
> >>>mmcblk0: mmc0:1234 SA04G 3.67 GiB
> >>>mmcblk0: p1 p2 p3
> >>>...
> >>>
> >>>to the same dmesg section for 3.0.0 :
> >>>...
> >>>Waiting for root device /dev/mmcblk0p2...
> >>>mmc0: error -110 whilst initialising SD card
> >>>at91_mci at91_mci: Timeout waiting end of packet
> >>>mmc0: error -110 whilst initialising SD card
> >>>[no further progress]
> >>>
> >>>Non "HC" SD cards work as expected in 3.0.0
> >>
> >>If no-one on the CC list has any ideas, would you be interested in
> >>trying to bisect this change?
> >>
> >>Another possibility would be adding printks before all of the -ETIMEDOUT
> >>lines in core/* and host/at*, in order to see which one you're hitting
> >>(and therefore which operation is causing the initialization to fail).
> >>But a full bisection would be more conclusive.
> >
> >Still broken in lk 3.1.0, same errors in dmesg.
> 
> Still broken in lk 3.2.0, same errors in dmesg.
> 
> The solution (hack) up to lk 3.1.0 has been to take
> linux-2.6.38/drivers/mmc/core/sd.c file and overwrite
> the defective sd.c . That worked in lk 3.0.* and 3.1.* .
> In lk 3.2.0 the old sd.c no longer compiles but
> by adding "#include <linux/stat.h>" is does and thereafter
> that SDHC card can be read again.
> 
> My test system is a FoxG20 card which is based on the
> AT91SAM9G20 SOC. The card's BIOS can read the 4 GB
> microSD (HC) card in all cases; the problem is with
> SDHC cards and all drivers/mmc/core/sd.c from and
> including lk 3.0.0
can you test it on atmel_mci?

at91_mci is deprecated and will be drop soon

Best Regards,
J.
