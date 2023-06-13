Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F268EB64DD
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFMUee (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjFMUec (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A69DC
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f658a17aa4so6691550e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688469; x=1689280469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2Xs3XgGJttCT2952b8M8V6pJJgNj+V+JW7LJwfPkUM=;
        b=YZZUMljVoLCRehekqNwUr42thbxpLbBIH/2jnNJqY5Y7DE0SwxpGZACVeYsMb8oqOV
         lQsLn4YYLs2fEREGsIw0gUkUMwxAenDkeFX4PGlNSCA4n4y6x8hiJ8Y+jP/KxH1lE6fX
         wa591VIA/MtLG9q3olyAeD4ZxMCROoMKrH8MCUdSAU0vByfD3FO74QMSQ+PCkNih26bq
         7bR1ThZ5hJdF6gkb3Q6HL4kH1NCwg+yW60pW7PKoGVWSAzGvNu6aAkQsCxMBTVQkQLeT
         z4J0Xshd9xMPVuJZi2O26CMTArz0PI709LYWoU8qqPIuGHBEZ14c3fGb3KTT0oDWutVK
         LONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688469; x=1689280469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2Xs3XgGJttCT2952b8M8V6pJJgNj+V+JW7LJwfPkUM=;
        b=A/BqY0UjkD9ZrFyX2wh0ZPxTJWNM8MPAUcKhYhmmvl2Ul6GbcHXLci+fCOYS0FiZHo
         /nbTj+KCpFMWvK/aPU4ygrCAa5yQ0z7IUKdDFxOIqeDBmScpyCsAeIzoo5goVgYXxpfm
         pjrGdQbXVP1FhPExiKd+YFzRMRtpWVyT1BSsAVZzlgM0HrrCr6wvEGE3fbfeW6NbsEnS
         BLEgWIXpXq6xeQ9nTASBsgvDd+BGM/tVbED+gnunGrrnbVAbjqih85LLpDCUDaMWyKi9
         0PnBlPq6aXoQ6GNBhBlPqIaonEtRDPbk97n/5AqtEjxW2s6E1dTLT2EUIocM8MmtR9y5
         3heQ==
X-Gm-Message-State: AC+VfDySgjl8QAglZtEybUHRctOZi8HwOezAWrh1IyBi9zwouzkRq4L8
        4N3DeJhd4KuzTL780+Q4E8UX7w==
X-Google-Smtp-Source: ACHHUZ6fZm7YQd7MlaNDN8uljS3Hdj3RBXwGZEnl6OMQ0T50GRRu2flWt5GAGuE0HYaEU9gJ6Q7y9Q==
X-Received: by 2002:a19:8c0d:0:b0:4f4:c973:c97f with SMTP id o13-20020a198c0d000000b004f4c973c97fmr5921646lfd.49.1686688469107;
        Tue, 13 Jun 2023 13:34:29 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:28 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:34:20 +0200
Subject: [PATCH v4 04/10] mmc: mmci: Break out error check in busy detect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v4-4-df9c8c504353@linaro.org>
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

The busy detect callback for Ux500 checks for an error
in the status in the first if() clause. The only practical
reason is that if an error occurs, the if()-clause is not
executed, and the code falls through to the last
if()-clause if (host->busy_status) which will clear and
disable the irq. Make this explicit instead: it is easier
to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 47b306e45f78..d632658d9d20 100644
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

