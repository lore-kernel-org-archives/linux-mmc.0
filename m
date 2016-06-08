From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 1/4] Documentation: mmc: add description for new caps
Date: Wed,  8 Jun 2016 16:20:21 +0800
Message-ID: <1465374021-2526-1-git-send-email-shawn.lin@rock-chips.com>
References: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Let's add some basic description for cap-no-sdio,
cap-no-sd and cap-no-mmc.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index ecc007a..e16d42b 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -39,6 +39,9 @@ Optional properties:
 - cap-power-off-card: powering off the card is safe
 - cap-mmc-hw-reset: eMMC hardware reset is supported
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
+- cap-no-sdio: skip sending sdio cmd during initialization
+- cap-no-sd: skip sending sd cmd during initialization
+- cap-no-mmc: skip sending mmc cmd during initialization
 - full-pwr-cycle: full power cycle of the card is supported
 - mmc-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
 - mmc-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
-- 
2.3.7
