From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 10/11] mmc: tmio: reconfigure the controller on runtime resume
Date: Wed,  4 Jan 2012 15:17:15 +0100
Message-ID: <1325686636-23905-11-git-send-email-g.liakhovetski@gmx.de>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55270 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684Ab2ADORX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2012 09:17:23 -0500
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

After the controller has been runtime suspended it has to be reset and DMA
has to be re-enabled, if it is used.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 1811006..9106b3d 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1031,6 +1031,10 @@ EXPORT_SYMBOL(tmio_mmc_host_suspend);
 int tmio_mmc_host_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	tmio_mmc_reset(host);
+	tmio_mmc_enable_dma(host, true);
 
 	/* The MMC core will perform the complete set up */
 	return mmc_resume_host(mmc);
-- 
1.7.2.5

