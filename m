From: <Chikkature@lina0132712>, <Rajashekar@lina0132712>,
	<Madhusudhan@lina0132712>, <madhu.cr@ti.com>
Subject: [PATCH] OMAP: HSMMC maintainence
Date: Thu, 30 Jun 2011 16:07:26 -0500
Message-ID: <1309468046-17904-1-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Madhusudhan Chikkature <madhu.cr@ti.com>

Removing the OMAP HS MMC entry from the MAINTAINERS file as I will
no longer be able to maintain this driver.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 MAINTAINERS |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0094224..96061d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4306,12 +4306,6 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/omap.c
 
-OMAP HS MMC SUPPORT
-M:	Madhusudhan Chikkature <madhu.cr@ti.com>
-L:	linux-omap@vger.kernel.org
-S:	Maintained
-F:	drivers/mmc/host/omap_hsmmc.c
-
 OMAP RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
-- 
1.7.0.4

