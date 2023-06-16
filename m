Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F8EB64D7
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbjFPUmi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244916AbjFPUmi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C27E30EF
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f85fcef623so57334e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948155; x=1689540155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MaSrGsItjz38jmRCKZDyUKiiCZ5FqGUYqo/gG3lc/s=;
        b=OXlcMWIsMKz1SPtQEZCKgftVjgdmOlr53aapZasGvO4VPT0Y3QoawALDRX113OMZL9
         8LdnADjX0rQwu+aJefAeKG7HXAOYjb+J7NIjzTFB4aAo9jXLR1Wzr/MV+6qa6vUakKji
         wURZKbtU3ZPdQmSH9okDg6cwEYBVlcJhMnuG02VkgZEc134oXojwTp1TjeVTdYxuRHLe
         dIjSXJhVJia1zCUPJNveSeW/vTq2TobrmbwQTvMhCld4RIdB4L03zQ9pPMSPTM0v/P/h
         WHYUfAZWVxVaTMjJW5tsycVsF3GO2wA2e1s5nzbEd5i/2C+PTxuRLB+Y2Xjj04lpKja/
         F9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948155; x=1689540155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MaSrGsItjz38jmRCKZDyUKiiCZ5FqGUYqo/gG3lc/s=;
        b=bCO9j2C3vVI3zyWYxBAB0KM4sUF1sR+2tSYod3+3I2GAmU0/YRTjYaX0Y9U6CNaETP
         LWxk9D+w5++OG2vhi1RREVWSOXnVKAseih14CRaIG48sKr486/FgOFU+AlmAc7UW6vZ4
         TnTMU7yFrtz34GYbz/P4lcqL88f/m6YgMOJP0nBURotctWhKgM8Qfr3OhiC+G1WIMkYz
         pssYy8exokLAZSJVsppCM0xoUVS++SG5jT9prfTJMYR4Y0Lx7zVEv1Mq24fEbD0xSs6Z
         papEbp8oGl9wwhGn5HAiclRDuUL+SEhRJY5ch0Xae1z4hQaNSZjfEjvmq+YHlkprCkH5
         vo8g==
X-Gm-Message-State: AC+VfDyYQSa9V1OwVVfgP06SNLiL2uxxdXNZtRUzN9QJgp7E0cBXj1f7
        RqCErI2g/Io7ENxo1qRpSM4bNw==
X-Google-Smtp-Source: ACHHUZ7z57R+8+5C0ijjO+dqc+GjE5JefqDQEhH5siUiZoEy4gcFiEJKOkMzvy2v4klete84pLtRkw==
X-Received: by 2002:a19:911e:0:b0:4f7:3ee8:eeda with SMTP id t30-20020a19911e000000b004f73ee8eedamr1101648lfd.34.1686948154880;
        Fri, 16 Jun 2023 13:42:34 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 22:42:23 +0200
Subject: [PATCH v7 5/9] mmc: mmci: Make busy complete state machine
 explicit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v7-5-69a7164f2a61@linaro.org>
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This refactors the ->busy_complete() callback currently
only used by Ux500 and STM32 to handle busy detection on
hardware where one and the same IRQ is fired whether we get
a start or an end signal on busy detect.

The code is currently using the cached status from the
command IRQ in ->busy_status as a state to select what to
do next: if this state is non-zero we are waiting for
IRQs and if it is zero we treat the state as the starting
point for a busy detect wait cycle.

Make this explicit by creating a state machine where the
->busy_complete callback moves between three states.

The Ux500 busy detect code currently assumes this order:
we enable the busy detect IRQ, get a busy start IRQ, then a
busy end IRQ, and then we clear and mask this IRQ and
proceed.

We insert debug prints for unexpected states.

This works as before on most cards, however on a
problematic card that is not working with busy detect, and
which I have been debugging, the following happens a lot:

[    3.380554] mmci-pl18x 80005000.mmc: no busy signalling in time
[    3.387420] mmci-pl18x 80005000.mmc: no busy signalling in time
[    3.394561] mmci-pl18x 80005000.mmc: lost busy status
     when waiting for busy start IRQ

This probably means that the busy detect start IRQ has
already occurred when we start executing the
->busy_complete() callbacks, and the busy detect end IRQ
is counted as the start IRQ, and this is what is causing
the card to not be detected properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- Return properly with true if we get the second "busy end IRQ"
  as expected.
- If busy is still asserted at busy end IRQ, we keep waiting
  instead of aborting and completing the command.
