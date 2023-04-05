Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4863C761AF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbjDEGuo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbjDEGum (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875AF4200
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x17so45372189lfu.5
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7+5pU+r96Qz2w0wNTiDpH3eRUOcskPk55XY3zWiSmk=;
        b=zgWbUgX/XfiSWni75W9Bj0RZ1KnO1TF7F0GaVsByzr2hWpatcrvkwvEY9UQD3VKBuE
         1q0xiP3XRDRrEmuHfNtCITo+UFbTrxvQISanWWfFooW7rA56xHFsfNlJmo58pwU4zWyz
         1SPMxoD1RgrXN3+8OZaX1ZSgu/KjL+oiyRuaXkWZLbGhrbHYdpQI+k5eC497CJ2Hashr
         +LgFfHHaGUY8lBoZUKeRv20slfoKQak3McmU52ROLAhoJlfe9dNWyztgLPIxzTDkPFAK
         PItfnSfCC3EhAdgIh8Dw0sL3FqRP5fuYJmbLKJWdo5AMordUGt+bOenQlbCi5s7MhAbA
         Vfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7+5pU+r96Qz2w0wNTiDpH3eRUOcskPk55XY3zWiSmk=;
        b=H5P40BL7cjBI2Df+b2iBAig/yA1hpHS96e5tMF8QqKAQbMXqSBWWS05oOaRD3RKUpt
         IyYNxwobfFnch08ubvoCZkrdTHxA7UdVxZYalmmJ/+STWFoCVtjlwRubtBxEMzTr8rjG
         YIpnobWyo1H2LR8qlE57v526g9Q4joR0bD0U29Ca3u6q2BooGEnWOjBN2+FoG12PuCCr
         5GWmm5ZPGmBpG4JjC4WEGrVEFk6YsGYbDmBAiFq/uX6I2hoGUk7Zk2qJs8/T0hh/jbDL
         IXCvRHMjrT0fVONgtuM8kdn6dQDweUzxnbYbrir6KSlXZDIRoBlMI2UfvZn+GUKYgnAf
         YKKw==
X-Gm-Message-State: AAQBX9evEnBddPoM55BkZXNY3PriUCvCjVcc62ZMyZTi3FvwjNFxQ4hQ
        0hUJz7uMA+76CwQYHoGMnA7VrzwG1kVnQLkNu0M=
X-Google-Smtp-Source: AKy350Y9Ih333G9FNO5tvFGMZKM2N4TIypLFGpKiUu5kNp4TOyhAj5kFHyeL59gAQNbpRzZR1MD6aw==
X-Received: by 2002:a19:7506:0:b0:4e8:5392:492c with SMTP id y6-20020a197506000000b004e85392492cmr1275150lfe.43.1680677439946;
        Tue, 04 Apr 2023 23:50:39 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:33 +0200
Subject: [PATCH 07/13] mmc: mmci: Retry the busy start condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-7-28ac19a74e5e@linaro.org>
References: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
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

This makes the ux500 ->busy_complete() callback re-read
the status register 10 times while waiting for the busy
signal to assert in the status register.

If this does not happen, we bail out regarding the
command completed already, i.e. before we managed to
start to check the busy status.

There is a comment in the code about this, let's just
implementit to be certain that we can catch this glitch
if it happens.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c14a7732386e..670b1622d282 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -664,6 +664,7 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
+	int retries = 10;
 
 	if (status & err_msk) {
 		/* Stop any ongoing busy detection if an error occurs */
@@ -684,22 +685,29 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * Note that, the card may need a couple of clock cycles before
 	 * it starts signaling busy on DAT0, hence re-read the
 	 * MMCISTATUS register here, to allow the busy bit to be set.
-	 * Potentially we may even need to poll the register for a
-	 * while, to allow it to be set, but tests indicates that it
-	 * isn't needed.
 	 */
 	if (host->busy_state == MMCI_BUSY_IDLE) {
 		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
-		status = readl(base + MMCISTATUS);
-		if (status & host->variant->busy_detect_flag) {
-			writel(readl(base + MMCIMASK0) |
-			       host->variant->busy_detect_mask,
-			       base + MMCIMASK0);
-
-			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
-			host->busy_state = MMCI_BUSY_WAITING_FOR_IRQS;
-			return false;
+		while (retries) {
+			status = readl(base + MMCISTATUS);
+			if (status & host->variant->busy_detect_flag) {
+				writel(readl(base + MMCIMASK0) |
+				       host->variant->busy_detect_mask,
+				       base + MMCIMASK0);
+
+				host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
+				host->busy_state = MMCI_BUSY_WAITING_FOR_IRQS;
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
2.39.2

