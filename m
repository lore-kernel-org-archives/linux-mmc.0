From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH 5/5] mmc: sdhci: add new quirk for setting BUS_POWER & BUS_VLT fields
Date: Fri,  4 Sep 2015 21:02:21 +0530
Message-ID: <1441380741-13115-6-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441380741-13115-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441380741-13115-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kliu5@marvell.com, ulf.hansson@linaro.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-mmc@vger.kernel.org

IN case of Marvell 1928 family of devices, the SD_BUS_POWER and
SD_BUS_VLT bits are used internally to gate the clocks, so
we have to set these fields.

Pasting Spec words here,

The <SD_BUS_VLT> and <SD_BUS_POWER> fields should be configured
to correct values. These actually do not do the voltage selection
or switch power to the SD card. However these fields are used
internally to gate the clock. So if these fields are set
incorrectly, SD module will not function.

And during my development, I have seen that SD card wouldn't function
without right configuration into these fields.

So this patch adds new quirk (SDHCI_QUIRK2_MUST_SET_SDHCI_BUS_POWER),
which make sure that ->set_power() sets these fields.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mmc/host/sdhci-pltfm.c | 3 +++
 drivers/mmc/host/sdhci.c       | 3 ++-
 drivers/mmc/host/sdhci.h       | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a207f5a..0872da0 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -101,6 +101,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	if (of_device_is_compatible(np, "marvell,pxav3-988-sdhci"))
+		host->quirks2 |= SDHCI_QUIRK2_MUST_SET_SDHCI_BUS_POWER;
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		pltfm_host->clock = be32_to_cpup(clk);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2d58b31..418f381 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1265,7 +1265,8 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		else
 			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 
-		return;
+		if (!(host->quirks2 | SDHCI_QUIRK2_MUST_SET_SDHCI_BUS_POWER))
+			return;
 	}
 
 	if (mode != MMC_POWER_OFF) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9b0e2a8..8802a0c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -409,6 +409,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<13)
 /* Controller broken with using ACMD23 */
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
+/* Voltage capabilities of Controller must be set  */
+#define SDHCI_QUIRK2_MUST_SET_SDHCI_BUS_POWER		(1<<15)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.1
