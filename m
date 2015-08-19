From: Rabin Vincent <rabin.vincent@axis.com>
Subject: [PATCH 1/3] mmc: usdhi6rol0: handle probe deferral for regulator
Date: Wed, 19 Aug 2015 15:41:34 +0200
Message-ID: <1439991696-28488-1-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:44738 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbbHSNlt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Aug 2015 09:41:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, Rabin Vincent <rabinv@axis.com>

We ignore errors from mmc_regulator_get_supply() because the usage of
the regulators is optional for the driver, but we still need to check
for and handle EPROBE_DEFER, like it's done in for example dw_mmc.
Otherwise we might end up not using the specified regulators just
because of probe order.

Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 54b082b..63d5d72 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1715,12 +1715,14 @@ static int usdhi6_probe(struct platform_device *pdev)
 	if (!mmc)
 		return -ENOMEM;
 
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret == -EPROBE_DEFER)
+		goto e_free_mmc;
+
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
 		goto e_free_mmc;
 
-	mmc_regulator_get_supply(mmc);
-
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
 	host->wait	= USDHI6_WAIT_FOR_REQUEST;
-- 
1.7.10.4

