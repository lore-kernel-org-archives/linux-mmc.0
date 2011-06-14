From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH v2] omap: hsmmc: fix ocr mask usage
Date: Tue, 14 Jun 2011 15:59:59 +0530
Message-ID: <1308047399-8537-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42941 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872Ab1FNKag (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Jun 2011 06:30:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, kishore.kadiyala@ti.com, cjb@laptop.org, gadiyar@ti.com, Sourav Poddar <sourav.poddar@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

The OMAP HSMMC driver uses an ocr_mask to determine the
list of voltages supported by the card. It populates this
mask based on the list of voltages supported by the
regulator that supplies the voltage.

Commit 64be97822b (omap4 hsmmc: Update ocr mask for MMC2 for
regulator to use) passed a fixed ocr_mask from the OMAP4 SDP
board file to limit the voltage to 2.9-3.0 Volts, and updated
the driver to use this mask if provided, instead of using the
regulator's supported voltages.

However the commit is buggy - the ocr_mask is overridden
by the regulator's capabilities anyway. Fix this.

(The bug shows up when a system-wide suspend is attempted
on the OMAP4 SDP/Blaze platforms. The eMMC card comes up
at 3V, but drops to 1.65V after the system resumes).

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Acked-by: Balaji T K <balajitk@ti.com>
Tested-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 v2: Rebase to latest kernel(Linux 3.0-rc3)
 v1: https://patchwork.kernel.org/patch/576871/

 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5b2e215..8707bcd 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -429,7 +429,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 				return -EINVAL;
 			}
 		}
-		mmc_slot(host).ocr_mask = mmc_regulator_get_ocrmask(reg);
 
 		/* Allow an aux regulator */
 		reg = regulator_get(host->dev, "vmmc_aux");
-- 
1.7.0.4

