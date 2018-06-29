From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH] mmc: core: cd_label must be last entry of mmc_gpio struct
Date: Fri, 29 Jun 2018 09:35:32 +0800
Message-ID: <1530236132-7968-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, yamada.masahiro@socionext.com, evgreen@chromium.org, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Making "char cd_label[0]" the last entry of mmc_gpio struct,
the result is correct as below:

144:          0  gpio-mxc  22 Edge      2198000.mmc cd
161:          0  gpio-mxc   7 Edge      2190000.mmc cd

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/mmc/core/slot-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index ef05e00..1ccf9dc 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,8 +27,8 @@ struct mmc_gpio {
 	bool override_cd_active_level;
 	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
 	char *ro_label;
-	char cd_label[0];
 	u32 cd_debounce_delay_ms;
+	char cd_label[0];
 };
 
 static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
-- 
2.7.4
