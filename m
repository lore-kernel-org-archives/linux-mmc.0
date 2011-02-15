From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 03/12] mmc: sd: query function modes for uhs cards
Date: Tue, 15 Feb 2011 15:05:01 +0530
Message-ID: <1297762510-2696-4-git-send-email-arindam.nath@amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54223 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab1BOJgo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 04:36:44 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so5731723iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 01:36:44 -0800 (PST)
In-Reply-To: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

SD cards which conform to Physical Layer Spec v3.01 can support
additional Bus Speed Modes, Driver Strength, and Current Limit
other than the default values. We use CMD6 mode 0 to read these
additional card functions. The values read here will be used during
UHS-I initialization steps.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c    |   99 +++++++++++++++++++++++++++++++++++++++-------
 include/linux/mmc/card.h |    3 +
 2 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index e968d5c..2a84396 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -283,25 +283,94 @@ static int mmc_read_switch(struct mmc_card *card)
 		return -ENOMEM;
 	}
 
-	err = mmc_sd_switch(card, 0, 0, 1, status);
-	if (err) {
-		/* If the host or the card can't do the switch,
-		 * fail more gracefully. */
-		if ((err != -EINVAL)
-		 && (err != -ENOSYS)
-		 && (err != -EFAULT))
+	if (card->scr.sda_spec3) {
+		/* First find out the supported Bus Speed Modes. */
+		err = mmc_sd_switch(card, 0, 0, 1, status);
+		if (err) {
+			/*
+			 * If the host or the card can't do the switch,
+			 * fail more gracefully.
+			 */
+			if ((err != -EINVAL)
+			&& (err != -ENOSYS)
+			&& (err != -EFAULT))
+				goto out;
+
+			printk(KERN_WARNING "%s: problem reading "
+				"Bus Speed modes.\n",
+				mmc_hostname(card->host));
+			err = 0;
+
 			goto out;
+		}
 
-		printk(KERN_WARNING "%s: problem reading switch "
-			"capabilities, performance might suffer.\n",
-			mmc_hostname(card->host));
-		err = 0;
+		card->sw_caps.uhs_bus_mode = status[13];
+
+		/* Find out Driver Strengths supported by the card */
+		err = mmc_sd_switch(card, 0, 2, 1, status);
+		if (err) {
+			/*
+			 * If the host or the card can't do the switch,
+			 * fail more gracefully.
+			 */
+			if ((err != -EINVAL)
+			&& (err != -ENOSYS)
+			&& (err != -EFAULT))
+				goto out;
+
+			printk(KERN_WARNING "%s: problem reading "
+				"Driver Strength.\n",
+				mmc_hostname(card->host));
+			err = 0;
 
-		goto out;
-	}
+			goto out;
+		}
 
-	if (status[13] & 0x02)
-		card->sw_caps.hs_max_dtr = 50000000;
+		card->sw_caps.uhs_drv_type = status[9];
+
+		/* Find out Current Limits supported by the card */
+		err = mmc_sd_switch(card, 0, 3, 1, status);
+		if (err) {
+			/*
+			 * If the host or the card can't do the switch,
+			 * fail more gracefully.
+			 */
+			if ((err != -EINVAL)
+			&& (err != -ENOSYS)
+			&& (err != -EFAULT))
+				goto out;
+
+			printk(KERN_WARNING "%s: problem reading "
+				"Current Limit.\n",
+				mmc_hostname(card->host));
+			err = 0;
+
+			goto out;
+		}
+
+		card->sw_caps.uhs_curr_limit = status[7];
+	} else {
+		err = mmc_sd_switch(card, 0, 0, 1, status);
+		if (err) {
+			/*
+			 * If the host or the card can't do the switch,
+			 * fail more gracefully.
+			 */
+			if ((err != -EINVAL)
+			&& (err != -ENOSYS)
+			&& (err != -EFAULT))
+				goto out;
+
+			printk(KERN_WARNING "%s: problem reading switch "
+				"capabilities, performance might suffer.\n",
+				mmc_hostname(card->host));
+			err = 0;
+			goto out;
+		}
+
+		if (status[13] & 0x02)
+			card->sw_caps.hs_max_dtr = 50000000;
+	}
 
 out:
 	kfree(status);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 22b0335..7080f22 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -75,6 +75,9 @@ struct sd_ssr {
 
 struct sd_switch_caps {
 	unsigned int		hs_max_dtr;
+	unsigned int		uhs_bus_mode;
+	unsigned int		uhs_drv_type;
+	unsigned int		uhs_curr_limit;
 };
 
 struct sdio_cccr {
-- 
1.7.1

