Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDB5EB64DD
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjFPUmj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbjFPUmi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB93AA3
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f764e92931so1683846e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948156; x=1689540156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjsyh8HKup5upDCLPid4awp+IS7Z6M7SAZiVl4zctHA=;
        b=X+PodAaeInuf0O+d/zgrs2lkQSEmTMMODroUtX8Xz2WhVSk3xFRPnWp+qdT7unBOZQ
         q8ySuV8METFG9rCWGI9wLxJQkkoP5b+npsahJ2MDkg3ib7bXlAu45paBOsUs62d3UITE
         Av9K8EwCjyb+mNBKWR79dhA7OZBBA4CFlXHxQ5ukJHJlM1tbFDfkaxWoVxEkyALWw5Oc
         Kwo7dRJo6rpRgyLBSByI4tO7sAlS4VoiQRuChbw+0c4nXXaBi9mSrmqRSJUI4LFcbdi/
         m8wXy+yNtDxDL1PA9idSh0Qqbz7QpR6J1PcTy11P+Z7CUD69RRw1Q2IwlAhJpcXQS1N2
         iJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948156; x=1689540156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjsyh8HKup5upDCLPid4awp+IS7Z6M7SAZiVl4zctHA=;
        b=DgttXCgZE5QadZPP8+vUv6n6PW7pENDjh2kg+UVt8JdJElQCT6c1oa4YVLQH5U0/an
         ML2m6krXsKBrwpadzDfreMUL1oIKPDDDIjCpJRuZ/Ddf1lEJv9zvWI90cRa7FYcwLKv4
         ud2Dw7MGUdTlIH5TVKz8psrv2kqTVNASdT/bZTW+o62/JOr3sYVgad4VeOG+GqSV6xvv
         aJ3aO20le0677+OMn6itKvA3wIPns5QsRcbQjMMaKV2MnUBNh0RyWCC63yMjy7aiuFU9
         9OMfSxe2vFgRiHsut8xzpErRpS7j5vxvDaLvwiEMUH9PNpHjc5Wkgvg1FFEYOKUfeen5
         hzwQ==
X-Gm-Message-State: AC+VfDxr7TI43w92dSnKPwzYFPLPnbuDEu9HZ9N75/Chatklvobk162Z
        cY8CL4Wn+mi1Cl76CEaUntaORg==
X-Google-Smtp-Source: ACHHUZ5aHzFuuNbQ75rOaWvIgySxBmXGkEhrRl3IzKxBPGadvKhHKdErE/kk8SIc/ZlQhePgwgtdGg==
X-Received: by 2002:a05:6512:285:b0:4f8:41f6:5adb with SMTP id j5-20020a056512028500b004f841f65adbmr2090120lfp.46.1686948155803;
        Fri, 16 Jun 2023 13:42:35 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 22:42:24 +0200
Subject: [PATCH v7 6/9] mmc: mmci: Retry the busy start condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v7-6-69a7164f2a61@linaro.org>
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This makes the ux500 ->busy_complete() callback re-read
the status register 10 times while waiting for the busy
signal to assert in the status register.

If this does not happen, we bail out regarding the
command completed already, i.e. before we managed to
start to check the busy status.

There is a comment in the code about this, let's just
implement it to be certain that we can catch this glitch
if it happens.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- No changes.
ChangeLog v4->v6:
- No changes.
ChangeLog v3->v4:
- Accumulate status flags outside the if()-clause in the
  busy detect retry loop.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- Move over the initial saving of host->busy_status from
  an unrelated patch to this one: it is clear what we are
  doing: we don't want to miss any transient
  (MCI_CMDSENT | MCI_CMDRESPEND) in the status register.
---
 drivers/mmc/host/mmci.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e61aeca278ec..b38c471a7f8b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -674,6 +674,7 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
+	int retries = 10;
 
 	if (status & err_msk) {
 		/* Stop any ongoing busy detection if an error occurs */
@@ -694,21 +695,35 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * Note that, the card may need a couple of clock cycles before
 	 * it starts signaling busy on DAT0, hence re-read the
 	 * MMCISTATUS register here, to allow the busy bit to be set.
-	 * Potentially we may even need to poll the register for a
-	 * while, to allow it to be set, but tests indicates that it
-	 * isn't needed.
 	 */
 	if (host->busy_state == MMCI_BUSY_DONE) {
-		status = readl(base + MMCISTATUS);
-		if (status & host->variant->busy_detect_flag) {
-			writel(readl(base + MMCIMASK0) |
-			       host->variant->busy_detect_mask,
-			       base + MMCIMASK0);
-
-			host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
-			host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
-			return false;
+		/*
+		 * Save the first status register read to be sure to catch
+		 * all bits that may be lost will retrying. If the command
+		 * is still busy this will result in assigning 0 to
+		 * host->busy_status, which is what it should be in IDLE.
+		 */
+		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
+		while (retries) {
+			status = readl(base + MMCISTATUS);
+			/* Keep accumulating status bits */
+			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			if (status & host->variant->busy_detect_flag) {
+				writel(readl(base + MMCIMASK0) |
+				       host->variant->busy_detect_mask,
+				       base + MMCIMASK0);
+				host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
+				return false;
+			}
+			retries--;
 		}
+		dev_dbg(mmc_dev(host->mmc), "no busy signalling in time\n");
+		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+		writel(readl(base + MMCIMASK0) &
+		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+		host->busy_state = MMCI_BUSY_DONE;
+		host->busy_status = 0;
+		return true;
 	}
 
 	/*

-- 
2.40.1

