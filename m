From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/4] sdhci: Allow the probe handler to override slots
Date: Mon, 13 Sep 2010 16:02:27 +0100
Message-ID: <20100913150217.23167.88864.stgit@localhost.localdomain>
References: <20100913145805.23167.35463.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11959 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611Ab0IMPrl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 11:47:41 -0400
In-Reply-To: <20100913145805.23167.35463.stgit@localhost.localdomain>
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
index 168b837..24f9f6a 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -874,6 +874,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 			goto free;
 	}
 
+	slots = chip->num_slots;	/* Quirk may have changed this */
+
 	for (i = 0;i < slots;i++) {
 		slot = sdhci_pci_probe_slot(pdev, chip, first_bar + i);
 		if (IS_ERR(slot)) {

