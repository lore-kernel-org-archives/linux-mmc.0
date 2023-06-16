Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A6EB64D7
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbjFPUml (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjFPUmk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD3630EF
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f6170b1486so1539361e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948157; x=1689540157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+YfQHHTaK1F9cdLN5V1bAawJ006MIRupdl+qM41oJM=;
        b=Sw1malw1PwQKzk3KvN+ch294ScTLM131f36w6dW3v0N38yk586wxB3+ZaHuAYFbFKY
         e9pN3xh5Iy0JjMy3/ldDaCVY9fa0ytUginx5WTYwiIiM9m1NFWDuEqlITYuQgjbsacPn
         iXkDM1KOyJy8vz07EHNjW+AlrlpgfSh5dJfPhThheOnLYyHtden5WPDIeLiCNCXo3jZj
         4GmjFsm0I9CBKgLll+692O7cs3Yoa8wA50GfDjRlKmees9SuPa/J3F7ILKqJOxQ6/7sl
         achrCto1jenGY+qfe+mMzedS7GLcKf0DFzZtZCQDN0iCEUMOOnEvCYcy/h84XVdiwNqL
         Frmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948157; x=1689540157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+YfQHHTaK1F9cdLN5V1bAawJ006MIRupdl+qM41oJM=;
        b=ZMjFatxxEcyAfoRjXPwXbbT7RW0t1MhRTW1c9q1CX5y1fBdeXbtcmBsWCUfWe5LMo/
         1gayAWctMg150uU/S+tboyHihyTzUlR2BPybeuu9je75tFE58XTA7mxlYhLcPsn5CYey
         YaxA0y8InrXKsVY0mQ41gJB8Az3jAVT0uzONnNezONEINJTlrxXrDIlD5JdXUex0BXIa
         0IzpP0M3S0vHy3f4VQvhB6aqcMHduIDYTwB+suHrOOD+I1949QHRm0C/vfjgxqr7+xbU
         Pid/vtGr2wSqVHN4lFwCh3cp/d/HFcVdwsKWtS7o7muKqeeth/34A6nrOPEH2TR8D+S1
         KK5g==
X-Gm-Message-State: AC+VfDwOiStlizw1i+B3rsxd1X66kvyXV8jKClfkr4m2UcRA0P4mwcjB
        IxQOEfqLbj9nuQqd8L7CzuPKhCLh0lvHUdpm8bg=
X-Google-Smtp-Source: ACHHUZ4mtCwLJm+5uyEd1opc6EH46BmcwDmg9yHNuT1qkZzqedblx0Ws0Q6pur2x9knD3KlQSgfHuw==
X-Received: by 2002:ac2:4d97:0:b0:4f6:5473:7bf0 with SMTP id g23-20020ac24d97000000b004f654737bf0mr1134293lfe.21.1686948157674;
        Fri, 16 Jun 2023 13:42:37 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:37 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 22:42:26 +0200
Subject: [PATCH v7 8/9] mmc: mmci: Use a switch statement machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v7-8-69a7164f2a61@linaro.org>
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As is custom, use a big switch statement to transition
between the edges of the state machine inside
the ux500 ->busy_complete callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- No changes.
ChangeLog v4->v6:
- No changes.
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
index f89e4c44ea04..d38ba9aa9be8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -686,6 +686,12 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
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
@@ -696,7 +702,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * it starts signaling busy on DAT0, hence re-read the
 	 * MMCISTATUS register here, to allow the busy bit to be set.
 	 */
-	if (host->busy_state == MMCI_BUSY_DONE) {
+	case MMCI_BUSY_DONE:
 		/*
 		 * Save the first status register read to be sure to catch
 		 * all bits that may be lost will retrying. If the command
@@ -722,8 +728,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
-		goto out_ret_state;
-	}
+		break;
 
 	/*
 	 * If there is a command in-progress that has been successfully
@@ -736,12 +741,11 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
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
@@ -750,23 +754,24 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			goto out_ret_state;
 		}
-	}
+		break;
 
-	if (host->busy_state == MMCI_BUSY_WAITING_FOR_END_IRQ) {
+	case MMCI_BUSY_WAITING_FOR_END_IRQ:
 		if (!(status & host->variant->busy_detect_flag)) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			host->busy_state = MMCI_BUSY_DONE;
-			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"busy status still asserted when handling busy end IRQ - will keep waiting\n");
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

