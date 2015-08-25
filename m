From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 06/11] mmc: host: omap_hsmmc: set timing in the UHSMS field
Date: Tue, 25 Aug 2015 14:35:37 +0530
Message-ID: <1440493542-26150-7-git-send-email-kishon@ti.com>
References: <1440493542-26150-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440493542-26150-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add a separate function to set the UHSMS field to one
of SDR104, SDR50, DDR50, SDR25 or SDR12 depending on the
inserted SD card. This is required for
tuning to succeed in the case of SDR104/HS200 or SDR50.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 60c1ac2..c042b91 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -114,6 +114,13 @@
 
 /* AC12 */
 #define AC12_V1V8_SIGEN		(1 << 19)
+#define AC12_UHSMC_MASK		(7 << 16)
+#define AC12_UHSMC_SDR12	(0 << 16)
+#define AC12_UHSMC_SDR25	(1 << 16)
+#define AC12_UHSMC_SDR50	(2 << 16)
+#define AC12_UHSMC_SDR104	(3 << 16)
+#define AC12_UHSMC_DDR50	(4 << 16)
+#define AC12_UHSMC_RES		(0x7 << 16)
 
 /* Interrupt masks for IE and ISE register */
 #define CC_EN			(1 << 0)
@@ -199,6 +206,7 @@ struct omap_hsmmc_host {
 	unsigned int		dma_sg_idx;
 	unsigned char		bus_mode;
 	unsigned char		power_mode;
+	unsigned char		timing;
 	int			suspended;
 	u32			con;
 	u32			hctl;
@@ -1667,6 +1675,41 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	omap_hsmmc_start_command(host, req->cmd, req->data);
 }
 
+static void omap_hsmmc_set_timing(struct omap_hsmmc_host *host)
+{
+	u32 val;
+	struct mmc_ios *ios = &host->mmc->ios;
+
+	omap_hsmmc_stop_clock(host);
+
+	val = OMAP_HSMMC_READ(host->base, AC12);
+	val &= ~AC12_UHSMC_MASK;
+	switch (ios->timing) {
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+		val |= AC12_UHSMC_SDR104;
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		val |= AC12_UHSMC_DDR50;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		val |= AC12_UHSMC_SDR50;
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		val |= AC12_UHSMC_SDR25;
+		break;
+	case MMC_TIMING_UHS_SDR12:
+		val |= AC12_UHSMC_SDR12;
+		break;
+	default:
+		val |= AC12_UHSMC_RES;
+		break;
+	}
+	OMAP_HSMMC_WRITE(host->base, AC12, val);
+
+	omap_hsmmc_start_clock(host);
+}
+
 /* Routine to configure clock values. Exposed API to core */
 static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
@@ -1715,6 +1758,11 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	omap_hsmmc_set_clock(host);
 
+	if (ios->timing != host->timing) {
+		omap_hsmmc_set_timing(host);
+		host->timing = ios->timing;
+	}
+
 	if (do_send_init_stream)
 		send_init_stream(host);
 
@@ -2204,6 +2252,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
+	host->timing	= 0;
 	host->next_data.cookie = 1;
 	host->vqmmc_enabled = 0;
 
-- 
1.7.9.5
