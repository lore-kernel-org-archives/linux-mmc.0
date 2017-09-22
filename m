From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 3/4] mmc-host: vub300: use setup_timer() helper.
Date: Fri, 22 Sep 2017 17:37:25 +0530
Message-ID: <1506082046-6878-4-git-send-email-allen.lkml@gmail.com>
References: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35974 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbdIVMHo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 08:07:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id f84so382993pfj.3
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 05:07:43 -0700 (PDT)
In-Reply-To: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: brucechang@via.com.tw, tony.olech@elandigitalsystems.com, pierre@ossman.eu, linux-mmc@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/mmc/host/vub300.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 8f569d2..c1a1698 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2323,13 +2323,11 @@ static int vub300_probe(struct usb_interface *interface,
 	INIT_WORK(&vub300->cmndwork, vub300_cmndwork_thread);
 	INIT_WORK(&vub300->deadwork, vub300_deadwork_thread);
 	kref_init(&vub300->kref);
-	init_timer(&vub300->sg_transfer_timer);
-	vub300->sg_transfer_timer.data = (unsigned long)vub300;
-	vub300->sg_transfer_timer.function = vub300_sg_timed_out;
+	setup_timer(&vub300->sg_transfer_timer, vub300_sg_timed_out,
+		    (unsigned long)vub300);
 	kref_get(&vub300->kref);
-	init_timer(&vub300->inactivity_timer);
-	vub300->inactivity_timer.data = (unsigned long)vub300;
-	vub300->inactivity_timer.function = vub300_inactivity_timer_expired;
+	setup_timer(&vub300->inactivity_timer,
+		    vub300_inactivity_timer_expired, (unsigned long)vub300);
 	vub300->inactivity_timer.expires = jiffies + HZ;
 	add_timer(&vub300->inactivity_timer);
 	if (vub300->card_present)
-- 
2.7.4

