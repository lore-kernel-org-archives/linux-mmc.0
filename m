From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mmc: sdhci-xenon: Remove redundant dev_err call in get_dt_pad_ctrl_data()
Date: Tue, 25 Apr 2017 06:34:46 +0000
Message-ID: <20170425063446.32726-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34422 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980787AbdDYGev (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Apr 2017 02:34:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id g23so8070969pfj.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Apr 2017 23:34:51 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hu Ziji <huziji@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-mmc@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 4bdbcd3..d43841e 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -639,11 +639,8 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
 
 	params->pad_ctrl.reg = devm_ioremap_resource(mmc_dev(host->mmc),
 						     &iomem);
-	if (IS_ERR(params->pad_ctrl.reg)) {
-		dev_err(mmc_dev(host->mmc), "Unable to get SoC PHY PAD ctrl register for %s\n",
-			np->name);
+	if (IS_ERR(params->pad_ctrl.reg))
 		return PTR_ERR(params->pad_ctrl.reg);
-	}
 
 	ret = of_property_read_string(np, "marvell,pad-type", &name);
 	if (ret) {



