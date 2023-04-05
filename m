Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FEC77B62
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjDEGuj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbjDEGuj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33E3A8E
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y20so45369736lfj.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzNDUri52+ydwnf/71tMhyZyGCHdCPy1yA6ftXOBwcg=;
        b=xwbw5c1tMoZpFDnTx4NAqBXZGcaMkUkhjWMiuO9UG19bRMZaouaHMfUN4Llg69zepE
         +24Zl+9gH8GGbC49btX52adt4iZBT+56J2Gl8mq1kqqYETj9CB1ggq8xt1lT1AFFBJL8
         jV9TSGuFqFfBdLAAqbB1rIBXEbbM9j47YDVH8hv2sXeotgrrPi0SMWL3/o5+crv5YRtZ
         Syap8G15D341r3qyk3srGJ0SDgS82j8dQa0EAz0g5sLCNGNYqtsBS/8DzW29bZFd4bMG
         A9u4RVqqfPKV71XLzEHzD2S31RttzrFkdf/LHFkeGB0Sg/Aqv3Uu767EfWyVVbVSF0QY
         57WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzNDUri52+ydwnf/71tMhyZyGCHdCPy1yA6ftXOBwcg=;
        b=RH4aKkWWBjEnt5S0KkuN6bMsz6wSgnFhDI5IlPyZ3LJA4JeJjZFsVH5Klo4XW0/72B
         nPlsqEL+8KKkIMr9z9pfgKWFnL/AnvbBdsvUCUeYNgxYcu0xZSywFr9th/pBZmbOvRY7
         SXP8Oz0W5hZbjttOvXRkM5y3idPQrIpf5D9NhJZTDwqxl8q0UA1ZuQ1Zf40NuhZYTxkT
         iVKhhU49SFiWde5kWudTM+0TIbQxKWZymwr+mn3oPDlu8Gzcar+obsizv3Xqwn+BJ9+0
         8cLiA6Qs/qOiGvZwBUhFf3UbJzuEbZifUO8FXDgRtW+djNrvkF0oBObmymVbS+Z1qb0/
         Rpkw==
X-Gm-Message-State: AAQBX9ctext/TnC5V2JJTg+Oed0v4RqadkxCFNZLbVZlaX1ZRaSpZmlc
        CE+2lqnp5U3qULf27FHP4yiM5Q==
X-Google-Smtp-Source: AKy350bFChkzu/xDuMrQEacxaYMKmPDwmQZtQnPBti5B1xqTDTgiwMx5x20RvKZlOVJIVjSyFspsEQ==
X-Received: by 2002:ac2:5d46:0:b0:4ea:e296:fe9e with SMTP id w6-20020ac25d46000000b004eae296fe9emr1235549lfd.9.1680677436318;
        Tue, 04 Apr 2023 23:50:36 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:29 +0200
Subject: [PATCH 03/13] mmc: mmci: Unwind big if() clause
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-3-28ac19a74e5e@linaro.org>
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
 drivers/mmc/host/mmci.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3e08b2e95550..3c1e11266fa9 100644
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
@@ -671,14 +678,17 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * while, to allow it to be set, but tests indicates that it
 	 * isn't needed.
 	 */
-	if (!host->busy_status && !(status & err_msk) &&
-	    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
-		writel(readl(base + MMCIMASK0) |
-		       host->variant->busy_detect_mask,
-		       base + MMCIMASK0);
-
+	if (!host->busy_status && !(status & err_msk)) {
 		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
-		return false;
+		status = readl(base + MMCISTATUS);
+		if (status & host->variant->busy_detect_flag) {
+			writel(readl(base + MMCIMASK0) |
+			       host->variant->busy_detect_mask,
+			       base + MMCIMASK0);
+
+			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			return false;
+		}
 	}
 
 	/*

-- 
2.39.2

