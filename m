Return-Path: <SRS0=+qgY=A3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C75C433EA
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 12:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FCC2076D
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 12:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FUWkqx6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgGPMnO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:43:14 -0400
Received: from crapouillou.net ([89.234.176.41]:48810 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMnO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jul 2020 08:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594903380; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LhQckHNurdhS6vBban56gv482FE8HQsr0t2XKo3IDvQ=;
        b=FUWkqx6BwzsJoj0gcdVLKpTuSI/+GvOzmToecvnSI7wO1LANUtU2V2wGQ5venagbYnuyUz
        DVRxT4bALigB1jwEpn/t1JeMIgmdELHDP4i61Z0Nmc+t9MFvAIcnkHM2SP/gAfEVFeVHkN
        g+3ztltYQukgEt88WD3hScm0wN+lYaQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, od@zcrc.me,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 3/3] mmc: jz4740: Use pm_ptr() macro
Date:   Thu, 16 Jul 2020 14:42:50 +0200
Message-Id: <20200716124250.9829-3-paul@crapouillou.net>
In-Reply-To: <20200716124250.9829-1-paul@crapouillou.net>
References: <20200716124250.9829-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the newly introduced pm_ptr() macro to simplify the code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Notes:
    v2: Use pm_ptr() macro instead of pm_sleep_ptr()
    v3: Rebase on 5.8-rc5 and add Ulf's Reviewed-by

 drivers/mmc/host/jz4740_mmc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index cba7a6fcd178..447552ac25c4 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1108,24 +1108,18 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-
-static int jz4740_mmc_suspend(struct device *dev)
+static int __maybe_unused jz4740_mmc_suspend(struct device *dev)
 {
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int jz4740_mmc_resume(struct device *dev)
+static int __maybe_unused jz4740_mmc_resume(struct device *dev)
 {
 	return pinctrl_select_default_state(dev);
 }
 
 static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
 	jz4740_mmc_resume);
-#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
-#else
-#define JZ4740_MMC_PM_OPS NULL
-#endif
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
@@ -1133,7 +1127,7 @@ static struct platform_driver jz4740_mmc_driver = {
 	.driver = {
 		.name = "jz4740-mmc",
 		.of_match_table = of_match_ptr(jz4740_mmc_of_match),
-		.pm = JZ4740_MMC_PM_OPS,
+		.pm = pm_ptr(&jz4740_mmc_pm_ops),
 	},
 };
 
-- 
2.27.0

