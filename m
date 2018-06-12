From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 12/19] mmc: mmci: add variant property to request a reset
Date: Tue, 12 Jun 2018 15:14:33 +0200
Message-ID: <1528809280-31116-13-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

Some variants could require a reset.
STM32 sdmmc variant needs to reset hardware block
during the power cycle procedure (for re-initialization)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
 drivers/mmc/host/mmci.c                        | 9 +++++++++
 drivers/mmc/host/mmci.h                        | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 03796cf..e952707 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -11,6 +11,8 @@ Required properties:
 - compatible             : contains "arm,pl18x", "arm,primecell".
 - vmmc-supply            : phandle to the regulator device tree node, mentioned
                            as the VCC/VDD supply in the eMMC/SD specs.
+depend of variant:
+- resets                 : phandle to internal reset line.
 
 Optional properties:
 - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9c00804..87724e1 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -37,6 +37,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/reset.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -1445,6 +1446,14 @@ static int mmci_probe(struct amba_device *dev,
 
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
+	if (variant->reset) {
+		host->rst = devm_reset_control_get_exclusive(&dev->dev, NULL);
+		if (IS_ERR(host->rst)) {
+			ret = PTR_ERR(host->rst);
+			goto clk_disable;
+		}
+	}
+
 	/* Get regulators and the supported OCR mask */
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 30d3f53..2d7e901 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -284,6 +284,7 @@ struct mmci_host;
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @mmci_dma: Pointer to platform-specific DMA callbacks.
+ * @reset: true if variant has need reset signal.
  * @validate_data: if hardware block has specific constraint on validate data
  * @set_clk_ios: if clock procedure of variant is specific
  * @set_pwr_ios: if power procedure of variant is specific
@@ -329,6 +330,7 @@ struct variant_data {
 	u32			start_err;
 	u32			opendrain;
 	struct mmci_dma_ops	*mmci_dma;
+	bool			reset;
 	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
 	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
 	void (*set_pwrreg)(struct mmci_host *host, unsigned char power_mode,
@@ -345,6 +347,8 @@ struct mmci_host {
 	struct clk		*clk;
 	bool			singleirq;
 
+	struct reset_control	*rst;
+
 	spinlock_t		lock;
 
 	unsigned int		mclk;
-- 
2.7.4
