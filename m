From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: [PATCH] mmc: add ricoh e823 pci id
Date: Fri, 11 Feb 2011 16:25:31 -0600
Message-ID: <1297463131-3557-2-git-send-email-manoj.iyer@canonical.com>
References: <1297463131-3557-1-git-send-email-manoj.iyer@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297463131-3557-1-git-send-email-manoj.iyer@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
---
 drivers/mmc/host/sdhci-pci.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 0dc905b..f7e622c 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -547,6 +547,14 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 	},
 
 	{
+		.vendor         = PCI_VENDOR_ID_RICOH,
+		.device         = 0xe823,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.driver_data    = (kernel_ulong_t)&sdhci_ricoh_mmc,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_ENE,
 		.device		= PCI_DEVICE_ID_ENE_CB712_SD,
 		.subvendor	= PCI_ANY_ID,
-- 
1.7.1
