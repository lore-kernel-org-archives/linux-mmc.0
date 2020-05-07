Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CA1C4724C
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 12:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EA021841
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 12:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgEGMOy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 08:14:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3891 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbgEGMOx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 7 May 2020 08:14:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 583EBC7DD4A97541A1BB;
        Thu,  7 May 2020 20:14:48 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 20:14:41 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] mmc: sdhci-pci-gli: Make sdhci_pci_gli_resume static
Date:   Thu, 7 May 2020 20:20:50 +0800
Message-ID: <1588854050-19161-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix the following sparse warning:

drivers/mmc/host/sdhci-pci-gli.c:343:5: warning:
symbol 'sdhci_pci_gli_resume' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index bdb6336..fd76aa6 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -340,7 +340,7 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
 }
 
 #ifdef CONFIG_PM_SLEEP
-int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
+static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot = chip->slots[0];
 
-- 
2.6.2

