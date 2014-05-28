From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 01/13] mmc: mmci: use NSEC_PER_SEC macro
Date: Wed, 28 May 2014 14:45:55 +0100
Message-ID: <1401284755-16481-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1401284608-16428-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33078 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbaE1NqD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 09:46:03 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so3739714wiv.13
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2014 06:46:02 -0700 (PDT)
In-Reply-To: <1401284608-16428-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

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

