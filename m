From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V5 20/24] mmc: mmci: add optional reset property
Date: Fri, 5 Oct 2018 15:22:58 +0200
Message-ID: <1538745782-27446-21-git-send-email-ludovic.Barre@st.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a optional reset management.
STM32 sdmmc variant needs to reset hardware block
during the power cycle procedure (for re-initialization).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 7 +++++++
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 84e92d1..72d16a3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -36,6 +36,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/reset.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -1876,6 +1877,12 @@ static int mmci_probe(struct amba_device *dev,
 
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
+	host->rst = devm_reset_control_get_optional_exclusive(&dev->dev, NULL);
+	if (IS_ERR(host->rst)) {
+		ret = PTR_ERR(host->rst);
+		goto clk_disable;
+	}
+
 	/* Get regulators and the supported OCR mask */
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index bbc4332..84a24ea 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -318,6 +318,8 @@ struct mmci_host {
 	struct clk		*clk;
 	u8			singleirq:1;
 
+	struct reset_control	*rst;
+
 	spinlock_t		lock;
 
 	unsigned int		mclk;
-- 
2.7.4
