From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v5 3/6] mmc: sdhci-esdhc-imx: add compatible string in
 bingding doc
Date: Mon, 10 Aug 2015 16:18:05 +0800
Message-ID: <1439194688-18335-4-git-send-email-haibo.chen@freescale.com>
References: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, aisheng.dong@freescale.com
Cc: fabio.estevam@freescale.com, devicetree@vger.kernel.org, haibo.chen@freescale.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de, johan.derycke@barco.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add a required property "fsl,imx7d-usdhc" in binding doc.
Add an optional property "fsl,tuning-step" in binding doc.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 211e778..dca56d6 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -15,6 +15,7 @@ Required properties:
 	       "fsl,imx6q-usdhc"
 	       "fsl,imx6sl-usdhc"
 	       "fsl,imx6sx-usdhc"
+	       "fsl,imx7d-usdhc"
 
 Optional properties:
 - fsl,wp-controller : Indicate to use controller internal write protection
@@ -27,6 +28,11 @@ Optional properties:
   transparent level shifters on the outputs of the controller. Two cells are
   required, first cell specifies minimum slot voltage (mV), second cell
   specifies maximum slot voltage (mV). Several ranges could be specified.
+- fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.
+  The uSDHC use one delay cell as default increasing step to do tuning process.
+  This property allows user to change the tuning step to more than one delay
+  cells which is useful for some special boards or cards when the default
+  tuning step can't find the proper delay window within limited tuning retries.
 
 Examples:
 
-- 
1.9.1
