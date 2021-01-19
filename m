Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C00C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 05:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4601122252
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 05:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbhASFiT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 00:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbhASFPe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 00:15:34 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD1C061757;
        Mon, 18 Jan 2021 21:14:53 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id g15so7084161pjd.2;
        Mon, 18 Jan 2021 21:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dXrgf1LZzL6eF1i+mvPcch+z/XkMiWVGO2kmOldCnEI=;
        b=DztL4URkAwRJ2ODVyxeNBZBxz5S+xRS8xuaC46nJWu+D8De10B3gwSKVTYmljiNmEN
         TuzPjpuC9IaKIFfa/xre01cevViuOpZgb6OtG4CbVR4C05S0NdEY1rqIXzrmYYFDXNtn
         2GjKpQfoJxg39r1Hn7NCD+OQAAeCGN5NE6Ja8udUSgGGm36tp4mexRj2SkxJ+j9nx0sh
         ZMwnYPh6qnf/cvxhCBYqTV84Pjziw4DG2HTZVGHMsNo/W/ixLqe9YdIzzD1SdVy3Orpw
         Wh8GdsE2cY1XQSXg/BqSQfp8hNYbkbLwqiBrGRZss/Rrqhtil5cICRi66GT06jH7OIHf
         onlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dXrgf1LZzL6eF1i+mvPcch+z/XkMiWVGO2kmOldCnEI=;
        b=qSWrAoliD/QjUMYPhm8k1BRUzKaLx5f+Af+YZOQFqp3r6gRXKHm5LONlEQ00TEU4l1
         +BzKRqz0kxG+WSJK7UrxDgMSgaZepdX1SM1aVmQRmvf2PKV/Fm5SUfAYnzUZOvWRMTdn
         wniswnyOQt9U6x72lxtNjq5RIuhY/q/ZSta9McXAgRtxo44NheUH3DYDXMhfk7y00Ssv
         a7ipEMAaS4cZRjflj+J3ADje7tmNT2dYZYAjWHd2Ocfpu8Ti0AtKU84RbQAQtblYru9a
         MzojujntwQWTxgj/qxLyB/eFN+VzcmfKQaJsB0draN08lsDcla3vftmdXlcdq9HkIPVu
         k7Dw==
X-Gm-Message-State: AOAM5316+MyaVOXyFQjyBSha8//38RC4mkDE6HxgWMjK7ZS3sdTme3Kg
        KhEAymwkknLkJD5YzvzwnAA=
X-Google-Smtp-Source: ABdhPJzSv5y7FgI8sHfaewHW1iOyxsA+jPc2FomGn4TeblnqYWCWFfKU0qY31KFXihgns7xB/8SiDA==
X-Received: by 2002:a17:90a:5c81:: with SMTP id r1mr3315583pji.175.1611033293232;
        Mon, 18 Jan 2021 21:14:53 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id x125sm17687306pgb.35.2021.01.18.21.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 21:14:52 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: test: remove the shutdown function
Date:   Tue, 19 Jan 2021 13:14:25 +0800
Message-Id: <20210119051425.305-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Since it's doing nothing for shutdown behavior. And the callback will
be checked firstly in mmc_bus_shutdown().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/mmc_test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 152e752..f999b48 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3267,17 +3267,12 @@ static void mmc_test_remove(struct mmc_card *card)
 	mmc_test_free_dbgfs_file(card);
 }
 
-static void mmc_test_shutdown(struct mmc_card *card)
-{
-}
-
 static struct mmc_driver mmc_driver = {
 	.drv		= {
 		.name	= "mmc_test",
 	},
 	.probe		= mmc_test_probe,
 	.remove		= mmc_test_remove,
-	.shutdown	= mmc_test_shutdown,
 };
 
 static int __init mmc_test_init(void)
-- 
1.9.1

