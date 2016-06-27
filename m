From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 3/3] phy: rockchip-emmc: Wait even longer for the DLL to lock
Date: Mon, 27 Jun 2016 10:39:27 -0700
Message-ID: <1467049167-14628-4-git-send-email-dianders@chromium.org>
References: <1467049167-14628-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467049167-14628-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, ulf.hansson@linaro.org, kishon@ti.com
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, briannorris@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Two times out of 2000 reboots I ran into the error message
"rockchip_emmc_phy_power: dllrdy timeout".  Presumably there is some
corner case where the DLL just takes a little longer to timeout.  Let's
give it even more time to handle these corner cases.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/phy/phy-rockchip-emmc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
index a2aa6aca7dec..fd57345ffed2 100644
--- a/drivers/phy/phy-rockchip-emmc.c
+++ b/drivers/phy/phy-rockchip-emmc.c
@@ -206,8 +206,18 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 	 * per the math: 10.2 us * (50000000 Hz / 100000 Hz) => 5.1 ms
 	 * Hopefully we won't be running at 100 kHz, but we should still make
 	 * sure we wait long enough.
+	 *
+	 * NOTE: There appear to be corner cases where the DLL seems to take
+	 * extra long to lock for reasons that aren't understood.  In some
+	 * extreme cases we've seen it take up to over 10ms (!).  We'll be
+	 * generous and give it 50ms.  We still busy wait here because:
+	 * - In most cases it should be super fast.
+	 * - This is not called lots during normal operation so it shouldn't
+	 *   be a power or performance problem to busy wait.  We expect it
+	 *   only at boot / resume.  In both cases, eMMC is probably on the
+	 *   critical path so busy waiting a little extra time should be OK.
 	 */
-	timeout = jiffies + msecs_to_jiffies(10);
+	timeout = jiffies + msecs_to_jiffies(50);
 	do {
 		udelay(1);
 
-- 
2.8.0.rc3.226.g39d4020
