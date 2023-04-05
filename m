Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF3AC76188
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbjDEGum (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbjDEGul (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A583A8E
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k37so45379212lfv.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZaLiA0g44U1TRcntaLQYKCUF28R2/Q5H+MPwsKmLwc=;
        b=fL7wUylNUaTmX4XGMPv3Cf3g4V40XOfdDDRUJhuxhA1S73DqkqRsTKyTkpRo26F3I5
         wYiswhO7fQSs/zhzMjc1rSdhzmAYgDucl/YGPmUPSD4/mT5Cc4ksFxdxx/h5oBn3KP2W
         7ChV88hCqTnfVwOqgqDN57/4ncGkTnsTfvtEp250NJaW0UQVSs981X4E46XHW7rdXf8E
         iSagJzZW9Vc61fAU6Amnh7D02OZZOpa9vTxS6ckzHkPS1rJN7bmLTldumT91APF2Vldl
         ttmxnsQ2LZcprscsEi7Dp7bsDPEI0B8oN61ccha3C+Jr2DTFd5sy1VvHmPihFCFhgy4q
         D9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZaLiA0g44U1TRcntaLQYKCUF28R2/Q5H+MPwsKmLwc=;
        b=AAPR9hYZA19ILOnMS5z/LnCa8csdo4h2GLDRxOdq20HMHaY5GUaCpaPNTIaJdmnEaQ
         pLxdIG/nXVua2hjIDdQKn09gbsuomunk00RmL4obZnfSo1r40ZofZZWmBv0g2ENUHI7v
         +SwuluOLRBZLwhqK344XfDhsVXcdw6xPtr2UTfAakR+cEN8EwnuXxAmK8t+tCk8IV5AZ
         BbL+Oy1vMfQjlGyYjJ40PnZQT2sahyHtGG14bxxT/HFQ9D7/Mmkv72dQFZYlG9vb/3ge
         ArWmA3hNoJxepP5q5ZW41xDvvyMc2Gg+Qe+HzCrnih2FcaX1tL3sXoaiHKZvrQIB7ym7
         6PDA==
X-Gm-Message-State: AAQBX9cOIv8YhK2DvgNRXmyaRI0Mu8jRSUdTnRTQLsK8xsWcsmGDsrQQ
        JkmqHKrgE1o7yoM4LHx284I6yw==
X-Google-Smtp-Source: AKy350blL9duykk1KRNQnFkCyz/h8/m3XElkUTeiFRvWyhGuExbfjktkfA11jOcl64HmbSeHNW8YWQ==
X-Received: by 2002:ac2:55a8:0:b0:4e8:3fc7:9483 with SMTP id y8-20020ac255a8000000b004e83fc79483mr1370064lfg.23.1680677438330;
        Tue, 04 Apr 2023 23:50:38 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:37 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:31 +0200
Subject: [PATCH 05/13] mmc: mmci: Break out error check in busy detect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-5-28ac19a74e5e@linaro.org>
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

The busy detect callback for Ux500 checks for an error
in the status in the first if() clause. The only practical
reason is that if an error occurs, the if()-clause is not
executed, and the code falls through to the last
if()-clause if (host->busy_status) which will clear and
disable the irq. Make this explicit instead: it is easier
to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index db3a8ce27a0e..13dec2e09164 100644
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
 		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
 		status = readl(base + MMCISTATUS);
 		if (status & host->variant->busy_detect_flag) {

-- 
2.39.2

