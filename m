From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 1/5] Documentation: mmc: add mmc-hs400-enhanced-strobe
Date: Mon, 23 May 2016 12:13:32 +0800
Message-ID: <1463976812-29698-1-git-send-email-shawn.lin@rock-chips.com>
References: <1463976789-29618-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:55377 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbcEWENx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2016 00:13:53 -0400
In-Reply-To: <1463976789-29618-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

mmc-hs400-enhanced-strobe is used to claim that the
host can support hs400 mode with enhanced strobe
introduced by emmc 5.1 spec.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v5: None
Changes in v4: None
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


