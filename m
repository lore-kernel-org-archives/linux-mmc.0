Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD714A0A0
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051846; cv=none; b=YfBb47P77hWuiGf+yuxY37unYa0LlpqFb7/d4rOxTS/lQ0F1UER5swQgBVfbf2y6kSzq6jKJW5QDGRkGH8Af6cVOFjiXpsbtY3JoJSnee2bmMDWQGC3eMcVx4wwacXeRyDrk+m2N9ANuEImYvDhx7SxdETfuEdBD4OrmY1oDCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051846; c=relaxed/simple;
	bh=EoWMxLo5INoQqLvX5iNLGZoSAD+nAVTybp3fuwGirrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e2HZTAaucSGtSgtExOTylLnshTmEmDfsW9WKlGa6ZPEEz+i1wzQd3HAvZbEwHrTb3IJ9mYITlaH4W+I9v59t826g9fBye9ZgFSyFhoByTXCF+YHKe2IVxOfHU3ONIOlky0kfjIH9vMGo8Ldo5TJfWR3a3NssSBX64VBg4VRWOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Po6YliNx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Po6YliNx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51c66cc680aso393631e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714051843; x=1714656643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+tdO/UIC3b/X5P2tckJN1J8odXZjxVoO/7WKXxrhTE=;
        b=Po6YliNx4sOHGUOCS5UlWCtEjYK7iEp2uGm45NmS9TZ7L23SRADPiNRPheFQnlv+OS
         mPHO8WJiSXa3R0WdOYf11PiNkAKCiEAp5lKIyjt/kqdk0tenTrFn/HweRP/v7gMzA9ls
         Lo20Awy3AXJfRrqJc9w6tNcrSV72eFKEgMn4+9DkWZs2Iicm/AQgZtmtGkA29mjvTThP
         q7RyetBUGuFLsAPptVfuCovySlC2a3zGkkAmXjjqx1Zt16rFEWxBW8R9rWNxmxnidPwH
         JbM3MMdG414dthEZPUApiNkJTkp4XdOadC7oJfTFyQT8ZbqeysGRoD4dLKtVe587sK1b
         HmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051843; x=1714656643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+tdO/UIC3b/X5P2tckJN1J8odXZjxVoO/7WKXxrhTE=;
        b=KVW/rkQ4xKw3A1z8BR0ZQVfGE3rU8v88bDv+3Bq6oz2V7oi4o4T8mwqunFlVycGhTl
         JGFfqDgrnrabfykP+9IV8Xc3okQ6K44+8rzKwxOpqgf/psROCCkXMrZZS75oAVA+eHP3
         llchYG43d3LqScJu4N6+tQhwdQU+VN7p0PKyeOtDCLgsYoehMsHqk9pQl/S/z02WxVoV
         5TcWe/w5dI4Tq3xzL0O5RGIPFqFKNRoHOLbQ3ajaBFcQrQOzEGm3jJ2HJnvjJu53AHTN
         KCJCi1FnmFqFjt1DrTJnK+qs0UHQd+eK0fLaacLgOTAR0NW38lqyivFZnAECy024sxwL
         CLgQ==
X-Gm-Message-State: AOJu0YzbgRbEcO48fzj+ifToMw2cxAvkEw8vpbT+IaeLQ71qgo8H0tes
	77rOh67m7aXCJRiqnc+WgLbRQ6elT3XSLjn306ORcblr5ZPlRLKKQHi7RVp+vnVew0t8ji8Lfqs
	b
X-Google-Smtp-Source: AGHT+IEW0aa8yBIv50goI4Mi10vAgRT8hVO2OmLTeiao6aGSd1rPtqW6Jiouo17uZuM1PLgR6UjHbQ==
X-Received: by 2002:a05:6512:60f:b0:51b:ae4c:f20a with SMTP id b15-20020a056512060f00b0051bae4cf20amr1002286lfe.28.1714051842896;
        Thu, 25 Apr 2024 06:30:42 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id g2-20020a19e042000000b0051884ea2a32sm2856052lfj.31.2024.04.25.06.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:30:42 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	Felix Qin <xiaokeqinhealth@126.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Convert to use __mmc_poll_for_busy() SD_APP_OP_COND too
