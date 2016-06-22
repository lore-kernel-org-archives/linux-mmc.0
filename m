From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5/5] mmc: bcm2835-sdhost: add to devicetree
Date: Wed, 22 Jun 2016 13:42:18 +0200
Message-ID: <1466595738-2229-6-git-send-email-kraxel@redhat.com>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

---
 arch/arm/boot/dts/bcm283x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index b982522..b9540d9 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -239,6 +239,14 @@
 			status = "disabled";
 		};
 
+		sdhost: sdhost@7e202000 {
+			compatible = "brcm,bcm2835-sdhost";
+			reg = <0x7e202000 0x100>;
+			interrupts = <2 24>;
+			clocks = <&clocks BCM2835_CLOCK_VPU>;
+			status = "disabled";
+		};
+
 		hvs@7e400000 {
 			compatible = "brcm,bcm2835-hvs";
 			reg = <0x7e400000 0x6000>;
-- 
1.8.3.1
