Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A42C77B70
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjDHWAl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDHWAj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 18:00:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A411955BF
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 15:00:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h11so51424564lfu.8
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 15:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680991237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eL2tfczN7su2jHUV2L3L9PcxI+ycYQtmblvqUdrfgmI=;
        b=sbCZRGtj0pBtvuBE5qNrrAagA41l80nwBDTq9ERbV6uofvc9xMva7TzDVOiDm0nJBG
         UpgBWOg4DpEZc0LdhmVOtrp7/GNV/52R1jgnUp9KtAWAruqmkuOhDrGJFUBZ105Xe8ia
         aVysJEU5LxZSZ7sjfCyRrNi+7riA35fQTFZ3mEsnwTrXWk1QPExdyYpWdRVJT+wuU3Wa
         geBtzI7TYoIthWk+pZfr0Zh4I4scxVMC7zx4PSqHyb1Yr3NCrkwYplOtjRN8qDqVlmyN
         71rEgtepq666wLQ7NInidKflpds+sqHV8DPxt9Rw70Kn2IvMWh/OpTUt494kJxkShVPx
         pdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680991237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL2tfczN7su2jHUV2L3L9PcxI+ycYQtmblvqUdrfgmI=;
        b=pbf/S2L0pQLLbKYfeRTXsQ5EwgdlWHW5HngTTU6iQjdtFX25VckSLo/ypu73zk/TAI
         YZt/Z3iVESbUDvH7Hg31t6YAq/RmmRbCvzITPbkFuxkV0aJnVgMBvuTFc1w8tcbMTd7u
         KKpwSzQMDYf9kw3PB8Sc8eLahDEhKhiJn5D6ZOg3JEurjVzKAovQRnngGQea4EuVKlJ9
         bRPriS1ukvtEtCbWnzsuNCiKwkyIJokzPiN7UMdmYUHioOndMTykrYH5axNKnlxqUV4J
         izJq9wwxFLNSw+8chaLI/XcUTdLgRF1ynO+MzKWbYIWnge2hQG8oSvG4gRHq8JO30fPY
         ps/A==
X-Gm-Message-State: AAQBX9eeb7FzlMTbajK61d/WrIjGpxvMpFx8bz/aeiSctjKE8Y2sB9I7
        0svX96q2Z5WI+plx/S2GzZ8nyk2U1TdHnsdiQBo=
X-Google-Smtp-Source: AKy350bdedttz8LNGHVTqRJZTPzHsZh/f5b5PazxcSTopf17Qg+1MOLB28Li27oAmDRNouCVlW0O5Q==
X-Received: by 2002:a19:c206:0:b0:4eb:30f9:eed7 with SMTP id l6-20020a19c206000000b004eb30f9eed7mr1630557lfc.22.1680991236968;
        Sat, 08 Apr 2023 15:00:36 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm1328904lfq.229.2023.04.08.15.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:00:36 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 09 Apr 2023 00:00:24 +0200
Subject: [PATCH v2 03/12] mmc: mmci: Stash status while waiting for busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v2-3-eeb10323b546@linaro.org>
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

Some interesting flags can arrive while we are waiting for
the first busy detect IRQ so OR then onto the stashed
flags so they are not missed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8496df2020d9..e742dedaca1a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -703,6 +703,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 */
 	if (host->busy_status &&
 	    (status & host->variant->busy_detect_flag)) {
+		host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 		return false;
 	}

-- 
2.39.2

