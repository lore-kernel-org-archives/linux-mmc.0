From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] mmc: tegra: move platform data header
Date: Tue,  4 Sep 2012 16:42:45 -0600
Message-ID: <1346798565-28884-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:35284 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824Ab2IDWmv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Sep 2012 18:42:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Stephen Warren <swarren@nvidia.com>

Move the Tegra SDHCI platform data header out of arch/arm/mach-tegra, as
a pre-requisite of single zImage.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c                     |    3 +--
 .../sdhci.h => include/linux/mmc/tegra_sdhci.h     |    2 --
 2 files changed, 1 insertions(+), 4 deletions(-)
 rename arch/arm/mach-tegra/include/mach/sdhci.h => include/linux/mmc/tegra_sdhci.h (93%)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f98ece6..73c5d1f 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -24,11 +24,10 @@
 #include <linux/gpio.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/tegra_sdhci.h>
 
 #include <asm/gpio.h>
 
-#include <mach/sdhci.h>
-
 #include "sdhci-pltfm.h"
 
 /* Tegra SDHOST controller vendor register definitions */
diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h b/include/linux/mmc/tegra_sdhci.h
similarity index 93%
rename from arch/arm/mach-tegra/include/mach/sdhci.h
rename to include/linux/mmc/tegra_sdhci.h
index 4231bc7..70aa1a7 100644
--- a/arch/arm/mach-tegra/include/mach/sdhci.h
+++ b/include/linux/mmc/tegra_sdhci.h
@@ -1,6 +1,4 @@
 /*
- * include/asm-arm/arch-tegra/include/mach/sdhci.h
- *
  * Copyright (C) 2009 Palm, Inc.
  * Author: Yvonne Yip <y@palm.com>
  *
-- 
1.7.0.4

