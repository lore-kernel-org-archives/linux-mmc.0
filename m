From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 2/5] mmc: omap_hsmmc: Enable omap_hsmmc for Keystone 2
Date: Tue, 20 Oct 2015 16:50:06 -0500
Message-ID: <1445377809-12516-2-git-send-email-fcooper@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, ssantosh@kernel.org, ulf.hansson@linaro.org, m-karicheri2@ti.com, grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Enable omap_hsmmc for Keystone 2 architecture which reuses the HSMMC
IP found on OMAP platforms.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8a1e349..2ccec71 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -366,7 +366,7 @@ config MMC_OMAP
 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
 	depends on HAS_DMA
-	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
 	  If you have an omap2plus board with a Multimedia Card slot,
-- 
2.6.1
