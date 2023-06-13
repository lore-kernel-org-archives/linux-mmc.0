Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D0EEB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjFMUei (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFMUeg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD4F135
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f624daccd1so7144484e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688473; x=1689280473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JE66c0ktyvQx6kWI5NItLAz064PDkHXvXmuP+9scr2c=;
        b=bxsgHbO44p214U+802iMIXHWym+XLhFjEkkLg7UGgTF1wcSkxCPGWMvoweXCkMQ6bl
         xD7caYOksWThGvMKGZ7VTM5z+1VD/aJzuRD0PIafxoUPPlbVhaNQ3GLkEENin+bMtH5L
         +/wqnumydUKsk9iJ+hm0prpnv1vzIWoNEsT4KwKDu7vP7jHgTzoxwwgJTMi9HgTN31iI
         SFT+j1Pb5wkVNARLBTTOZbE1ChcqiA33bj5admkhDnLeh+4n+XQY+Phqji0LtD3QgeOX
         eZcnN/WJbwMlA5wzercPLKZgOx8kqoD/X/iTV04xUuA+TFvNB9nbVFuURcgqcYn+FNp0
         RWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688473; x=1689280473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE66c0ktyvQx6kWI5NItLAz064PDkHXvXmuP+9scr2c=;
        b=UWC+JGl59nBbUHODZVohy0ag7qcdHDCcAwiwxCaygShlIepvr1LnDoltUoovIo316x
         RHV29iyUQuHegiNjKgbLDBtxVWvXdmKh7UnFFgzjV7cZcCRsrYIdgyk9mWAnakLJ9i5f
         4QjgPAJyU8Nc/xvF/3bdMW8IG/RrnhIknU8w3syndDgb+L2y3EHMtLCOr8HhKc/U5qkv
         6tlThgdyOxMMlf0TYBChX+eIA75Y5sFuQ9aU/XWcXX1QOYi8JHCCfRp0ppKM+N/AZkxt
         qlX2lRvmeQSP3YkD3K8DdR65BILNcbmwGiI8/yzCeAId2wwmSt3oigWr4EIJGyVK7//h
         OISw==
X-Gm-Message-State: AC+VfDy6xb9XhOALsYvUWrJ6g7IWPVH2IKwHpXcy4LnhJeLxfDsX8Lnz
        95NYeMxQMWs7k0OzgHXsi61stg==
X-Google-Smtp-Source: ACHHUZ4g5V/S4mNpuHFoty2XirnD9QeYi5zuSZOi4dtpWJjMEcYhCAOj4HaKbTiQ2OLH0thHxm4yPg==
X-Received: by 2002:a19:2d17:0:b0:4ef:f1f4:14db with SMTP id k23-20020a192d17000000b004eff1f414dbmr6092205lfj.16.1686688473049;
        Tue, 13 Jun 2023 13:34:33 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:32 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:34:24 +0200
Subject: [PATCH v4 08/10] mmc: mmci: Use a switch statement machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v4-8-df9c8c504353@linaro.org>
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
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

As is custom, use a big switch statement to transition
between the edges of the state machine inside
the ux500 ->busy_complete callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 48714e570116..cb766b8d419d 100644
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
-	if (host->busy_state == MMCI_BUSY_DONE) {
+	case MMCI_BUSY_DONE:
 		/*
 		 * Save the first status register read to be sure to catch
 		 * all bits that may be lost will retrying. If the command
@@ -712,8 +718,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
-		goto out_ret_state;
-	}
+		break;
 
 	/*
 	 * If there is a command in-progress that has been successfully
@@ -726,12 +731,11 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * both the start and the end interrupts needs to be cleared,
 	 * one after the other. So, clear the busy start IRQ here.
 	 */
-	if (host->busy_state == MMCI_BUSY_WAITING_FOR_START_IRQ) {
+	case MMCI_BUSY_WAITING_FOR_START_IRQ:
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
-			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
@@ -740,16 +744,14 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			goto out_ret_state;
 		}
-	}
+		break;
 
-	if (host->busy_state == MMCI_BUSY_WAITING_FOR_END_IRQ) {
+	case MMCI_BUSY_WAITING_FOR_END_IRQ:
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_DONE;
-			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -758,11 +760,14 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			goto out_ret_state;
 		}
-	}
+		break;
 
-	return true;
+	default:
+		dev_dbg(mmc_dev(host->mmc), "fell through on state %d\n",
+			host->busy_state);
+		break;
+	}
 
 out_ret_state:
 	return (host->busy_state == MMCI_BUSY_DONE);

-- 
2.40.1

