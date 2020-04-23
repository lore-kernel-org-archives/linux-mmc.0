Return-Path: <SRS0=Q/yj=6H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F06C2BA19
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 06:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F662074F
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 06:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgDWGhN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:37:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbgDWGhN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Apr 2020 02:37:13 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63D5C9B22542436B0BDB;
        Thu, 23 Apr 2020 14:37:10 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 14:37:00 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mmc: sdhci-pci-o2micro: Make some symbols static
Date:   Thu, 23 Apr 2020 14:43:19 +0800
Message-ID: <1587624199-96926-1-git-send-email-zou_wei@huawei.com>
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

drivers/mmc/host/sdhci-pci-o2micro.c:497:6: warning: symbol
'sdhci_pci_o2_set_clock' was not declared. Should it be static?
drivers/mmc/host/sdhci-pci-o2micro.c:512:5: warning: symbol
'sdhci_pci_o2_probe_slot' was not declared. Should it be static?
drivers/mmc/host/sdhci-pci-o2micro.c:581:5: warning: symbol
'sdhci_pci_o2_probe' was not declared. Should it be static?
drivers/mmc/host/sdhci-pci-o2micro.c:786:5: warning: symbol
'sdhci_pci_o2_resume' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index fa81050..e2a8468 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -494,7 +494,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
 	}
 }
 
-void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
+static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	u16 clk;
 
@@ -509,7 +509,7 @@ void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_o2_enable_clk(host, clk);
 }
 
-int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
+static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
@@ -578,7 +578,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
-int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
+static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 {
 	int ret;
 	u8 scratch;
@@ -783,7 +783,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 }
 
 #ifdef CONFIG_PM_SLEEP
-int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
+static int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
 {
 	sdhci_pci_o2_probe(chip);
 	return sdhci_pci_resume_host(chip);
-- 
2.6.2

