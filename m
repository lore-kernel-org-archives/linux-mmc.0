From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] mmc: host: via-sdmmc: constify pci_device_id.
Date: Mon, 17 Jul 2017 22:01:33 +0530
Message-ID: <6e5268522c9f41b6f6b6d9a3f70212b641042bb1.1500309009.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: brucechang@via.com.tw, HaraldWelte@viatech.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   6952	    880	      0	   7832	   1e98	drivers/mmc/host/via-sdmmc.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   7032	    800	      0	   7832	   1e98	drivers/mmc/host/via-sdmmc.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/via-sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 6380044..a838bf5 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -323,7 +323,7 @@ struct via_crdr_mmc_host {
 /* some devices need a very long delay for power to stabilize */
 #define VIA_CRDR_QUIRK_300MS_PWRDELAY	0x0001
 
-static struct pci_device_id via_ids[] = {
+static const struct pci_device_id via_ids[] = {
 	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_9530,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
 	{0,}
-- 
2.7.4
