From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/5] Documentation: mmc: add mmc-hs400-enhanced-strobe
Date: Tue, 10 May 2016 17:09:35 +0800
Message-ID: <1462871375-32402-1-git-send-email-shawn.lin@rock-chips.com>
References: <1462871343-32361-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462871343-32361-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

mmc-hs400-enhanced-strobe is used to claim that the
host can support hs400 mode with enhanced strobe
introduced by emmc 5.1 spec.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/mmc/mmc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index ed23b9b..ecc007a 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -46,6 +46,7 @@ Optional properties:
 - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
 - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
+- mmc-hs400-enhanced-strobe: eMMC HS400 enhanced strobe mode is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
 
-- 
2.3.7
