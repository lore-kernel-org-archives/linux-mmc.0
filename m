From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [v1] mmc: host: dw_mmc-pci:- Handle return NULL error from pcim_iomap_table
Date: Thu, 22 Dec 2016 17:36:49 +0530
Message-ID: <1482408409-13404-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Here, If pcim_iomap_table will fail. It will return NULL.
Kernel can run into a NULL-pointer dereference.
This error check will avoid NULL pointer dereference.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/dw_mmc-pci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index ab82796..f42d302 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -61,6 +61,8 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 		return ret;
 
 	host->regs = pcim_iomap_table(pdev)[PCI_BAR_NO];
+	if (!host->regs)
+		return -ENOMEM;
 
 	pci_set_master(pdev);
 
-- 
1.7.9.5
