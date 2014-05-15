From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 01/14] mmc: mmci: use NSEC_PER_SEC macro
Date: Thu, 15 May 2014 10:36:16 +0100
Message-ID: <1400146576-29846-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch replaces a constant used in calculating timeout with a proper
macro. This is make code more readable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a084edd..a38e714 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -718,7 +718,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	data->bytes_xfered = 0;
 
 	clks = (unsigned long long)data->timeout_ns * host->cclk;
-	do_div(clks, 1000000000UL);
+	do_div(clks, NSEC_PER_SEC);
 
 	timeout = data->timeout_clks + (unsigned int)clks;
 
-- 
1.9.1
