Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9A3C56202
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 07:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFDD221FC
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 07:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKLHw0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 02:52:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53561 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgKLHwT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2020 02:52:19 -0500
X-UUID: f86e32c304ef4ebaa5b93d08d8b7ec87-20201112
X-UUID: f86e32c304ef4ebaa5b93d08d8b7ec87-20201112
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1451875633; Thu, 12 Nov 2020 15:52:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Nov 2020 15:52:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 15:52:12 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <irq-linux@rere.qmqm.pl>, Wenbin Mei <wenbin.mei@mediatek.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v1 3/3] mmc: core: Set cqe off during suspend flow
Date:   Thu, 12 Nov 2020 15:52:08 +0800
Message-ID: <20201112075208.28183-4-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201112075208.28183-1-wenbin.mei@mediatek.com>
References: <20201112075208.28183-1-wenbin.mei@mediatek.com>
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
to the default value, so CQE need to be re-initialized after resuming back.

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
---
 drivers/mmc/core/host.c | 2 ++
 drivers/mmc/core/mmc.c  | 5 +++++
 include/linux/mmc/pm.h  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ce43f7573d80..c98486c8fb3b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -284,6 +284,8 @@ int mmc_of_parse(struct mmc_host *host)
 	if (device_property_read_bool(dev, "wakeup-source") ||
 	    device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (device_property_read_bool(dev, "cqe-off-in-suspend"))
+		host->pm_caps |= MMC_PM_CQE_OFF_IN_SUSPEND;
 	if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
 		host->caps |= MMC_CAP_3_3V_DDR;
 	if (device_property_read_bool(dev, "mmc-ddr-1_8v"))
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b3fa193de846..f5ae1f13a867 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2047,6 +2047,11 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		err = mmc_deselect_cards(host);
 
 	if (!err) {
+		if (host->cqe_enabled &&
+		    (host->pm_caps & MMC_PM_CQE_OFF_IN_SUSPEND)) {
+			host->cqe_ops->cqe_disable(host);
+			host->cqe_enabled = false;
+		}
 		mmc_power_off(host);
 		mmc_card_set_suspended(host->card);
 	}
diff --git a/include/linux/mmc/pm.h b/include/linux/mmc/pm.h
index 3549f8045784..3dd1046f2c8f 100644
--- a/include/linux/mmc/pm.h
+++ b/include/linux/mmc/pm.h
@@ -23,5 +23,6 @@ typedef unsigned int mmc_pm_flag_t;
 
 #define MMC_PM_KEEP_POWER	(1 << 0)	/* preserve card power during suspend */
 #define MMC_PM_WAKE_SDIO_IRQ	(1 << 1)	/* wake up host system on SDIO IRQ assertion */
+#define MMC_PM_CQE_OFF_IN_SUSPEND  (1 << 2)	/* cqe off during suspend */
 
 #endif /* LINUX_MMC_PM_H */
-- 
2.18.0

