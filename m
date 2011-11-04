From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/4] mmc: Add additional binding for mmc host controller
Date: Fri, 4 Nov 2011 17:20:38 +0530
Message-ID: <1320407441-29697-2-git-send-email-rnayak@ti.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37099 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab1KDLvL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Nov 2011 07:51:11 -0400
In-Reply-To: <1320407441-29697-1-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, thomas.abraham@linaro.org, balajitk@ti.com, cjb@laptop.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>

Add mmc host controller capability binding to support
'MMC_CAP_POWER_OFF_CARD' powering off of the card after boot.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/mmc/linux-mmc-host.txt     |    1 +
 drivers/mmc/core/host.c                            |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
index 714b2b1..cf893ed 100644
--- a/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
+++ b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
@@ -11,3 +11,4 @@ specific mmc host controller capabilities.
 - linux,mmc_cap_disable - Host can be disabled and re-enabled to save power
 - linux,mmc_cap_nonremovable - Host is connected to nonremovable media
 - linux,mmc_cap_erase - Host allows erase/trim commands
+- linux,mmc_cap_power_off_card - Host can power off the card after boot
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 4ee2e43..822337a 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -413,6 +413,8 @@ void mmc_of_parse_host_caps(struct device_node *np, unsigned long *caps)
 		*caps |= MMC_CAP_NONREMOVABLE;
 	if (of_find_property(np, "linux,mmc_cap_erase", NULL))
 		*caps |= MMC_CAP_ERASE;
+	if (of_find_property(np, "linux,mmc_cap_power_off_card", NULL))
+		*caps |= MMC_CAP_POWER_OFF_CARD;
 }
 EXPORT_SYMBOL(mmc_of_parse_host_caps);
 #endif /* CONFIG_OF */
-- 
1.7.1

