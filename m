From: srinivas.kandagatla@linaro.org
Subject: [PATCH RFC 10/12] mmc: mmci: Add clock support for Qualcomm.
Date: Mon, 21 Apr 2014 22:49:05 +0100
Message-ID: <1398116945-31640-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

MCICLK going to card bus is directly driven by the clock controller, so the
driver has to set the required rates depending on the state of the card. This
bit of support is very much similar to bypass mode but there is no such thing
called bypass mode in MCICLK register of Qcom SD card controller. By default
the clock is directly driven by the clk controller.

This patch adds clock support for Qualcomm SDCC in the driver. This bit of
code is conditioned on hw designer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/mmci.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f465eb5..2cd3a8f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -291,7 +291,18 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	host->cclk = 0;
 
 	if (desired) {
-		if (desired >= host->mclk) {
+		if (desired != host->mclk &&
+		    host->hw_designer == AMBA_VENDOR_QCOM) {
+			/* Qcom MCLKCLK register does not define bypass bits */
+			int rc = clk_set_rate(host->clk, desired);
+			if (rc < 0) {
+				dev_err(mmc_dev(host->mmc),
+					"Error setting clock rate (%d)\n", rc);
+			} else {
+				host->mclk = clk_get_rate(host->clk);
+				host->cclk = host->mclk;
+			}
+		} else if (desired >= host->mclk) {
 			clk = MCI_CLK_BYPASS;
 			if (variant->st_clkdiv)
 				clk |= MCI_ST_UX500_NEG_EDGE;
@@ -1612,7 +1623,8 @@ static int mmci_probe(struct amba_device *dev,
 	 * of course.
 	 */
 	if (plat->f_max)
-		mmc->f_max = min(host->mclk, plat->f_max);
+		mmc->f_max = (host->hw_designer == AMBA_VENDOR_QCOM) ?
+				plat->f_max : min(host->mclk, plat->f_max);
 	else
 		mmc->f_max = min(host->mclk, fmax);
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
-- 
1.7.9.5
