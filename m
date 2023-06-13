Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566DCEB64DB
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjFMUed (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFMUeb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D4A1996
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f620583bc2so7460675e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688467; x=1689280467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjbTCpreEwrPILZW6pVXqr+kf3zl3RqDAOxeSTWO4Xo=;
        b=OGfRhCFCEBHmYRzodJx0DsHjJwHotZpGZY8TupzhoiuigjQ/wY3KjwP/2zSy6xQ7jC
         PzyIy7Z6+Zzfe0fnf3t0qlYmFcb3E/xFhSgJ4+GfHB5vDnWFxP9fhsj2u9E5Voo5ICaV
         7JDEOksiEw/NbZKgGU04Qjzj83hKRY/8qb85uxw46wGTnI9bEChR+zIRKY0n2BLYcUf3
         vBHDzKlWlAu7aJ/snZj+kaX13XoDtJAbrxWlsfdi7fmaL+EYFuxKHT0/K7iZeRAa0twU
         hW31Y2XZcT+dsH1pEoPysyw2A0/Q+QNKG2xxIwx6WnzRVcJcC6UUmRExQaVswFouOG8P
         nXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688467; x=1689280467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjbTCpreEwrPILZW6pVXqr+kf3zl3RqDAOxeSTWO4Xo=;
        b=cfK5GQptt3twPs2BSVMhsVRaM0Qwsq0R49P+a6dxfXXo7ahXjl8aU+Cg1CJ2JJYOE7
         tyuNL2XV3Fg7R2yybdRQrkeTsuzLCs9F7Y34/3WSORuMeBk4RqwigXC3u0cY351MlXn1
         Eg3M7KdPOHbEpqjVWSXBTBoeBJElG7e6fxK93rOUr6GQxLo79e9Og3suH4wztVuT3cEx
         ANRobw4YUzlnTCygyqf9cUYpYJx+yMMhC/gmxNxaichoDRTDWOA4USHoLcajVFCCQmsi
         6FfiWugqxEzrh9roTF5BYComYQ9j1oY5npziXzxgal48a7+NDCJFUlluv+weB0zUv6QK
         A8GQ==
X-Gm-Message-State: AC+VfDyTJ0G0NqMrJatczTPE4ea/Mmpeq5rzxTXqB2h4tgyeDjmo+gyo
        doBoshgpzwoQuWXSy82ucgbsPg==
X-Google-Smtp-Source: ACHHUZ4bLabGiY0m9kbpH88S2x0f/T1TMtQw6g60ZJS+cKL8tYcQdAXtZcauyjVGuutNwa1+6YGaWQ==
X-Received: by 2002:a19:ab01:0:b0:4f1:3bd7:e53a with SMTP id u1-20020a19ab01000000b004f13bd7e53amr6432839lfe.49.1686688467301;
        Tue, 13 Jun 2023 13:34:27 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:26 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:34:18 +0200
Subject: [PATCH v4 02/10] mmc: mmci: Unwind big if() clause
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v4-2-df9c8c504353@linaro.org>
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
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- Only assign the cached status in host->busy_status if
  we have busy detect signalling going on.
---
 drivers/mmc/host/mmci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0a4b6b6e0f03..eee449f90915 100644
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

