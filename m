From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/2] DT: bindings: remove bcm2835-sdhci
Date: Fri,  3 Jun 2016 19:47:12 +0000
Message-ID: <1464983233-27001-2-git-send-email-stefan.wahren@i2se.com>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The sdhci-iproc also supports bcm2835. So this binding is obsolete.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |   18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt

diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
deleted file mode 100644
index 59476fb..0000000
--- a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Broadcom BCM2835 SDHCI controller
-
-This file documents differences between the core properties described
-by mmc.txt and the properties that represent the BCM2835 controller.
-
-Required properties:
-- compatible : Should be "brcm,bcm2835-sdhci".
-- clocks : The clock feeding the SDHCI controller.
-
-Example:
-
-sdhci: sdhci {
-	compatible = "brcm,bcm2835-sdhci";
-	reg = <0x7e300000 0x100>;
-	interrupts = <2 30>;
-	clocks = <&clk_mmc>;
-	bus-width = <4>;
-};
-- 
1.7.9.5
