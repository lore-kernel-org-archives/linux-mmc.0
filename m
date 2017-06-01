From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/7] ARM: dts: dra72-evm-revc: Add vmmc_aux supply to mmc1
Date: Thu, 1 Jun 2017 20:03:57 +0530
Message-ID: <20170601143401.16852-4-kishon@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170601143401.16852-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, kishon@ti.com, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add vmmc_aux-supply property to mmc1 dt node and populate
it with ldo1_reg to reflect ldo1_out is connected to mmc1 IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm-revc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index 47dcd527ec58..40a399735533 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -93,6 +93,10 @@
 	};
 };
 
+&mmc1 {
+	vmmc_aux-supply = <&ldo1_reg>;
+};
+
 &mmc2 {
 	vmmc-supply = <&evm_1v8_sw>;
 };
-- 
2.11.0
