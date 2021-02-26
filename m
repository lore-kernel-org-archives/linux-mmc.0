Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278FFC433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F2C64EE7
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 08:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhBZIm4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Feb 2021 03:42:56 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:20054 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhBZImv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Feb 2021 03:42:51 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app3 (Coremail) with SMTP id cC_KCgBnvthKtDhg5Z7LAQ--.49145S4;
        Fri, 26 Feb 2021 16:41:50 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci-o2micro: Add missing checks in sdhci_pci_o2_probe
Date:   Fri, 26 Feb 2021 16:41:46 +0800
Message-Id: <20210226084146.29095-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBnvthKtDhg5Z7LAQ--.49145S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur18XFyfJr4kZw45JFWUArb_yoW8Ar4DpF
        s5ZrW5Cr4kJFyYkF9rAwn5Xr1YyrZFyrWUGryfG34xZFWUAFZ0yrZ3GFW5tr1DWrWkKa1f
        ZFsYqryDCFWUJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgQGBlZdtSfEeAAMsv
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It's odd to adopt different error handling on failure of
pci_read_config_dword(). Check the return value and terminate
execution flow on failure of all pci_read_config_dword() calls
in this function.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 94e3f72f6405..51d55a87aebe 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -706,6 +706,8 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 			ret = pci_read_config_dword(chip->pdev,
 						    O2_SD_FUNC_REG0,
 						    &scratch_32);
+			if (ret)
+				return ret;
 			scratch_32 = ((scratch_32 & 0xFF000000) >> 24);
 
 			/* Check Whether subId is 0x11 or 0x12 */
@@ -716,6 +718,8 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 				ret = pci_read_config_dword(chip->pdev,
 							    O2_SD_FUNC_REG4,
 							    &scratch_32);
+				if (ret)
+					return ret;
 
 				/* Enable Base Clk setting change */
 				scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
@@ -795,6 +799,8 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 
 		ret = pci_read_config_dword(chip->pdev,
 					    O2_SD_PLL_SETTING, &scratch_32);
+		if (ret)
+			return ret;
 
 		if ((scratch_32 & 0xff000000) == 0x01000000) {
 			scratch_32 &= 0x0000FFFF;
@@ -812,6 +818,8 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 			ret = pci_read_config_dword(chip->pdev,
 						    O2_SD_FUNC_REG4,
 						    &scratch_32);
+			if (ret)
+				return ret;
 			scratch_32 |= (1 << 22);
 			pci_write_config_dword(chip->pdev,
 					       O2_SD_FUNC_REG4, scratch_32);
-- 
2.17.1

