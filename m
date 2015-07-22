From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH V2 08/11] mmc: sdhci: make max-frequency property in device
 tree work
Date: Wed, 22 Jul 2015 20:53:07 +0800
Message-ID: <1437569590-5228-9-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, hs@denx.de, p.zabel@pengutronix.de, tharvey@gateworks.com, shawn.guo@linaro.org, s.hauer@pengutronix.de, ipaton0@gmail.com, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, smoch@web.de, gwenhael.goavec-merou@armadeus.com, rmk+kernel@arm.linux.org.uk, lisovy@gmail.com, s.trumtrar@pengutronix.de, robertcnelson@gmail.com, b29396@freescale.com, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-mmc@vger.kernel.org

Device tree provides option to specify the max freqency with property
"max-frequency" in dts and common parse function mmc_of_parse() will
parse it and use this value to set host->f_max to tell the MMC core
the maxinum frequency the host works.

However, current sdhci driver will finally overwrite this value with
host->max_clk regardless of the max-frequency property.

This patch makes sure not overwrite the max-frequency set from device
tree and do basic sanity check.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/mmc/host/sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 947033d..c83d110 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2874,6 +2874,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	u32 max_current_caps;
 	unsigned int ocr_avail;
 	unsigned int override_timeout_clk;
+	u32 max_clk;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -3058,18 +3059,22 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
-	mmc->f_max = host->max_clk;
+	max_clk = host->max_clk;
+
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else if (host->version >= SDHCI_SPEC_300) {
 		if (host->clk_mul) {
 			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
-			mmc->f_max = host->max_clk * host->clk_mul;
+			max_clk = host->max_clk * host->clk_mul;
 		} else
 			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
+	if (!mmc->f_max || (mmc->f_max && (mmc->f_max > max_clk)))
+		mmc->f_max = max_clk;
+
 	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
 		host->timeout_clk = (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
 					SDHCI_TIMEOUT_CLK_SHIFT;
-- 
1.9.1
