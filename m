Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93204C2BAEE
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F60A20719
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIel5Uag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgCXSHK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:07:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37562 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgCXSHK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:07:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so14019116lfg.4
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8SsdXxw6WR8Wur1e28lt2OagUPIvgDuohaIqQCKjAs=;
        b=TIel5Uag6dZ3G0P5rfvaRxHE+J6faOARtdYwQWa0o7ycd/GgSLvBZmXGfzUYoA3wCR
         chLelbgWdGy0YTF6/9ycMDGKSUub/JCYmjc2JVNFkp6Cf6vDkWUDMRmlndg1zFYOXSOr
         5V6elXA2S6f9Nmf0RqrO77kmdvuaN1Qad+WEHn/Dfra1Pq9pOhrYZBAbEHGQpbLnRrXb
         1giw7FMuH6ECSXaE0gM2ElHm8kskRBz2SpCUv2VTYsjS9FJuULzLdyVT2KZ0KxMJrl8N
         QvH11UsguqzJv36qR9I6ffVNRkhQbGZrA0/3LBceTHkbbARh4W41jHq4SJIqLS+CCu7q
         W0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8SsdXxw6WR8Wur1e28lt2OagUPIvgDuohaIqQCKjAs=;
        b=OX/WEsUWAwo12p23IJNTftdh7chDAtDbs7re1RztEEP2jt+7B9ZVgyU50MtQESFeMh
         3xlCMF/ubNWxh7+/JvS0C01xcsXIrSq3mfp09I47ztIJzqagqr5kum2Qk0BfAPf5BV7Z
         o4QHwVspqwh5T8+35NAXQOaSbzpvLhhjDsIiiirnAwvxvG0VmOwLISh+UtYwyj4Z8Dwp
         GPGTb0mpFJDZRSvVhQOe4u+A4DJBeBPLPG3vUZho4r+2wTK8OZTK4uhsKl0MuXC8MrAD
         eD1f50PypZQS++Grzrnb5NgO+il/XozU/42nn1rIhT7Jn8qmUX9ceLu4qD7vjIZ8jRU9
         v44g==
X-Gm-Message-State: ANhLgQ2qJLmxdHY5QLaFRiQ8CMIPJT2ZGkTNwJrAXbHZTpeNjyDW7FBR
        k9FP0K1lCp53hz7jRtsvp1FS8Q==
X-Google-Smtp-Source: ADFU+vs1iKgFEQHMKMWWpUIuZuzM5YuqIBxiTCl2JAnxIR+KDVwYeJ+0kD/ZNvy1xNOu0SxrTNAc4Q==
X-Received: by 2002:a19:be11:: with SMTP id o17mr7367103lff.168.1585073227363;
        Tue, 24 Mar 2020 11:07:07 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 203sm10519660ljf.65.2020.03.24.11.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:07:06 -0700 (PDT)
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
Subject: [PATCH 5.5.12 5/5] mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
Date:   Tue, 24 Mar 2020 19:06:50 +0100
Message-Id: <20200324180650.28819-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180650.28819-1-ulf.hansson@linaro.org>
References: <20200324180650.28819-1-ulf.hansson@linaro.org>
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

