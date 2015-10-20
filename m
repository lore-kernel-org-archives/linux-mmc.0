From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 1/9] mmc: core: Add DT bindings for eMMC hardware reset support
Date: Tue, 20 Oct 2015 17:13:03 +0800
Message-ID: <1445332391-30530-2-git-send-email-chaotian.jing@mediatek.com>
References: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:41621 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751401AbbJTJN4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2015 05:13:56 -0400
In-Reply-To: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Barry Song <baohua@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Howard Chen <ibanezchen@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Kristina Martsenko <kristina.martsenko@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cog>

Sometime only need set MMC_CAP_HW_RESET for one of MMC hosts,
So set it in device tree is better.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 1 +
 drivers/mmc/core/host.c                       | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 0384fc3..f693baf 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -37,6 +37,7 @@ Optional properties:
 - sd-uhs-sdr104: SD UHS SDR104 speed is supported
 - sd-uhs-ddr50: SD UHS DDR50 speed is supported
 - cap-power-off-card: powering off the card is safe
+- cap-mmc-hw-reset: eMMC hardware reset is supported
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
 - full-pwr-cycle: full power cycle of the card is supported
 - mmc-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index abd933b..04fdc2f 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -507,6 +507,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps |= MMC_CAP_UHS_DDR50;
 	if (of_property_read_bool(np, "cap-power-off-card"))
 		host->caps |= MMC_CAP_POWER_OFF_CARD;
+	if (of_property_read_bool(np, "cap-mmc-hw-reset"))
+		host->caps |= MMC_CAP_HW_RESET;
 	if (of_property_read_bool(np, "cap-sdio-irq"))
 		host->caps |= MMC_CAP_SDIO_IRQ;
 	if (of_property_read_bool(np, "full-pwr-cycle"))
-- 
1.8.1.1.dirty

