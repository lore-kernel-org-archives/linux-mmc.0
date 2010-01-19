From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/3] mmc: bfin_sdh: drop redundant MMC depend string
Date: Tue, 19 Jan 2010 03:02:10 -0500
Message-ID: <1263888131-25656-2-git-send-email-vapier@gentoo.org>
References: <1263888131-25656-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754987Ab0ASICZ@vger.kernel.org>
In-Reply-To: <1263888131-25656-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-mmc@vger.kernel.org

The host/Kconfig file is only included when MMC is selected.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index ce1d288..f6af92a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -399,7 +399,7 @@ config MMC_VIA_SDMMC
 
 config SDH_BFIN
 	tristate "Blackfin Secure Digital Host support"
-	depends on MMC && ((BF54x && !BF544) || (BF51x && !BF512))
+	depends on (BF54x && !BF544) || (BF51x && !BF512)
 	help
 	  If you say yes here you will get support for the Blackfin on-chip
 	  Secure Digital Host interface.  This includes support for MMC and
-- 
1.6.6
