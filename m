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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A4EC433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 07:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C2560FE6
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 07:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhETHkQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 May 2021 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETHkQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 03:40:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF3C061574;
        Thu, 20 May 2021 00:38:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so4976305pjb.2;
        Thu, 20 May 2021 00:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiPsJNGM4sCbj6djsRajsc6kTack1LF/u3c+wT1/9g0=;
        b=tH68u/7OQRmhRmsRDWCeJIPONTuTrp73VMorKn+Thvup8aVIhdrDz2fBa2k2JuQAjs
         6ab1GxZIqkJMGgOV/GWmQgF5pUJrRr2m6s+w6aOxOGJXFD64Lcm7jCWKk5Dgsxys25LS
         PliVWS/5IBWHQnAGBsIFl/7pbAwXOSHqCqu0h3Yn/U4iOO+yDbb5cbplgwc6VV9KhLMu
         zAuHTvaGy8snYnucg0bRHbf+CTUIO9keVY+uVwPc/FIbSCcT/MT6+aS2GbafviZDx/3K
         3962eWM7JAw8q2CcsU7YWaXU0IbpHLK57kIvNphJfSU0XjQa7ZIRswlYhBLAA1hzcDdi
         Jv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiPsJNGM4sCbj6djsRajsc6kTack1LF/u3c+wT1/9g0=;
        b=Y0Ndh8ZkdccvF5UwlrLhkL1py/T0Bs/tXcnsWRRS3ZPlHCkIR1Rjp4guNDUBSTqLYb
         sdI6AOj30B045/c1WBaZ3X25gb1r1Y5luWLJgPuvXhI2/Z+Mg/PLbf/bPucTAwvoUCsv
         swjw7A007jpL5Pzn2aZs2xSDeRdUMCnAglygPI4shoodK4zxa1fU0QpFiPUA2uNw9Rhb
         LLeQY9vMBLjzbG4Z6u9ltTenBNXQ9FD7Wr1J8EjwwWoHJi6VIGQGddGTTX0RM+iR6SXZ
         SlKuVtroT36PhQy2oKuEqKDFIearbszduv8UHP/Pz5XREFjoslySWc380yc9/Xf3wAVa
         inlw==
X-Gm-Message-State: AOAM530ub1EuwukG+4HjAqZm7TUh6tiINGncLgwrSK7N2oD/XKPWmgcz
        9KGf8n3RiYQpQW1f8j8gg+s=
X-Google-Smtp-Source: ABdhPJzJZ1O/rsUSwqE7oxekfDWUS/KFyIrVfXdIVoDq8locd+XLepYve+7fFVvZrNb2dfxqcDK+EA==
X-Received: by 2002:a17:90a:c7d5:: with SMTP id gf21mr3820930pjb.87.1621496334941;
        Thu, 20 May 2021 00:38:54 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id g4sm1289746pgu.46.2021.05.20.00.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:38:54 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: core: Return err directly if mmc_wait_for_cmd() fails
Date:   Thu, 20 May 2021 15:38:46 +0800
Message-Id: <20210520073846.1920-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We do not care the '*rocr' when mmc_send_op_cond() fails.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/mmc_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5756781..b282998 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -180,7 +180,7 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_cmd(host, &cmd, 0);
 		if (err)
-			break;
+			goto out;
 
 		/* wait until reset completes */
 		if (mmc_host_is_spi(host)) {
@@ -208,7 +208,7 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 
 	if (rocr && !mmc_host_is_spi(host))
 		*rocr = cmd.resp[0];
-
+out:
 	return err;
 }
 
-- 
1.9.1

