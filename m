Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25281C7EE45
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Jun 2023 19:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjFKTlu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Jun 2023 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjFKTlr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2023 15:41:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5141FD2
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so4310113e87.3
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686512504; x=1689104504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6Ue4bYrXyR9j80ovW9fc7Vt7MxWUEhRPqPmpf2o0qo=;
        b=zd20DlhR2hxHUuFfATGWD/CU45g0SHtMXtYWmhJmj4p+WAOkPdH13eS5m8WSILbe+R
         FK/JP5aLMN66icLCgm4LYJsMbuM6gxEOYKOhEg74swgtQ7Ihmt34njRw9ZB3C74Fdec/
         NCo+uI5OLk3xPeG+Wz5ULGjKLQQ3l9f8rL2Sw4LNo7v9UK9XudLnVisOIQFY1ezZ2xA0
         t/ijZtDJXvKiGBrNIrNjSFgcmO8YkoWVOSXnOckw/+qDZfdCgGqLRHkZFhoUzX0rWItw
         w2sJgQhZFTcQXIreLySn5GnhwxZk9kVuyptUWokNJH4uu6P5k2cP0WOQ2mVtKlgndqsu
         ew9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512504; x=1689104504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6Ue4bYrXyR9j80ovW9fc7Vt7MxWUEhRPqPmpf2o0qo=;
        b=WgFSlD8/iCnXk/dPbXpycAti0DHLDzbOLCxPZ13/ruF5akMCaE6ZRsOJPUpaU9BRkF
         VTFni3z9VZ1o2ZWrgH+2VsXxWUsiOo5f45U+kjOuGESqghgxdpaULu0o5BlrTeez8ZM8
         uvfb/A1u5lMZRf338bYpPdmVp7yLkQ2YuKK5uzYx3CwdSfaID/PPtrseJb93fMvAmWAr
         kWAcm6Wr9mRQTJLrN3Oj6ZppfjOBSCs1EjJ+S74fULbDyfbXyrcJYwvJKHRDD3YkZvVJ
         Enk18/gUxVtvPc3ZLq+H4WQccOWAN7/IlmvIomx7VyskVvdAkHLR5k/7FeFOVK5tE0H/
         AR+A==
X-Gm-Message-State: AC+VfDxXPo56Ow+5QjEAv5Hz4hNudW+Jan4aHbivcWoueoXStJAQIs/e
        ENiZEoHNAUEQbpSA5L05p9lm2g==
X-Google-Smtp-Source: ACHHUZ4rtxZmAAiTtmPxVVXhq3W7BSegGOw3ef9o1EK9vWgXdelDsLn/HHhHvMActgf6HZguAlCmfQ==
X-Received: by 2002:a05:6512:286:b0:4f6:3ab6:3d9e with SMTP id j6-20020a056512028600b004f63ab63d9emr3127554lfp.59.1686512504688;
        Sun, 11 Jun 2023 12:41:44 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1246960lfl.28.2023.06.11.12.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:41:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 11 Jun 2023 21:41:30 +0200
Subject: [PATCH v3 04/10] mmc: mmci: Break out error check in busy detect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v3-4-cd3d5925ae64@linaro.org>
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

The busy detect callback for Ux500 checks for an error
in the status in the first if() clause. The only practical
reason is that if an error occurs, the if()-clause is not
executed, and the code falls through to the last
if()-clause if (host->busy_status) which will clear and
disable the irq. Make this explicit instead: it is easier
to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 73b5205592ae..fbc13923f4fe 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -665,6 +665,15 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
 
+	if (status & err_msk) {
+		/* Stop any ongoing busy detection if an error occurs */
+		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+		writel(readl(base + MMCIMASK0) &
+		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+		host->busy_status = 0;
+		return true;
+	}
+
 	/*
 	 * Before unmasking for the busy end IRQ, confirm that the
 	 * command was sent successfully. To keep track of having a
@@ -678,7 +687,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * while, to allow it to be set, but tests indicates that it
 	 * isn't needed.
 	 */
-	if (!host->busy_status && !(status & err_msk)) {
+	if (!host->busy_status) {
 		status = readl(base + MMCISTATUS);
 		if (status & host->variant->busy_detect_flag) {
 			writel(readl(base + MMCIMASK0) |

-- 
2.40.1

