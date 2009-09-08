From: thomas.ab@samsung.com
Subject: [PATCH 1/8] s3c6410: sdhci: Adding additional elements in sdhci platform data structure.
Date: Tue,  8 Sep 2009 15:46:48 +0900
Message-ID: <1252392408-23849-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:57694 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbZIHG5Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 02:57:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This patch adds additional elements in the s3c6410 sdhci
platform data structure. The elements added are parent clock name,
source clock name and desired clock speed.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c/include/plat/sdhci.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/sdhci.h b/arch/arm/plat-s3c/include/plat/sdhci.h
index f615308..b96ec42 100644
--- a/arch/arm/plat-s3c/include/plat/sdhci.h
+++ b/arch/arm/plat-s3c/include/plat/sdhci.h
@@ -37,6 +37,9 @@ struct mmc_ios;
 struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
+	char		clk_parent_name[20];
+	char            clk_source_name[20];
+	unsigned long   clk_speed;
 
 	char		**clocks;	/* set of clock sources */
 
-- 
1.5.3.4

