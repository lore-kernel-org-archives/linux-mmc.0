Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6883DC5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 06:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0860D208B8
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 06:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKRGeN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Nov 2020 01:34:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50528 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725794AbgKRGeN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Nov 2020 01:34:13 -0500
X-UUID: 92d89cdc1c634cf28d265d8639f7634b-20201118
X-UUID: 92d89cdc1c634cf28d265d8639f7634b-20201118
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 462278039; Wed, 18 Nov 2020 14:34:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 Nov 2020 14:34:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Nov 2020 14:34:07 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH] mmc: mediatek: Add system suspend/resume interface
Date:   Wed, 18 Nov 2020 14:34:05 +0800
Message-ID: <20201118063405.24906-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Before we got these errors on MT8192 platform:
[   59.153891] Restarting tasks ...
[   59.154540] done.
[   59.159175] PM: suspend exit
[   59.218724] mtk-msdc 11f60000.mmc: phase: [map:fffffffe] [maxlen:31]
[final:16]
[  119.776083] mmc0: cqhci: timeout for tag 9
[  119.780196] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
[  119.786709] mmc0: cqhci: Caps:      0x100020b6 | Version:  0x00000510
[  119.793225] mmc0: cqhci: Config:    0x00000101 | Control:  0x00000000
[  119.799706] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000000
[  119.806177] mmc0: cqhci: Int sig:   0x00000000 | Int Coal: 0x00000000
[  119.812670] mmc0: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
[  119.819149] mmc0: cqhci: Doorbell:  0x003ffc00 | TCN:      0x00000200
[  119.825656] mmc0: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
[  119.832155] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00001000
[  119.838627] mmc0: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
[  119.845174] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x0000891c
[  119.851654] mmc0: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
[  119.865773] mmc0: cqhci: : ===========================================
[  119.872358] mmc0: running CQE recovery
From these logs, we found TDL base was back to the default value.

After suspend, the mmc host is powered off by HW, and bring CQE register
to the default value, so we add system suspend/resume interface, then bring
CQE to deactivated state before suspend, it will be enabled by CQE first
request after resume.

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index fc5ee5df91ad..c5f9cd6fc951 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2758,11 +2758,29 @@ static int msdc_runtime_resume(struct device *dev)
 	msdc_restore_reg(host);
 	return 0;
 }
+
+static int msdc_sys_suspend(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	int ret;
+
+	if (mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(mmc);
+		if (ret)
+			return ret;
+	}
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int msdc_sys_resume(struct device *dev)
+{
+	return pm_runtime_force_resume(dev);
+}
 #endif
 
 static const struct dev_pm_ops msdc_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(msdc_sys_suspend, msdc_sys_resume)
 	SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
 };
 
-- 
2.18.0

