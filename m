From: srinivas.kandagatla@linaro.org
Subject: [PATCH v6 03/12] mmc: mmci: Add enough delay between writes to CMD register.
Date: Mon,  2 Jun 2014 10:08:57 +0100
Message-ID: <1401700137-11547-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1401699818-11329-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401699818-11329-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Qcom SD Card controller POWER, CLKCTRL, DATACTRL and COMMAND registers
should be updated in MCLK domain, and writes to these registers must be
separated by three MCLK cycles. This resitriction is not applicable for
other registers. Any subsequent writes to these register will be ignored
until 3 MCLK have passed.

One usec delay between two CMD register writes is not sufficient in the
card identification phase where the CCLK is very low. This patch replaces
a static 1 usec delay to use mmci_reg_delay function which can provide
correct delay depending on the cclk frequency.

Without this patch the card is not detected.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a38e714..ed20bf5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -810,7 +810,7 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 
 	if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
 		writel(0, base + MMCICOMMAND);
-		udelay(1);
+		mmci_reg_delay(host);
 	}
 
 	c |= cmd->opcode | MCI_CPSM_ENABLE;
-- 
1.9.1
