From: Daniel Drake <dsd@laptop.org>
Subject: crash in mmc subsystem during suspend
Date: Fri, 20 Nov 2009 08:51:27 +0000
Message-ID: <1258707087.2235.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:4782 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbZKTIv0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2009 03:51:26 -0500
Received: by fg-out-1718.google.com with SMTP id d23so3172514fga.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2009 00:51:32 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

We're busy testing the suspend/resume functionality on the new OLPC
XO-1.5 laptop. This uses a SD card as its primary disk, which is on a
SDHCI controller on the VIA VX855 chipset. We are running Linux v2.6.31

We are occasionally encountering a crash from below mmc_rescan() during
suspend:

BUG: unable to handle kernel paging request at 6b6b6c57          
IP: [<b066d6e2>] sdio_remove_func+0x9/0x27
Call Trace:
[<b066cfb4>] ? mmc_sdio_remove+0x34/0x65                        
[<b066d1fc>] ? mmc_attach_sdio+0x217/0x240                      
[<b066a22f>] ? mmc_rescan+0x1a2/0x20f                           
[<b042e9a0>] ? worker_thread+0x156/0x1e1


This needs at least a few hundred suspend/resume cycles before it
reproduces, and often more than 2000.

Here is a log of the final couple of suspend/resumes and the crash:
http://dev.laptop.org/attachment/ticket/9707/p1_crash.log

and some of our diagnosis/discussion so far:
http://dev.laptop.org/ticket/9707

Does anyone have any theories on why this is happening?

Thanks,
Daniel


