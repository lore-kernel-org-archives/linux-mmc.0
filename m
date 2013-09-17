From: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH] at91: mmc: fix missing pinctrl in dt
Date: Tue, 17 Sep 2013 11:57:37 +0200
Message-ID: <1379411857-18516-2-git-send-email-jiri.prchal@aksignal.cz>
References: <1379411857-18516-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379411857-18516-1-git-send-email-jiri.prchal@aksignal.cz>
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
Cc: ludovic.desroches@atmel.com, Jiri Prchal <jiri.prchal@aksignal.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This patch adds pinctrl to soc dtsi file.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index cf78ac0..c5d26b0 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -556,6 +556,8 @@
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_mmc0_slot0_clk_cmd_dat0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
1.7.9.5
