Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A29C55185
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B581E20767
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q+aOwso/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgDVQcf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:32:35 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3302 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDVQce (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 12:32:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea071940000>; Wed, 22 Apr 2020 09:32:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 22 Apr 2020 09:32:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 22 Apr 2020 09:32:33 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Apr
 2020 16:32:33 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 22 Apr 2020 16:32:33 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.165.49]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ea071a00002>; Wed, 22 Apr 2020 09:32:33 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <skomatineni@nvidia.com>
CC:     <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 5.4.33 2/2] sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
Date:   Wed, 22 Apr 2020 09:32:29 -0700
Message-ID: <1587573149-30269-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587573149-30269-1-git-send-email-skomatineni@nvidia.com>
References: <1587573149-30269-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587573141; bh=AI2k/GeOJka+x5ydpwPpmWF5ssDecgtebTTmy/odja0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Q+aOwso//9q/gPBeXksB5egUqJegSFWCyFX80F1/NwPCodYcBTfoGSN3tUWNQUkjO
         /7r0YyeGW9fq1ELEX2gP7xtFWYilCBBbVc2Zl8gi8EuNZlg1+oqWhT/q9MfV5JzAvU
         EKJ0XUIP7RSjebfPEvrp++WkvtHMlJM4WiZr8zGzGKJW53xhM6++RFg17mdEDOSCOy
         JzJ/MTZDkKHjFGeCCUCbOV1GcLODeJotn8kMkqcOpsoTqbNusjucuOyOM89k5hPbtu
         fdYYGWm6UGHbpKkiOPfqn2KzhOd26Df0YzfpiQVkIMECH7LWkXdacFDqWk1DtxWYX7
         Im5IHCYAZ0RoA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

commit ff124c31ccd7
("sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability")

Tegra sdhci host supports HW busy detection of the device busy
signaling over data0 lane.

So, this patch enables host capability MMC_CAP_wAIT_WHILE_BUSY.

Cc: <stable@vger.kernel.org>
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

