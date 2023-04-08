Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7529BC7619A
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjDHWAq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDHWAo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 18:00:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DFD5271
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 15:00:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m4so2112121lfj.13
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680991238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJsyZE/JIyPbZVqKw0X4sKoqKT/D+w7MAVDudQ5nzcs=;
        b=hOD1t4Lo/31LCyAASej5HsSHFq5ckS+258NNJXMKYW9d+QzQjQvV3aPXTRKouyskLY
         VQgG3wAecuPmi+67x0BD74KJ0vUgYxxH29VF7ThpXa+g+vmXeHjAhNkAGtqFZG0GRuQV
         UwVW1uOhmFGjW5ZVHN1cGa4ZJdqqEgtelsmjFswgrJGCVnCMop+9y098ldYJnRaWxiwP
         zm8Uht9BlE+UGtSRl3S0DCXkB91vd6hW3ygwn3Hlu6r4eO0wlKl4MQEJeTbjwz5IA8do
         OliUFw1NyV6fxIO7tj4kae7dQRTX47Pa+j1CagRASLmWAPRiZq2CueIXNHaNa4jJGo3M
         75Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680991238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJsyZE/JIyPbZVqKw0X4sKoqKT/D+w7MAVDudQ5nzcs=;
        b=P2HUAI4frks1K2a1v9yWhwJkmyTs32dEoiGrf/VijMZxvGCE6dmYNjXQ4vSctq25EB
         Gk9pQAHxhrX5ZjhenGXcd/SOyEiYf76CfW4hkDEkUJkt7zwa97ll1cBGN7mbFm/zb6Gt
         h71463PX2iIiY4VJgdNt5cjRJdNk3oaG2deVS3Xw8mtcA5gDaPQFTb0hypT4W7b0VPkW
         YCpYfE0cHfk9iIRrjahhOKX6FWYqgxAlZhfOzdhUppTjpW6GIGO+DW/QjAEWPA5k/nM9
         o400pTqfc6mhBVVpnpKPanc0WYX3yMVJ2LKJuM6nLgliLkOk7yDvIrInxFxjkpN8sNB+
         QQlw==
X-Gm-Message-State: AAQBX9c4rOiB8Pwle8ulXNR3s+G2Ky1V1EN8K0UC+DCx+T7PVFB6IaWG
        ymCxcoZ7ih99xslNGqG7zEtvVA==
X-Google-Smtp-Source: AKy350andnvVy70t9th/ugLsnTSHw/vQxQcHGqsjcQA8CqI4Gx/+OfteSZvp1zDW482e39XJrjpTtg==
X-Received: by 2002:a05:6512:986:b0:4ea:f7af:7ee with SMTP id w6-20020a056512098600b004eaf7af07eemr1386157lft.45.1680991237948;
        Sat, 08 Apr 2023 15:00:37 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm1328904lfq.229.2023.04.08.15.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:00:37 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 09 Apr 2023 00:00:25 +0200
Subject: [PATCH v2 04/12] mmc: mmci: Break out error check in busy detect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v2-4-eeb10323b546@linaro.org>
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
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

The busy detect callback for Ux500 checks for an error
in the status in the first if() clause. The only practical
reason is that if an error occurs, the if()-clause is not
executed, and the code falls through to the last
if()-clause if (host->busy_status) which will clear and
disable the irq. Make this explicit instead: it is easier
to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e742dedaca1a..7d42625f2356 100644
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
2.39.2

