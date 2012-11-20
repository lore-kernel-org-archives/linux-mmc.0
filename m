From: <wei_wang@realsil.com.cn>
Subject: [PATCH v3 2/2] mmc/host/rtsx: Explicitely include slab.h in rtsx_pci_sdmmc.c
Date: Tue, 20 Nov 2012 11:24:44 +0800
Message-ID: <e46f49551ee089dfac863c7f1d9e02cb9b42e1ff.1353381810.git.wei_wang@realsil.com.cn>
References: <cover.1353381810.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:34483 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2KTDZU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 22:25:20 -0500
In-Reply-To: <cover.1353381810.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>

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
Acked-by: Chris Ball <cjb@laptop.org>
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

