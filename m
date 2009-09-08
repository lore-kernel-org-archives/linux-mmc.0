From: thomas.ab@samsung.com
Subject: [PATCH 7/8] s3c6410: sdhci: Remove host_caps field from sdhci platform data structure
Date: Tue,  8 Sep 2009 16:00:32 +0900
Message-ID: <1252393232-31780-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:42403 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbZIHHMN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 03:12:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This patch removes the host_caps field from the s3c_sdhci_platdata
data structure. This field is not used by the sdhci driver.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c/include/plat/sdhci.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/sdhci.h b/arch/arm/plat-s3c/include/plat/sdhci.h
index b96ec42..f43d1a6 100644
--- a/arch/arm/plat-s3c/include/plat/sdhci.h
+++ b/arch/arm/plat-s3c/include/plat/sdhci.h
@@ -23,7 +23,6 @@ struct mmc_ios;
 /**
  * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
  * @max_width: The maximum number of data bits supported.
- * @host_caps: Standard MMC host capabilities bit field.
  * @cfg_gpio: Configure the GPIO for a specific card bit-width
  * @cfg_card: Configure the interface for a specific card and speed. This
  *            is necessary the controllers and/or GPIO blocks require the
@@ -36,7 +35,6 @@ struct mmc_ios;
 */
 struct s3c_sdhci_platdata {
 	unsigned int	max_width;
-	unsigned int	host_caps;
 	char		clk_parent_name[20];
 	char            clk_source_name[20];
 	unsigned long   clk_speed;
-- 
1.5.3.4

