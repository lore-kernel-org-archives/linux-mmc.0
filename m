Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5933BC38A29
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 19:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2913E20780
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 19:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pgOA48rG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgDQTOa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:14:30 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10573 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgDQTOZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 15:14:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9a00040000>; Fri, 17 Apr 2020 12:14:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 12:14:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 Apr 2020 12:14:24 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 19:14:24 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 19:14:24 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.241]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e9a000e0001>; Fri, 17 Apr 2020 12:14:23 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <gregkh@linuxfoundation.org>, <faiz_abbas@ti.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>
CC:     <bbiswas@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: [PATCH 4.19.113 3/3] sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
Date:   Fri, 17 Apr 2020 12:14:04 -0700
Message-ID: <1587150844-12003-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587150844-12003-1-git-send-email-skomatineni@nvidia.com>
References: <1587150844-12003-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587150852; bh=y6URX/l8Hj7E0fa2dP1yy7nEvZn2Klmb4qHShYYMUPI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=pgOA48rGpGQw8m/Q9KuiZRgGRDAl8YmdvEe05UqH7tgujiuIGTmPiesvSh01oQ1QW
         lksgpPwyE8QJwO7Ee3c0s3pLOU2EO0ZDJ3GBFzfnh4EfYhmu0ChDoOVDXvehgxubLu
         qHJGYe7OsK3aSJQA2oawPr9SFHqBumnxNbY8BYbmKJ4TgydSHi4K/QTayGMdwZ2eYQ
         eP+9yq7DWTo6rbIh9fB3b1L6sItcWs3Xon9r2qBVygyXBr3tUexs75u7dDqwhnyCKW
         IJ4k7ARt8hUBRC1G4Mvc4ZOZqoiETU8ev44HI2tvjwhqXT/bn6qUGDlZi7NUeOQNsO
         mIDyfiFSeth/Q==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

commit ff124c31ccd7
("sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability")

Tegra sdhci host supports HW busy detection of the device busy
signaling over data0 lane.

So, this patch enables host capability MMC_CAP_WAIT_WHILE_BUSY.

Cc: <stable@vger.kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0f4de73..fde1f3b 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -529,6 +529,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_parse_dt;
 
+	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-- 
2.7.4

