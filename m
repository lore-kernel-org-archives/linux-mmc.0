Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C4127E15
	for <linux-mmc@vger.kernel.org>; Wed, 17 Apr 2024 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343535; cv=none; b=d6KFEOSyUarWtD3mrBij0t14YM8s2JjN5z8rh98sFMZJHCAsnpiFgmNN3iFeInH9Q8K1H6rhLSdwTtUk+frX68YfVUbT/oW4Tk/fiFr7i4YTb3kPW9fA9NXnsN9UerBsiZdCzNB9pre+af9rFhNpHCXs/U2183Xj5Rtp/BC7lmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343535; c=relaxed/simple;
	bh=mNJabjaGdNhjxsF3EQooO2x+C34eizJIAXhO0aYZ7Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fMOs/VUtDnKHtAo8lnqp+1ZIl1BF/WfbmKSAmD5BxoVVD1xAZug53MR8PGzQYkBIxnaDn8bmU0ADamZYe54TMpDL/hliris/zaUSzXVR8ed7NRa0xMfY5M5yN1txbYxqWS80gNu8qgDTHW7fMYJaz6SohNCbDHU5nYQJOgBJIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=D+v9RbwC; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="D+v9RbwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iL/r2
	SAfz35VjFM0Kl7suwHpeiGRgO5yDl80uHJoXeU=; b=D+v9RbwCQKDnfYn4q6IoW
	LcDpVmTCHRs5cK5vxEea//aHWV7tJOgySywaIsFEywo9r60ha80sKzpcZEGTQZu2
	tKqynzdPuXYXRgqYneDMtmwFUtvPGXdOt/BHCR6mi82LX/EpkXPXpHKcRYvSnVFZ
	6UZcSNwd4lwi8auYoGMozY=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDXHwQOjB9mgrVQBA--.8865S2;
	Wed, 17 Apr 2024 16:45:03 +0800 (CST)
From: Felix Qin <xiaokeqinhealth@126.com>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: dsimic@manjaro.org,
	Avri.Altman@wdc.com,
	Felix Qin <xiaokeqinhealth@126.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 1/1] mmc: core: increase the number of retries of the ACMD41
Date: Wed, 17 Apr 2024 16:45:00 +0800
Message-Id: <20240417084500.152486-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXHwQOjB9mgrVQBA--.8865S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr17Ar43JF13tFW7Kr4xtFb_yoW8Cr1kpF
	s8WryjkFnrJF43ZFy8Ga1q9343X3WIkFWUKrZ2vw10vr15W345WrZrCFWYyryUZayUuF92
	qF9Iqr13GFya9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRfhL8UUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6BfD1WVLa5qM9QAAsP

Extensive testing has shown that a few specific SD cards require
an increase in the number of command retries to successfully
initialize.

More info:
Platform: Rockchip SoC + DW Multimedia host Controller
SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
Note: The SD card is custom-made by the customer in collaboration
with the wafer foundry.

Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
v2: Add more info
---
---
 drivers/mmc/core/sd_ops.c | 4 ++--
 drivers/mmc/core/sd_ops.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index a59cd592f06e..b3b6e8725b80 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -127,7 +127,7 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 		cmd.arg = ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
-	for (i = 100; i; i--) {
+	for (i = SD_APP_OP_COND_RETRIES; i; i--) {
 		err = mmc_wait_for_app_cmd(host, NULL, &cmd);
 		if (err)
 			break;
@@ -147,7 +147,7 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 
 		err = -ETIMEDOUT;
 
-		mmc_delay(10);
+		mmc_delay(SD_APP_OP_COND_INTERVAL);
 	}
 
 	if (!i)
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index 7667fc223b74..80c5c836ccd1 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -10,6 +10,14 @@
 
 #include <linux/types.h>
 
+/*
+ * Extensive testing has shown that a few specific SD cards require
+ * an increase in the number of command retries to successfully
+ * initialize.
+ */
+#define SD_APP_OP_COND_RETRIES  200
+#define SD_APP_OP_COND_INTERVAL 10	/* millisecond */
+
 struct mmc_card;
 struct mmc_host;
 
-- 
2.34.1

