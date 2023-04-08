Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B63C77B61
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 22:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDHWAp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDHWAn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 18:00:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8C7D8C
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 15:00:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z8so4101057lfb.12
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680991242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulSk45VVtkQg/VdJQPl9abn/cnbMSUxtNO73oyBUdnI=;
        b=xNtWRgV51u81o5Ru5snbvFHi2CMdQ/qYrwzEfDnwHb9oacILRfg7jP1XbwIDMLHPsD
         hHEE3aI1uFJqAUzSwReO4uEqZzGvN1AK3xv4heIlTVuaQMIYi6VDesg/oI0g6kWnbKKN
         rK+s2FheyK2Kc0mX6AAXhPv1k3JoL52oiJQD5fKQU8IcuQC0hgMMpgsOIWp0wCyNpsof
         7eBb18o8rLx2rhHyGeipGcCyX8WbUiY/CvS8yf0eA+KWCiV9HfqBSj1xjg8B8/4+xGxr
         mL1RpnMnTWqVdmZJdJMZEbCmwgunkW6P8KswOfIkuoD8wV3WScx+G9BfI5C/5aJqmrA9
         xuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680991242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulSk45VVtkQg/VdJQPl9abn/cnbMSUxtNO73oyBUdnI=;
        b=HMr9t56zObYOzu7DUgJ1aRQmESHu0ZJLwTxgRyKgtPMxvBVzpQV1nMO1rW6F4fhMd4
         bZ47zCSLl5cy41E6dSUKJzKuLAjU7OUgbjk8QUChGwXOjvAFkX0o8KL/LPIrE0O9mrdJ
         0FuiHqwrdPo7+koF6QMGWc1w5a/PRGNTjD0NATOEiowUpJjwjdSZ5CKlqt7CW7jRx4/D
         kopGh4sHlcrN/gJlSTq3Z12Hde/Z+2AO6rzMM48//HU/O9DVT98aib9+GCIJfTBGEamI
         G1jAYwl2IBKDTOJw11HMGtqRlUIkMwumIt1drGPQBHduwGM3Ot1+d00kcv1VDWNDQ5Jj
         viXw==
X-Gm-Message-State: AAQBX9c3QDSmzJ+UHWV0O/Ij6hugnZAfCPV3BrGd7VmNNNfFo+JXXAJ4
        Fdc9cXQTJREPxtZBlsOT0SKkm3z4br9cnwVq+Mw=
X-Google-Smtp-Source: AKy350al+1pRL1fKihF3snfzUxn/XCgYEiLlufMjMilEnI+leSgyi3G5zSBnXdRXnw3k8tn4QYQWZA==
X-Received: by 2002:a05:6512:985:b0:4eb:1e73:d30a with SMTP id w5-20020a056512098500b004eb1e73d30amr594315lft.45.1680991241832;
        Sat, 08 Apr 2023 15:00:41 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm1328904lfq.229.2023.04.08.15.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:00:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 09 Apr 2023 00:00:29 +0200
Subject: [PATCH v2 08/12] mmc: mmci: Use a switch statement machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v2-8-eeb10323b546@linaro.org>
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As is custom, use a big switch statement to transition
between the edges of the state machine inside
the ux500 ->busy_complete callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2689c6bb62d6..76d885d7e49f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -676,6 +676,12 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		goto out_ret_state;
 	}
 
+	/*
+	 * The state transitions are encoded in a state machine crossing
+	 * the edges in this switch statement.
+	 */
+	switch (host->busy_state) {
+
 	/*
 	 * Before unmasking for the busy end IRQ, confirm that the
 	 * command was sent successfully. To keep track of having a
@@ -686,7 +692,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * it starts signaling busy on DAT0, hence re-read the
 	 * MMCISTATUS register here, to allow the busy bit to be set.
 	 */
-	if (host->busy_state == MMCI_BUSY_IDLE) {
+	case MMCI_BUSY_IDLE:
 		/*
 		 * Save the first status register read to be sure to catch
 		 * all bits that may be lost will retrying. If the command
@@ -713,8 +719,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
-		goto out_ret_state;
-	}
+		break;
 
 	/*
 	 * If there is a command in-progress that has been successfully
@@ -727,12 +732,11 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * both the start and the end interrupts needs to be cleared,
 	 * one after the other. So, clear the busy start IRQ here.
 	 */
-	if (host->busy_state == MMCI_BUSY_WAITING_FOR_IRQS) {
+	case MMCI_BUSY_WAITING_FOR_IRQS:
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_START_IRQ;
-			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
@@ -741,16 +745,14 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			goto out_ret_state;
 		}
-	}
+		break;
 
-	if (host->busy_state == MMCI_BUSY_START_IRQ) {
+	case MMCI_BUSY_START_IRQ:
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_END_IRQ;
-			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -759,9 +761,8 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			goto out_ret_state;
 		}
-	}
+		break;
 
 	/*
 	 * If there is a command in-progress that has been successfully
@@ -769,11 +770,10 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * the busy end IRQ. Clear and mask the IRQ, then continue to
 	 * process the command.
 	 */
-	if (host->busy_state == MMCI_BUSY_END_IRQ) {
+	case MMCI_BUSY_END_IRQ:
 		if (status & host->variant->busy_detect_flag) {
 			/* We should just get two IRQs for busy detect */
 			dev_err(mmc_dev(host->mmc), "spurious busy detect IRQ\n");
-			goto out_ret_state;
 		}
 
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
@@ -782,9 +782,15 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 
 		host->busy_state = MMCI_BUSY_DONE;
 		host->busy_status = 0;
-	} else {
+		break;
+
+	case MMCI_BUSY_DONE:
+		break;
+
+	default:
 		dev_dbg(mmc_dev(host->mmc), "fell through on state %d\n",
 			host->busy_state);
+		break;
 	}
 
 out_ret_state:

-- 
2.39.2

