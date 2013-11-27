From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 08/15] mmc: sh_mmcif: Enable driver compilation with COMPILE_TEST
Date: Wed, 27 Nov 2013 02:18:30 +0100
Message-ID: <1385515117-23664-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This helps increasing build testing coverage.

Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index ca1315e..265ba48 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -589,7 +589,8 @@ config MMC_DW_PCI
 
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
-	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
+	depends on MMC_BLOCK
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  This selects the MMC Host Interface controller (MMCIF).
 
-- 
1.8.3.2

