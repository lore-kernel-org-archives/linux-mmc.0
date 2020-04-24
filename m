Return-Path: <SRS0=wlIT=6I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA04C55186
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 20:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3CD21744
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 20:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bbV/ZW/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgDXUHA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:07:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13051 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgDXUG5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Apr 2020 16:06:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea346d40000>; Fri, 24 Apr 2020 13:06:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Apr 2020 13:06:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 Apr 2020 13:06:56 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Apr
 2020 20:06:56 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 24 Apr 2020 20:06:56 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.165.152]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ea346df0001>; Fri, 24 Apr 2020 13:06:56 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <skomatineni@nvidia.com>
CC:     <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 4.19.113 3/3] sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
Date:   Fri, 24 Apr 2020 13:06:52 -0700
Message-ID: <1587758812-3331-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587758812-3331-1-git-send-email-skomatineni@nvidia.com>
References: <1587758812-3331-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587758804; bh=y6URX/l8Hj7E0fa2dP1yy7nEvZn2Klmb4qHShYYMUPI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bbV/ZW/OMsgz2vQxObdyqlszdCY32TE7lfSzFvwiC4skwvAlKbYKItHkf06SRpWfQ
         CbEkA8mqhyOKzDeIocdYYUbYOD/5PzOjokaquiRTjWrvCY38BAtqgK9nRmo6Rs2QLW
         QgcPpm5ju7qTcQ6zstkZ6uSEc/obeaLhSnutevWvrkYIwxI0H18Pk0pQVQA2bk6HEi
         JN2N/GszT7vIKmQ2HYmCzfVut+H9V+lEskPa5FGmVi6H1tJt86zDDE1rys1ofcI6gn
         /9ZkdX8WHBzP1V5eFHb/tTte5yPMSZF8V6/MayQ3eAC9Sl4pC5vOwgvN1eSp7V/Jmq
         XrcyBAbqGh+2w==
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

