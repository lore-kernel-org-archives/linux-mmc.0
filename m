From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 02/11] mmc: sd: query function modes for uhs cards
Date: Wed, 20 Apr 2011 15:00:52 +0530
Message-ID: <1303291861-1788-3-git-send-email-arindam.nath@amd.com>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59541 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab1DTJbw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 05:31:52 -0400
Received: by pwi15 with SMTP id 15so308394pwi.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 02:31:51 -0700 (PDT)
In-Reply-To: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, subhashj@codeaurora.org, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

SD cards which conform to Physical Layer Spec v3.01 can support
additional Bus Speed Modes, Driver Strength, and Current Limit
other than the default values. We use CMD6 mode 0 to read these
additional card functions. The values read here will be used
during UHS-I initialization steps.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c    |   69 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/mmc/card.h |    4 ++
 2 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 98aed60..8b25047 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -189,6 +189,9 @@ static int mmc_decode_scr(struct mmc_card *card)
 
 	scr->sda_vsn = UNSTUFF_BITS(resp, 56, 4);
 	scr->bus_widths = UNSTUFF_BITS(resp, 48, 4);
+	if (scr->sda_vsn == SCR_SPEC_VER_2)
+		/* Check if Physical Layer Spec v3.0 is supported*/
+		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
 
 	if (UNSTUFF_BITS(resp, 55, 1))
 		card->erased_byte = 0xFF;
@@ -278,25 +281,75 @@ static int mmc_read_switch(struct mmc_card *card)
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
index 72a9868..56f4d92 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -67,6 +67,7 @@ struct mmc_ext_csd {
 
 struct sd_scr {
 	unsigned char		sda_vsn;
+	unsigned char		sda_spec3;
 	unsigned char		bus_widths;
 #define SD_SCR_BUS_WIDTH_1	(1<<0)
 #define SD_SCR_BUS_WIDTH_4	(1<<2)
@@ -80,6 +81,9 @@ struct sd_ssr {
 
 struct sd_switch_caps {
 	unsigned int		hs_max_dtr;
+	unsigned int		sd3_bus_mode;
+	unsigned int		sd3_drv_type;
+	unsigned int		sd3_curr_limit;
 };
 
 struct sdio_cccr {
-- 
1.7.1

