From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [v1] mmc: host: dw_mmc-pci:- Unmap region obtained by pcim_iomap_regions
Date: Fri, 23 Dec 2016 16:01:16 +0530
Message-ID: <1482489076-17799-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Unmap and release PCI BARs, if dw_mci_pci_probe is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/dw_mmc-pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index ab82796..f10bad8 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -65,8 +65,10 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	ret = dw_mci_probe(host);
-	if (ret)
+	if (ret) {
+		pcim_iounmap_regions(pdev, 1 << PCI_BAR_NO);
 		return ret;
+	}
 
 	pci_set_drvdata(pdev, host);
 
-- 
1.7.9.5
