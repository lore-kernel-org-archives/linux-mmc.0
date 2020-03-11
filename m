Return-Path: <SRS0=lJwf=46=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715FCC10DCE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 01:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AEE206EB
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 01:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCMBL0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:11:26 -0400
Received: from 97-93-29-23.dhcp.snlo.ca.charter.com ([97.93.29.23]:54452 "EHLO
        skomatineni-linux.nvidia.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbgCMBL0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 21:11:26 -0400
X-Greylist: delayed 91210 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 21:11:25 EDT
Received: by skomatineni-linux.nvidia.com (Postfix, from userid 1000)
        id E04C81040078; Tue, 10 Mar 2020 17:20:31 -0700 (PDT)
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        baolin.wang@linaro.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, bradleybolen@gmail.com,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     skomatineni@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v2 2/2] sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
Date:   Tue, 10 Mar 2020 17:20:30 -0700
Message-Id: <1583886030-11339-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583886030-11339-1-git-send-email-skomatineni@nvidia.com>
References: <1583886030-11339-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tegra sdhci host supports HW busy detection of the device busy
signaling over data0 lane.

So, this patch enables host capability MMC_CAP_wAIT_WHILE_BUSY.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index fa8f6a4..1c381f8 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1580,6 +1580,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_parse_dt;
 
+	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-- 
2.7.4

