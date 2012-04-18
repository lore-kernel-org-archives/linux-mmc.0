From: Venkatraman S <svenkatr@ti.com>
Subject: [RFC PATCH 05/11] mmc: Add BKOPS field offsets
Date: Wed, 18 Apr 2012 11:55:26 +0530
Message-ID: <1334730332-22244-6-git-send-email-svenkatr@ti.com>
References: <1334730332-22244-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334730332-22244-1-git-send-email-svenkatr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: arnd.bergmann@linaro.org, cjb@laptop.org, alex.limberg@sandisk.com, ilan.smith@sandisk.com, lporzio@micron.com, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 include/linux/mmc/mmc.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index b822a2c..ec2f195 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -280,6 +280,8 @@ struct _mmc_csd {
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
 #define EXT_CSD_HPI_MGMT		161	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
+#define EXT_CSD_BKOPS_EN		163	/* R/W */
+#define EXT_CSD_BKOPS_START		164	/* W */
 #define EXT_CSD_SANITIZE_START		165     /* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_BOOT_WP			173	/* R/W */
-- 
1.7.10.rc2
