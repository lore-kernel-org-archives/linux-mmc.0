From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/2] mmc: esdhc: get voltage from dts file
Date: Mon, 22 Jul 2013 15:53:56 +0800
Message-ID: <1374479636-9254-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: scottwood@freescale.com, cjb@laptop.org, AFLEMING@freescale.com, Haijun Zhang <haijun.zhang@freescale.com>, cbouatmailru@gmail.com
List-Id: linux-mmc@vger.kernel.org

Add voltage-range support in esdhc of T4, So we can choose
to read voltages from dts file as one optional.
If we can get a valid voltage-range from device node, we use
this voltage as the final voltage support. Else we still read
from capacity or from other provider.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 31 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          |  3 +++
 include/linux/mmc/sdhci.h         |  1 +
 3 files changed, 35 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 15039e2..8b4b27a 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -262,6 +262,35 @@ static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
 	return 0;
 }
 
+static void esdhc_get_voltage(struct sdhci_host *host,
+			struct platform_device *pdev)
+{
+	const u32 *voltage_ranges;
+	int num_ranges, i;
+	struct device_node *np;
+	np = pdev->dev.of_node;
+
+	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
+	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
+	if (!voltage_ranges || !num_ranges) {
+		dev_info(&pdev->dev, "OF: voltage-ranges unspecified\n");
+		return;
+	}
+
+	for (i = 0; i < num_ranges; i++) {
+		const int j = i * 2;
+		u32 mask;
+		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
+				be32_to_cpu(voltage_ranges[j + 1]));
+		if (!mask) {
+			dev_info(&pdev->dev,
+				"OF: false voltage-ranges specified\n");
+			return;
+		}
+		host->ocr_mask |= mask;
+	}
+}
+
 static const struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
@@ -317,6 +346,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	/* call to generic mmc_of_parse to support additional capabilities */
 	mmc_of_parse(host->mmc);
 
+	esdhc_get_voltage(host, pdev);
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		sdhci_pltfm_free(pdev);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a78bd4f..57541e0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3119,6 +3119,9 @@ int sdhci_add_host(struct sdhci_host *host)
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
 
+	if (host->ocr_mask)
+		ocr_avail = host->ocr_mask;
+
 	mmc->ocr_avail = ocr_avail;
 	mmc->ocr_avail_sdio = ocr_avail;
 	if (host->ocr_avail_sdio)
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e3c6a74..3e781b8 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -171,6 +171,7 @@ struct sdhci_host {
 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
 	unsigned int            ocr_avail_mmc;
+	u32 ocr_mask;		/* available voltages */
 
 	wait_queue_head_t	buf_ready_int;	/* Waitqueue for Buffer Read Ready interrupt */
 	unsigned int		tuning_done;	/* Condition flag set when CMD19 succeeds */
-- 
1.8.0
