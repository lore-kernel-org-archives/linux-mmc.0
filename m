From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 6/6] mmc: tmio: refactor CLK_CTL bit calculation
Date: Thu, 23 Aug 2018 13:44:20 +0900
Message-ID: <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

  for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
          clock <<= 1;

... is too tricky, hence I replaced with

  roundup_pow_of_two(divisor) >> 2

'(clk >> 22) & 0x1' is the bit test for the 1/1 divisor, but
it is not clear.  'divisor <= 1' is easier to understand.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/tmio_mmc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index b031a77..e04c322 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -48,19 +48,27 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 			       unsigned int new_clock)
 {
-	u32 clk = 0, clock;
+	unsigned int clock, divisor;
+	u32 clk = 0;
+	int clk_sel;
 
 	if (new_clock == 0) {
 		tmio_mmc_clk_stop(host);
 		return;
 	}
 
-	clock = host->mmc->f_min;
+	divisor = host->pdata->hclk / new_clock;
 
-	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
-		clock <<= 1;
+	if (divisor <= 1) {
+		clk_sel = 1;
+		clk = 0;
+	} else {
+		clk_sel = 0;
+		/* bit7 set: 1/512, ... bit0 set:1/4, all bits clear: 1/2 */
+		clk = roundup_pow_of_two(divisor) >> 2;
+	}
 
-	host->pdata->set_clk_div(host->pdev, (clk >> 22) & 1);
+	host->pdata->set_clk_div(host->pdev, clk_sel);
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-- 
2.7.4
