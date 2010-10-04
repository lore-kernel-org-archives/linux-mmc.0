From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/3] sdhci: Allow the probe handler to override slots
Date: Mon, 04 Oct 2010 15:06:42 +0100
Message-ID: <20101004140633.14608.59308.stgit@localhost.localdomain>
References: <20101004140454.14608.70665.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46815 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275Ab0JDPrd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2010 11:47:33 -0400
Received: from localhost.localdomain (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id o94EP8Qm024116
	for <linux-mmc@vger.kernel.org>; Mon, 4 Oct 2010 15:25:13 +0100
In-Reply-To: <20101004140454.14608.70665.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Currently we write it to the chip data, but if the probe handler overrides
it we ignore the new value and keep using our cached one. Fix this so that
a probe handler can adjust the slot count

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/sdhci-pci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index e8aa99d..4f5d6d0 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -818,6 +818,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 			goto free;
 	}
 
+	slots = chip->num_slots;	/* Quirk may have changed this */
+
 	for (i = 0;i < slots;i++) {
 		slot = sdhci_pci_probe_slot(pdev, chip, first_bar + i);
 		if (IS_ERR(slot)) {

