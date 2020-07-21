Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966D9C433E8
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F8C2073A
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595366647;
	bh=N6nUiUUBnWNBviVXCib+HaFXYm7Gu9fCJgmKStm3FWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nfOHFUli80Yfq/48geOanTUSkMTYNHmDqOGgk3plgWSRbnCP3XLFH0buZjqtkqaWg
	 C0GzSsXFQQ661wQ3VimGFIDIhccb3ARb+YWfEAnvw3S7/emWeBmBEGoGktS3+8qV0u
	 zPgRqdQ3xCMouzeH+tvejd/seZFhaClMamxzB1ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbgGUVYG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbgGUVYE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jul 2020 17:24:04 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F6BF20717;
        Tue, 21 Jul 2020 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595366643;
        bh=N6nUiUUBnWNBviVXCib+HaFXYm7Gu9fCJgmKStm3FWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAYBm0N83HY2B9McItfud5cXi0pY/NT0FoUP/FbWbY8/8311MZ1W5uw8nPiMyAK59
         ByMUKymMbXQZjwKO9isXPjm73FN66ephXGk53ZH418VldZmzvWOVfvKDwdw1ZfrgIA
         8LSTi+DAgJ8asp/g2t8fmAMAip+nOC8i+JICx9tg=
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
Subject: [PATCH 4/5] misc: rtsx: Find L1 PM Substates capability instead of hard-coding
Date:   Tue, 21 Jul 2020 16:23:35 -0500
Message-Id: <20200721212336.1159079-5-helgaas@kernel.org>
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

Instead of hard-coding the location of the L1 PM Substates capability based
on the Device ID, search for it in the extended capabilities list.  This
works for any device, as long as it implements the L1 PM Substates
capability correctly, so it doesn't require maintenance as new devices are
added.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rts5249.c | 12 ++++++------
 drivers/misc/cardreader/rts5260.c |  7 ++++++-
 drivers/misc/cardreader/rts5261.c |  7 ++++++-
 include/linux/rtsx_pci.h          |  4 ----
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 665472d05993..1b8149e806c1 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -95,15 +95,15 @@ static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
 static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
 {
 	struct pci_dev *pdev = pcr->pci;
+	int l1ss;
 	struct rtsx_cr_option *option = &(pcr->option);
 	u32 lval;
 
-	if (CHK_PCI_PID(pcr, PID_524A))
-		pci_read_config_dword(pdev,
-			PCR_ASPM_SETTING_REG1, &lval);
-	else
-		pci_read_config_dword(pdev,
-			PCR_ASPM_SETTING_REG2, &lval);
+	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!l1ss)
+		return;
+
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
 
 	if (lval & ASPM_L1_1_EN_MASK)
 		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 0e806dd7ad08..ebf77643cc90 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -498,10 +498,15 @@ static void rts5260_pwr_saving_setting(struct rtsx_pcr *pcr)
 static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 {
 	struct pci_dev *pdev = pcr->pci;
+	int l1ss;
 	struct rtsx_cr_option *option = &pcr->option;
 	u32 lval;
 
-	pci_read_config_dword(pdev, PCR_ASPM_SETTING_5260, &lval);
+	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!l1ss)
+		return;
+
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
 
 	if (lval & ASPM_L1_1_EN_MASK)
 		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 4f30637ee4ac..4b6e3fe4a007 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -413,10 +413,15 @@ static int rts5261_init_from_hw(struct rtsx_pcr *pcr)
 static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 {
 	struct pci_dev *pdev = pcr->pci;
+	int l1ss;
 	u32 lval;
 	struct rtsx_cr_option *option = &pcr->option;
 
-	pci_read_config_dword(pdev, PCR_ASPM_SETTING_REG1, &lval);
+	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!l1ss)
+		return;
+
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
 
 	if (lval & ASPM_L1_1_EN_MASK)
 		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 87eafba55749..f1e27b858972 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1029,10 +1029,6 @@
 #define   PHY_DIG1E_RX_EN_KEEP		0x0001
 #define PHY_DUM_REG			0x1F
 
-#define PCR_ASPM_SETTING_REG1		0x160
-#define PCR_ASPM_SETTING_REG2		0x168
-#define PCR_ASPM_SETTING_5260		0x178
-
 #define PCR_SETTING_REG1		0x724
 #define PCR_SETTING_REG2		0x814
 #define PCR_SETTING_REG3		0x747
-- 
2.25.1

