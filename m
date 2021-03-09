Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A94C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 06:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE97265299
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 06:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhCIGsO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:48:14 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35183 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhCIGsD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 01:48:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UR3kCff_1615272481;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UR3kCff_1615272481)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 14:48:01 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     brucechang@via.com.tw
Cc:     HaraldWelte@viatech.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] mmc: via-sdmmc: remove unneeded variable 'ret'
Date:   Tue,  9 Mar 2021 14:47:58 +0800
Message-Id: <1615272478-52458-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix the following coccicheck warning:
./drivers/mmc/host/via-sdmmc.c:1274:5-8: Unneeded variable: "ret".
Return "0" on line 1295

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mmc/host/via-sdmmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 4f4c081..a1d0985 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1271,7 +1271,6 @@ static int __maybe_unused via_sd_suspend(struct device *dev)
 static int __maybe_unused via_sd_resume(struct device *dev)
 {
 	struct via_crdr_mmc_host *sdhost;
-	int ret = 0;
 	u8 gatt;
 
 	sdhost = dev_get_drvdata(dev);
@@ -1292,7 +1291,7 @@ static int __maybe_unused via_sd_resume(struct device *dev)
 	via_restore_pcictrlreg(sdhost);
 	via_init_sdc_pm(sdhost);
 
-	return ret;
+	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(via_sd_pm_ops, via_sd_suspend, via_sd_resume);
-- 
1.8.3.1

