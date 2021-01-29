Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72847C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 05:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3118B64DD6
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 05:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhA2Fbt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Jan 2021 00:31:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:49247 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231953AbhA2Fbf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2021 00:31:35 -0500
X-UUID: 9c77f5a880134de88f0e810e876e5e11-20210129
X-UUID: 9c77f5a880134de88f0e810e876e5e11-20210129
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1898397024; Fri, 29 Jan 2021 13:30:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Jan 2021 13:30:39 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jan 2021 13:30:38 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 2/2] mmc: mediatek: enable crypto hardware engine
Date:   Fri, 29 Jan 2021 13:29:07 +0800
Message-ID: <20210129052907.31753-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use SMC call enable hardware crypto engine due to it only be control
in EL3.

Change-Id: I5c6c8c534442e030bc5a4de23a317049924a8852
Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 19 +++++++++++++++++++
 drivers/mmc/host/mtk-sd.h | 11 +++++++++++
 2 files changed, 30 insertions(+)
 create mode 100755 drivers/mmc/host/mtk-sd.h

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index e870afd66ae8..923644b8fc1e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -4,6 +4,7 @@
  * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -33,6 +34,7 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include "cqhci.h"
+#include "mtk-sd.h"
 
 #define MAX_BD_NUM          1024
 #define MSDC_NR_CLOCKS      3
@@ -2612,6 +2614,14 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		/* 0 size, means 65536 so we don't have to -1 here */
 		mmc->max_seg_size = 64 * 1024;
 	}
+	/*
+	 * 1: MSDC_AES_CTL_INIT
+	 * 4: cap_id, no-meaning
+	 * 1: cfg_id, we choose the second cfg group
+	 */
+	if (mmc->caps2 & MMC_CAP2_CRYPTO)
+		arm_smccc_smc(MTK_SIP_MMC_CONTROL,
+			1, 4, 1, 0, 0, 0, 0, &smccc_res);
 
 	host->timeout_clks = 3 * 1048576;
 	host->dma.gpd = dma_alloc_coherent(&pdev->dev,
@@ -2770,6 +2780,15 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
 
 	msdc_ungate_clock(host);
 	msdc_restore_reg(host);
+
+	/*
+	 * 1: MSDC_AES_CTL_INIT
+	 * 4: cap_id, no-meaning
+	 * 1: cfg_id, we choose the second cfg group
+	 */
+	if (mmc->caps2 & MMC_CAP2_CRYPTO)
+		arm_smccc_smc(MTK_SIP_MMC_CONTROL,
+			1, 4, 1, 0, 0, 0, 0, &smccc_res);
 	return 0;
 }
 
diff --git a/drivers/mmc/host/mtk-sd.h b/drivers/mmc/host/mtk-sd.h
new file mode 100755
index 000000000000..e9421ef7d880
--- /dev/null
+++ b/drivers/mmc/host/mtk-sd.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#include <linux/soc/mediatek/mtk_sip_svc.h>
+
+/*
+ * SiP commands
+ */
+#define MTK_SIP_MMC_CONTROL               MTK_SIP_SMC_CMD(0x273)
-- 
2.18.0

