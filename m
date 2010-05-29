From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: mmc omap BUG in mmc_omap_start_request on boot
Date: Fri, 28 May 2010 18:36:42 -0700
Message-ID: <1275097002.9620.8.camel@runt.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58465 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab0E2Bgu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 May 2010 21:36:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

Hey all,

I've been playing with the latest Linus tree kernel trying to get MMC
working on my device (an HTC Herald), and I've come up against a
problem.

In the function mmc_omap_start_request in drivers/mmc/host/omap.c, line
1160, I'm finding that this bug:

    BUG_ON(irqs_disabled());

is triggering shortly after the MMC initializes on boot.  I hadn't had
this problem before, but it's been a while since I've worked with this,
and I don't know what could have changed to cause this.  If I comment
out that line, everything seems to run fine -- the mmc card comes up,
and I can boot from it perfectly.

I'm sure commenting it out isn't the right solution, but I don't know
the MMC subsystem well enough to understand why that function is called
while interrupts are disabled.

Can anyone point me in a direction that might allow me to resolve this?
Has anyone else had this problem recently?

For reference, this is on an HTC Herald (OMAP850-based OMAP1).

Thanks
Cory

