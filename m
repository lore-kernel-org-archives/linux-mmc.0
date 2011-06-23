From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 18/35] drivers/mmc changes for SMBIOS and System Firmware
Date: Thu, 23 Jun 2011 13:24:02 -0400
Message-ID: <20110623172401.27701.81021.sendpatchset@prarit.bos.redhat.com>
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>
List-Id: linux-mmc@vger.kernel.org

drivers/mmc changes for SMBIOS and System Firmware

As part of the new SMBIOS and System Firmware code:

- cleanup of includes for dmi.h and mod_devicetable.h which were included in
some files that did not need them

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
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
1.7.5.4
