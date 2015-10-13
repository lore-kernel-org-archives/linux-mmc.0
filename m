From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 1/4] mmc: core: Add DT bindings for eMMC hardware reset support
Date: Tue, 13 Oct 2015 17:37:55 +0800
Message-ID: <1444729078-26585-2-git-send-email-chaotian.jing@mediatek.com>
References: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Hans de Goede <hdegoede@redhat.com>, Lars-Peter Clausen <lars@metafoo.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Howard Chen <ibanezchen@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, Kristina Martsenko <kristina.martsenko@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, srv_heup
List-Id: linux-mmc@vger.kernel.org

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
