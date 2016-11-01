From: Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 2/2] mmc: sdhci-iproc: support standard byte register
 accesses
Date: Tue,  1 Nov 2016 09:37:57 -0700
Message-ID: <1478018277-10097-3-git-send-email-scott.branden@broadcom.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: devicetree@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Srinath Mannam <srinath.mannam@broadcom.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add bytewise register accesses support for newer versions of IPROC
SDHCI controllers.
Previous sdhci-iproc versions of SDIO controllers
(such as Raspberry Pi and Cygnus) only allowed for 32-bit register
accesses.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mmc/host/sdhci-iproc.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 7262466..d7046d6 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -143,6 +143,14 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
 }
 
 static const struct sdhci_ops sdhci_iproc_ops = {
+	.set_clock = sdhci_set_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
+static const struct sdhci_ops sdhci_iproc_32only_ops = {
 	.read_l = sdhci_iproc_readl,
 	.read_w = sdhci_iproc_readw,
 	.read_b = sdhci_iproc_readb,
@@ -156,6 +164,28 @@ static const struct sdhci_ops sdhci_iproc_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
+	.ops = &sdhci_iproc_32only_ops,
+};
+
+static const struct sdhci_iproc_data iproc_cygnus_data = {
+	.pdata = &sdhci_iproc_cygnus_pltfm_data,
+	.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
+			& SDHCI_MAX_BLOCK_MASK) |
+		SDHCI_CAN_VDD_330 |
+		SDHCI_CAN_VDD_180 |
+		SDHCI_CAN_DO_SUSPEND |
+		SDHCI_CAN_DO_HISPD |
+		SDHCI_CAN_DO_ADMA2 |
+		SDHCI_CAN_DO_SDMA,
+	.caps1 = SDHCI_DRIVER_TYPE_C |
+		 SDHCI_DRIVER_TYPE_D |
+		 SDHCI_SUPPORT_DDR50,
+	.mmc_caps = MMC_CAP_1_8V_DDR,
+};
+
 static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
@@ -182,7 +212,7 @@ static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_MISSING_CAPS,
-	.ops = &sdhci_iproc_ops,
+	.ops = &sdhci_iproc_32only_ops,
 };
 
 static const struct sdhci_iproc_data bcm2835_data = {
@@ -194,7 +224,8 @@ static const struct sdhci_iproc_data bcm2835_data = {
 
 static const struct of_device_id sdhci_iproc_of_match[] = {
 	{ .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
-	{ .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_data },
+	{ .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
+	{ .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
-- 
2.5.0
