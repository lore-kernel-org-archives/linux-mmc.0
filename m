From: Prarit Bhargava <prarit@redhat.com>
Subject: [RFC PATCH 18/35] drivers/mmc changes for SMBIOS and System Firmware
Date: Tue, 31 May 2011 11:52:39 -0400
Message-ID: <20110531155239.3558.63991.sendpatchset@prarit.bos.redhat.com>
Content-Type: text/x-c; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>
List-Id: linux-mmc@vger.kernel.org

drivers/mmc changes for SMBIOS and System Firmware

---
 drivers/mmc/host/sdhci-pltfm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index dbab040..6fd7336 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -24,7 +24,6 @@
 
 #include <linux/delay.h>
 #include <linux/highmem.h>
-#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <linux/mmc/host.h>
-- 
1.7.5.1
