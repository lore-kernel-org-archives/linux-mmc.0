From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Subject: [PATCH v3 3/3] mmc: sdhci-of-aspeed: add inversion signal presence
Date: Mon, 18 Nov 2019 13:46:46 +0300
Message-ID: <20191118104646.3838-4-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118104646.3838-1-i.mikhaylov@yadro.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Ivan Mikhaylov <i.mikhaylov@yadro.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, openbmc@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
bit in case of inverted card detection signal.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 8962f6664381..56912e30c47e 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -111,7 +111,19 @@ static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
+static u32 aspeed_sdhci_readl(struct sdhci_host *host, int reg)
+{
+	u32 val = readl(host->ioaddr + reg);
+
+	if (unlikely(reg == SDHCI_PRESENT_STATE) &&
+	    (host->mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
+		val ^= SDHCI_CARD_PRESENT;
+
+	return val;
+}
+
 static const struct sdhci_ops aspeed_sdhci_ops = {
+	.read_l = aspeed_sdhci_readl,
 	.set_clock = aspeed_sdhci_set_clock,
 	.get_max_clock = aspeed_sdhci_get_max_clock,
 	.set_bus_width = aspeed_sdhci_set_bus_width,
-- 
2.20.1
