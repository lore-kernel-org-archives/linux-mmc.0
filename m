From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 05/15] mmc: sdhci-esdhci-imx: disable DLL delay line
 settings explicitly
Date: Tue, 12 Jul 2016 15:46:14 +0800
Message-ID: <1468309584-3591-6-git-send-email-aisheng.dong@nxp.com>
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

From: Dong Aisheng <aisheng.dong@freescale.com>

Disable DLL delay line settings explicitly during driver initialization
in case ROM/uBoot had set an invalid delay.
e.g. MX6DL ROM has set the default delay line(DLLCTRL) to 0x1000021,
the uSDHC clock timing will become marginal when works on DDR mode
due to default delay and will possibly see CRC errors in case the board
is not perfectly designed on the eMMC chip layout.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 91c6a6864e15..874d5105f83c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1187,6 +1187,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		*/
 		writel(readl(host->ioaddr + 0x6c) | BIT(7),
 			host->ioaddr + 0x6c);
+
+		/* disable DLL_CTRL delay line settings */
+		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
 	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
-- 
1.9.1
