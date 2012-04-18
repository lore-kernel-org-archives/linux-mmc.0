From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/3] mmc: omap_hsmmc: release correct resource
Date: Wed, 18 Apr 2012 15:19:11 +0530
Message-ID: <1334742553-11060-1-git-send-email-svenkatr@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Russell King <rmk+kernel@arm.linux.org.uk>, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>

res can be one of several resources, as this variable is re-used several
times during probe.  This can cause the wrong resource parameters to be
passed to release_mem_region().

Get the original memory resource before calling release_mem_region().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4254b6f..d15b149 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2042,7 +2042,9 @@ err1:
 err_alloc:
 	omap_hsmmc_gpio_free(pdata);
 err:
-	release_mem_region(res->start, resource_size(res));
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
-- 
1.7.10.rc2

