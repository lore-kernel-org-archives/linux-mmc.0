From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [Q] mmc host cleanup sequence - how to prevent races
Date: Fri, 27 May 2011 18:45:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1105271755260.29976@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53229 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab1E0QpN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2011 12:45:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by axis700.grange (Postfix) with ESMTP id 9BD5B189B6B
	for <linux-mmc@vger.kernel.org>; Fri, 27 May 2011 18:45:11 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all

I am uncertain about the correct mmc host clean up order, namely what 
should happen first: interrupt handlers freed or mmc_remove_host() called?

First freeing interrupts doesn't seem to be a good idea. mmc_remove_host() 
can be waiting for interrupts, which then deadlocks. So, interrupts must 
be freed after mmc_remove_host(). But that creates a window, during which 
if an interrupt occurs, bad things can happen(TM). But normal MMC 
interrupts are not supposed to happen after mmc_remove_host() returns - no 
more requests will be flying. But there are two more kinds of interrupts, 
that still can happen in that window: hotplug and SDIO. To prevent 
hotplug, e.g., the sdhci driver, calls sdhci_disable_card_detection(). 
That helps against that race, but - what if we then miss a card eject 
between that call and mmc_remove_host()? Won't the core then try to 
communicate with a card, that's gone?

And then SDIO. We could do a similar thing - prohibit processing of SDIO 
interrupts before calling mmc_remove_host(). But could it be the case, 
that a higher level kernel driver is waiting for that SDIO interrupt, and 
then mmc_remove_host() will be waiting for that driver to release the card 
(if anything like that is happening in mmc?), and they will deadlock?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
