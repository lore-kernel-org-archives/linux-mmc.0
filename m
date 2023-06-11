Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F2C87FDC
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Jun 2023 19:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjFKTlu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Jun 2023 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjFKTlt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2023 15:41:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9EDE51
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso4234132e87.0
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686512505; x=1689104505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnoJbS9/Ay6FH59vYZflel3IJO/fgTDRMIeCev/1iAY=;
        b=mZLBvIw4hd4Az9ncr1RPQ7plZHc4samFRNtZA/X/ZF9PjeqwKA+lzIdgOSFeaFdSfs
         rOp2q/2p0VPnM6zivWX/CFt2yPbGv9nIr2LXh/MTalCngWTFCDNu7DfKmHMtZq7fBPt0
         oiWuQ3WLzLtsdi3tGvq7+DMrhSquGsVbUNDAzC7OdCVWzUA2X5vovczgQku15dhIXszn
         uhdOEhWtDR0NRoF1qVhU1jiAvRlpohq8Zu1BQWyOot88CKfh1Ew7/WUb8xHIQ48OT0fm
         D874cLJUa12Uv4APiXzmJORdi5LlocuXQB5TjJ5KwKzOWLnjxsY/H//r9nq4ucq1Xj8m
         9tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512505; x=1689104505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnoJbS9/Ay6FH59vYZflel3IJO/fgTDRMIeCev/1iAY=;
        b=SKKGeHj7/UbbAfk/clBw1as6rfFVoKtBZvk9UDuDv0oR2kBqT7+1RqYXcRz6TeyWVJ
         Cg326urCSQqxylwWy1vqfqgRko5tXXRBAVTv/Qo3p0GigkCfEJZPnBAyyGwRanrJNEvd
         5T+/2+nCOFzSv2a1eJBBjFQSGoBH98ZnMm/FN7Avmy+VZi3QUastdIH2cFGLZYhUgJQM
         nxJI99zql6a8qK93z7V/ztNPjaxtXiN8hjmgt6khq9t07qOyu8N791dhbm/iPnd0Zg6U
         OcKoas+LwPVkkN3O1NcSZFB9OVfBhm/tFAQisxCklsk464Vbx+3zSNXTUdqkKfHjD4+j
         0g/g==
X-Gm-Message-State: AC+VfDzZwt7DS3gibbz42NC0w4ialr5S//wTKwA9h3Tui0pbzmmX4YuR
        MGFtrKlSFrLX7TdcVGS1z/8KMg==
X-Google-Smtp-Source: ACHHUZ5hYwBw8cIGDbN4Ma0k4bYHBtE95hYPa3a9ldyxqKx2nnq1c9L+fCfHXxY1VqYMfmc9PMWVMQ==
X-Received: by 2002:ac2:465b:0:b0:4f6:1805:6080 with SMTP id s27-20020ac2465b000000b004f618056080mr3751407lfo.4.1686512505612;
        Sun, 11 Jun 2023 12:41:45 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1246960lfl.28.2023.06.11.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:41:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 11 Jun 2023 21:41:31 +0200
Subject: [PATCH v3 05/10] mmc: mmci: Make busy complete state machine
 explicit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v3-5-cd3d5925ae64@linaro.org>
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
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

Augment the STM32 driver with similar states for
completeness.

This works as before on most cards, however on a
problematic card that is not working with busy detect, and
which I have been debugging, this happens:

[127220.662719] mmci-pl18x 80005000.mmc: lost busy status
		when waiting for busy end IRQ

This probably means that the busy detect start IRQ has
already occurred when we start executing the
->busy_complete() callbacks, and the busy detect end IRQ
is counted as the start IRQ, and this is what is causing
the card to not be detected properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Drop surplus states and merge IDLE and DONE states into one,
  we start out DONE. Name states *_WAITING_FOR_* so it is clear
  what is going on.
- Rebase on other changes.
- Reword commit message.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c             | 55 +++++++++++++++++++++++++------------
 drivers/mmc/host/mmci.h             | 14 ++++++++++
 drivers/mmc/host/mmci_stm32_sdmmc.c |  6 +++-
 3 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index fbc13923f4fe..edc68fc7b642 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -670,6 +670,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+		host->busy_state = MMCI_BUSY_DONE;
 		host->busy_status = 0;
 		return true;
 	}
@@ -687,7 +688,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * while, to allow it to be set, but tests indicates that it
 	 * isn't needed.
 	 */
-	if (!host->busy_status) {
+	if (host->busy_state == MMCI_BUSY_DONE) {
 		status = readl(base + MMCISTATUS);
 		if (status & host->variant->busy_detect_flag) {
 			writel(readl(base + MMCIMASK0) |
@@ -695,6 +696,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       base + MMCIMASK0);
 
 			host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
 			return false;
 		}
 	}
@@ -710,25 +712,40 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
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
+		if (status & host->variant->busy_detect_flag) {
+			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+			host->busy_state = MMCI_BUSY_DONE;
+			return false;
+		} else {
+			dev_dbg(mmc_dev(host->mmc),
+				"lost busy status when waiting for busy end IRQ\n");
+			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+			writel(readl(base + MMCIMASK0) &
+			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+			host->busy_state = MMCI_BUSY_DONE;
+			host->busy_status = 0;
+			return true;
+		}
 	}
 
 	return true;
@@ -1259,6 +1276,8 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 
 	host->busy_status = 0;
 	if ((cmd->flags & MMC_RSP_BUSY) && (host->variant->busy_timeout)) {
+		host->busy_state = MMCI_BUSY_DONE;
+
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
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 60bca78a72b1..a805647b6664 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -393,8 +393,10 @@ static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	busy_d0 = sdmmc_status & MCI_STM32_BUSYD0;
 
 	/* complete if there is an error or busy_d0end */
-	if ((status & err_msk) || busy_d0end)
+	if ((status & err_msk) || busy_d0end) {
+		host->busy_state = MMCI_BUSY_DONE;
 		goto complete;
+	}
 
 	/*
 	 * On response the busy signaling is reflected in the BUSYD0 flag.
@@ -408,6 +410,7 @@ static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			host->busy_status = status &
 				(MCI_CMDSENT | MCI_CMDRESPEND);
 		}
+		host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
 		return false;
 	}
 
@@ -416,6 +419,7 @@ static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel_relaxed(mask & ~host->variant->busy_detect_mask,
 			       base + MMCIMASK0);
 		host->busy_status = 0;
+		host->busy_state = MMCI_BUSY_DONE;
 	}
 
 	writel_relaxed(host->variant->busy_detect_mask, base + MMCICLEAR);

-- 
2.40.1

