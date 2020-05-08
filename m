Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977CC38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 11:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BE3206D6
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 11:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKPX9yE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHL3A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHL3A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 07:29:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF769C05BD43
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 04:28:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so1266994ljj.11
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MhxfN8SxWdzLn5dMAyqxuGTc1RgZ6rin/GDX/jd0f+0=;
        b=ZKPX9yE36H2wtQ3VjloefuuUrYsUwjVrwfFJNGFGYkMyRjO8A3r4sWl2jcXsOP8AC9
         UJ8zYFu1ghNGoeOnv7rJ3VpMEUe0IDQIhXVoQNAMQrz8W5AeVZVdQct/jgnQhlVAA13i
         1DZaq7WmQgd02YIRU2/gJfRJS/swygeM4kc5sCsckkgPI1cg9KfJDrZozqW8Ej2U7ort
         rbG7NWJVwatVaPzNysjlKESiEEHyRoK7Pknb45QwHcH1y4oBXBkORgKQx6Y+y0GgSw7k
         fHwciFos1JnKf4by+Uxclv2WeeBavhfuu5Vq7YEGIUPynrF/mK0cQRZacNYHUNcg5ieT
         dXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MhxfN8SxWdzLn5dMAyqxuGTc1RgZ6rin/GDX/jd0f+0=;
        b=BxAlNey62fQ784vfQQaoyZX9JYTuKT3Hagq+0BNL1Ss+x6QwjQPW+k82KFw+zqy2jo
         /OZ5BoxfNNnvrM1fmMzNFC+FQB/DHfLm8O76GhZ4+Ydcl67wIDawcmZhIf3r3tr4Lpbr
         f5fLGMV7kqQ+4+F3yN0t6bY2OpnerPmPwsqAgV/H4FwBt6lh8hct9oeZFEcUeye6CTjI
         KgBYeTcZWCIpUnKW8G/5Ea+xYNwD1NXIDKXS9m49H9QxP7E1FMSwWbvqQFzVJOWQT04A
         iLf0eHOFeaywS6fJIhDYNDqEQI+SWTkdGcfxcj32/msctld9L1A5nkk+4pZSCJUn7fov
         fI8Q==
X-Gm-Message-State: AOAM531DPjLol0qEiJ3yaleA9q87VIj+w5FmhAAOMqRM4rb0LBjmD53h
        0r8lM815I8vpoDhWNdl9beHDxzLC20U=
X-Google-Smtp-Source: ABdhPJxrj9Y0bYuPfk0zghwguTUWkRn2VVke2+xrpwKfhjTeNTsHgU2qDNR9RlJ/fhjWo8+xnMmkXA==
X-Received: by 2002:a2e:80da:: with SMTP id r26mr1368925ljg.38.1588937337746;
        Fri, 08 May 2020 04:28:57 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id w29sm1051292lfc.4.2020.05.08.04.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 04:28:56 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] mmc: core: Enable erase/discard/trim support for all mmc hosts
Date:   Fri,  8 May 2020 13:28:53 +0200
Message-Id: <20200508112853.23525-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Step by step, mmc host drivers and the mmc core have been improved in
regards to support erase/discard/trim operations. We have now reached a
point when it no longer seems reasonable to use an opt-in approach to
enable the functionality. Therefore, let's switch to make the operations
always supported.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4c5de6d37ac7..8d2b808e9b58 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1815,8 +1815,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	unsigned int rem, to = from + nr;
 	int err;
 
-	if (!(card->host->caps & MMC_CAP_ERASE) ||
-	    !(card->csd.cmdclass & CCC_ERASE))
+	if (!(card->csd.cmdclass & CCC_ERASE))
 		return -EOPNOTSUPP;
 
 	if (!card->erase_size)
@@ -1872,8 +1871,7 @@ EXPORT_SYMBOL(mmc_erase);
 
 int mmc_can_erase(struct mmc_card *card)
 {
-	if ((card->host->caps & MMC_CAP_ERASE) &&
-	    (card->csd.cmdclass & CCC_ERASE) && card->erase_size)
+	if (card->csd.cmdclass & CCC_ERASE && card->erase_size)
 		return 1;
 	return 0;
 }
-- 
2.20.1

