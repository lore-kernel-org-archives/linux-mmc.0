Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A62C433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 07:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C932073E
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 07:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgGFHDh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:03:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52369 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgGFHDh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 03:03:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 066738e14004461, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 066738e14004461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 6 Jul 2020 15:03:08 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 6 Jul 2020 15:03:08 +0800
Received: from localhost (172.22.88.222) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 6 Jul 2020
 15:03:08 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>, <rui_feng@realsil.com.cn>,
        <bhelgaas@google.com>, <kdlnx@doth.eu>, <linus.walleij@linaro.org>,
        <rmfrfs@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Ricky Wu <ricky_wu@realtek.com>
Subject: [PATCH] misc: rtsx: Add support new chip rts5228 mmc:  rtsx: Add support MMC_CAP2_NO_MMC
Date:   Mon, 6 Jul 2020 15:02:59 +0800
Message-ID: <20200706070259.32565-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

In order to support new chip rts5228, the definitions of some internal
registers and workflow have to be modified.
Added rts5228.c rts5228.h for independent functions of the new chip rts5228

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/Makefile   |   2 +-
 drivers/misc/cardreader/rts5228.c  | 740 +++++++++++++++++++++++++++++
 drivers/misc/cardreader/rts5228.h  | 168 +++++++
 drivers/misc/cardreader/rtsx_pcr.c |  89 ++--
 drivers/misc/cardreader/rtsx_pcr.h |   5 +
 drivers/mmc/host/rtsx_pci_sdmmc.c  |   2 +
 include/linux/rtsx_pci.h           |  11 +
 7 files changed, 985 insertions(+), 32 deletions(-)
 create mode 100644 drivers/misc/cardreader/rts5228.c
 create mode 100644 drivers/misc/cardreader/rts5228.h

diff --git a/drivers/misc/cardreader/Makefile b/drivers/misc/cardreader/Makefile
index 1f56267ed2f4..895128475d83 100644
--- a/drivers/misc/cardreader/Makefile
+++ b/drivers/misc/cardreader/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MISC_ALCOR_PCI)	+= alcor_pci.o
 obj-$(CONFIG_MISC_RTSX_PCI)	+= rtsx_pci.o
