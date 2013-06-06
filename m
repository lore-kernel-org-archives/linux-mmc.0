From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 04/10] mmc: omap_hsmmc: update needs_vmmc for dt
Date: Fri, 7 Jun 2013 00:44:13 +0530
Message-ID: <1370546059-24181-5-git-send-email-balajitk@ti.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1370546059-24181-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

update needs_vmmc, needs_vmmc_aux for dt boot

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 21fc152..08f4ca7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1763,6 +1763,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
 		pdata->slots[0].features |= HSMMC_HAS_HSPE_SUPPORT;
 
+	pdata->needs_vmmc = of_property_read_bool(np, "vmmc-supply");
+	pdata->needs_vmmc_aux = of_property_read_bool(np, "vmmc_aux-supply");
+
 	return pdata;
 }
 #else
-- 
1.7.5.4

