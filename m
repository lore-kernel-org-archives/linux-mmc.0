From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 6/8] mmc: sdhci-esdhc-imx: using specific compatible string
 in binding doc
Date: Mon, 22 Sep 2014 17:12:09 +0800
Message-ID: <1411377131-19741-7-git-send-email-b29396@freescale.com>
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

Using specific compatible string in binding doc to make the binding
more clear.
It's also used to avoid checkpatch warning in the future like follows:
0005-mmc-sdhci-do-not-enable-card-cd-wakeup-for-gpio-case.patch has no obvious style problems and is ready for submission.
WARNING: DT compatible string "fsl,imx6sx-usdhc" appears un-documented -- check ./Documentation/devicetree/bindings/
+       { .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },

total: 0 errors, 1 warnings, 18 lines checked

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 9046ba06..c415d34 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -7,7 +7,14 @@ This file documents differences between the core properties described
 by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
 
 Required properties:
-- compatible : Should be "fsl,<chip>-esdhc"
+- compatible : Should be "fsl,<chip>-esdhc", the supported chips include
+	       "fsl,imx25-esdhc"
+	       "fsl,imx35-esdhc"
+	       "fsl,imx51-esdhc"
+	       "fsl,imx53-esdhc"
+	       "fsl,imx6q-usdhc"
+	       "fsl,imx6sl-usdhc"
+	       "fsl,imx6sx-usdhc"
 
 Optional properties:
 - fsl,cd-controller : Indicate to use controller internal card detection
-- 
1.7.8
