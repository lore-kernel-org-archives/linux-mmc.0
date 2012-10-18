From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH v3 15/16] spi: omap2-mcspi: add generic DMA request
	support to the DT binding
Date: Thu, 18 Oct 2012 09:26:54 -0400
Message-ID: <1350566815-409-16-git-send-email-mporter@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1350566815-409-1-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The binding definition is based on the generic DMA request binding.

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/omap-spi.txt |   27 +++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index 81df374..11aff04 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -7,8 +7,18 @@ Required properties:
 - ti,spi-num-cs : Number of chipselect supported  by the instance.
 - ti,hwmods: Name of the hwmod associated to the McSPI
 
+Optional properties:
+- dmas: List of DMA controller phandle and DMA request ordered
+	pairs. One tx and one rx pair is required for each chip
+	select.
+- dma-names: List of DMA request names. These strings correspond
+	1:1 with the ordered pairs in dmas. The string naming is
+	to be "rxN" and "txN" for RX and TX requests,
+	respectively, where N equals the chip select number.
 
-Example:
+Examples:
+
+[hwmod populated DMA resources]
 
 mcspi1: mcspi@1 {
     #address-cells = <1>;
@@ -18,3 +28,18 @@ mcspi1: mcspi@1 {
     ti,spi-num-cs = <4>;
 };
 
+[generic DMA request binding]
+
+mcspi1: mcspi@1 {
+    #address-cells = <1>;
+    #size-cells = <0>;
+    compatible = "ti,omap4-mcspi";
+    ti,hwmods = "mcspi1";
+    ti,spi-num-cs = <2>;
+    dmas = <&edma 42
+	    &edma 43
+	    &edma 44
+	    &edma 45>;
+    dma-names = "tx0", "rx0", "tx1", "rx1";
+};
+
-- 
1.7.9.5


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
