From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 1/4] MMC: atmel-mci: fix two parameters swapped
Date: Tue, 27 Apr 2010 16:36:26 +0200
Message-ID: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
References: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: haavard.skinnemoen@atmel.com, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@avr32linux.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Two parameters were swapped in the calls to atmci_init_slot(). Two parameters
were swapped in the calls to atmci_init_slot(). Their values

Reported-by: Anders Grahn <anders.grahn@hd-wireless.se>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 4338750..321e0bf 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1767,13 +1767,13 @@ static int __init atmci_probe(struct platform_device *pdev)
 	ret = -ENODEV;
 	if (pdata->slot[0].bus_width) {
 		ret = atmci_init_slot(host, &pdata->slot[0],
-				MCI_SDCSEL_SLOT_A, 0);
+				0, MCI_SDCSEL_SLOT_A);
 		if (!ret)
 			nr_slots++;
 	}
 	if (pdata->slot[1].bus_width) {
 		ret = atmci_init_slot(host, &pdata->slot[1],
-				MCI_SDCSEL_SLOT_B, 1);
+				1, MCI_SDCSEL_SLOT_B);
 		if (!ret)
 			nr_slots++;
 	}
-- 
1.5.6.5
