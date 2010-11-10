From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH 4/5] mmc: sdhci-pci invokes the sdhci_enable_irq_wakeups with SDHCI_WAKE_ON_INT
Date: Wed, 10 Nov 2010 16:28:08 +0100
Message-ID: <1289402889-14160-6-git-send-email-peppe.cavallaro@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-5-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:49494 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756604Ab0KJP2o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 10:28:44 -0500
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A5ED999
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:41 +0000 (GMT)
Received: from mail1.ctn.st.com (mail1.ctn.st.com [164.130.116.128])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F0E05419
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:41 +0000 (GMT)
In-Reply-To: <1289402889-14160-5-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci-pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 59f3de5..8634fb1 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -524,7 +524,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 
 		slot_pm_flags = slot->host->mmc->pm_flags;
 		if (slot_pm_flags & MMC_PM_WAKE_SDIO_IRQ)
-			sdhci_enable_irq_wakeups(slot->host);
+			sdhci_enable_irq_wakeups(slot->host, SDHCI_WAKE_ON_INT);
 
 		pm_flags |= slot_pm_flags;
 	}
-- 
1.5.5.6

