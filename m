Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB21C7619A
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbjDEGul (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbjDEGuk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD764200
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k37so45379164lfv.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSJ4MzJQ8UoPiz3rGVKBpIQtOY1lklGXlYq7/mXSQCU=;
        b=kRXZrFDq4/sV1F5HRJwuIvnh6JTWv/kvEjyGrh00xAUixf6+JOCnJhimtch92xg/SL
         dkm7lhBjKbP6wPWTCSfjIh6ok49XTRZXSDvW3sj1aM7ED67Tk3HbXuxd9SVlGaWYZVb0
         xKQhobCrl87z/3vKBIUZhU2ZwTsMtNyUi9JOmWrXM49z6Cz7706JKrK+rXB3YLcygQ12
         1IoOkUPFTDJq/PWlHG5X8r4jBgDkA2Q61PrZWAQ1/b5HAmfb3mIo/qTn15JEX8JLB+PC
         u1sJLx3++5QK57WbglBk64Gs3aDItT93xvXQR/cI7cay/+iY6H4rQNR4XjbMfalkXw0h
         ZN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSJ4MzJQ8UoPiz3rGVKBpIQtOY1lklGXlYq7/mXSQCU=;
        b=jclIpPPvh38AYD32PVIcrEiWYsS2w49+Af5t3K7mqXlE2HzD5hVrauUyx/uE6jo7Rh
         zVFbl5SGFSC++JEfJ/nRJeWyJBNZBXrtF61XDWkC8tnGosPsVmswrb/zZlZFPdbPuBNc
         Tf6Y236kFFvV3Tuh0YEPQT14lZ/H6xZEC9RgtFm+0dC/UMQn78TudiyWrxSWznHW7soN
         ZelVnsUx1TlG2g8y+my7PrcqiNJ4Di6Du96YNaBhQ7b7PxjCWv4b5YIceFhffwI8cU21
         KplX36a0yPLB0qbh6r/1T8E+34MhRiFH3BUxBEnVKtE/6F34fNzTxS0vML8v+XZYKjAx
         65lg==
X-Gm-Message-State: AAQBX9eVw75NHgQ5bhOSkej4GKOVI4gekXUeTiuq+l2agrN0M1lr5EYM
        WT33tUejr/O2leQsTiW94402tA==
X-Google-Smtp-Source: AKy350Z8FesrBLZIGWRqwdr9YER0mju4LtzITsqbu9lQmVTwD33TDZguDxpYfgzVF655JsV+OwrlIg==
X-Received: by 2002:ac2:46e4:0:b0:4e9:d53b:337e with SMTP id q4-20020ac246e4000000b004e9d53b337emr1257013lfo.45.1680677437096;
        Tue, 04 Apr 2023 23:50:37 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:36 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:30 +0200
Subject: [PATCH 04/13] mmc: mmci: Stash status while waiting for busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-4-28ac19a74e5e@linaro.org>
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

Some interesting flags can arrive while we are waiting for
the first busy detect IRQ so OR then onto the stashed
flags so they are not missed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3c1e11266fa9..db3a8ce27a0e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -704,6 +704,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 */
 	if (host->busy_status &&
 	    (status & host->variant->busy_detect_flag)) {
+		host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 		return false;
 	}

-- 
2.39.2

