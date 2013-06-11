From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH v3 1/7] clk: divider: add flag to limit possible dividers to even numbers
Date: Tue, 11 Jun 2013 13:29:32 +0200
Message-ID: <201306111329.32749.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201306111328.52679.heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-mmc@vger.kernel.org

SoCs like the Rockchip Cortex-A9 ones contain divider some clocks
that use the regular mechanisms for storage but allow only even
dividers and 1 to be used.

Therefore add a flag that lets _is_valid_div limit the valid dividers
to these values. _get_maxdiv is also adapted to return even values
for the CLK_DIVIDER_ONE_BASED case.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-divider.c    |   14 ++++++++++++--
 include/linux/clk-provider.h |    2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index ce5cfe9..bdee7cf 100644
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
index 1ec14a7..bd52e52 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -266,6 +266,7 @@ struct clk_div_table {
  *   of this register, and mask of divider bits are in higher 16-bit of this
  *   register.  While setting the divider bits, higher 16-bit should also be
  *   updated to indicate changing divider bits.
+ * CLK_DIVIDER_EVEN - only allow even divider values
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -281,6 +282,7 @@ struct clk_divider {
 #define CLK_DIVIDER_POWER_OF_TWO	BIT(1)
 #define CLK_DIVIDER_ALLOW_ZERO		BIT(2)
 #define CLK_DIVIDER_HIWORD_MASK		BIT(3)
+#define CLK_DIVIDER_EVEN		BIT(4)
 
 extern const struct clk_ops clk_divider_ops;
 struct clk *clk_register_divider(struct device *dev, const char *name,
-- 
1.7.2.3
