Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6301C433E7
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A192072E
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595366644;
	bh=HtZ8+oGVwMLlTIFRT4Um1tfyxkNMBEGKI1zdIM4Ry9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=urczjbu1Ugem8y6L2q6eI8jERmb/Q0wgrIr7QE3arv/waXgJBGrxKQtYoa4uNJ77S
	 A34bAw70w3Pq0j9EqOFJ0wy0UkRlb4PPJkn96mbyHRvsPUtIzPQiDviuYX5oZLALiK
	 uVNm3FL5uJ8zdckbAxsvj9LoJGg+FJnEbeQFQwIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgGUVYE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731217AbgGUVYC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jul 2020 17:24:02 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C862073A;
        Tue, 21 Jul 2020 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595366641;
        bh=HtZ8+oGVwMLlTIFRT4Um1tfyxkNMBEGKI1zdIM4Ry9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSMiRU2Tec0x03YxbimOqh8dYzGvNWN0m1YNVUo6huYmWzTYSQqeaYGSfwH63D1AE
         Ie/jt9UT50CnkvjZ+UyYRqlO8PlUN7NqMoy8WiRx7vdROkB4If4PCWcyhUk3Lw7RjR
         PaMSvrgRERB7c4yyskrZYCD1gwJfKR5/AWvbrrLg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ricky Wu <ricky_wu@realtek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rui Feng <rui_feng@realsil.com.cn>, Klaus Doth <kdlnx@doth.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/5] misc: rtsx: Remove rtsx_pci_read/write_config() wrappers
Date:   Tue, 21 Jul 2020 16:23:34 -0500
Message-Id: <20200721212336.1159079-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721212336.1159079-1-helgaas@kernel.org>
References: <20200721212336.1159079-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

rtsx_pci_read_config_dword() and similar wrappers around the PCI config
accessors add very little value, and they obscure the fact that often we
are accessing standard PCI registers that should be coordinated with the
PCI core.

Remove the wrappers and use the PCI config accessors directly.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rtl8411.c  |  8 +++++---
 drivers/misc/cardreader/rts5209.c  |  5 +++--
 drivers/misc/cardreader/rts5227.c  |  5 +++--
 drivers/misc/cardreader/rts5229.c  |  5 +++--
 drivers/misc/cardreader/rts5249.c  | 12 +++++++-----
 drivers/misc/cardreader/rts5260.c  | 10 ++++++----
 drivers/misc/cardreader/rts5261.c  | 19 +++++++++++--------
 drivers/misc/cardreader/rtsx_pcr.c |  2 +-
 include/linux/rtsx_pci.h           | 12 ------------
 9 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/cardreader/rtl8411.c b/drivers/misc/cardreader/rtl8411.c
index 489ebe907688..a07674ed0596 100644
--- a/drivers/misc/cardreader/rtl8411.c
+++ b/drivers/misc/cardreader/rtl8411.c
@@ -37,10 +37,11 @@ static int rtl8411b_is_qfn48(struct rtsx_pcr *pcr)
 
 static void rtl8411_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	u32 reg1 = 0;
 	u8 reg3 = 0;
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg1);
+	pci_read_config_dword(pdev, PCR_SETTING_REG1, &reg1);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg1);
 
 	if (!rtsx_vendor_setting_valid(reg1))
@@ -52,16 +53,17 @@ static void rtl8411_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr->card_drive_sel &= 0x3F;
 	pcr->card_drive_sel |= rtsx_reg_to_card_drive_sel(reg1);
 
-	rtsx_pci_read_config_byte(pcr, PCR_SETTING_REG3, &reg3);
+	pci_read_config_byte(pdev, PCR_SETTING_REG3, &reg3);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG3, reg3);
 	pcr->sd30_drive_sel_3v3 = rtl8411_reg_to_sd30_drive_sel_3v3(reg3);
 }
 
 static void rtl8411b_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	u32 reg = 0;
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG1, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
 
 	if (!rtsx_vendor_setting_valid(reg))
