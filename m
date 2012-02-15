From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: [PATCH] sdhci-tegra: fix linux/module.h included twice
Date: Wed, 15 Feb 2012 18:54:26 +0100
Message-ID: <1329328466-4627-1-git-send-email-danny.kukawka@bisect.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:41575 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753811Ab2BORyi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 12:54:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Danny Kukawka <dkukawka@suse.de>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@nvidia.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Remove double include of linux/module.h.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 drivers/mmc/host/sdhci-tegra.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 78a36eb..cb34856 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -23,7 +23,6 @@
 #include <linux/gpio.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
-#include <linux/module.h>
 
 #include <asm/gpio.h>
 
-- 
1.7.8.3

