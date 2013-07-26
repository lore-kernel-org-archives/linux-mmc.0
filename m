From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Fri, 26 Jul 2013 17:51:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62465 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114Ab3GZPvg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 11:51:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>

Add DT properties for UHS SDR12, SDR25, SDR50, SDR104 and DDR50 modes and
for supported by the host in DDR mode VccQ values. Adding them to DT will
automatically enable respective MMC host capabilities.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    7 +++++++
 drivers/mmc/core/host.c                       |   14 ++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 458b57f..de4a716 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -29,6 +29,13 @@ Optional properties:
 - cap-power-off-card: powering off the card is safe
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
 - full-pwr-cycle: full power cycle of the card is supported
+- uhs-sdr12: the host supports UHS SDR12 mode
+- uhs-sdr25: the host supports UHS SDR25 mode
+- uhs-sdr50: the host supports UHS SDR50 mode
+- uhs-sdr104: the host supports UHS SDR104 mode
+- uhs-ddr50: the host supports UHS DDR50 mode
+- ddr-1v2: the host can support DDR, using 1.2V VccQ
+- ddr-1v8: the host can support DDR, using 1.8V VccQ
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 6fb6f77..e12fba0 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -423,6 +423,20 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps |= MMC_CAP_POWER_OFF_CARD;
 	if (of_find_property(np, "cap-sdio-irq", &len))
 		host->caps |= MMC_CAP_SDIO_IRQ;
+	if (of_find_property(np, "uhs-sdr12", &len))
+		host->caps |= MMC_CAP_UHS_SDR12;
+	if (of_find_property(np, "uhs-sdr25", &len))
+		host->caps |= MMC_CAP_UHS_SDR25;
+	if (of_find_property(np, "uhs-sdr50", &len))
+		host->caps |= MMC_CAP_UHS_SDR50;
+	if (of_find_property(np, "uhs-sdr104", &len))
+		host->caps |= MMC_CAP_UHS_SDR104;
+	if (of_find_property(np, "uhs-ddr50", &len))
+		host->caps |= MMC_CAP_UHS_DDR50;
+	if (of_find_property(np, "ddr-1v2", &len))
+		host->caps |= MMC_CAP_1_2V_DDR;
+	if (of_find_property(np, "ddr-1v8", &len))
+		host->caps |= MMC_CAP_1_8V_DDR;
 	if (of_find_property(np, "full-pwr-cycle", &len))
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
 	if (of_find_property(np, "keep-power-in-suspend", &len))
-- 
1.7.2.5

