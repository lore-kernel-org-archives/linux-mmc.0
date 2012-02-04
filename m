From: Chris Ball <cjb@laptop.org>
Subject: Re: "mmc_host mmc0: WARNING: IMR=0x00004040" on debug console
Date: Sat, 04 Feb 2012 17:54:36 -0500
Message-ID: <m2ipjm9plf.fsf@bob.laptop.org>
References: <1326989504.2687.3.camel@salbei.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35678 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815Ab2BDWy5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 17:54:57 -0500
In-Reply-To: <1326989504.2687.3.camel@salbei.fritz.box> (Thomas Bechtold's
	message of "Thu, 19 Jan 2012 17:11:44 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Bechtold <thomasbechtold@jpberlin.de>
Cc: linux-mmc@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi, adding some recent atmel-mci.c committers to the thread,

On Thu, Jan 19 2012, Thomas Bechtold wrote:
> i updated from kernel 2.6.35.3 (from kernel.org) to kernel 3.2.1 (from 
> kernel.org) on arm (at91stamp9G20) and have a MMC card which can be 
> completly disabled with a hardware switch. The mmc card is then used by 
> another processor without linux. That works very well.
> My question is, why i get always the message "mmc_host mmc0: WARNING: 
> IMR=0x00004040" after i removed the mmc card slot once. That's a new 
> behavior with 3.2.1. I had no message with 2.6.35.3.
> When the mmc slot returns to linux, the message stops and i get:
>
> mmc_host mmc0: WARNING: IMR=0x00004040
> mmc0: host does not support reading read-only switch. assuming write-enable.
> mmc0: new SD card at address b368
> mmcblk0: mmc0:b368 H1697 1.91 GiB
>   mmcblk0: unknown partition table
>
> That's fine.
>
> Should i just ignore the message (or simple patch 
> driver/mmc/host/atmel_mci.c)?

It would be good to leave the warning in for situations that we still
don't expect, and it looks like IMR=0x00004040 decodes to ATMCI_ENDTX
and ATMCI_TXBUFE, so you could try something like:

        if (iflags & ~(ATMCI_SDIOIRQA | ATMCI_SDIOIRQB)) {
                /* Interrupts with ENDTX and TXBUFE set are seen
                 * with at91stamp9G20 hardware when switching the
                 * processor that MMC is attached to, so don't warn
                 * if they are set. 
                 */
                if (iflags & ~(ATMCI_ENDTX | ATMCI_TXBUFE)) {
                        dev_warn(&slot->mmc->class_dev, "WARNING: IMR="
                                 "0x%08x\n", iflags);
                }
        }

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
