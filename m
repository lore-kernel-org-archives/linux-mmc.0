From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v1] ARM: dts: ls1021aqds: Enable the esdhc
Date: Fri, 28 Dec 2018 18:02:51 +0800
Message-ID: <20181228100251.25697-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, yinbo.zhu@nxp.com, yangbo.lu@nxp.com, linux-arm-kernel@lists.infradead.org, leoyang.li@nxp.com
List-Id: linux-mmc@vger.kernel.org

This patch is to set the esdhc's status to "okay" in kernel.

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index bfd3746..98e562c 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -334,6 +334,10 @@
 	};
 };
 
+&esdhc {
+	status = "okay";
+};
+
 &sai2 {
 	status = "okay";
 };
-- 
1.7.1
