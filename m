From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 20/23] mmc: sdhci-esdhc-imx: fix strobe DLL lock wrong clock
 issue
Date: Sat, 16 Apr 2016 01:29:44 +0800
Message-ID: <1460741387-23815-21-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
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
Cc: aisheng.dong@nxp.com, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

When enable DDR, the clock factor definition is changed.
e.g. original 200Mhz will become 100Mhz one MIX_CTRL_DDREN bit is set
So we need to update the clock setting then the strobe dll can lock
the correct clock rate.

Additionally we also need disable the clock before locking strobe dll.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 07b1144..3ff213f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -852,6 +852,11 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 	u32 v;
 
 	if (host->mmc->actual_clock > ESDHC_STROBE_DLL_CLK_FREQ) {
+		/* disable clock before enabling strobe dll */
+		writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
+		       (~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON),
+		       host->ioaddr + ESDHC_VENDOR_SPEC);
+
 		/* force a reset on strobe dll */
 		writel(ESDHC_STROBE_DLL_CTRL_RESET,
 			host->ioaddr + ESDHC_STROBE_DLL_CTRL);
@@ -913,6 +918,8 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		m |= ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN;
 		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		imx_data->is_ddr = 1;
+		/* update clock after enable DDR for strobe DLL lock */
+		host->ops->set_clock(host, host->clock);
 		esdhc_set_strobe_dll(host);
 		break;
 	}
-- 
1.9.1