diff --git a/drivers/misc/cardreader/rts5209.c b/drivers/misc/cardreader/rts5209.c
index 659056164b21..39a6a7ecc32e 100644
--- a/drivers/misc/cardreader/rts5209.c
+++ b/drivers/misc/cardreader/rts5209.c
@@ -23,9 +23,10 @@ static u8 rts5209_get_ic_version(struct rtsx_pcr *pcr)
 
 static void rts5209_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	u32 reg;
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG1, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
 
 	if (rts5209_vendor_setting1_valid(reg)) {
@@ -34,7 +35,7 @@ static void rts5209_fetch_vendor_settings(struct rtsx_pcr *pcr)
 		pcr->aspm_en = rts5209_reg_to_aspm(reg);
 	}
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
 
 	if (rts5209_vendor_setting2_valid(reg)) {
diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 3a9467aaa435..f5f392ddf3d6 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -56,9 +56,10 @@ static void rts5227_fill_driving(struct rtsx_pcr *pcr, u8 voltage)
 
 static void rts5227_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	u32 reg;
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG1, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
 
 	if (!rtsx_vendor_setting_valid(reg))
@@ -69,7 +70,7 @@ static void rts5227_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr->card_drive_sel &= 0x3F;
 	pcr->card_drive_sel |= rtsx_reg_to_card_drive_sel(reg);
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
 	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
 	if (rtsx_reg_check_reverse_socket(reg))
diff --git a/drivers/misc/cardreader/rts5229.c b/drivers/misc/cardreader/rts5229.c
index 9f080a32ef50..89e6f124ca5c 100644
--- a/drivers/misc/cardreader/rts5229.c
+++ b/drivers/misc/cardreader/rts5229.c
@@ -23,9 +23,10 @@ static u8 rts5229_get_ic_version(struct rtsx_pcr *pcr)
 
 static void rts5229_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	u32 reg;
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG1, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
 
 	if (!rtsx_vendor_setting_valid(reg))
@@ -37,7 +38,7 @@ static void rts5229_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr->card_drive_sel &= 0x3F;
 	pcr->card_drive_sel |= rtsx_reg_to_card_drive_sel(reg);
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
 	pcr->sd30_drive_sel_3v3 =
 		map_sd_drive(rtsx_reg_to_sd30_drive_sel_3v3(reg));
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 6c6c9e95a29f..665472d05993 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -55,9 +55,10 @@ static void rts5249_fill_driving(struct rtsx_pcr *pcr, u8 voltage)
 
 static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	u32 reg;
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG1, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
 
 	if (!rtsx_vendor_setting_valid(reg)) {
@@ -70,7 +71,7 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr->card_drive_sel &= 0x3F;
 	pcr->card_drive_sel |= rtsx_reg_to_card_drive_sel(reg);
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
 	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
 	if (rtsx_reg_check_reverse_socket(reg))
@@ -93,14 +94,15 @@ static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
 
 static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	struct rtsx_cr_option *option = &(pcr->option);
 	u32 lval;
 
 	if (CHK_PCI_PID(pcr, PID_524A))
-		rtsx_pci_read_config_dword(pcr,
+		pci_read_config_dword(pdev,
 			PCR_ASPM_SETTING_REG1, &lval);
 	else
-		rtsx_pci_read_config_dword(pcr,
+		pci_read_config_dword(pdev,
 			PCR_ASPM_SETTING_REG2, &lval);
 
 	if (lval & ASPM_L1_1_EN_MASK)
@@ -118,7 +120,7 @@ static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
 	if (option->ltr_en) {
 		u16 val;
 
-		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
+		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &val);
 		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
 			option->ltr_enabled = true;
 			option->ltr_active = true;
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 7a9dbb778e84..0e806dd7ad08 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -64,9 +64,10 @@ static void rts5260_fill_driving(struct rtsx_pcr *pcr, u8 voltage)
 
 static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	u32 reg;
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG1, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
 
 	if (!rtsx_vendor_setting_valid(reg)) {
@@ -79,7 +80,7 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr->card_drive_sel &= 0x3F;
 	pcr->card_drive_sel |= rtsx_reg_to_card_drive_sel(reg);
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
 	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
 	if (rtsx_reg_check_reverse_socket(reg))
@@ -496,10 +497,11 @@ static void rts5260_pwr_saving_setting(struct rtsx_pcr *pcr)
 
 static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	struct rtsx_cr_option *option = &pcr->option;
 	u32 lval;
 
-	rtsx_pci_read_config_dword(pcr, PCR_ASPM_SETTING_5260, &lval);
+	pci_read_config_dword(pdev, PCR_ASPM_SETTING_5260, &lval);
 
 	if (lval & ASPM_L1_1_EN_MASK)
 		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
@@ -518,7 +520,7 @@ static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 	if (option->ltr_en) {
 		u16 val;
 
-		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
+		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &val);
 		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
 			option->ltr_enabled = true;
 			option->ltr_active = true;
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 195822ec858e..4f30637ee4ac 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -59,9 +59,11 @@ static void rts5261_fill_driving(struct rtsx_pcr *pcr, u8 voltage)
 
 static void rtsx5261_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	u32 reg;
+
 	/* 0x814~0x817 */
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
 
 	if (!rts5261_vendor_setting_valid(reg)) {
@@ -76,7 +78,7 @@ static void rtsx5261_fetch_vendor_settings(struct rtsx_pcr *pcr)
 		pcr->flags |= PCR_REVERSE_SOCKET;
 
 	/* 0x724~0x727 */
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
+	pci_read_config_dword(pdev, PCR_SETTING_REG1, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
 
 	pcr->aspm_en = rts5261_reg_to_aspm(reg);
@@ -361,6 +363,7 @@ static void rts5261_process_ocp(struct rtsx_pcr *pcr)
 
 static int rts5261_init_from_hw(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	int retval;
 	u32 lval, i;
 	u8 valid, efuse_valid, tmp;
@@ -386,8 +389,7 @@ static int rts5261_init_from_hw(struct rtsx_pcr *pcr)
 	pcr_dbg(pcr, "Load efuse valid: 0x%x\n", efuse_valid);
 
 	if (efuse_valid == 0) {
-		retval = rtsx_pci_read_config_dword(pcr,
-			PCR_SETTING_REG2, &lval);
+		retval = pci_read_config_dword(pdev, PCR_SETTING_REG2, &lval);
 		if (retval != 0)
 			pcr_dbg(pcr, "read 0x814 DW fail\n");
 		pcr_dbg(pcr, "DW from 0x814: 0x%x\n", lval);
@@ -399,9 +401,9 @@ static int rts5261_init_from_hw(struct rtsx_pcr *pcr)
 		REG_EFUSE_POR, 0);
 	pcr_dbg(pcr, "Disable efuse por!\n");
 
-	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &lval);
+	pci_read_config_dword(pdev, PCR_SETTING_REG2, &lval);
 	lval = lval & 0x00FFFFFF;
-	retval = rtsx_pci_write_config_dword(pcr, PCR_SETTING_REG2, lval);
+	retval = pci_write_config_dword(pdev, PCR_SETTING_REG2, lval);
 	if (retval != 0)
 		pcr_dbg(pcr, "write config fail\n");
 
@@ -410,10 +412,11 @@ static int rts5261_init_from_hw(struct rtsx_pcr *pcr)
 
 static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	u32 lval;
 	struct rtsx_cr_option *option = &pcr->option;
 
-	rtsx_pci_read_config_dword(pcr, PCR_ASPM_SETTING_REG1, &lval);
+	pci_read_config_dword(pdev, PCR_ASPM_SETTING_REG1, &lval);
 
 	if (lval & ASPM_L1_1_EN_MASK)
 		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
@@ -439,7 +442,7 @@ static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 	if (option->ltr_en) {
 		u16 val;
 
-		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
+		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &val);
 		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
 			option->ltr_enabled = true;
 			option->ltr_active = true;
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 169505165a52..f0a1bee735b5 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1327,7 +1327,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
 				   PCI_EXP_LNKCTL_CLKREQ_EN);
 	/* Enter L1 when host tx idle */
-	rtsx_pci_write_config_byte(pcr, 0x70F, 0x5B);
+	pci_write_config_byte(pdev, 0x70F, 0x5B);
 
 	if (pcr->ops->extra_init_hw) {
 		err = pcr->ops->extra_init_hw(pcr);
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index b1071c80fffc..87eafba55749 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -99,18 +99,6 @@
 #define rtsx_pci_readb(pcr, reg) \
 	ioread8((pcr)->remap_addr + reg)
 
-#define rtsx_pci_read_config_byte(pcr, where, val) \
-	pci_read_config_byte((pcr)->pci, where, val)
-
-#define rtsx_pci_write_config_byte(pcr, where, val) \
-	pci_write_config_byte((pcr)->pci, where, val)
-
-#define rtsx_pci_read_config_dword(pcr, where, val) \
-	pci_read_config_dword((pcr)->pci, where, val)
-
-#define rtsx_pci_write_config_dword(pcr, where, val) \
-	pci_write_config_dword((pcr)->pci, where, val)
-
 #define STATE_TRANS_NONE		0
 #define STATE_TRANS_CMD			1
 #define STATE_TRANS_BUF			2
-- 
2.25.1

