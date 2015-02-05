From: Addy Ke <addy.ke@rock-chips.com>
Subject: [PATCH] mmc: core: add runtime-resume caps to support resume at runtime_resume
Date: Thu,  5 Feb 2015 19:06:59 +0800
Message-ID: <1423134419-23109-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, heiko@sntech.de, olof@lixom.net, dianders@chromium.org, sonnyrao@chromium.org, amstan@chromium.org
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, zhenfu.fang@rock-chips.com, cf@rock-chips.com, lintao@rock-chips.com, chenfen@rock-chips.com, zyf@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, zhangqing@rock-chips.com, hl@rock-chips.com, Addy Ke <addy.ke@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
 drivers/mmc/core/host.c                       |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 438899e..303b448 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -40,9 +40,20 @@ Optional properties:
 - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
 - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
+- runtime-resume: resume at runtime_resume is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
 
+Card power and reset control:
+The following properties can be specified for cases where the MMC
+peripheral needs additional reset, regulator and clock lines. It is for
+example common for WiFi/BT adapters to have these separate from the main
+MMC bus:
+  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
+  - card-external-vcc-supply: Regulator to drive (independent) card VCC
+  - clock with name "card_ext_clock": External clock provided to the card
+>>>>>>> 0064e63... FROMLIST: mmc: core: add runtime-resume caps to support resume at runtime_resume
+
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
 line levels. We choose to follow the SDHCI standard, which specifies both those
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8be0df7..cb44c85 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -422,6 +422,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps |= MMC_CAP_POWER_OFF_CARD;
 	if (of_find_property(np, "cap-sdio-irq", &len))
 		host->caps |= MMC_CAP_SDIO_IRQ;
+	if (of_find_property(np, "runtime-resume", &len))
+		host->caps |= MMC_CAP_RUNTIME_RESUME;
 	if (of_find_property(np, "full-pwr-cycle", &len))
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
 	if (of_find_property(np, "keep-power-in-suspend", &len))
-- 
1.8.3.2


