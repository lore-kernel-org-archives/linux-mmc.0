From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH 3/3] mmc: sd: Retry switching to highspeed mode in case of error
Date: Thu, 10 Sep 2015 00:33:18 +0800
Message-ID: <1441816398-4330-3-git-send-email-yszhou4tech@gmail.com>
References: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36470 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbbIIQhv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2015 12:37:51 -0400
Received: by padhk3 with SMTP id hk3so14880463pad.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2015 09:37:50 -0700 (PDT)
In-Reply-To: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, Yousong Zhou <yszhou4tech@gmail.com>

A SD card with sunxi-mmc can fail with the following error message (RCE for
response CRC error) when trying to switch to highspeed mode.  But the mode
switch can almost always succeed on the second try.

Dmesg before this commit.

    [    1.112060] mmc0: host does not support reading read-only switch, assuming write-enable
    [    1.126527] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 6, RD RCE !!
    [    1.132388] sunxi-mmc 1c0f000.mmc: data error, sending stop command
    [    1.139451] sunxi-mmc 1c0f000.mmc: send stop command failed
    [    1.145056] mmc0: error -110 whilst initialising SD card
    [    1.150424] ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
    [    1.156533] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 1, RTO !!

Dmesg after this commit.

    [    1.062306] mmc0: host does not support reading read-only switch, assuming write-enable
    [    1.070635] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 6, RD RCE !!
    [    1.295939] sunxi-mmc 1c0f000.mmc: data error, sending stop command
    [    1.322635] Waiting for root device /dev/mmcblk0p2...
    [    1.322691] sunxi-mmc 1c0f000.mmc: send stop command failed
    [    1.335686] mmc0: new high speed SD card at address 0002
    [    1.341557] mmcblk0: mmc0:0002 00000 974 MiB
    [    1.347021]  mmcblk0: p1 p2

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 drivers/mmc/core/sd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index e28ebf3..7465b16 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -364,7 +364,7 @@ int mmc_sd_switch_hs(struct mmc_card *card)
 		return -ENOMEM;
 	}
 
-	err = mmc_sd_switch(card, 1, 0, 1, status);
+	err = __mmc_sd_switch(card, 1, 0, 1, status, MMC_CMD_RETRIES);
 	if (err)
 		goto out;
 
-- 
1.7.10.4

