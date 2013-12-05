From: Tim Kryger <tim.kryger@linaro.org>
Subject: [PATCH v4 3/8] Documentation: dt: kona-sdhci: Add clocks property
Date: Thu, 5 Dec 2013 11:20:39 -0800
Message-ID: <1386271244-3927-4-git-send-email-tim.kryger@linaro.org>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christian Daudt <bcm@fixthebug.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Axel Lin <axel.lin@ingics.com>
Cc: Device Tree List <devicetree@vger.kernel.org>, Linaro Patches List <patches@linaro.org>, Tim Kryger <tim.kryger@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

The Kona SDHCI block requires a clock that must be specified in the
device tree.  Update the documentation to reflect this requirement.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 Documentation/devicetree/bindings/mmc/kona-sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/kona-sdhci.txt b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
index 789fb07..aaba248 100644
--- a/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
@@ -6,12 +6,16 @@ and the properties present in the bcm281xx SDHCI
 Required properties:
 - compatible : Should be "brcm,kona-sdhci"
 - DEPRECATED: compatible : Should be "bcm,kona-sdhci"
+- clocks: phandle + clock specifier pair of the external clock
+
+Refer to clocks/clock-bindings.txt for generic clock consumer properties.
 
 Example:
 
 sdio2: sdio@0x3f1a0000 {
 	compatible = "brcm,kona-sdhci";
 	reg = <0x3f1a0000 0x10000>;
+	clocks = <&sdio3_clk>;
 	interrupts = <0x0 74 0x4>;
 };
 
-- 
1.8.0.1
