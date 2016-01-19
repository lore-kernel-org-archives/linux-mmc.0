From: P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [LINUX PATCH 3/5] mmc: host: Added DT support to use SDIO in standard
 speed.
Date: Tue, 19 Jan 2016 19:47:33 +0530
Message-ID: <1453213055-35563-3-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>, Emil Lenchak <emill@xilinx.com>, Tobias Klauser <tklauser@distanz.ch>, Sudeep Holla <Sudeep.Holla@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, "Ivan T.
 Ivanov" <ivan.ivanov@linaro.org>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Haibo Chen <haibo.chen@freescale.com>, Marek Vasut <marex@denx.de>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, Suman Tripathi <stripathi@apm.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: devicetree@vger.kernel.org, Harini Katakam <harinik@xilinx.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, P L Sai Krishna <lakshmis@xilinx.com>, Anirudha Sarangi <anirudh@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

If the controller is used in High Speed Mode (Zynq-7000 data output on
rising edge of the clock) the hold time requirement for the
JEDEC/MMC 4.41 Specification is NOT met.
In Standard Speed Mode (Zynq-7000 data output on falling edge of the clock)
an extra half clock period is added to the clock to out delay meeting the
hold time requirement.
This patch adds device tree property 'broken-mmc-highspeed' to sdhci node
to force the controller to use in standard speed as a workaround.

Signed-off-by: Emil Lenchak <emill@xilinx.com>
Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 3 +++
 drivers/mmc/host/sdhci.c       | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 223c5eb..37df5cb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -102,6 +102,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	if (of_get_property(np, "broken-mmc-highspeed", NULL))
+		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
+
 	of_property_read_u32(np, "clock-frequency", &pltfm_host->clock);
 
 	if (of_find_property(np, "keep-power-in-suspend", NULL))
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8b064cd..5cc07d6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3114,7 +3114,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;
 
-	if (caps[0] & SDHCI_CAN_DO_HISPD)
+	if ((caps[0] & SDHCI_CAN_DO_HISPD) &&
+		!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-- 
2.1.2
