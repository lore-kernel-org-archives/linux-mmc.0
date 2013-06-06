From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 2/8] clk: divider: add flag to limit possible dividers to
 even numbers
Date: Thu, 6 Jun 2013 21:09:07 +0200
Message-ID: <201306062109.08278.heiko@sntech.de>
References: <201306062107.58875.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201306062107.58875.heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

SoCs like the Rockchip Cortex-A9 ones contain divider some clocks
that use the regular mechanisms for storage but allow only even
dividers and 1 to be used.

Therefore add a flag that lets _is_valid_div limit the valid dividers
to these values. _get_maxdiv is also adapted to return even values
for the CLK_DIVIDER_ONE_BASED case.

Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/clk/clk-divider.c    |   14 ++++++++++++--
 include/linux/clk-provider.h |    2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index e37c48a..adfbd0d 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -45,8 +45,16 @@ static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
 
 static unsigned int _get_maxdiv(struct clk_divider *divider)
 {
-	if (divider->flags & CLK_DIVIDER_ONE_BASED)
-		return div_mask(divider);
+	if (divider->flags & CLK_DIVIDER_ONE_BASED) {
+		unsigned int div = div_mask(divider);
+
+		/* decrease to even number */
+		if (divider->flags & CLK_DIVIDER_EVEN)
+			div--;
+
+		return div;
+	}
+
 	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
 		return 1 << div_mask(divider);
 	if (divider->table)
@@ -141,6 +149,8 @@ static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
 		return is_power_of_2(div);
 	if (divider->table)
 		return _is_valid_table_div(divider->table, div);
+	if (divider->flags & CLK_DIVIDER_EVEN && div != 1 && (div % 2) != 0)
+		return false;
 	return true;
 }
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 420a187..9fdd60d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -268,6 +268,7 @@ struct clk_div_table {
  *	indicate the bits that get changed during a write. So for a clock with
  *	shift 0 and width 2, setting the divider to 2 would result in a write
  *	of (3 << 16) | (2 << 0).
+ * CLK_DIVIDER_EVEN - only allow even divider values
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -283,6 +284,7 @@ struct clk_divider {
 #define CLK_DIVIDER_POWER_OF_TWO	BIT(1)
 #define CLK_DIVIDER_ALLOW_ZERO		BIT(2)
 #define CLK_DIVIDER_MASK_UPPER_HALF	BIT(3)
+#define CLK_DIVIDER_EVEN		BIT(4)
 
 extern const struct clk_ops clk_divider_ops;
 struct clk *clk_register_divider(struct device *dev, const char *name,
-- 
1.7.2.3
