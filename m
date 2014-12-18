From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/6] mmc: sdhci-st: Do cleanup while mmc_of_parse() return an error
Date: Thu, 18 Dec 2014 10:41:43 +0100
Message-ID: <1418895704-25908-6-git-send-email-ulf.hansson@linaro.org>
References: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:63987 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbaLRJmD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 04:42:03 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so1122064wiv.8
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 01:42:02 -0800 (PST)
In-Reply-To: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>

At errors, balance sdhci_pltfm_init() with sdhci_pltfm_free(), to make
sure all data is freed properly.

Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 328f348..882b07e 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -78,10 +78,9 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	}
 
 	ret = mmc_of_parse(host->mmc);
-
 	if (ret) {
 		dev_err(&pdev->dev, "Failed mmc_of_parse\n");
-		return ret;
+		goto err_of;
 	}
 
 	clk_prepare_enable(clk);
@@ -108,6 +107,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
 
 err_out:
 	clk_disable_unprepare(clk);
+err_of:
 	sdhci_pltfm_free(pdev);
 
 	return ret;
-- 
1.9.1

