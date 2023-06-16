Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061AEB64D8
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjFPUmg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjFPUmf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7123AA4
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1611987e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948152; x=1689540152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgLzIEwUjksEjQv4aYSqatUN+oXUaB2j9A2tsvxCYyc=;
        b=a322ThMVtliN+JEBQ+qCe3D+6A5ug1thhAi1c8LpJTWiCxXxIip+Fsrbw7zY+nZMXx
         FHF8SbgZ4woyMCXHIoRHGjuxxyVLMEUQPSPaIyAiFsAi8N16k5rIVwcfOr0lqO7Fd4yP
         UixGCEIgncxhn+39SloQDpqVDuYw1kmDz3QH7HwiclwaVacWGvvlbqwLb/duOErVDkpL
         LykYJPgiXcEXkW/YvbJvl2+26F1vyg9Hm2Yv8/orVEOeWfyBTykc+GxSwjSn2kozW7j1
         4es++iIK5juyhIoe5urvtJMC1K2seGFR4+63XI2dWZ6EwrZ2cgBNk57XPQ00Fu9+9nWf
         erRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948152; x=1689540152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgLzIEwUjksEjQv4aYSqatUN+oXUaB2j9A2tsvxCYyc=;
        b=DeaOZGYH6HgNM6BE9mK3jyRtRNZg2KslHe6deSob5ZTq0wswLCNvo3nkizxv5POH7o
         OUugx9HeL53ALoj1N3Qnmmi7MGwA8FXfmkAgk3MbrUPJ1sqb9xa1C5O7pBiteESTbn9V
         mg3qso5OJBjxguAT49Xa/L6rWEEQeYu+AP+7yqnPocQ7Pt6Df3kHqGCM5p3KWf+AQRvZ
         dvwP0Q5UADyp/0Wnni/Z5+pzLhZBZeZHRHI9CTU/ZUGeoWh2wSUWeHp41LRcJUxWtkLI
         aKF7Ebn6+ES9h8RAjTTbNNWUcZbEvV0Kc1jWLb6E31aDqhnXD8R0ogpBwQmA/pOlRPtZ
         mjxw==
X-Gm-Message-State: AC+VfDyoqdmCFQGsiGtv5S5L9nnZJhAwv6OPzcjnykYRe8MMl8VdjCTK
        c/DI7kzxqcmzo/zEZcIzm+i6xQ==
X-Google-Smtp-Source: ACHHUZ5RAv9vEfDAx5rHOg0jbQFgU/y+kBgq7As5IHeWBPWJ9YEYxJ7Qk6XkUVgw0fKcAYhA3fojFw==
X-Received: by 2002:a19:644e:0:b0:4e9:9e45:3470 with SMTP id b14-20020a19644e000000b004e99e453470mr2437539lfj.3.1686948152503;
        Fri, 16 Jun 2023 13:42:32 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:32 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 22:42:20 +0200
Subject: [PATCH v7 2/9] mmc: mmci: Unwind big if() clause
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v7-2-69a7164f2a61@linaro.org>
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This does two things: firsr replace the hard-to-read long
if-expression:

  if (!host->busy_status && !(status & err_msk) &&
      (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {

With the more readable:

  if (!host->busy_status && !(status & err_msk)) {
     status = readl(base + MMCISTATUS);
     if (status & host->variant->busy_detect_flag) {

Second notice that the re-read MMCISTATUS register is now
stored into the status variable, using logic OR because what
if something else changed too?

While we are at it, explain what the function is doing.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- Add nice ASCII art illustration of the two interrupts.
ChangeLog v4->v6:
- No changes.
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- Only assign the cached status in host->busy_status if
  we have busy detect signalling going on.
---
 drivers/mmc/host/mmci.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0a4b6b6e0f03..b2c7c2d39767 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -654,6 +654,23 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 	return MCI_DPSM_ENABLE | (host->data->blksz << 16);
 }
 
+/*
+ * ux500_busy_complete() - this will wait until the busy status
+ * goes off, saving any status that occur in the meantime into
+ * host->busy_status until we know the card is not busy any more.
+ * The function returns true when the busy detection is ended
+ * and we should continue processing the command.
+ *
+ * The Ux500 typically fires two IRQs over a busy cycle like this:
+ *
+ *  DAT0 busy          +-----------------+
+ *                     |                 |
+ *  DAT0 not busy  ----+                 +--------
+ *
+ *                     ^                 ^
+ *                     |                 |
+ *                    IRQ1              IRQ2
+ */
 static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
@@ -671,14 +688,16 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * while, to allow it to be set, but tests indicates that it
 	 * isn't needed.
 	 */
-	if (!host->busy_status && !(status & err_msk) &&
-	    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
-		writel(readl(base + MMCIMASK0) |
-		       host->variant->busy_detect_mask,
-		       base + MMCIMASK0);
+	if (!host->busy_status && !(status & err_msk)) {
+		status = readl(base + MMCISTATUS);
+		if (status & host->variant->busy_detect_flag) {
+			writel(readl(base + MMCIMASK0) |
+			       host->variant->busy_detect_mask,
+			       base + MMCIMASK0);
 
-		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
-		return false;
+			host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			return false;
+		}
 	}
 
 	/*

-- 
2.40.1

