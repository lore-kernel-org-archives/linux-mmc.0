From: <wei_wang@realsil.com.cn>
Subject: [PATCH v2 2/2] mmc/host/rtsx: Explicitely include slab.h in rtsx_pci_sdmmc.c
Date: Tue, 20 Nov 2012 10:09:23 +0800
Message-ID: <1c626d24c0fde1778afea0b5883b6da70d6ec135.1353377266.git.wei_wang@realsil.com.cn>
References: <cover.1353377266.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1353377266.git.wei_wang@realsil.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

From: Wei WANG <wei_wang@realsil.com.cn>

This fixes the following build error on some architectures (parisc at least):

drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sd_normal_rw':
drivers/mmc/host/rtsx_pci_sdmmc.c:448:2: error: implicit
declaration of function 'kzalloc'
[-Werror=implicit-function-declaration]
drivers/mmc/host/rtsx_pci_sdmmc.c:448:6: warning: assignment
makes pointer from integer without a cast [enabled by default]
drivers/mmc/host/rtsx_pci_sdmmc.c:472:2: error: implicit
declaration of function 'kfree'
[-Werror=implicit-function-declaration]

Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 067dd46..571915d 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-- 
1.7.9.5
