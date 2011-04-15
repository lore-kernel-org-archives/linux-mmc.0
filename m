From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 03/12] mmc: sd: query function modes for uhs cards
Date: Fri, 15 Apr 2011 16:08:53 +0530
Message-ID: <1302863942-1774-4-git-send-email-arindam.nath@amd.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49866 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631Ab1DOKkb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 06:40:31 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so1032526pwi.19
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 03:40:31 -0700 (PDT)
In-Reply-To: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, subhashj@codeaurora.org, prakity@marvell.com, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

SD cards which conform to Physical Layer Spec v3.01 can support
additional Bus Speed Modes, Driver Strength, and Current Limit
other than the default values. We use CMD6 mode 0 to read these
additional card functions. The values read here will be used
during UHS-I initialization steps.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c    |   66 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/mmc/card.h |    3 ++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index b967588..eefa4aa 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -284,25 +284,75 @@ static int mmc_read_switch(struct mmc_card *card)
 		return -ENOMEM;
 	}
 
+	/* Find out the supported Bus Speed Modes. */
 	err = mmc_sd_switch(card, 0, 0, 1, status);
 	if (err) {
-		/* If the host or the card can't do the switch,
-		 * fail more gracefully. */
+		/*
+		 * If the host or the card can't do the switch,
+		 * fail more gracefully.
+		 */
 		if ((err != -EINVAL)
-		 && (err != -ENOSYS)
-		 && (err != -EFAULT))
+		&& (err != -ENOSYS)
+		&& (err != -EFAULT))
 			goto out;
 
-		printk(KERN_WARNING "%s: problem reading switch "
-			"capabilities, performance might suffer.\n",
+		printk(KERN_WARNING "%s: problem reading Bus Speed modes.\n",
 			mmc_hostname(card->host));
 		err = 0;
 
 		goto out;
 	}
 
-	if (status[13] & 0x02)
-		card->sw_caps.hs_max_dtr = 50000000;
+	if (card->scr.sda_spec3) {
+		card->sw_caps.sd3_bus_mode = status[13];
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
+
+			goto out;
+		}
+
+		card->sw_caps.sd3_drv_type = status[9];
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
+		card->sw_caps.sd3_curr_limit = status[7];
+	} else {
+		if (status[13] & 0x02)
+			card->sw_caps.hs_max_dtr = 50000000;
+	}
 
 out:
 	kfree(status);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 86d9672..18b0334 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -84,6 +84,9 @@ struct sd_ssr {
 
 struct sd_switch_caps {
 	unsigned int		hs_max_dtr;
+	unsigned int		sd3_bus_mode;
+	unsigned int		sd3_drv_type;
+	unsigned int		sd3_curr_limit;
 };
 
 struct sdio_cccr {
-- 
1.7.1

