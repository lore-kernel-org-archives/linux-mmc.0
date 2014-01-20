From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: Add support for Erratum 2.1.1.128 in device
 tree boot
Date: Mon, 20 Jan 2014 17:29:02 -0600
Message-ID: <1390260542-22213-1-git-send-email-nm@ti.com>
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
To: Balaji T K <balajitk@ti.com>, Chris Ball <chris@printf.net>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

When device is booted using devicetree, platforms impacted by
Erratum 2.1.1.128 is not detected easily in the mmc driver. This erratum
indicates that the module cannot do multi-block transfers.

Handle this by providing a boolean flag to indicate to driver that it is
working on a hardware with mentioned limitation.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

This explains the logs I see:
OMAP3430 LDP (ES2.2):
	uImage only boot:  http://slexy.org/raw/s2YrbMAi7c 
	uImage+dtb concatenated boot: http://slexy.org/raw/s20qVg17T0 

With the following flag set, device is now able to consistently boot with
device tree supported uImage+dtb concat boot.

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 ++
 drivers/mmc/host/omap_hsmmc.c                      |    3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 8c8908a..ab36f8b 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -26,6 +26,8 @@ specifier is required.
 dma-names: List of DMA request names. These strings correspond
 1:1 with the DMA specifiers listed in dmas. The string naming is
 to be "rx" and "tx" for RX and TX DMA requests, respectively.
+ti,erratum-2.1.1.128: boolean, for OMAP3430/OMAP35xx platforms with broken
+multiblock reads
 
 Examples:
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 014bfe5..f2d5940 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1730,6 +1730,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,dual-volt", NULL))
 		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
 
+	if (of_find_property(np, "ti,erratum-2.1.1.128", NULL))
+		pdata->controller_flags |= OMAP_HSMMC_BROKEN_MULTIBLOCK_READ;
+
 	/* This driver only supports 1 slot */
 	pdata->nr_slots = 1;
 	pdata->slots[0].switch_pin = cd_gpio;
-- 
1.7.9.5