- Drop the STM32 changes - just makes things complex.
ChangeLog v4->v6:
- When waiting for the busy end IRQ, what we expect is that
  the IRQ should trigger right after the busy signal ends, and
  thus thes busy indication should be de-asserted (low). We
  invert the logic such that this is what we expect, and
  the error case is if the busy detect status is still high
  when we get the busy end IRQ.
ChangeLog v3->v4:
- Assign state MMCI_BUSY_DONE outside the if()-clause for
  the busy detect initialization.
ChangeLog v2->v3:
- Drop surplus states and merge IDLE and DONE states into one,
  we start out DONE. Name states *_WAITING_FOR_* so it is clear
  what is going on.
- Rebase on other changes.
- Reword commit message.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 49 +++++++++++++++++++++++++++++++------------------
 drivers/mmc/host/mmci.h | 14 ++++++++++++++
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e493fb7c724f..e61aeca278ec 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -680,6 +680,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+		host->busy_state = MMCI_BUSY_DONE;
 		host->busy_status = 0;
 		return true;
 	}
@@ -697,7 +698,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * while, to allow it to be set, but tests indicates that it
 	 * isn't needed.
 	 */
-	if (!host->busy_status) {
+	if (host->busy_state == MMCI_BUSY_DONE) {
 		status = readl(base + MMCISTATUS);
 		if (status & host->variant->busy_detect_flag) {
 			writel(readl(base + MMCIMASK0) |
@@ -705,6 +706,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       base + MMCIMASK0);
 
 			host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
 			return false;
 		}
 	}
@@ -720,25 +722,34 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * both the start and the end interrupts needs to be cleared,
 	 * one after the other. So, clear the busy start IRQ here.
 	 */
-	if (host->busy_status &&
-	    (status & host->variant->busy_detect_flag)) {
-		host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
-		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-		return false;
+	if (host->busy_state == MMCI_BUSY_WAITING_FOR_START_IRQ) {
+		if (status & host->variant->busy_detect_flag) {
+			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+			host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
+			return false;
+		} else {
+			dev_dbg(mmc_dev(host->mmc),
+				"lost busy status when waiting for busy start IRQ\n");
+			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+			writel(readl(base + MMCIMASK0) &
+			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+			host->busy_state = MMCI_BUSY_DONE;
+			host->busy_status = 0;
+			return true;
+		}
 	}
 
-	/*
-	 * If there is a command in-progress that has been successfully
-	 * sent and the busy bit isn't set, it means we have received
-	 * the busy end IRQ. Clear and mask the IRQ, then continue to
-	 * process the command.
-	 */
-	if (host->busy_status) {
-		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-
-		writel(readl(base + MMCIMASK0) &
-		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
-		host->busy_status = 0;
+	if (host->busy_state == MMCI_BUSY_WAITING_FOR_END_IRQ) {
+		if (!(status & host->variant->busy_detect_flag)) {
+			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			host->busy_state = MMCI_BUSY_DONE;
+			return true;
+		} else {
+			dev_dbg(mmc_dev(host->mmc),
+				"busy status still asserted when handling busy end IRQ - will keep waiting\n");
+			return false;
+		}
 	}
 
 	return true;
@@ -1268,6 +1279,8 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 	}
 
 	host->busy_status = 0;
+	host->busy_state = MMCI_BUSY_DONE;
+
 	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
 		if (!cmd->busy_timeout)
 			cmd->busy_timeout = 10 * MSEC_PER_SEC;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index e1a9b96a3396..12a7bbd3ce26 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -261,6 +261,19 @@ struct clk;
 struct dma_chan;
 struct mmci_host;
 
+/**
+ * enum mmci_busy_state - enumerate the busy detect wait states
+ *
+ * This is used for the state machine waiting for different busy detect
+ * interrupts on hardware that fire a single IRQ for start and end of
+ * the busy detect phase on DAT0.
+ */
+enum mmci_busy_state {
+	MMCI_BUSY_WAITING_FOR_START_IRQ,
+	MMCI_BUSY_WAITING_FOR_END_IRQ,
+	MMCI_BUSY_DONE,
+};
+
 /**
  * struct variant_data - MMCI variant-specific quirks
  * @clkreg: default value for MCICLOCK register
@@ -409,6 +422,7 @@ struct mmci_host {
 	u32			clk_reg;
 	u32			clk_reg_add;
 	u32			datactrl_reg;
+	enum mmci_busy_state	busy_state;
 	u32			busy_status;
 	u32			mask1_reg;
 	u8			vqmmc_enabled:1;

-- 
2.40.1

