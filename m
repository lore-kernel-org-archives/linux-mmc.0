Return-Path: <SRS0=xPu9=EE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA2C388F7
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Oct 2020 01:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5375F20782
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Oct 2020 01:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgJ2B6H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:58:07 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34940 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgJ2B6B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2020 21:58:01 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09T1voID3002945, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09T1voID3002945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Oct 2020 09:57:51 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Thu, 29 Oct 2020
 09:57:50 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH v3 2/3] misc: rtsx: Add SD Express mode support for RTS5261
Date:   Thu, 29 Oct 2020 09:57:48 +0800
Message-ID: <1603936668-3363-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

RTS5261 support SD mode and PCIe/NVMe mode. The workflow is as follows.
1.RTS5261 work in SD mode and set MMC_CAPS2_SD_EXP flag.
2.If card is plugged in, Host send CMD8 to ask card's PCIe availability.
3.If the card has PCIe availability and WP is not set, init_sd_express() will be invoked,
RTS5261 switch to PCIe/NVMe mode.
4.Mmc driver handover it to NVMe driver.
5.If card is unplugged, RTS5261 will switch to SD mode.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
v2:remove duplicate define
---
 drivers/misc/cardreader/rts5261.c  |  4 ++++
 drivers/misc/cardreader/rts5261.h  | 23 -----------------------
 drivers/misc/cardreader/rtsx_pcr.c |  5 +++++
 include/linux/rtsx_pci.h           | 23 +++++++++++++++++++++++
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 471961487ff8..536c90d4fd76 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -738,8 +738,12 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 {
 	struct rtsx_cr_option *option = &pcr->option;
 	struct rtsx_hw_param *hw_param = &pcr->hw_param;
+	u8 val;
 
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	rtsx_pci_read_register(pcr, RTS5261_FW_STATUS, &val);
+	if (!(val & RTS5261_EXPRESS_LINK_FAIL_MASK))
+		pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
 	pcr->num_slots = 1;
 	pcr->ops = &rts5261_pcr_ops;
 
diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
index ebfdd236a553..8d80f0d5d5d6 100644
--- a/drivers/misc/cardreader/rts5261.h
+++ b/drivers/misc/cardreader/rts5261.h
@@ -65,23 +65,6 @@
 #define RTS5261_FW_EXPRESS_TEST_MASK	(0x01<<0)
 #define RTS5261_FW_EA_MODE_MASK		(0x01<<5)
 
-/* FW config register */
-#define RTS5261_FW_CFG0			0xFF54
-#define RTS5261_FW_ENTER_EXPRESS	(0x01<<0)
-
-#define RTS5261_FW_CFG1			0xFF55
-#define RTS5261_SYS_CLK_SEL_MCU_CLK	(0x01<<7)
-#define RTS5261_CRC_CLK_SEL_MCU_CLK	(0x01<<6)
-#define RTS5261_FAKE_MCU_CLOCK_GATING	(0x01<<5)
-/*MCU_bus_mode_sel: 0=real 8051 1=fake mcu*/
-#define RTS5261_MCU_BUS_SEL_MASK	(0x01<<4)
-/*MCU_clock_sel:VerA 00=aux16M 01=aux400K 1x=REFCLK100M*/
-/*MCU_clock_sel:VerB 00=aux400K 01=aux16M 10=REFCLK100M*/
-#define RTS5261_MCU_CLOCK_SEL_MASK	(0x03<<2)
-#define RTS5261_MCU_CLOCK_SEL_16M	(0x01<<2)
-#define RTS5261_MCU_CLOCK_GATING	(0x01<<1)
-#define RTS5261_DRIVER_ENABLE_FW	(0x01<<0)
-
 /* FW status register */
 #define RTS5261_FW_STATUS		0xFF56
 #define RTS5261_EXPRESS_LINK_FAIL_MASK	(0x01<<7)
@@ -121,12 +104,6 @@
 #define RTS5261_DV3318_19		(0x04<<4)
 #define RTS5261_DV3318_33		(0x07<<4)
 
-#define RTS5261_LDO1_CFG0		0xFF72
-#define RTS5261_LDO1_OCP_THD_MASK	(0x07<<5)
-#define RTS5261_LDO1_OCP_EN		(0x01<<4)
-#define RTS5261_LDO1_OCP_LMT_THD_MASK	(0x03<<2)
-#define RTS5261_LDO1_OCP_LMT_EN		(0x01<<1)
-
 /* CRD6603-433 190319 request changed */
 #define RTS5261_LDO1_OCP_THD_740	(0x00<<5)
 #define RTS5261_LDO1_OCP_THD_800	(0x01<<5)
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 37ccc67f4914..6e5c16b4b7d1 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -990,6 +990,11 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
 		} else {
 			pcr->card_removed |= SD_EXIST;
 			pcr->card_inserted &= ~SD_EXIST;
+			if (PCI_PID(pcr) == PID_5261) {
+				rtsx_pci_write_register(pcr, RTS5261_FW_STATUS,
+					RTS5261_EXPRESS_LINK_FAIL_MASK, 0);
+				pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
+			}
 		}
 		pcr->dma_error_count = 0;
 	}
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 745f5e73f99a..b47959f48ccd 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -658,6 +658,19 @@
 #define   PM_WAKE_EN			0x01
 #define PM_CTRL4			0xFF47
 
