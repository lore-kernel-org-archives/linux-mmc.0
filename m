From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 7/8] mmc: sdhci-esdhc-imx: add imx6sx support
Date: Mon, 22 Sep 2014 17:12:10 +0800
Message-ID: <1411377131-19741-8-git-send-email-b29396@freescale.com>
References: <1411377131-19741-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411377131-19741-1-git-send-email-b29396@freescale.com>
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
Cc: ulf.hansson@linaro.org, shawn.guo@linaro.org, b29396@freescale.com, chris@printf.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The imx6sx usdhc is derived from imx6sl, the difference is minor.
imx6sx have the errata ESDHC_FLAG_ERR004536 fixed.
So introduce a new compatible string for imx6sx to distinguish them.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index dc0e384..87179c4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -150,6 +150,11 @@ static struct esdhc_soc_data usdhc_imx6sl_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536,
 };
 
+static struct esdhc_soc_data usdhc_imx6sx_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1,
+};
+
 struct pltfm_imx_data {
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
@@ -190,6 +195,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
 	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
 	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
+	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
 	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
 	{ /* sentinel */ }
-- 
1.7.8
