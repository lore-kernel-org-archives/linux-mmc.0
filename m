From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v3 01/10] mmc: core: Add DT bindings for eMMC hardware reset
 support
Date: Tue, 27 Oct 2015 14:24:21 +0800
Message-ID: <1445927070-5102-2-git-send-email-chaotian.jing@mediatek.com>
References: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Minda Chen <Minda.Chen@csr.com>, Dong Aisheng <b29396@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, Weijun Yang <Weijun.Yang@csr.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, Howard Chen <ibanezchen@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ivan.ivanov@linaro.org, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias>
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
