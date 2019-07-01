From: Colin King <colin.king@canonical.com>
Subject: [PATCH] mmc: alcor: remove a redundant greater or equal to zero comparison
Date: Mon,  1 Jul 2019 18:52:46 +0100
Message-ID: <20190701175246.32270-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Daniel Drake <drake@endlessm.com>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A greater or equal comparison on the unsigned int variable tmp_diff
is always true as unsigned ints are never negative.  Hence the
comparison is redundant and can be removed.

Addresses-Coverity: ("Unsigned compared against 0")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/alcor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index e481535cba2b..1aee485d56d4 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -672,7 +672,7 @@ static void alcor_set_clock(struct alcor_sdmmc_host *host, unsigned int clock)
 		tmp_clock = DIV_ROUND_UP(cfg->clk_src_freq, tmp_div);
 		tmp_diff = abs(clock - tmp_clock);
 
-		if (tmp_diff >= 0 && tmp_diff < diff) {
+		if (tmp_diff < diff) {
 			diff = tmp_diff;
 			clk_src = cfg->clk_src_reg;
 			clk_div = tmp_div;
-- 
2.20.1
