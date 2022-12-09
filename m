Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2893AC4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Dec 2022 04:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLIEQS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Dec 2022 23:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLIEQR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2022 23:16:17 -0500
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB8EACB08;
        Thu,  8 Dec 2022 20:16:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=0;PH=DS;RN=6;SR=0;TI=SMTPD_---0VWsiWsO_1670557296;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VWsiWsO_1670557296)
          by smtp.aliyun-inc.com;
          Fri, 09 Dec 2022 11:41:42 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     adrian.hunter@intel.com
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: Modify mismatched function name
Date:   Fri,  9 Dec 2022 11:41:34 +0800
Message-Id: <20221209034134.38477-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

No functional modification involved.

drivers/mmc/host/sdhci-of-esdhc.c:243: warning: expecting prototype for _fixup(). Prototype was for esdhc_writel_fixup() instead.
drivers/mmc/host/sdhci-of-esdhc.c:117: warning: expecting prototype for _fixup(). Prototype was for esdhc_readl_fixup() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3397
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 9d875bb531a8..4712adac7f7c 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -98,7 +98,7 @@ struct sdhci_esdhc {
 };
 
 /**
- * esdhc_read*_fixup - Fixup the value read from incompatible eSDHC register
+ * esdhc_readl_fixup - Fixup the value read from incompatible eSDHC register
  *		       to make it compatible with SD spec.
  *
  * @host: pointer to sdhci_host
@@ -223,7 +223,7 @@ static u8 esdhc_readb_fixup(struct sdhci_host *host,
 }
 
 /**
- * esdhc_write*_fixup - Fixup the SD spec register value so that it could be
+ * esdhc_writel_fixup - Fixup the SD spec register value so that it could be
  *			written into eSDHC register.
  *
  * @host: pointer to sdhci_host
-- 
2.20.1.7.g153144c

