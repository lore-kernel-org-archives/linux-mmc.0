Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79701C41621
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFBB2074D
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXLB+FEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgCXSHw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:07:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32784 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCXSHw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:07:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id f20so3772337ljm.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8SsdXxw6WR8Wur1e28lt2OagUPIvgDuohaIqQCKjAs=;
        b=bXLB+FEonMWU5yCYDNNCwM7DMyqWiCgHeh9KBEDU9H05YBCLCtfQ6BfQ4Wj675/77z
         extRXLQoyDKiM7YaI3RUdHXTIvuyowuy3fijpn8BobjrlmTOTj13A4nJHfWVYeJLcTYw
         pbnf0RUCGhRUcEGcmqd0O9pGT48+BNvCdmWrpTAkUG1UlJo5Byrgvp41E2MQqJQUwnjW
         CSBAFR7Uk5Ds/xnaPFlaH8vG2wtJ0xSWvCfIK/wMzFzjU0ERfojF2CfgR7juhIfQC8hX
         YAc5JPzObZifoz/TiMQKB3Yr8SeaMnA19Nte1Q76CBMGeAMOQ0E/kmC2XQbE7PogQFTz
         SIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8SsdXxw6WR8Wur1e28lt2OagUPIvgDuohaIqQCKjAs=;
        b=kCo09txHOoJLIOu1CoqllhAJPj8vYTV1y0V5qw0fHhnbQE68zQo8IZLtnkoOKk6CrQ
         MRoQT69ufjNuFCvkEDY22lOqpLNou46/9O2zUx8TvqBhCqvtvZICmpdTRe+Lbf2rbEDJ
         GMUYku0D48DIpDMvX0ScfOE2oAokpwphWFHUlbwSon17JG/oduKOyW3QclG/hrIAOL32
         MjH6kNpez0QxgX6lgTHrtPC/1pU3mbdtqwSL6kFh3FtN4tmBTB4KMecOxBYhLIlv0ekl
         tbhyQ5LEj/DM4UhzZxDF1/e9NZtpXjR7NGJ8Xg7psICCKyXRj5rFugkZ/FlNO6QvpvT8
         Xjsg==
X-Gm-Message-State: ANhLgQ2qhfPSvsWLGntG3rAvYCQ0ys2kF5ljs5P5fNdpX2bNbs2Edjsr
        osV5N/m4KRnnn4MMd5iotv9D2w==
X-Google-Smtp-Source: ADFU+vsAG+RBizWk7K20WS6AoDZ1kvqWGGaXFBe5zOjiY0vib4LLsWVOa+CSBjZGLU/ozj7vAbF/xg==
X-Received: by 2002:a2e:9903:: with SMTP id v3mr18140211lji.96.1585073270215;
        Tue, 24 Mar 2020 11:07:50 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 3sm12113809ljq.18.2020.03.24.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:07:49 -0700 (PDT)
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
Subject: [PATCH 5.4.28 5/5] mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
Date:   Tue, 24 Mar 2020 19:07:38 +0100
Message-Id: <20200324180738.28892-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180738.28892-1-ulf.hansson@linaro.org>
References: <20200324180738.28892-1-ulf.hansson@linaro.org>
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
index 403ac44a7378..a25c3a4d3f6c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1552,6 +1552,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
+	/* R1B responses is required to properly manage HW busy detection. */
+	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
+
 	tegra_sdhci_parse_dt(host);
 
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
-- 
2.20.1

