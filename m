Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E075EC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Nov 2022 02:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiKWCMc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Nov 2022 21:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbiKWCMb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2022 21:12:31 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95FFB85;
        Tue, 22 Nov 2022 18:12:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VVUQGIZ_1669169542;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VVUQGIZ_1669169542)
          by smtp.aliyun-inc.com;
          Wed, 23 Nov 2022 10:12:23 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tonyhuang.sunplus@gmail.com
Cc:     lhjeff911@gmail.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mmc: Remove unneeded semicolon
Date:   Wed, 23 Nov 2022 10:12:21 +0800
Message-Id: <20221123021221.9646-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

./drivers/mmc/host/sunplus-mmc.c:321:2-3: Unneeded semicolon

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3238
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mmc/host/sunplus-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index 5c36daf09bfb..db5e0dcdfa7f 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -318,7 +318,7 @@ static void spmmc_set_bus_width(struct spmmc_host *host, int width)
 		value &= ~SPMMC_SD_DATA_WD;
 		value &= ~SPMMC_MMC8_EN;
 		break;
-	};
+	}
 	writel(value, host->base + SPMMC_SD_CONFIG0_REG);
 }
 
-- 
2.20.1.7.g153144c

