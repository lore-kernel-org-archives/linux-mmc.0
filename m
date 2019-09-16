From: Denis Efremov <efremov@linux.com>
Subject: [PATCH v3 23/26] memstick: use PCI_STD_NUM_BARS
Date: Mon, 16 Sep 2019 23:41:55 +0300
Message-ID: <20190916204158.6889-24-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>, linux-mmc@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
PCI BARs.

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/memstick/host/jmb38x_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 32747425297d..fd281c1d39b1 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -848,7 +848,7 @@ static int jmb38x_ms_count_slots(struct pci_dev *pdev)
 {
 	int cnt, rc = 0;
 
-	for (cnt = 0; cnt < PCI_ROM_RESOURCE; ++cnt) {
+	for (cnt = 0; cnt < PCI_STD_NUM_BARS; ++cnt) {
 		if (!(IORESOURCE_MEM & pci_resource_flags(pdev, cnt)))
 			break;
 
-- 
2.21.0
