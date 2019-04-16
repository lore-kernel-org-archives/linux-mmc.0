From: NeilBrown <neil@brown.name>
Subject: [PATCH 1/5] mmc: mtk-sd: support "voltage-ranges" setting.
Date: Tue, 16 Apr 2019 14:47:29 +1000
Message-ID: <155539004920.25108.9476903376124066171.stgit@noble.brown>
References: <155538933003.25108.3338569916935462285.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155538933003.25108.3338569916935462285.stgit@noble.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

If the mtk-sd silicon is used in a context where there is no explicit
regulator, it is not currently possible to specify the voltage
ranges.  This is true for the MT7621 MIPS Soc.

So add a called to mmc_of_parse_voltage() so that voltage-ranges can
be given.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt |    6 ++++--
 drivers/mmc/host/mtk-sd.c                        |    3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index f5bcda3980cc..ed61cd5a5b8f 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -27,10 +27,12 @@ Required properties:
 - pinctrl-names: should be "default", "state_uhs"
 - pinctrl-0: should contain default/high speed pin ctrl
 - pinctrl-1: should contain uhs mode pin ctrl
-- vmmc-supply: power to the Core
-- vqmmc-supply: power to the IO
 
 Optional properties:
+- vmmc-supply: power to the Core
+- vqmmc-supply: power to the IO
+- voltage-ranges: if vmmc-supply not present, this can specify pairs
+	of millivolt numbers to describe available ranged.
 - assigned-clocks: PLL of the source clock
 - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
 - hs400-ds-delay: HS400 DS delay setting
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 0798f0ba6d34..4492a4465c0e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2125,6 +2125,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto host_free;
+	ret = mmc_of_parse_voltage(pdev->dev.of_node, &mmc->ocr_avail);
+	if (ret < 0)
+		goto host_free;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->base = devm_ioremap_resource(&pdev->dev, res);
