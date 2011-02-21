From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap: hsmmc: fix ocr mask usage
Date: Mon, 21 Feb 2011 11:37:17 +0530
Message-ID: <1298268437-17989-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45447 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab1BUGH3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Feb 2011 01:07:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Chris Ball <cjb@laptop.org>

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
Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
---
Tony, Chris,

This is only a partial fix. It fixes the obvious bug introduced
in the commit I noted above, however it is not the final
fix. I'm not convinced the way the regulators are handled
in this driver is correct - I'm still studying the code and
will come up with a proper fix later.

However, this does fix a real bug and I believe the bug is
obvious. Would be nice to get this into the -rc series if
we still can.

- Anand

 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/drivers/mmc/host/omap_hsmmc.c
===================================================================
--- linux-2.6.orig/drivers/mmc/host/omap_hsmmc.c
+++ linux-2.6/drivers/mmc/host/omap_hsmmc.c
@@ -413,7 +413,6 @@ static int omap_hsmmc_reg_get(struct oma
 				return -EINVAL;
 			}
 		}
-		mmc_slot(host).ocr_mask = mmc_regulator_get_ocrmask(reg);
 
 		/* Allow an aux regulator */
 		reg = regulator_get(host->dev, "vmmc_aux");