-rtsx_pci-objs := rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.o rts5249.o rts5260.o rts5261.o
+rtsx_pci-objs := rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.o rts5249.o rts5260.o rts5261.o rts5228.o
 obj-$(CONFIG_MISC_RTSX_USB)	+= rtsx_usb.o
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
new file mode 100644
index 000000000000..99aff7cd0a93
--- /dev/null
+++ b/drivers/misc/cardreader/rts5228.c
@@ -0,0 +1,740 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Driver for Realtek PCI-Express card reader
+ *
+ * Copyright(c) 2018-2019 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * Author:
+ *   Ricky WU <ricky_wu@realtek.com>
+ *   Rui FENG <rui_feng@realsil.com.cn>
+ *   Wei WANG <wei_wang@realsil.com.cn>
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/rtsx_pci.h>
+
+#include "rts5228.h"
+#include "rtsx_pcr.h"
+
+static u8 rts5228_get_ic_version(struct rtsx_pcr *pcr)
+{
+	u8 val;
+
+	rtsx_pci_read_register(pcr, DUMMY_REG_RESET_0, &val);
+	return val & IC_VERSION_MASK;
+}
+
+static void rts5228_fill_driving(struct rtsx_pcr *pcr, u8 voltage)
+{
+	u8 driving_3v3[4][3] = {
+		{0x13, 0x13, 0x13},
+		{0x96, 0x96, 0x96},
+		{0x7F, 0x7F, 0x7F},
+		{0x96, 0x96, 0x96},
+	};
+	u8 driving_1v8[4][3] = {
+		{0x99, 0x99, 0x99},
+		{0xB5, 0xB5, 0xB5},
+		{0xE6, 0x7E, 0xFE},
+		{0x6B, 0x6B, 0x6B},
+	};
+	u8 (*driving)[3], drive_sel;
+
+	if (voltage == OUTPUT_3V3) {
+		driving = driving_3v3;
+		drive_sel = pcr->sd30_drive_sel_3v3;
+	} else {
+		driving = driving_1v8;
+		drive_sel = pcr->sd30_drive_sel_1v8;
+	}
+
+	rtsx_pci_write_register(pcr, SD30_CLK_DRIVE_SEL,
+			 0xFF, driving[drive_sel][0]);
+
+	rtsx_pci_write_register(pcr, SD30_CMD_DRIVE_SEL,
+			 0xFF, driving[drive_sel][1]);
+
+	rtsx_pci_write_register(pcr, SD30_DAT_DRIVE_SEL,
+			 0xFF, driving[drive_sel][2]);
+}
+
+static void rtsx5228_fetch_vendor_settings(struct rtsx_pcr *pcr)
+{
+	u32 reg;
+	/* 0x724~0x727 */
+	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
+	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
+
+	if (!rtsx_vendor_setting_valid(reg)) {
+		pcr_dbg(pcr, "skip fetch vendor setting\n");
+		return;
+	}
+	pcr->sd30_drive_sel_1v8 = rtsx_reg_to_sd30_drive_sel_1v8(reg);
+	pcr->aspm_en = rtsx_reg_to_aspm(reg);
+
+	/* 0x814~0x817 */
+	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &reg);
+	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
+
+	pcr->rtd3_en = rtsx_reg_to_rtd3(reg);
+	if (rtsx_check_mmc_support(reg))
+		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
+	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
+	if (rtsx_reg_check_reverse_socket(reg))
+		pcr->flags |= PCR_REVERSE_SOCKET;
+}
+
+static int rts5228_optimize_phy(struct rtsx_pcr *pcr)
+{
+	return rtsx_pci_write_phy_register(pcr, 0x07, 0x8F40);
+}
+
+static void rts5228_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
+{
+	/* Set relink_time to 0 */
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, MASK_8_BIT_DEF, 0);
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
+				RELINK_TIME_MASK, 0);
+
+	if (pm_state == HOST_ENTER_S3)
+		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
+					D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
+
+	rtsx_pci_write_register(pcr, FPDCTL,
+		SSC_POWER_DOWN, SSC_POWER_DOWN);
+}
+
+static int rts5228_enable_auto_blink(struct rtsx_pcr *pcr)
+{
+	return rtsx_pci_write_register(pcr, OLT_LED_CTL,
+		LED_SHINE_MASK, LED_SHINE_EN);
+}
+
+static int rts5228_disable_auto_blink(struct rtsx_pcr *pcr)
+{
+	return rtsx_pci_write_register(pcr, OLT_LED_CTL,
+		LED_SHINE_MASK, LED_SHINE_DISABLE);
+}
+
+static int rts5228_turn_on_led(struct rtsx_pcr *pcr)
+{
+	return rtsx_pci_write_register(pcr, GPIO_CTL,
+		0x02, 0x02);
+}
+
+static int rts5228_turn_off_led(struct rtsx_pcr *pcr)
+{
+	return rtsx_pci_write_register(pcr, GPIO_CTL,
+		0x02, 0x00);
+}
+
+/* SD Pull Control Enable:
+ *     SD_DAT[3:0] ==> pull up
+ *     SD_CD       ==> pull up
+ *     SD_WP       ==> pull up
+ *     SD_CMD      ==> pull up
+ *     SD_CLK      ==> pull down
+ */
+static const u32 rts5228_sd_pull_ctl_enable_tbl[] = {
+	RTSX_REG_PAIR(CARD_PULL_CTL2, 0xAA),
+	RTSX_REG_PAIR(CARD_PULL_CTL3, 0xE9),
+	0,
+};
+
+/* SD Pull Control Disable:
+ *     SD_DAT[3:0] ==> pull down
+ *     SD_CD       ==> pull up
+ *     SD_WP       ==> pull down
+ *     SD_CMD      ==> pull down
+ *     SD_CLK      ==> pull down
+ */
+static const u32 rts5228_sd_pull_ctl_disable_tbl[] = {
+	RTSX_REG_PAIR(CARD_PULL_CTL2, 0x55),
+	RTSX_REG_PAIR(CARD_PULL_CTL3, 0xD5),
+	0,
+};
+
+static int rts5228_sd_set_sample_push_timing_sd30(struct rtsx_pcr *pcr)
+{
+	rtsx_pci_write_register(pcr, SD_CFG1, SD_MODE_SELECT_MASK
+		| SD_ASYNC_FIFO_NOT_RST, SD_30_MODE | SD_ASYNC_FIFO_NOT_RST);
+	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, CLK_LOW_FREQ);
+	rtsx_pci_write_register(pcr, CARD_CLK_SOURCE, 0xFF,
+			CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, 0);
+
+	return 0;
+}
+
+static int rts5228_card_power_on(struct rtsx_pcr *pcr, int card)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+
+	if (option->ocp_en)
+		rtsx_pci_enable_ocp(pcr);
+
+	rtsx_pci_write_register(pcr, REG_CRC_DUMMY_0,
+			CFG_SD_POW_AUTO_PD, CFG_SD_POW_AUTO_PD);
+
+	rtsx_pci_write_register(pcr, RTS5228_LDO1_CFG1,
+			RTS5228_LDO1_TUNE_MASK, RTS5228_LDO1_33);
+
+	rtsx_pci_write_register(pcr, RTS5228_LDO1233318_POW_CTL,
+			RTS5228_LDO1_POWERON_MASK, RTS5228_LDO1_SOFTSTART);
+	mdelay(2);
+	rtsx_pci_write_register(pcr, RTS5228_LDO1233318_POW_CTL,
+			RTS5228_LDO1_POWERON_MASK, RTS5228_LDO1_FULLON);
+
+
+	rtsx_pci_write_register(pcr, RTS5228_LDO1233318_POW_CTL,
+			RTS5228_LDO3318_POWERON, RTS5228_LDO3318_POWERON);
+
+	msleep(20);
+
+	rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, SD_OUTPUT_EN);
+
+	/* Initialize SD_CFG1 register */
+	rtsx_pci_write_register(pcr, SD_CFG1, 0xFF,
+			SD_CLK_DIVIDE_128 | SD_20_MODE | SD_BUS_WIDTH_1BIT);
+
+	rtsx_pci_write_register(pcr, SD_SAMPLE_POINT_CTL,
+			0xFF, SD20_RX_POS_EDGE);
+	rtsx_pci_write_register(pcr, SD_PUSH_POINT_CTL, 0xFF, 0);
+	rtsx_pci_write_register(pcr, CARD_STOP, SD_STOP | SD_CLR_ERR,
+			SD_STOP | SD_CLR_ERR);
+
+	/* Reset SD_CFG3 register */
+	rtsx_pci_write_register(pcr, SD_CFG3, SD30_CLK_END_EN, 0);
+	rtsx_pci_write_register(pcr, REG_SD_STOP_SDCLK_CFG,
+			SD30_CLK_STOP_CFG_EN | SD30_CLK_STOP_CFG1 |
+			SD30_CLK_STOP_CFG0, 0);
+
+	if (pcr->extra_caps & EXTRA_CAPS_SD_SDR50 ||
+	    pcr->extra_caps & EXTRA_CAPS_SD_SDR104)
+		rts5228_sd_set_sample_push_timing_sd30(pcr);
+
+	return 0;
+}
+
+static int rts5228_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
+{
+	int err;
+	u16 val = 0;
+
+	rtsx_pci_write_register(pcr, RTS5228_CARD_PWR_CTL,
+			RTS5228_PUPDC, RTS5228_PUPDC);
+
+	switch (voltage) {
+	case OUTPUT_3V3:
+		rtsx_pci_read_phy_register(pcr, PHY_TUNE, &val);
+		val |= PHY_TUNE_SDBUS_33;
+		err = rtsx_pci_write_phy_register(pcr, PHY_TUNE, val);
+		if (err < 0)
+			return err;
+
+		rtsx_pci_write_register(pcr, RTS5228_DV3318_CFG,
+				RTS5228_DV3318_TUNE_MASK, RTS5228_DV3318_33);
+		rtsx_pci_write_register(pcr, SD_PAD_CTL,
+				SD_IO_USING_1V8, 0);
+		break;
+	case OUTPUT_1V8:
+		rtsx_pci_read_phy_register(pcr, PHY_TUNE, &val);
+		val &= ~PHY_TUNE_SDBUS_33;
+		err = rtsx_pci_write_phy_register(pcr, PHY_TUNE, val);
+		if (err < 0)
+			return err;
+
+		rtsx_pci_write_register(pcr, RTS5228_DV3318_CFG,
+				RTS5228_DV3318_TUNE_MASK, RTS5228_DV3318_18);
+		rtsx_pci_write_register(pcr, SD_PAD_CTL,
+				SD_IO_USING_1V8, SD_IO_USING_1V8);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set pad drive */
+	rts5228_fill_driving(pcr, voltage);
+
+	return 0;
+}
+
+static void rts5228_stop_cmd(struct rtsx_pcr *pcr)
+{
+	rtsx_pci_writel(pcr, RTSX_HCBCTLR, STOP_CMD);
+	rtsx_pci_writel(pcr, RTSX_HDBCTLR, STOP_DMA);
+	rtsx_pci_write_register(pcr, RTS5260_DMA_RST_CTL_0,
+				RTS5260_DMA_RST | RTS5260_ADMA3_RST,
+				RTS5260_DMA_RST | RTS5260_ADMA3_RST);
+	rtsx_pci_write_register(pcr, RBCTL, RB_FLUSH, RB_FLUSH);
+}
+
+static void rts5228_card_before_power_off(struct rtsx_pcr *pcr)
+{
+	rts5228_stop_cmd(pcr);
+	rts5228_switch_output_voltage(pcr, OUTPUT_3V3);
+}
+
+static void rts5228_enable_ocp(struct rtsx_pcr *pcr)
+{
+	u8 val = 0;
+
+	val = SD_OCP_INT_EN | SD_DETECT_EN;
+	rtsx_pci_write_register(pcr, REG_OCPCTL, 0xFF, val);
+	rtsx_pci_write_register(pcr, RTS5228_LDO1_CFG0,
+			RTS5228_LDO1_OCP_EN | RTS5228_LDO1_OCP_LMT_EN,
+			RTS5228_LDO1_OCP_EN | RTS5228_LDO1_OCP_LMT_EN);
+}
+
+static void rts5228_disable_ocp(struct rtsx_pcr *pcr)
+{
+	u8 mask = 0;
+
+	mask = SD_OCP_INT_EN | SD_DETECT_EN;
+	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, 0);
+	rtsx_pci_write_register(pcr, RTS5228_LDO1_CFG0,
+			RTS5228_LDO1_OCP_EN | RTS5228_LDO1_OCP_LMT_EN, 0);
+}
+
+static int rts5228_card_power_off(struct rtsx_pcr *pcr, int card)
+{
+	int err = 0;
+
+	rts5228_card_before_power_off(pcr);
+	err = rtsx_pci_write_register(pcr, RTS5228_LDO1233318_POW_CTL,
+				RTS5228_LDO_POWERON_MASK, 0);
+	rtsx_pci_write_register(pcr, REG_CRC_DUMMY_0, CFG_SD_POW_AUTO_PD, 0);
+
+	if (pcr->option.ocp_en)
+		rtsx_pci_disable_ocp(pcr);
+
+	return err;
+}
+
+static void rts5228_init_ocp(struct rtsx_pcr *pcr)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+
+	if (option->ocp_en) {
+		u8 mask, val;
+
+		rtsx_pci_write_register(pcr, RTS5228_LDO1_CFG0,
+			RTS5228_LDO1_OCP_EN | RTS5228_LDO1_OCP_LMT_EN,
+			RTS5228_LDO1_OCP_EN | RTS5228_LDO1_OCP_LMT_EN);
+
+		rtsx_pci_write_register(pcr, RTS5228_LDO1_CFG0,
+			RTS5228_LDO1_OCP_THD_MASK, option->sd_800mA_ocp_thd);
+
+		rtsx_pci_write_register(pcr, RTS5228_LDO1_CFG0,
+			RTS5228_LDO1_OCP_LMT_THD_MASK,
+			RTS5228_LDO1_LMT_THD_1500);
+
+		rtsx_pci_read_register(pcr, RTS5228_LDO1_CFG0, &val);
+
+		mask = SD_OCP_GLITCH_MASK;
+		val = pcr->hw_param.ocp_glitch;
+		rtsx_pci_write_register(pcr, REG_OCPGLITCH, mask, val);
+
+		rts5228_enable_ocp(pcr);
+
+	} else {
+		rtsx_pci_write_register(pcr, RTS5228_LDO1_CFG0,
+			RTS5228_LDO1_OCP_EN | RTS5228_LDO1_OCP_LMT_EN, 0);
+	}
+}
+
+static void rts5228_clear_ocpstat(struct rtsx_pcr *pcr)
+{
+	u8 mask = 0;
+	u8 val = 0;
+
+	mask = SD_OCP_INT_CLR | SD_OC_CLR;
+	val = SD_OCP_INT_CLR | SD_OC_CLR;
+
+	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, val);
+
+	udelay(1000);
+	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, 0);
+
+}
+
+static void rts5228_process_ocp(struct rtsx_pcr *pcr)
+{
+	if (!pcr->option.ocp_en)
+		return;
+
+	rtsx_pci_get_ocpstat(pcr, &pcr->ocp_stat);
+
+	if (pcr->ocp_stat & (SD_OC_NOW | SD_OC_EVER)) {
+		rts5228_clear_ocpstat(pcr);
+		rts5228_card_power_off(pcr, RTSX_SD_CARD);
+		rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, 0);
+		pcr->ocp_stat = 0;
+	}
+
+}
+
+static void rts5228_init_from_cfg(struct rtsx_pcr *pcr)
+{
+	u32 lval;
+	struct rtsx_cr_option *option = &pcr->option;
+
+	rtsx_pci_read_config_dword(pcr, PCR_ASPM_SETTING_REG1, &lval);
+
+
+	if (0 == (lval & 0x0F))
+		rtsx_pci_enable_oobs_polling(pcr);
+	else
+		rtsx_pci_disable_oobs_polling(pcr);
+
+	if (lval & ASPM_L1_1_EN_MASK)
+		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
+	else
+		rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
+
+	if (lval & ASPM_L1_2_EN_MASK)
+		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
+	else
+		rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
+
+	if (lval & PM_L1_1_EN_MASK)
+		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
+	else
+		rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
+
+	if (lval & PM_L1_2_EN_MASK)
+		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
+	else
+		rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
+
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0xFF, 0);
+	if (option->ltr_en) {
+		u16 val;
+
+		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
+		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
+			option->ltr_enabled = true;
+			option->ltr_active = true;
+			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
+		} else {
+			option->ltr_enabled = false;
+		}
+	}
+
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+		option->force_clkreq_0 = false;
+	else
+		option->force_clkreq_0 = true;
+}
+
+static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+
+	rtsx_pci_write_register(pcr, RTS5228_AUTOLOAD_CFG1,
+			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
+
+	rts5228_init_from_cfg(pcr);
+
+	rtsx_pci_write_register(pcr, L1SUB_CONFIG1,
+			AUX_CLK_ACTIVE_SEL_MASK, MAC_CKSW_DONE);
+	rtsx_pci_write_register(pcr, L1SUB_CONFIG3, 0xFF, 0);
+
+	rtsx_pci_write_register(pcr, FUNC_FORCE_CTL,
+			FUNC_FORCE_UPME_XMT_DBG, FUNC_FORCE_UPME_XMT_DBG);
+
+	rtsx_pci_write_register(pcr, PCLK_CTL,
+			PCLK_MODE_SEL, PCLK_MODE_SEL);
+
+	rtsx_pci_write_register(pcr, PM_EVENT_DEBUG, PME_DEBUG_0, PME_DEBUG_0);
+	rtsx_pci_write_register(pcr, PM_CLK_FORCE_CTL, CLK_PM_EN, CLK_PM_EN);
+
+	/* LED shine disabled, set initial shine cycle period */
+	rtsx_pci_write_register(pcr, OLT_LED_CTL, 0x0F, 0x02);
+
+	/* Configure driving */
+	rts5228_fill_driving(pcr, OUTPUT_3V3);
+
+	if (pcr->flags & PCR_REVERSE_SOCKET)
+		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x30);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
+
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
+	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
+	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
+	rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
+			FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
+
+	return 0;
+}
+
+static void rts5228_enable_aspm(struct rtsx_pcr *pcr, bool enable)
+{
+	u8 mask, val;
+
+	if (pcr->aspm_enabled == enable)
+		return;
+
+	mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
+	val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
+	val |= (pcr->aspm_en & 0x02);
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
+	pcr->aspm_enabled = enable;
+}
+
+static void rts5228_disable_aspm(struct rtsx_pcr *pcr, bool enable)
+{
+	u8 mask, val;
+
+	if (pcr->aspm_enabled == enable)
+		return;
+
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC, 0);
+	mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
+	val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
+	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
+	mdelay(10);
+	pcr->aspm_enabled = enable;
+}
+
+static void rts5228_set_aspm(struct rtsx_pcr *pcr, bool enable)
+{
+	if (enable)
+		rts5228_enable_aspm(pcr, true);
+	else
+		rts5228_disable_aspm(pcr, false);
+}
+
+static void rts5228_set_l1off_cfg_sub_d0(struct rtsx_pcr *pcr, int active)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+	int aspm_L1_1, aspm_L1_2;
+	u8 val = 0;
+
+	aspm_L1_1 = rtsx_check_dev_flag(pcr, ASPM_L1_1_EN);
+	aspm_L1_2 = rtsx_check_dev_flag(pcr, ASPM_L1_2_EN);
+
+	if (active) {
+		/* run, latency: 60us */
+		if (aspm_L1_1)
+			val = option->ltr_l1off_snooze_sspwrgate;
+	} else {
+		/* l1off, latency: 300us */
+		if (aspm_L1_2)
+			val = option->ltr_l1off_sspwrgate;
+	}
+
+	rtsx_set_l1off_sub(pcr, val);
+}
+
+static const struct pcr_ops rts5228_pcr_ops = {
+	.fetch_vendor_settings = rtsx5228_fetch_vendor_settings,
+	.turn_on_led = rts5228_turn_on_led,
+	.turn_off_led = rts5228_turn_off_led,
+	.extra_init_hw = rts5228_extra_init_hw,
+	.enable_auto_blink = rts5228_enable_auto_blink,
+	.disable_auto_blink = rts5228_disable_auto_blink,
+	.card_power_on = rts5228_card_power_on,
+	.card_power_off = rts5228_card_power_off,
+	.switch_output_voltage = rts5228_switch_output_voltage,
+	.force_power_down = rts5228_force_power_down,
+	.stop_cmd = rts5228_stop_cmd,
+	.set_aspm = rts5228_set_aspm,
+	.set_l1off_cfg_sub_d0 = rts5228_set_l1off_cfg_sub_d0,
+	.enable_ocp = rts5228_enable_ocp,
+	.disable_ocp = rts5228_disable_ocp,
+	.init_ocp = rts5228_init_ocp,
+	.process_ocp = rts5228_process_ocp,
+	.clear_ocpstat = rts5228_clear_ocpstat,
+	.optimize_phy = rts5228_optimize_phy,
+};
+
+
+static inline u8 double_ssc_depth(u8 depth)
+{
+	return ((depth > 1) ? (depth - 1) : depth);
+}
+
+int rts5228_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
+		u8 ssc_depth, bool initial_mode, bool double_clk, bool vpclk)
+{
+	int err, clk;
+	u16 n;
+	u8 clk_divider, mcu_cnt, div;
+	static const u8 depth[] = {
+		[RTSX_SSC_DEPTH_4M] = RTS5228_SSC_DEPTH_4M,
+		[RTSX_SSC_DEPTH_2M] = RTS5228_SSC_DEPTH_2M,
+		[RTSX_SSC_DEPTH_1M] = RTS5228_SSC_DEPTH_1M,
+		[RTSX_SSC_DEPTH_500K] = RTS5228_SSC_DEPTH_512K,
+	};
+
+	if (initial_mode) {
+		/* We use 250k(around) here, in initial stage */
+		clk_divider = SD_CLK_DIVIDE_128;
+		card_clock = 30000000;
+	} else {
+		clk_divider = SD_CLK_DIVIDE_0;
+	}
+	err = rtsx_pci_write_register(pcr, SD_CFG1,
+			SD_CLK_DIVIDE_MASK, clk_divider);
+	if (err < 0)
+		return err;
+
+	card_clock /= 1000000;
+	pcr_dbg(pcr, "Switch card clock to %dMHz\n", card_clock);
+
+	clk = card_clock;
+	if (!initial_mode && double_clk)
+		clk = card_clock * 2;
+	pcr_dbg(pcr, "Internal SSC clock: %dMHz (cur_clock = %d)\n",
+		clk, pcr->cur_clock);
+
+	if (clk == pcr->cur_clock)
+		return 0;
+
+	if (pcr->ops->conv_clk_and_div_n)
+		n = pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
+	else
+		n = clk - 4;
+	if ((clk <= 4) || (n > 396))
+		return -EINVAL;
+
+	mcu_cnt = 125/clk + 3;
+	if (mcu_cnt > 15)
+		mcu_cnt = 15;
+
+	div = CLK_DIV_1;
+	while ((n < MIN_DIV_N_PCR - 4) && (div < CLK_DIV_8)) {
+		if (pcr->ops->conv_clk_and_div_n) {
+			int dbl_clk = pcr->ops->conv_clk_and_div_n(n,
+					DIV_N_TO_CLK) * 2;
+			n = pcr->ops->conv_clk_and_div_n(dbl_clk,
+					CLK_TO_DIV_N);
+		} else {
+			n = (n + 4) * 2 - 4;
+		}
+		div++;
+	}
+
+	n = (n / 2) - 1;
+	pcr_dbg(pcr, "n = %d, div = %d\n", n, div);
+
+	ssc_depth = depth[ssc_depth];
+	if (double_clk)
+		ssc_depth = double_ssc_depth(ssc_depth);
+
+	if (ssc_depth) {
+		if (div == CLK_DIV_2) {
+			if (ssc_depth > 1)
+				ssc_depth -= 1;
+			else
+				ssc_depth = RTS5228_SSC_DEPTH_8M;
+		} else if (div == CLK_DIV_4) {
+			if (ssc_depth > 2)
+				ssc_depth -= 2;
+			else
+				ssc_depth = RTS5228_SSC_DEPTH_8M;
+		} else if (div == CLK_DIV_8) {
+			if (ssc_depth > 3)
+				ssc_depth -= 3;
+			else
+				ssc_depth = RTS5228_SSC_DEPTH_8M;
+		}
+	} else {
+		ssc_depth = 0;
+	}
+	pcr_dbg(pcr, "ssc_depth = %d\n", ssc_depth);
+
+	rtsx_pci_init_cmd(pcr);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CLK_CTL,
+				CLK_LOW_FREQ, CLK_LOW_FREQ);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CLK_DIV,
+			0xFF, (div << 4) | mcu_cnt);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL1, SSC_RSTB, 0);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2,
+			SSC_DEPTH_MASK, ssc_depth);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_DIV_N_0, 0xFF, n);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL1, SSC_RSTB, SSC_RSTB);
+	if (vpclk) {
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK0_CTL,
+				PHASE_NOT_RESET, 0);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK1_CTL,
+				PHASE_NOT_RESET, 0);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK0_CTL,
+				PHASE_NOT_RESET, PHASE_NOT_RESET);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK1_CTL,
+				PHASE_NOT_RESET, PHASE_NOT_RESET);
+	}
+
+	err = rtsx_pci_send_cmd(pcr, 2000);
+	if (err < 0)
+		return err;
+
+	/* Wait SSC clock stable */
+	udelay(SSC_CLOCK_STABLE_WAIT);
+	err = rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, 0);
+	if (err < 0)
+		return err;
+
+	pcr->cur_clock = clk;
+	return 0;
+
+}
+
+void rts5228_init_params(struct rtsx_pcr *pcr)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+	struct rtsx_hw_param *hw_param = &pcr->hw_param;
+
+	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	pcr->num_slots = 1;
+	pcr->ops = &rts5228_pcr_ops;
+
+	pcr->flags = 0;
+	pcr->card_drive_sel = RTSX_CARD_DRIVE_DEFAULT;
+	pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
+	pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
+	pcr->aspm_en = ASPM_L1_EN;
+	pcr->tx_initial_phase = SET_CLOCK_PHASE(28, 27, 11);
+	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
+
+	pcr->ic_version = rts5228_get_ic_version(pcr);
+	pcr->sd_pull_ctl_enable_tbl = rts5228_sd_pull_ctl_enable_tbl;
+	pcr->sd_pull_ctl_disable_tbl = rts5228_sd_pull_ctl_disable_tbl;
+
+	pcr->reg_pm_ctrl3 = RTS5228_AUTOLOAD_CFG3;
+
+	option->dev_flags = (LTR_L1SS_PWR_GATE_CHECK_CARD_EN
+				| LTR_L1SS_PWR_GATE_EN);
+	option->ltr_en = true;
+
+	/* init latency of active, idle, L1OFF to 60us, 300us, 3ms */
+	option->ltr_active_latency = LTR_ACTIVE_LATENCY_DEF;
+	option->ltr_idle_latency = LTR_IDLE_LATENCY_DEF;
+	option->ltr_l1off_latency = LTR_L1OFF_LATENCY_DEF;
+	option->l1_snooze_delay = L1_SNOOZE_DELAY_DEF;
+	option->ltr_l1off_sspwrgate = 0x7F;
+	option->ltr_l1off_snooze_sspwrgate = 0x78;
+
+	option->ocp_en = 1;
+	hw_param->interrupt_en |= SD_OC_INT_EN;
+	hw_param->ocp_glitch =  SD_OCP_GLITCH_800U;
+	option->sd_800mA_ocp_thd =  RTS5228_LDO1_OCP_THD_930;
+}
diff --git a/drivers/misc/cardreader/rts5228.h b/drivers/misc/cardreader/rts5228.h
new file mode 100644
index 000000000000..6a872246aeed
--- /dev/null
+++ b/drivers/misc/cardreader/rts5228.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Driver for Realtek PCI-Express card reader
+ *
+ * Copyright(c) 2018-2019 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * Author:
+ *   Ricky WU <ricky_wu@realtek.com>
+ *   Rui FENG <rui_feng@realsil.com.cn>
+ *   Wei WANG <wei_wang@realsil.com.cn>
+ */
+#ifndef RTS5228_H
+#define RTS5228_H
+
+
+#define RTS5228_AUTOLOAD_CFG0			0xFF7B
+#define RTS5228_AUTOLOAD_CFG1			0xFF7C
+#define RTS5228_AUTOLOAD_CFG2			0xFF7D
+#define RTS5228_AUTOLOAD_CFG3			0xFF7E
+#define RTS5228_AUTOLOAD_CFG4			0xFF7F
+
+#define RTS5228_REG_VREF			0xFE97
+#define RTS5228_PWD_SUSPND_EN			(1 << 4)
+
+#define RTS5228_PAD_H3L1			0xFF79
+#define PAD_GPIO_H3L1			(1 << 3)
+
+/* SSC_CTL2 0xFC12 */
+#define RTS5228_SSC_DEPTH_MASK		0x07
+#define RTS5228_SSC_DEPTH_DISALBE	0x00
+#define RTS5228_SSC_DEPTH_8M		0x01
+#define RTS5228_SSC_DEPTH_4M		0x02
+#define RTS5228_SSC_DEPTH_2M		0x03
+#define RTS5228_SSC_DEPTH_1M		0x04
+#define RTS5228_SSC_DEPTH_512K		0x05
+#define RTS5228_SSC_DEPTH_256K		0x06
+#define RTS5228_SSC_DEPTH_128K		0x07
+
+/* DMACTL 0xFE2C */
+#define RTS5228_DMA_PACK_SIZE_MASK		0xF0
+
+#define RTS5228_REG_LDO12_CFG			0xFF6E
+#define RTS5228_LDO12_VO_TUNE_MASK		(0x07<<1)
+#define RTS5228_LDO12_100				(0x00<<1)
+#define RTS5228_LDO12_105				(0x01<<1)
+#define RTS5228_LDO12_110				(0x02<<1)
+#define RTS5228_LDO12_115				(0x03<<1)
+#define RTS5228_LDO12_120				(0x04<<1)
+#define RTS5228_LDO12_125				(0x05<<1)
+#define RTS5228_LDO12_130				(0x06<<1)
+#define RTS5228_LDO12_135				(0x07<<1)
+#define RTS5228_REG_PWD_LDO12			(0x01<<0)
+
+#define RTS5228_REG_LDO12_L12	0xFF6F
+#define RTS5228_LDO12_L12_MASK			(0x07<<4)
+#define RTS5228_LDO12_L12_120			(0x04<<4)
+
+/* LDO control register */
+#define RTS5228_CARD_PWR_CTL			0xFD50
+#define RTS5228_PUPDC					(0x01<<5)
+
+#define RTS5228_LDO1233318_POW_CTL		0xFF70
+#define RTS5228_LDO3318_POWERON			(0x01<<3)
+#define RTS5228_LDO1_POWEROFF			(0x00<<0)
+#define RTS5228_LDO1_SOFTSTART			(0x01<<0)
+#define RTS5228_LDO1_FULLON				(0x03<<0)
+#define RTS5228_LDO1_POWERON_MASK		(0x03<<0)
+#define RTS5228_LDO_POWERON_MASK		(0x0F<<0)
+
+#define RTS5228_DV3318_CFG				0xFF71
+#define RTS5228_DV3318_TUNE_MASK		(0x07<<4)
+#define RTS5228_DV3318_17				(0x00<<4)
+#define RTS5228_DV3318_1V75				(0x01<<4)
+#define RTS5228_DV3318_18				(0x02<<4)
+#define RTS5228_DV3318_1V85				(0x03<<4)
+#define RTS5228_DV3318_19				(0x04<<4)
+#define RTS5228_DV3318_33				(0x07<<4)
+#define RTS5228_DV3318_SR_MASK			(0x03<<2)
+#define RTS5228_DV3318_SR_0				(0x00<<2)
+#define RTS5228_DV3318_SR_250			(0x01<<2)
+#define RTS5228_DV3318_SR_500			(0x02<<2)
+#define RTS5228_DV3318_SR_1000			(0x03<<2)
+
+#define RTS5228_LDO1_CFG0				0xFF72
+#define RTS5228_LDO1_OCP_THD_MASK		(0x07<<5)
+#define RTS5228_LDO1_OCP_EN				(0x01<<4)
+#define RTS5228_LDO1_OCP_LMT_THD_MASK	(0x03<<2)
+#define RTS5228_LDO1_OCP_LMT_EN			(0x01<<1)
+
+#define RTS5228_LDO1_OCP_THD_730		(0x00<<5)
+#define RTS5228_LDO1_OCP_THD_780		(0x01<<5)
+#define RTS5228_LDO1_OCP_THD_860		(0x02<<5)
+#define RTS5228_LDO1_OCP_THD_930		(0x03<<5)
+#define RTS5228_LDO1_OCP_THD_1000		(0x04<<5)
+#define RTS5228_LDO1_OCP_THD_1070		(0x05<<5)
+#define RTS5228_LDO1_OCP_THD_1140		(0x06<<5)
+#define RTS5228_LDO1_OCP_THD_1220		(0x07<<5)
+
+#define RTS5228_LDO1_LMT_THD_450		(0x00<<2)
+#define RTS5228_LDO1_LMT_THD_1000		(0x01<<2)
+#define RTS5228_LDO1_LMT_THD_1500		(0x02<<2)
+#define RTS5228_LDO1_LMT_THD_2000		(0x03<<2)
+
+#define RTS5228_LDO1_CFG1				0xFF73
+#define RTS5228_LDO1_SR_TIME_MASK		(0x03<<6)
+#define RTS5228_LDO1_SR_0_0				(0x00<<6)
+#define RTS5228_LDO1_SR_0_25			(0x01<<6)
+#define RTS5228_LDO1_SR_0_5				(0x02<<6)
+#define RTS5228_LDO1_SR_1_0				(0x03<<6)
+#define RTS5228_LDO1_TUNE_MASK			(0x07<<1)
+#define RTS5228_LDO1_18					(0x05<<1)
+#define RTS5228_LDO1_33					(0x07<<1)
+#define RTS5228_LDO1_PWD_MASK			(0x01<<0)
+
+#define RTS5228_AUXCLK_GAT_CTL			0xFF74
+
+#define RTS5228_REG_RREF_CTL_0			0xFF75
+#define RTS5228_FORCE_RREF_EXTL			(0x01<<7)
+#define RTS5228_REG_BG33_MASK			(0x07<<0)
+#define RTS5228_RREF_12_1V				(0x04<<0)
+#define RTS5228_RREF_12_3V				(0x05<<0)
+
+#define RTS5228_REG_RREF_CTL_1			0xFF76
+
+#define RTS5228_REG_RREF_CTL_2			0xFF77
+#define RTS5228_TEST_INTL_RREF			(0x01<<7)
+#define RTS5228_DGLCH_TIME_MASK			(0x03<<5)
+#define RTS5228_DGLCH_TIME_50			(0x00<<5)
+#define RTS5228_DGLCH_TIME_75			(0x01<<5)
+#define RTS5228_DGLCH_TIME_100			(0x02<<5)
+#define RTS5228_DGLCH_TIME_125			(0x03<<5)
+#define RTS5228_REG_REXT_TUNE_MASK		(0x1F<<0)
+
+#define RTS5228_REG_PME_FORCE_CTL		0xFF78
+#define FORCE_PM_CONTROL		0x20
+#define FORCE_PM_VALUE			0x10
+
+
+/* Single LUN, support SD */
+#define DEFAULT_SINGLE		0
+#define SD_LUN				1
+
+
+/* For Change_FPGA_SSCClock Function */
+#define MULTIPLY_BY_1    0x00
+#define MULTIPLY_BY_2    0x01
+#define MULTIPLY_BY_3    0x02
+#define MULTIPLY_BY_4    0x03
+#define MULTIPLY_BY_5    0x04
+#define MULTIPLY_BY_6    0x05
+#define MULTIPLY_BY_7    0x06
+#define MULTIPLY_BY_8    0x07
+#define MULTIPLY_BY_9    0x08
+#define MULTIPLY_BY_10   0x09
+
+#define DIVIDE_BY_2      0x01
+#define DIVIDE_BY_3      0x02
+#define DIVIDE_BY_4      0x03
+#define DIVIDE_BY_5      0x04
+#define DIVIDE_BY_6      0x05
+#define DIVIDE_BY_7      0x06
+#define DIVIDE_BY_8      0x07
+#define DIVIDE_BY_9      0x08
+#define DIVIDE_BY_10     0x09
+
+int rts5228_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
+		u8 ssc_depth, bool initial_mode, bool double_clk, bool vpclk);
+
+#endif /* RTS5228_H */
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 0d5928bc1b6d..5ff690d2e9a9 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -23,6 +23,7 @@
 
 #include "rtsx_pcr.h"
 #include "rts5261.h"
