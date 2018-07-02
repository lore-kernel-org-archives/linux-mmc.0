From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
Date: Mon,  2 Jul 2018 09:27:47 +0800
Message-ID: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, yamada.masahiro@socionext.com, adrian.hunter@intel.com, linus.walleij@linaro.org, evgreen@chromium.org, shawn.lin@rock-chips.com, fabio.estevam@nxp.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-mmc@vger.kernel.org

commit bfd694d5e21c ("mmc: core: Add tunable delay
before detecting card after card is inserted") adds
"u32 cd_debounce_delay_ms" to the last of mmc_gpio
struct and cause "char cd_label[0]" NOT work as string
pointer of card detect label, when "cat /proc/interrupts",
the devname for card detect gpio is incorrect as below:

144:          0  gpio-mxc  22 Edge      ▒
161:          0  gpio-mxc   7 Edge      ▒

Move the cd_label field down to fix this, and drop the
zero from the array size to prevent future similar bugs,
the result is correct as below:

144:          0  gpio-mxc  22 Edge      2198000.mmc cd
161:          0  gpio-mxc   7 Edge      2190000.mmc cd

Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card after card is inserted")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
---
changes since V1:
	- Add fix tag;
	- Drop the zero from the array size, then gcc will have compiling error for such kind of issue next time.
 drivers/mmc/core/slot-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index ef05e00..2a83368 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,8 +27,8 @@ struct mmc_gpio {
 	bool override_cd_active_level;
 	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
 	char *ro_label;
-	char cd_label[0];
 	u32 cd_debounce_delay_ms;
+	char cd_label[];
 };
 
 static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
-- 
2.7.4
