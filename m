From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: vub300: quieten "SET_CLOCK_SPEED" printk
Date: Fri, 20 May 2011 15:45:31 -0400
Message-ID: <1305920731-4077-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:51629 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186Ab1ETToG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 15:44:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Tony Olech <tony.olech@elandigitalsystems.com>

An average vub300 session with CONFIG_MMC_CLKGATE=y set prints repeated
lines in the form of:

[83083.620491] usb 1-1.4: SET_CLOCK_SPEED 48000kHz
[83083.629664] usb 1-1.4: SET_CLOCK_SPEED 0kHz

[root@xo ~]# dmesg | grep SET_CLOCK_SPEED | wc -l
203

So, change this from dev_info() to dev_dbg().  We still print a
dev_err() if the call actually fails.

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>
---
 drivers/mmc/host/vub300.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2273cca..cbb0330 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2005,8 +2005,8 @@ static void __set_clock_speed(struct vub300_mmc_host *vub300, u8 buf[8],
 		dev_err(&vub300->udev->dev, "SET_CLOCK_SPEED"
 			" %dkHz failed with retval=%d\n", kHzClock, retval);
 	} else {
-		dev_info(&vub300->udev->dev, "SET_CLOCK_SPEED"
-			 " %dkHz\n", kHzClock);
+		dev_dbg(&vub300->udev->dev, "SET_CLOCK_SPEED"
+			" %dkHz\n", kHzClock);
 	}
 }
 
-- 
1.7.0.1

