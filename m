From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 5/8] mmc: dw_mmc-rockchip: dt-binding: Add tuning related things
Date: Wed, 30 Sep 2015 16:07:41 +0200
Message-ID: <1443622064-14362-6-git-send-email-heiko@sntech.de>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51071 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057AbbI3OH4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Sep 2015 10:07:56 -0400
In-Reply-To: <1443622064-14362-1-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, tgih.jun@samsung.com, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org, Heiko Stuebner <heiko@sntech.de>

From: Alexandru M Stan <amstan@chromium.org>

Add ciu_drive, ciu_sample clocks and default-sample-phase. This will later
be used by tuning code.

We do not touch ciu_drive (and by extension define default-drive-phase).
Drive phase is mostly used to define minimum hold times, while one could
write some code to determine what phase meets the minimum hold time
(ex 10 degrees) this will not work with the current clock phase framework
(which floors angles, so we'll get 0 deg, and there's no way to know what
resolution the floors happen at). We assume that the default drive angles
set by the hardware are good enough.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index c327c2d..3dc13b6 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -14,6 +14,19 @@ Required Properties:
 							before RK3288
 	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
 
+Optional Properties:
+* clocks: from common clock binding: if ciu_drive and ciu_sample are
+  specified in clock-names, should contain handles to these clocks.
+
+* clock-names: Apart from the clock-names described in synopsys-dw-mshc.txt
+  two more clocks "ciu-drive" and "ciu-sample" are supported. They are used
+  to control the clock phases, "ciu-sample" is required for tuning high-
+  speed modes.
+
+* rockchip,default-sample-phase: The default phase to set ciu_sample at
+  probing, low speeds or in case where all phases work at tuning time.
+  If not specified 0 deg will be used.
+
 Example:
 
 	rkdwmmc0@12200000 {
-- 
2.5.1

