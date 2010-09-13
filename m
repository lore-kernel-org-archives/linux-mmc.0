From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/7] sdhci: Allow the probe handler to override slots
Date: Mon, 13 Sep 2010 18:39:02 +0100
Message-ID: <20100913173856.20345.84969.stgit@localhost.localdomain>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30364 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab0IMSXe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 14:23:34 -0400
In-Reply-To: <20100913172738.20345.61119.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

Currently we write it to the chip data, but if the probe handler overrides
it we ignore the new value and keep using our cached one. Fix this so that
a probe handler can adjust the slot count

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/sdhci-pci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 3e29e94..9b0a348 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -870,6 +870,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 			goto free;
 	}
 
+	slots = chip->num_slots;	/* Quirk may have changed this */
+
 	for (i = 0;i < slots;i++) {
 		slot = sdhci_pci_probe_slot(pdev, chip, first_bar + i);
 		if (IS_ERR(slot)) {

