From: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v11 1/8] dmaengine: edma: Add TI EDMA device tree binding
Date: Tue, 18 Jun 2013 01:38:12 -0500
Message-ID: <1371537499-12970-2-git-send-email-joelagnel@ti.com>
References: <1371537499-12970-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371537499-12970-1-git-send-email-joelagnel-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Matt Porter <mdp-l0cyMroinI0@public.gmane.org>

The binding definition is based on the generic DMA controller
binding.

Joel:
* Droped reserved and queue DT entries from Documentation
for now from the original patch series (v10)
* Included properties in Documentation and clarified DMA properties (V11)
* Made ti,hwmod option
* Clarified DMA entries

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt |   34 +++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
new file mode 100644
index 0000000..9fbbdb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -0,0 +1,34 @@
+TI EDMA
+
+Required properties:
+- compatible : "ti,edma3"
+- ti,edma-regions: Number of regions
+- ti,edma-slots: Number of slots
+- #dma-cells: Should be set to <1>
+              Clients should use a single channel number per DMA request.
+- dma-channels: Specify total DMA channels per CC
+- reg: Memory map for accessing module
+- interrupt-parent: Interrupt controller the interrupt is routed through
+- interrupts: Exactly 3 interrupts need to be specified in the order:
+              1. Transfer completion interrupt.
+              2. Memory protection interrupt.
+              3. Error interrupt.
+Optional properties:
+- ti,hwmods: Name of the hwmods associated to the EDMA
+- ti,edma-xbar-event-map: Crossbar event to channel map
+
+Example:
+
+edma: edma@49000000 {
+	reg = <0x49000000 0x10000>;
+	interrupt-parent = <&intc>;
+	interrupts = <12 13 14>;
+	compatible = "ti,edma3";
+	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
+	#dma-cells = <1>;
+	dma-channels = <64>;
+	ti,edma-regions = <4>;
+	ti,edma-slots = <256>;
+	ti,edma-xbar-event-map = <1 12
+				  2 13>;
+};
-- 
1.7.9.5
