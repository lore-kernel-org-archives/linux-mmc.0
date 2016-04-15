From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 13/23] mmc: sdhci-esdhc-imx: restore watermark level setting
 after resume
Date: Sat, 16 Apr 2016 01:29:37 +0800
Message-ID: <1460741387-23815-14-git-send-email-aisheng.dong@nxp.com>
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

Currently, we config the watermark_level register only in probe.
This will cause the mmc write operation timeout issue after system
resume back in LPSR mode. Because in LPSR mode, after system resume
back, the watermark_level register(0x44) changes to 0x08000880, which
set the write watermark level as 0, and set the read watermark level
as 128. This value is incorrect.

This patch restores the setting of watermark level register after
system resume back.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6fef6bc..4c28fbb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1261,6 +1261,11 @@ static int sdhci_esdhc_suspend(struct device *dev)
 
 static int sdhci_esdhc_resume(struct device *dev)
 {
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	/* restore watermark setting in case it's lost in low power mode */
+	writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
+
 	return sdhci_pltfm_resume(dev);
 }
 
-- 
1.9.1