+#include "rts5228.h"
 
 static bool msi_en = true;
 module_param(msi_en, bool, S_IRUGO | S_IWUSR);
@@ -50,6 +51,7 @@ static const struct pci_device_id rtsx_pci_ids[] = {
 	{ PCI_DEVICE(0x10EC, 0x525A), PCI_CLASS_OTHERS << 16, 0xFF0000 },
 	{ PCI_DEVICE(0x10EC, 0x5260), PCI_CLASS_OTHERS << 16, 0xFF0000 },
 	{ PCI_DEVICE(0x10EC, 0x5261), PCI_CLASS_OTHERS << 16, 0xFF0000 },
+	{ PCI_DEVICE(0x10EC, 0x5228), PCI_CLASS_OTHERS << 16, 0xFF0000 },
 	{ 0, }
 };
 
@@ -206,16 +208,10 @@ int __rtsx_pci_write_phy_register(struct rtsx_pcr *pcr, u8 addr, u16 val)
 	int err, i, finished = 0;
 	u8 tmp;
 
-	rtsx_pci_init_cmd(pcr);
-
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PHYDATA0, 0xFF, (u8)val);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PHYDATA1, 0xFF, (u8)(val >> 8));
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PHYADDR, 0xFF, addr);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PHYRWCTL, 0xFF, 0x81);
-
-	err = rtsx_pci_send_cmd(pcr, 100);
-	if (err < 0)
-		return err;
+	rtsx_pci_write_register(pcr, PHYDATA0, 0xFF, (u8)val);
+	rtsx_pci_write_register(pcr, PHYDATA1, 0xFF, (u8)(val >> 8));
+	rtsx_pci_write_register(pcr, PHYADDR, 0xFF, addr);
+	rtsx_pci_write_register(pcr, PHYRWCTL, 0xFF, 0x81);
 
 	for (i = 0; i < 100000; i++) {
 		err = rtsx_pci_read_register(pcr, PHYRWCTL, &tmp);
@@ -247,16 +243,10 @@ int __rtsx_pci_read_phy_register(struct rtsx_pcr *pcr, u8 addr, u16 *val)
 {
 	int err, i, finished = 0;
 	u16 data;
-	u8 *ptr, tmp;
-
-	rtsx_pci_init_cmd(pcr);
+	u8 tmp, val1, val2;
 
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PHYADDR, 0xFF, addr);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PHYRWCTL, 0xFF, 0x80);
-
-	err = rtsx_pci_send_cmd(pcr, 100);
-	if (err < 0)
-		return err;
+	rtsx_pci_write_register(pcr, PHYADDR, 0xFF, addr);
+	rtsx_pci_write_register(pcr, PHYRWCTL, 0xFF, 0x80);
 
 	for (i = 0; i < 100000; i++) {
 		err = rtsx_pci_read_register(pcr, PHYRWCTL, &tmp);
@@ -272,17 +262,9 @@ int __rtsx_pci_read_phy_register(struct rtsx_pcr *pcr, u8 addr, u16 *val)
 	if (!finished)
 		return -ETIMEDOUT;
 
-	rtsx_pci_init_cmd(pcr);
-
-	rtsx_pci_add_cmd(pcr, READ_REG_CMD, PHYDATA0, 0, 0);
-	rtsx_pci_add_cmd(pcr, READ_REG_CMD, PHYDATA1, 0, 0);
-
-	err = rtsx_pci_send_cmd(pcr, 100);
-	if (err < 0)
-		return err;
-
-	ptr = rtsx_pci_get_cmd_data(pcr);
-	data = ((u16)ptr[1] << 8) | ptr[0];
+	rtsx_pci_read_register(pcr, PHYDATA0, &val1);
+	rtsx_pci_read_register(pcr, PHYDATA1, &val2);
+	data = val1 | (val2 << 8);
 
 	if (val)
 		*val = data;
@@ -417,7 +399,7 @@ static void rtsx_pci_add_sg_tbl(struct rtsx_pcr *pcr,
 	if (end)
 		option |= RTSX_SG_END;
 
-	if (PCI_PID(pcr) == PID_5261) {
+	if ((PCI_PID(pcr) == PID_5261) || (PCI_PID(pcr) == PID_5228)) {
 		if (len > 0xFFFF)
 			val = ((u64)addr << 32) | (((u64)len & 0xFFFF) << 16)
 				| (((u64)len >> 16) << 6) | option;
@@ -723,6 +705,9 @@ int rtsx_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 	if (PCI_PID(pcr) == PID_5261)
 		return rts5261_pci_switch_clock(pcr, card_clock,
 				ssc_depth, initial_mode, double_clk, vpclk);
+	if (PCI_PID(pcr) == PID_5228)
+		return rts5228_pci_switch_clock(pcr, card_clock,
+				ssc_depth, initial_mode, double_clk, vpclk);
 
 	if (initial_mode) {
 		/* We use 250k(around) here, in initial stage */
@@ -1202,6 +1187,36 @@ void rtsx_pci_clear_ocpstat(struct rtsx_pcr *pcr)
 	}
 }
 
+void rtsx_pci_enable_oobs_polling(struct rtsx_pcr *pcr)
+{
+	u16 val;
+
+	if ((PCI_PID(pcr) != PID_525A) && (PCI_PID(pcr) != PID_5260)) {
+		rtsx_pci_read_phy_register(pcr, 0x01, &val);
+		val |= 1<<9;
+		rtsx_pci_write_phy_register(pcr, 0x01, val);
+	}
+	rtsx_pci_write_register(pcr, REG_CFG_OOBS_OFF_TIMER, 0xFF, 0x32);
+	rtsx_pci_write_register(pcr, REG_CFG_OOBS_ON_TIMER, 0xFF, 0x05);
+	rtsx_pci_write_register(pcr, REG_CFG_VCM_ON_TIMER, 0xFF, 0x83);
+	rtsx_pci_write_register(pcr, REG_CFG_OOBS_POLLING, 0xFF, 0xDE);
+
+}
+
+void rtsx_pci_disable_oobs_polling(struct rtsx_pcr *pcr)
+{
+	u16 val;
+
+	if ((PCI_PID(pcr) != PID_525A) && (PCI_PID(pcr) != PID_5260)) {
+		rtsx_pci_read_phy_register(pcr, 0x01, &val);
+		val &= ~(1<<9);
+		rtsx_pci_write_phy_register(pcr, 0x01, val);
+	}
+	rtsx_pci_write_register(pcr, REG_CFG_VCM_ON_TIMER, 0xFF, 0x03);
+	rtsx_pci_write_register(pcr, REG_CFG_OOBS_POLLING, 0xFF, 0x00);
+
+}
+
 int rtsx_sd_power_off_card3v3(struct rtsx_pcr *pcr)
 {
 	rtsx_pci_write_register(pcr, CARD_CLK_EN, SD_CLK_EN |
@@ -1233,6 +1248,10 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 {
 	int err;
 
+	if (PCI_PID(pcr) == PID_5228)
+		rtsx_pci_write_register(pcr, RTS5228_LDO1_CFG1, RTS5228_LDO1_SR_TIME_MASK,
+				RTS5228_LDO1_SR_0_5);
+
 	pcr->pcie_cap = pci_find_capability(pcr->pci, PCI_CAP_ID_EXP);
 	rtsx_pci_writel(pcr, RTSX_HCBAR, pcr->host_cmds_addr);
 
@@ -1280,6 +1299,9 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	if (PCI_PID(pcr) == PID_5261)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2, 0xFF,
 			RTS5261_SSC_DEPTH_2M);
+	else if (PCI_PID(pcr) == PID_5228)
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2, 0xFF,
+			RTS5228_SSC_DEPTH_2M);
 	else
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2, 0xFF, 0x12);
 
@@ -1314,6 +1336,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	case PID_525A:
 	case PID_5260:
 	case PID_5261:
+	case PID_5228:
 		rtsx_pci_write_register(pcr, PM_CLK_FORCE_CTL, 1, 1);
 		break;
 	default:
@@ -1401,6 +1424,10 @@ static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
 	case 0x5261:
 		rts5261_init_params(pcr);
 		break;
+
+	case 0x5228:
+		rts5228_init_params(pcr);
+		break;
 	}
 
 	pcr_dbg(pcr, "PID: 0x%04x, IC version: 0x%02x\n",
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index 024cbd998b2a..6b322db8738e 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -53,6 +53,7 @@ void rts525a_init_params(struct rtsx_pcr *pcr);
 void rtl8411b_init_params(struct rtsx_pcr *pcr);
 void rts5260_init_params(struct rtsx_pcr *pcr);
 void rts5261_init_params(struct rtsx_pcr *pcr);
+void rts5228_init_params(struct rtsx_pcr *pcr);
 
 static inline u8 map_sd_drive(int idx)
 {
@@ -70,6 +71,8 @@ static inline u8 map_sd_drive(int idx)
 #define rts5209_vendor_setting1_valid(reg)	(!((reg) & 0x80))
 #define rts5209_vendor_setting2_valid(reg)	((reg) & 0x80)
 
+#define rtsx_check_mmc_support(reg)		((reg) & 0x10)
+#define rtsx_reg_to_rtd3(reg)				((reg) & 0x02)
 #define rtsx_reg_to_aspm(reg)			(((reg) >> 28) & 0x03)
 #define rtsx_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 26) & 0x03)
 #define rtsx_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 5) & 0x03)
@@ -100,6 +103,8 @@ void rtsx_pci_disable_ocp(struct rtsx_pcr *pcr);
 void rtsx_pci_enable_ocp(struct rtsx_pcr *pcr);
 int rtsx_pci_get_ocpstat(struct rtsx_pcr *pcr, u8 *val);
 void rtsx_pci_clear_ocpstat(struct rtsx_pcr *pcr);
+void rtsx_pci_enable_oobs_polling(struct rtsx_pcr *pcr);
+void rtsx_pci_disable_oobs_polling(struct rtsx_pcr *pcr);
 int rtsx_sd_power_off_card3v3(struct rtsx_pcr *pcr);
 int rtsx_ms_power_off_card3v3(struct rtsx_pcr *pcr);
 
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 5a71f6678fd3..bce910de8b4d 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1336,6 +1336,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
 		mmc->caps |= MMC_CAP_1_8V_DDR;
 	if (pcr->extra_caps & EXTRA_CAPS_MMC_8BIT)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
+	if (pcr->extra_caps & EXTRA_CAPS_NO_MMC)
+		mmc->caps2 |= MMC_CAP2_NO_MMC;
 }
 
 static void realtek_init_host(struct realtek_pci_sdmmc *host)
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index e8780d4e4636..27a6ea82aeea 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -305,6 +305,8 @@
 #define   SD30_CLK_STOP_CFG0		0x01
 #define REG_PRE_RW_MODE			0xFD70
 #define EN_INFINITE_MODE		0x01
+#define REG_CRC_DUMMY_0		0xFD71
+#define CFG_SD_POW_AUTO_PD		(1<<0)
 
 #define SRCTL				0xFC13
 
@@ -599,6 +601,7 @@
 
 #define ASPM_FORCE_CTL			0xFE57
 #define   FORCE_ASPM_CTL0		0x10
+#define   FORCE_ASPM_CTL1		0x20
 #define   FORCE_ASPM_VAL_MASK		0x03
 #define   FORCE_ASPM_L1_EN		0x02
 #define   FORCE_ASPM_L0_EN		0x01
@@ -667,6 +670,11 @@
 #define   PM_WAKE_EN			0x01
 #define PM_CTRL4			0xFF47
 
+#define REG_CFG_OOBS_OFF_TIMER 0xFEA6
+#define REG_CFG_OOBS_ON_TIMER 0xFEA7
+#define REG_CFG_VCM_ON_TIMER 0xFEA8
+#define REG_CFG_OOBS_POLLING 0xFEA9
+
 /* Memory mapping */
 #define SRAM_BASE			0xE600
 #define RBUF_BASE			0xF400
@@ -1204,6 +1212,7 @@ struct rtsx_pcr {
 #define EXTRA_CAPS_MMC_HSDDR		(1 << 3)
 #define EXTRA_CAPS_MMC_HS200		(1 << 4)
 #define EXTRA_CAPS_MMC_8BIT		(1 << 5)
+#define EXTRA_CAPS_NO_MMC		(1 << 7)
 	u32				extra_caps;
 
 #define IC_VER_A			0
@@ -1242,6 +1251,7 @@ struct rtsx_pcr {
 	u8				dma_error_count;
 	u8			ocp_stat;
 	u8			ocp_stat2;
+	u8			rtd3_en;
 };
 
 #define PID_524A	0x524A
@@ -1250,6 +1260,7 @@ struct rtsx_pcr {
 #define PID_525A	0x525A
 #define PID_5260	0x5260
 #define PID_5261	0x5261
+#define PID_5228	0x5228
 
 #define CHK_PCI_PID(pcr, pid)		((pcr)->pci->device == (pid))
 #define PCI_VID(pcr)			((pcr)->pci->vendor)
-- 
2.17.1

