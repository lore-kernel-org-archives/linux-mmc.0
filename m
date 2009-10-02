From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/07] mmc: Add SuperH to the tmio-mmc Kconfig
Date: Fri, 02 Oct 2009 11:22:21 +0900
Message-ID: <20091002022221.8215.50121.sendpatchset@rxone.opensource.se>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SUPERH to the Kconfig dependencies for tmio_mmc.

This change allows us to drive the SDHI hardware blocks
found in SuperH Mobile with tmio_mmc.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/mmc/host/Kconfig
+++ work/drivers/mmc/host/Kconfig	2009-09-30 17:26:02.000000000 +0900
@@ -288,7 +288,7 @@ config MMC_SDRICOH_CS
 
 config MMC_TMIO
 	tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
-	depends on MFD_TMIO || MFD_ASIC3
+	depends on MFD_TMIO || MFD_ASIC3 || SUPERH
 	help
 	  This provides support for the SD/MMC cell found in TC6393XB,
 	  T7L66XB and also HTC ASIC3
