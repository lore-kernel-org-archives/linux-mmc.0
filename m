From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] Documentation: mmc: add description for new no-sd* and no-mmc
Date: Thu, 14 Jul 2016 16:26:03 +0800
Message-ID: <1468484764-32353-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds description for no-sd, no-sdio, no-mmc. We expose
these to DT as some of the controllers are unable to deal with
special cmd type due to hw limitation.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- amend the description of these properties and the commit msg

 Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index ecc007a..22d1e1f 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -49,6 +49,9 @@ Optional properties:
 - mmc-hs400-enhanced-strobe: eMMC HS400 enhanced strobe mode is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
+- no-sdio: controller is limited to send sdio cmd during initialization
+- no-sd: controller is limited to send sd cmd during initialization
+- no-mmc: controller is limited to send mmc cmd during initialization
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.3.7