+#define RTS5261_FW_CFG0			0xFF54
+#define   RTS5261_FW_ENTER_EXPRESS	(0x01 << 0)
+
+#define RTS5261_FW_CFG1			0xFF55
+#define   RTS5261_SYS_CLK_SEL_MCU_CLK	(0x01 << 7)
+#define   RTS5261_CRC_CLK_SEL_MCU_CLK	(0x01 << 6)
+#define   RTS5261_FAKE_MCU_CLOCK_GATING	(0x01 << 5)
+#define   RTS5261_MCU_BUS_SEL_MASK	(0x01 << 4)
+#define   RTS5261_MCU_CLOCK_SEL_MASK	(0x03 << 2)
+#define   RTS5261_MCU_CLOCK_SEL_16M	(0x01 << 2)
+#define   RTS5261_MCU_CLOCK_GATING	(0x01 << 1)
+#define   RTS5261_DRIVER_ENABLE_FW	(0x01 << 0)
+
 #define REG_CFG_OOBS_OFF_TIMER 0xFEA6
 #define REG_CFG_OOBS_ON_TIMER 0xFEA7
 #define REG_CFG_VCM_ON_TIMER 0xFEA8
@@ -701,6 +714,13 @@
 #define   RTS5260_DVCC_TUNE_MASK	0x70
 #define   RTS5260_DVCC_33		0x70
 
+/*RTS5261*/
+#define RTS5261_LDO1_CFG0		0xFF72
+#define   RTS5261_LDO1_OCP_THD_MASK	(0x07 << 5)
+#define   RTS5261_LDO1_OCP_EN		(0x01 << 4)
+#define   RTS5261_LDO1_OCP_LMT_THD_MASK	(0x03 << 2)
+#define   RTS5261_LDO1_OCP_LMT_EN	(0x01 << 1)
+
 #define LDO_VCC_CFG1			0xFF73
 #define   LDO_VCC_REF_TUNE_MASK		0x30
 #define   LDO_VCC_REF_1V2		0x20
@@ -741,6 +761,8 @@
 
 #define RTS5260_AUTOLOAD_CFG4		0xFF7F
 #define   RTS5260_MIMO_DISABLE		0x8A
+/*RTS5261*/
+#define   RTS5261_AUX_CLK_16M_EN		(1 << 5)
 
 #define RTS5260_REG_GPIO_CTL0		0xFC1A
 #define   RTS5260_REG_GPIO_MASK		0x01
@@ -1191,6 +1213,7 @@ struct rtsx_pcr {
 #define EXTRA_CAPS_MMC_HS200		(1 << 4)
 #define EXTRA_CAPS_MMC_8BIT		(1 << 5)
 #define EXTRA_CAPS_NO_MMC		(1 << 7)
+#define EXTRA_CAPS_SD_EXPRESS		(1 << 8)
 	u32				extra_caps;
 
 #define IC_VER_A			0
-- 
2.17.1

