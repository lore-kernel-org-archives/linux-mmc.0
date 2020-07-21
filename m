Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E10C433EB
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90545207BB
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595366647;
	bh=mjbCzfQUyreChEBi1wQcXinwxAO9wpEShodrHsLYVfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vcoZbqEGWtRyN36zdmv+am/2dR0tqRukr9bTPt3lbJ39tsfg+U3aLUunIJ7qLZ4JK
	 RnFgKWX9imZNURKw5DC9Kvgb01W4wk0rPnby+M/3YqyOAZH1AN3fP4btVB3U+j2iX6
	 Et1OB0epSCXgxINxqfrU9DBB0BOj5GqP8XZLcGcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgGUVYH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731217AbgGUVYG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jul 2020 17:24:06 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8DE2072E;
        Tue, 21 Jul 2020 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595366646;
        bh=mjbCzfQUyreChEBi1wQcXinwxAO9wpEShodrHsLYVfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKzgEVzYhCOd1k4J65eVRWxOQcNG1ASmYxJ5Z/mXS7fZ8KU0CLQE3rxbK+141d2GZ
         NzU6oB8UGRcoVccm7+ZKhx9J2Ir/djD03nzv0Qt2EUR5A/lLTHpt3dGvmsOkaIiUP8
         9sl+5pCSCMhsCCfRejjAW2Xbelo1ADGpGtFe6EjA=
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
Subject: [PATCH 5/5] misc: rtsx: Use standard PCI definitions
Date:   Tue, 21 Jul 2020 16:23:36 -0500
Message-Id: <20200721212336.1159079-6-helgaas@kernel.org>
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

When reading registers defined by the PCIe spec, use the names already
defined by the PCI core.  This makes maintenance of the PCI core and
drivers easier.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rts5249.c | 8 ++++----
 drivers/misc/cardreader/rts5260.c | 8 ++++----
 drivers/misc/cardreader/rts5261.c | 8 ++++----
 include/linux/rtsx_pci.h          | 5 -----
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 1b8149e806c1..941b3d77f1e9 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -105,16 +105,16 @@ static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
 
 	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
 
-	if (lval & ASPM_L1_1_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
 		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
 
-	if (lval & ASPM_L1_2_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
 		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
 
-	if (lval & PM_L1_1_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
 		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
 
-	if (lval & PM_L1_2_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
 		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
 
 	if (option->ltr_en) {
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index ebf77643cc90..b9f66b1384a6 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -508,16 +508,16 @@ static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 
 	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
 
-	if (lval & ASPM_L1_1_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
 		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
 
-	if (lval & ASPM_L1_2_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
 		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
 
-	if (lval & PM_L1_1_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
 		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
 
-	if (lval & PM_L1_2_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
 		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
 
 	rts5260_pwr_saving_setting(pcr);
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 4b6e3fe4a007..471961487ff8 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -423,22 +423,22 @@ static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 
 	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
 
-	if (lval & ASPM_L1_1_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
 		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
 	else
 		rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
 
-	if (lval & ASPM_L1_2_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
 		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
 	else
 		rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
 
-	if (lval & PM_L1_1_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
 		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
 	else
 		rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
 
-	if (lval & PM_L1_2_EN_MASK)
+	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
 		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
 	else
 		rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index f1e27b858972..9f70cdedb124 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1075,11 +1075,6 @@ struct pcr_ops {
 
 enum PDEV_STAT  {PDEV_STAT_IDLE, PDEV_STAT_RUN};
 
-#define ASPM_L1_1_EN_MASK		BIT(3)
-#define ASPM_L1_2_EN_MASK		BIT(2)
-#define PM_L1_1_EN_MASK		BIT(1)
-#define PM_L1_2_EN_MASK		BIT(0)
-
 #define ASPM_L1_1_EN			BIT(0)
 #define ASPM_L1_2_EN			BIT(1)
 #define PM_L1_1_EN				BIT(2)
-- 
2.25.1

