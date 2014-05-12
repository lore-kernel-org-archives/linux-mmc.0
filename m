From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v13 1/2] clk: sunxi: Fixup clk_sunxi_mmc_phase_control
 to take a clk rather then a hw_clk
Date: Mon, 12 May 2014 14:04:47 +0200
Message-ID: <1399896288-5826-2-git-send-email-hdegoede@redhat.com>
References: <1399896288-5826-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORB27RYKNQKGQEC5CCUMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1399896288-5826-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

__clk_get_hw is supposed to be used by clk providers, not clk consumers.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 3 ++-
 include/linux/clk/sunxi.h     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 59f9040..4cc2b2a 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -510,11 +510,12 @@ CLK_OF_DECLARE(sun7i_a20_gmac, "allwinner,sun7i-a20-gmac-clk",
  * clk_sunxi_mmc_phase_control() - configures MMC clock phase control
  */
 
-void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 output)
+void clk_sunxi_mmc_phase_control(struct clk *clk, u8 sample, u8 output)
 {
 	#define to_clk_composite(_hw) container_of(_hw, struct clk_composite, hw)
 	#define to_clk_factors(_hw) container_of(_hw, struct clk_factors, hw)
 
+	struct clk_hw *hw = __clk_get_hw(clk);
 	struct clk_composite *composite = to_clk_composite(hw);
 	struct clk_hw *rate_hw = composite->rate_hw;
 	struct clk_factors *factors = to_clk_factors(rate_hw);
diff --git a/include/linux/clk/sunxi.h b/include/linux/clk/sunxi.h
index 1ef5c89..aed28c4 100644
--- a/include/linux/clk/sunxi.h
+++ b/include/linux/clk/sunxi.h
@@ -17,6 +17,6 @@
 
 #include <linux/clk.h>
 
-void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 output);
+void clk_sunxi_mmc_phase_control(struct clk *clk, u8 sample, u8 output);
 
 #endif
-- 
1.9.0
