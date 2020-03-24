Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C85C2BAEE
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB1720719
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwepUZZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgCXSIP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:08:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33949 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgCXSIP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:08:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id s13so19669642ljm.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGIdmSaD4bL8sXYCDOXTAHaizP73PQqueDtC+tJUTFU=;
        b=uwepUZZsqvuP7LQ8t4z0sM0tNjEGZJINFJ2l1Ek5eoE1GrsnIMloCHRVN4NJwFRXfU
         fiMV8A2Ej7nRCyCKJLwMUH4MSJ5llHRv75IjRxCr/bd++fTbC269ZKglRJHYLzUtY4z/
         cMLJVvHw/YSorN9Jxtdl17Nx5khcoue8cS935EIhflOtaoTThxjZ05mB7sOLujLtpVJ7
         RV2YXZ6ZC+wmdIKmw3DGGww3vGQ8Npw1rS6kXbVfZEfk5ndDgtSfipFdNJosg5rOB7Mh
         XCbRly2hpv4FB0FTFpLIwTfiKrTcxz6oza+hoXtDPR6DMIkzsXeSAg2aleUM6akOkZAE
         p7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGIdmSaD4bL8sXYCDOXTAHaizP73PQqueDtC+tJUTFU=;
        b=DPzwdJ3sUxXyU3bhUeUZm+WcFz8K7VZE8g+y+dAl0N4EtiZNCl8hFUM3BY08LhscdJ
         ikcBXktWVlKkyki7cGXACEDDVbxCg8DrzuCixj3exzedyIJQKAjgPIRm7s/CZFyfyIao
         wSDsiLfCkZJ7Iq0UBT+YSKUTkilFm1Rso/yza3MYOFyAkgaHIN+Tg2HCB9okCs0lZtlQ
         4b2xHDy7CcLrOeLM3WI9G+aOxBhxuXSYV98lLE43dcYKYmG+0t3QBiV1cKtbSGDaySF0
         iNIBIUlB/RfXTnCVSr4AhUiFcJJwX/cnL8yS9phl9xcA+vTpsolimdD//iQu+emlPXpW
         Eqxw==
X-Gm-Message-State: ANhLgQ18Ejt7YbhkiBd25sZ+5EfSJ7ZFjBds6eyiDvOXddq+otWHfn9c
        7sZLtDu/qaF0v8gitLDz6qgASQ==
X-Google-Smtp-Source: ADFU+vtFbYu+jTNqgRwyr2VDn3JFGCB1OWgIZUWVTILGWVoDJQ+XouDD460jKVCLf/M09JNvHbyQAw==
X-Received: by 2002:a2e:9194:: with SMTP id f20mr7293688ljg.33.1585073293744;
        Tue, 24 Mar 2020 11:08:13 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id s10sm11029858ljp.87.2020.03.24.11.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:08:12 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 4.19.113 5/5] mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
Date:   Tue, 24 Mar 2020 19:08:00 +0100
Message-Id: <20200324180800.28953-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180800.28953-1-ulf.hansson@linaro.org>
References: <20200324180800.28953-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[ Upstream commit d2f8bfa4bff5028bc40ed56b4497c32e05b0178f ]

It has turned out that the sdhci-tegra controller requires the R1B response,
for commands that has this response associated with them. So, converting
from an R1B to an R1 response for a CMD6 for example, leads to problems
with the HW busy detection support.

Fix this by informing the mmc core about the requirement, via setting the
host cap, MMC_CAP_NEED_RSP_BUSY.

Reported-by: Bitan Biswas <bbiswas@nvidia.com>
Reported-by: Peter Geis <pgwipeout@gmail.com>
Suggested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: <stable@vger.kernel.org>
Tested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Tested-By: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 14d749a0de95..27bdf6d499bd 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -502,6 +502,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
+	/* R1B responses is required to properly manage HW busy detection. */
+	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
+
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
 							 GPIOD_OUT_HIGH);
 	if (IS_ERR(tegra_host->power_gpio)) {
-- 
2.20.1

