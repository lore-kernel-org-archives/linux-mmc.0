Return-Path: <SRS0=LU6H=7P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAE2C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 09:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A83206A4
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 09:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgFBJVF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:21:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:48061 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgFBJVF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Jun 2020 05:21:05 -0400
IronPort-SDR: Frk2PmokzxL8nwVxDZn295NIeyEQ48MKlaWJLSmFElOzNdc4TIPZerynw7iXNbTPO61VyofNK5
 SusRgLvZ3JQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:21:04 -0700
IronPort-SDR: dI1R7AxQVaIHe+52H03VmHXLIDabd1tIz9q+sYebuudsp3jDoKZvrf9F9eDjzW0VfWfEHG30kP
 T2HqapICPBHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="347347617"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2020 02:21:02 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 11/15] mmc: sdhci: use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  2 Jun 2020 11:20:59 +0200
Message-Id: <20200602092059.32146-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/mmc/host/sdhci-pci-gli.c     | 3 +--
 drivers/mmc/host/sdhci-pci-o2micro.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index fd76aa672e02..d14997f9cbf9 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -271,8 +271,7 @@ static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
 {
 	int ret;
 
-	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1,
-				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
 	if (ret < 0) {
 		pr_warn("%s: enable PCI MSI failed, error=%d\n",
 		       mmc_hostname(slot->host->mmc), ret);
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index fa8105087d68..498c51207bfb 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -470,8 +470,7 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
 		return;
 	}
 
-	ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
-				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	ret = pci_alloc_irq_vectors(chip->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
 	if (ret < 0) {
 		pr_err("%s: enable PCI MSI failed, err=%d\n",
 		       mmc_hostname(host->mmc), ret);
-- 
2.17.2

