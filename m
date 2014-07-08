From: Allen Martin <amartin@nvidia.com>
Subject: [PATCH] mmc: tegra: Don't include asm/gpio.h
Date: Tue, 8 Jul 2014 14:37:06 -0700
Message-ID: <1404855426-3438-1-git-send-email-amartin@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7963 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaGHVht (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jul 2014 17:37:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: pwalmsley@nvidia.com, swarren@wwwdotorg.org, linux-tegra@vger.kernel.org, Allen Martin <amartin@nvidia.com>

Not available on arm64 and not needed.

Signed-off-by: Allen Martin <amartin@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index d93a063a36f3..33100d10d176 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -26,8 +26,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
 
-#include <asm/gpio.h>
-
 #include "sdhci-pltfm.h"
 
 /* Tegra SDHOST controller vendor register definitions */
-- 
1.8.1.5

