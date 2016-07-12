From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 15/15] mmc: sdhci-esdhc-imx: clear tuning bits during
 driver probe
Date: Tue, 12 Jul 2016 15:46:24 +0800
Message-ID: <1468309584-3591-16-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
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

The tuning bits like FBCLK_SEL, SMP_CLK_SEL and DLY_CELL which affects
timing may have already been set by ROM if booting from SD3.0 mode like
SDR104. Let's clear it first during driver probe before doing the new
card enumeration to avoid working on the wrong timing.

Note that tuning bits are dynamical settings which may need to be kept
during MMC_PM_KEEP_POWER suspend, so we did not put them into hwinit
function.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e5b5d1c3eb01..2bb326bbc34a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1224,6 +1224,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
+
+		/* clear tuning bits in case ROM has set it already */
+		writel(0x0, host->ioaddr + ESDHC_MIX_CTRL);
+		writel(0x0, host->ioaddr + SDHCI_ACMD12_ERR);
+		writel(0x0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
-- 
1.9.1
