From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 08/19] mmc: sdhi: Enable the driver on all ARM platforms
Date: Tue, 29 Oct 2013 23:37:43 +0100
Message-ID: <1383086274-11049-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:38736 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab3J2Whi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2013 18:37:38 -0400
In-Reply-To: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
COMPILE_TEST.

Whether the CTL_DMA_ENABLE register is part of the standard TMIO
controller or is Renesas-specific is unknown and impossible to test as
we have no current or planned TMIO DMA users other than SUPERH and
ARCH_SHMOBILE. Writing to the register is thus conditionally compiled
for SUPERH and ARCH_SHMOBILE only. Adding ARCH_SHMOBILE_MULTI to the
list would extend this to multiarch kernels, but would break the driver
for non-shmobile platforms if the register is Renesas-specific. We can
thus get rid of the conditional compilation completely without
introducing any further issue, and let future non-Renesas users deal
with the situation if it turns out to be a the problem.

Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/Kconfig        | 2 +-
 drivers/mmc/host/tmio_mmc_dma.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..d57effb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -479,7 +479,7 @@ config MMC_TMIO
 
 config MMC_SDHI
 	tristate "SH-Mobile SDHI SD/SDIO controller support"
-	depends on SUPERH || ARCH_SHMOBILE
+	depends on SUPERH || ARM || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 65edb4a..8a4fd2d 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -28,10 +28,8 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 	if (!host->chan_tx || !host->chan_rx)
 		return;
 
-#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
-	/* Switch DMA mode on or off - SuperH specific? */
+	/* Switch DMA mode on or off. This might be Renesas-specific. */
 	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
-#endif
 }
 
 void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
-- 
1.8.1.5

