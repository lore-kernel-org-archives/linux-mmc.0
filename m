From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/3] Documentation: mmc: add description for new no-sd* and no-mmc
Date: Fri,  1 Jul 2016 15:45:30 +0800
Message-ID: <1467359130-11409-4-git-send-email-shawn.lin@rock-chips.com>
References: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds description for no-sd, no-sdio, no-mmc. We
expect the specific boards adds these in DT to improve
the initialization. For instance, for a soldered eMMC slot,
we could skip sending SDIO and SD commands to probe its card
types as it's always should be the type fo MMC card.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index ecc007a..b2046c6 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -49,6 +49,9 @@ Optional properties:
 - mmc-hs400-enhanced-strobe: eMMC HS400 enhanced strobe mode is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
+- no-sdio: skip sending sdio cmd during initialization
+- no-sd: skip sending sd cmd during initialization
+- no-mmc: skip sending mmc cmd during initialization
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.3.7
