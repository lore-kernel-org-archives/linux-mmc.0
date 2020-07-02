Return-Path: <SRS0=03RR=AN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A28DC433DF
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jul 2020 01:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1058F2085B
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jul 2020 01:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGBBxo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:53:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgGBBxo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Jul 2020 21:53:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 43B3E84ECBEA05F2FC52;
        Thu,  2 Jul 2020 09:53:41 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 09:53:33 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Sahitya Tummala" <stummala@codeaurora.org>
CC:     Hulk Robot <hulkci@huawei.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH -next] mmc: sdhci-msm: Make function sdhci_msm_dump_vendor_regs() static
Date:   Thu, 2 Jul 2020 10:03:47 +0800
Message-ID: <20200702020347.77214-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Hulk Robot <hulkci@huawei.com>

Fix sparse build warning:

drivers/mmc/host/sdhci-msm.c:1888:6: warning:
 symbol 'sdhci_msm_dump_vendor_regs' was not declared. Should it be static?

Signed-off-by: Hulk Robot <hulkci@huawei.com>
---
 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 15c42b059240..66f755f94d2c 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1885,7 +1885,7 @@ static void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
 #define SDHCI_MSM_DUMP(f, x...) \
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
-void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
+static void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);

