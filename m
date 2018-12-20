From: BOUGH CHEN <haibo.chen@nxp.com>
Subject: [PATCH 3/3] ARM: dts: imx6ull: change to use new compatible
 "fsl,imx6ull-usdhc" for usdhc
Date: Thu, 20 Dec 2018 07:49:55 +0000
Message-ID: <1545292612-14471-3-git-send-email-haibo.chen@nxp.com>
References: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

i.MX6ULL has errata ERR010450, there is I/O timing limitation,
for SDR mode, SD card clock can't exceed 150MHz, for DDR mode,
SD card clock can't exceed 45MHz. This patch change to use the
new compatible "fsl,imx6ull-usdhc" to follow this limitation.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm/boot/dts/imx6ull.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index f3668fe..4ad5828 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -30,6 +30,14 @@
 	>;
 };
 
+&usdhc1 {
+	compatible = "fsl,imx6ull-usdhc", "fsl,imx6sx-usdhc";
+};
+
+&usdhc2 {
+	compatible = "fsl,imx6ull-usdhc", "fsl,imx6sx-usdhc";
+};
+
 / {
 	soc {
 		aips3: aips-bus@2200000 {
-- 
1.9.1
