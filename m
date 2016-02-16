From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] mmc: mmc_spi: Add Card Detect comments and fix CD GPIO case
Date: Tue, 16 Feb 2016 13:06:41 +0900
Message-ID: <20160216040641.31979.6202.sendpatchset@little-apple>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34625 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbcBPEDx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2016 23:03:53 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, swarren@nvidia.com, linux-kernel@vger.kernel.org, eha@doredevelopment.dk, adrian.hunter@intel.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

This patch adds comments to describe the various ways card detection
may be implemented and when polling is needed. Also a fix is included
to prevent the MMC SPI driver from polling when a CD GPIO that supports
interrupts is specified using the gpios DT property (case 1).

Without this patch the DT node below results in the following output:

 spi_gpio: spi-gpio { /* SD2 @ CN12 */
         compatible = "spi-gpio";
         #address-cells = <1>;
         #size-cells = <0>;
         gpio-sck = <&gpio6 16 GPIO_ACTIVE_HIGH>;
         gpio-mosi = <&gpio6 17 GPIO_ACTIVE_HIGH>;
         gpio-miso = <&gpio6 18 GPIO_ACTIVE_HIGH>;
         num-chipselects = <1>;
         cs-gpios = <&gpio6 21 GPIO_ACTIVE_LOW>;
         status = "okay";

         spi@0 {
                 compatible = "mmc-spi-slot";
                 reg = <0>;
                 voltage-ranges = <3200 3400>;
                 spi-max-frequency = <25000000>;
                 gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;   /* CD */
         };
 };

 # dmesg | grep mmc
 mmc_spi spi32766.0: SD/MMC host mmc0, no WP, no poweroff, cd polling
 mmc0: host does not support reading read-only switch, assuming write-enable
 mmc0: new SDHC card on SPI
 mmcblk0: mmc0:0000 SU04G 3.69 GiB 
 mmcblk0: p1

 With this patch applied the "cd polling" portion above disappears.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on top of renesas-drivers-2016-02-09-v4.5-rc3 which
 simply put is v4.5-rc3 + selected linux-next trees.

 drivers/mmc/host/mmc_spi.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- 0001/drivers/mmc/host/mmc_spi.c
+++ work/drivers/mmc/host/mmc_spi.c	2016-02-16 12:47:47.900513000 +0900
@@ -1437,11 +1437,25 @@ static int mmc_spi_probe(struct spi_devi
 	if (status != 0)
 		goto fail_add_host;
 
+	/* Card detection in case of DT is supported in several ways:
+	 * 1) GPIO with interrupt support using "gpios" DT property.
+	 * 2) GPIO without interrupt support using "gpios" DT property.
+	 * 3) Interrupt only using "interrupt-parent/interrupts" DT properties.
+	 * 4) Both "gpios" and "interrupt-parent/interrupts" DT properties.
+	 * 5) Nothing specified.
+	 * For case 2 and 5 above polling is required.
+	 */
 	if (host->pdata && host->pdata->flags & MMC_SPI_USE_CD_GPIO) {
 		status = mmc_gpio_request_cd(mmc, host->pdata->cd_gpio,
 					     host->pdata->cd_debounce);
 		if (status != 0)
 			goto fail_add_host;
+
+		/* The platform has a CD GPIO signal that may support
+		 * interrupts, so let mmc_gpiod_request_cd_irq() decide
+		 * if polling is needed or not.
+		 */
+		mmc->caps &= ~MMC_CAP_NEEDS_POLL;
 		mmc_gpiod_request_cd_irq(mmc);
 	}
 