Date: Thu, 25 Apr 2024 15:30:34 +0200
Message-Id: <20240425133034.79599-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to what has already been changed for eMMC and the MMC_SEND_OP_COND
(CMD1), let's convert the SD_APP_OP_COND (ACMD41) for SD cards to use the
common __mmc_poll_for_busy() too.

This change means the initial delay period, that starts as 10ms will now
increase for every loop when being busy. The total accepted timeout for
being busy is 1s, which is according to the SD spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd_ops.c | 77 +++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index a59cd592f06e..3ce1ff336826 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -19,6 +19,15 @@
 #include "sd_ops.h"
 #include "mmc_ops.h"
 
+#define SD_APP_OP_COND_PERIOD_US	(10 * 1000) /* 10ms */
+#define SD_APP_OP_COND_TIMEOUT_MS	1000 /* 1s */
+
+struct sd_app_op_cond_busy_data {
+	struct mmc_host *host;
+	u32 ocr;
+	struct mmc_command *cmd;
+};
+
 int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 {
 	int err;
@@ -115,10 +124,44 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
 	return mmc_wait_for_app_cmd(card->host, card, &cmd);
 }
 
+static int sd_app_op_cond_cb(void *cb_data, bool *busy)
+{
+	struct sd_app_op_cond_busy_data *data = cb_data;
+	struct mmc_host *host = data->host;
+	struct mmc_command *cmd = data->cmd;
+	u32 ocr = data->ocr;
+	int err;
+	*busy = false;
+
+	err = mmc_wait_for_app_cmd(host, NULL, cmd);
+	if (err)
+		return err;
+
+	/* If we're just probing, do a single pass. */
+	if (ocr == 0)
+		return 0;
+
+	/* Wait until reset completes. */
+	if (mmc_host_is_spi(host)) {
+		if (!(cmd->resp[0] & R1_SPI_IDLE))
+			return 0;
+	} else if (cmd->resp[0] & MMC_CARD_BUSY) {
+		return 0;
+	}
+
+	*busy = true;
+	return 0;
+}
+
 int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
 	struct mmc_command cmd = {};
-	int i, err = 0;
+	struct sd_app_op_cond_busy_data cb_data = {
+		.host = host,
+		.ocr = ocr,
+		.cmd = &cmd
+	};
+	int err;
 
 	cmd.opcode = SD_APP_OP_COND;
 	if (mmc_host_is_spi(host))
@@ -127,36 +170,16 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 		cmd.arg = ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
-	for (i = 100; i; i--) {
-		err = mmc_wait_for_app_cmd(host, NULL, &cmd);
-		if (err)
-			break;
-
-		/* if we're just probing, do a single pass */
-		if (ocr == 0)
-			break;
-
-		/* otherwise wait until reset completes */
-		if (mmc_host_is_spi(host)) {
-			if (!(cmd.resp[0] & R1_SPI_IDLE))
-				break;
-		} else {
-			if (cmd.resp[0] & MMC_CARD_BUSY)
-				break;
-		}
-
-		err = -ETIMEDOUT;
-
-		mmc_delay(10);
-	}
-
-	if (!i)
-		pr_err("%s: card never left busy state\n", mmc_hostname(host));
+	err = __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US,
+				  SD_APP_OP_COND_TIMEOUT_MS, &sd_app_op_cond_cb,
+				  &cb_data);
+	if (err)
+		return err;
 
 	if (rocr && !mmc_host_is_spi(host))
 		*rocr = cmd.resp[0];
 
-	return err;
+	return 0;
 }
 
 static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
-- 
2.34.1

