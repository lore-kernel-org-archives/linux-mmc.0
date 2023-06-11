Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D438C7EE23
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Jun 2023 19:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFKTls (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Jun 2023 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjFKTlq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2023 15:41:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6D3E42
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f63a2e1c5fso4217799e87.2
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686512502; x=1689104502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97fyKcVEFuh2Yeg9Iaqs54dTpBgorwtoQwgxut62TCg=;
        b=yA0SGohAqbPT7T7z8/1vC7qEJb2uBbpUCq00HUlyQl6KSBH0cIZsKbggzUaaJbbX8w
         6xMiluvmqvyH3+2mi8cUQ+qY/dwp1NSL1LWZ+14JP2bxQOG/mTkpFZb7+R9ikSrXADyL
         +n5/kxPUUjXHLOIQWVoM/GFoVnGCu5kTQ/fGQjAbb+K84mDr1TmWYcFeAXgVh/Ctp0G8
         k4ox7k2GhzU1TrZi704Bh07grXgTOg9jFKpt4iwVa7Lz0tE/HOmUTy5D+yYELdH/+dT9
         3+AkwAcnmlD1/Ip+LbADMTInfuN7Z7Dw/FFyurY8yPB8Ndw77h0Jpc/3jVlDYVObzxLZ
         zgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512502; x=1689104502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97fyKcVEFuh2Yeg9Iaqs54dTpBgorwtoQwgxut62TCg=;
        b=UpR4iz0QPN9BVkJWFghoejuROjy6FzehX8d1jtZXJHmMfxQxnnsSgBQeKNpB5s1TGj
         GN3CtoUrDQiCkB81dPr4CM64Zp6ni0vLCiyy+h5EHeIAhsACHMJcm5QSgCX2g23Hh9JP
         +SX++fPt78VA3tlY78Gf4c/8lPPH6Gp1166BPOXWExmHqVD+bsrim6v+bZcpPaN0pRth
         zDLirnaGEBmcqRCCSEPk3XivbWfDaUqCwm6KYv9VKrIyFiQoJZL5+9+ZQkaa0Mx4oyYQ
         3E0GLs0xAyIWdAppd3jIoGKKBCAMNlpxDeNI2OqKzxwzzMDsK5n2Cje7WLaw7k3HXGJy
         8bzQ==
X-Gm-Message-State: AC+VfDwHYONGqRxgbQw+GwHA/EJh8e8ppFgQuaNTW+B4bCdkwMfT9yq3
        bC2mgBPJfYcFyvtnDjf9ppG/IA==
X-Google-Smtp-Source: ACHHUZ4FPt8+JEfGlHmbu5/k2niTR5QSnYLJBX0CszSWlXLxjQ6sdECjmra5ebSwlCr6RPqBbhbpZQ==
X-Received: by 2002:ac2:498f:0:b0:4f4:b378:469d with SMTP id f15-20020ac2498f000000b004f4b378469dmr3280704lfl.41.1686512502572;
        Sun, 11 Jun 2023 12:41:42 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1246960lfl.28.2023.06.11.12.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:41:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 11 Jun 2023 21:41:28 +0200
Subject: [PATCH v3 02/10] mmc: mmci: Unwind big if() clause
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v3-2-cd3d5925ae64@linaro.org>
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
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- Only assign the cached status in host->busy_status if
  we have busy detect signalling going on.
---
 drivers/mmc/host/mmci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 14d639872952..d8e7b17adaee 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -654,6 +654,13 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 	return MCI_DPSM_ENABLE | (host->data->blksz << 16);
 }
 
+/*
+ * ux500_busy_complete() - this will wait until the busy status
+ * goes off, saving any status that occur in the meantime into
+ * host->busy_status until we know the card is not busy any more.
+ * The function returns true when the busy detection is ended
+ * and we should continue processing the command.
+ */
 static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
@@ -671,14 +678,16 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
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

