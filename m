From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/41] mmc: host: omap_hsmmc: Prepare *set_timing() to be used
 for iodelay setting
Date: Fri, 19 May 2017 13:45:10 +0530
Message-ID: <20170519081541.26753-11-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, nsekhar@ti.com, Jonathan Corbet <corbet@lwn.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

No functional change. Add separate case statements for certain timing
like MMC_TIMING_SD_HS and MMC_TIMING_MMC_HS even though AC12_UHSMC_RES
has to be written to the AC12 register (same as for default modes).
Also have separate case sections for MMC_TIMING_UHS_SDR104 and
MMC_TIMING_UHS_HS200 even though the same UHSMC value has to be written
to the AC12 register. This is in preparation for setting iodelay
values.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9ac18521e097..7088a88074a8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1737,6 +1737,8 @@ static void omap_hsmmc_set_timing(struct omap_hsmmc_host *host)
 	val &= ~AC12_UHSMC_MASK;
 	switch (ios->timing) {
 	case MMC_TIMING_UHS_SDR104:
+		val |= AC12_UHSMC_SDR104;
+		break;
 	case MMC_TIMING_MMC_HS200:
 		val |= AC12_UHSMC_SDR104;
 		break;
@@ -1752,6 +1754,13 @@ static void omap_hsmmc_set_timing(struct omap_hsmmc_host *host)
 	case MMC_TIMING_UHS_SDR12:
 		val |= AC12_UHSMC_SDR12;
 		break;
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_MMC_HS:
+		val |= AC12_UHSMC_RES;
+		break;
+	case MMC_TIMING_MMC_DDR52:
+		val |= AC12_UHSMC_RES;
+		break;
 	default:
 		val |= AC12_UHSMC_RES;
 		break;
-- 
2.11.0
