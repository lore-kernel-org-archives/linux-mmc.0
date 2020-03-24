Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CFC41621
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100EE20789
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUWdRuu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgCXSHI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:07:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45652 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgCXSHI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:07:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id v4so10356481lfo.12
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55Q5nK7DG2eakt4E8m0DEdylbWI2T3RG1qzE0tCmg/8=;
        b=FUWdRuu5vsxI3HC6P64JoXJtDbK6QBLk09WCVOmnUvAnRi7eErR6n4kqgkitPA6vbX
         qSnMbErz4PUwBbW5GlnEsWUKFWczjocGrffDE+sqLqkxYWNpYaVGYvlVL97U9/ZLrdwv
         yb2UQjsA5/kw5TLMljXvFSMEg3nrKi2tVE0HDTeNqS8s7pjjMB9fYQcLsxE1ZnE8ljfw
         QuJtDvrZMWmzHwxNris1nSs/wu5dV4ImEIodjQu8UJQ1Kdp4fvu+ik883auF1Hyx12QM
         SujojXlJJoY42Y3nYgp5xyx0XuAEG9GwjWAQ/fL7MSeQCcYwnejnZ1y/O7e4B7V//+9T
         nWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55Q5nK7DG2eakt4E8m0DEdylbWI2T3RG1qzE0tCmg/8=;
        b=Rb+nF30NbPtZaWjJ+u85wscDVLw150o9yYKEEz5zD9GxJsvFrxbugYFQ/2WkglQBUR
         w7x0ZK20g56q7543K5RPpQwr5s513n7XptLNiv1BiTOzSthMcoRqU0Ztsuii65b8Y2Dt
         SClJJoZCIA16E1Q3mlgyqlMJRT7i2vpjHm/pjiw5c6V2q5gxmws0Lps8rD0pOMWDIRx0
         fd5gQQnpDRqh3QsMWubR/phmuFy/2W6meUpQCzd5YTI+vgCE2u/tA5sif/AGRVxOiaLF
         iVgAE/WSHnES+Mm4kiWOwmp5fj45cei1Dl5jlLCginR51TYPfQ7jGLVINd+ytYpXbNvM
         Ot9g==
X-Gm-Message-State: ANhLgQ1ojVgfNqhqobiqqdSi4EMxLEZUXUB26zgItR3x+kd2au4dFU0y
        JLEyGo5ySYDkMd0MoVH2VK6y3w==
X-Google-Smtp-Source: ADFU+vts+159LopaFbTmUdKm7ulidUw/f0T6q2tUCX+fPHQ7W4pHAHRl85wpcQb4rfnQwTe/mDPEkA==
X-Received: by 2002:a19:3847:: with SMTP id d7mr7807086lfj.158.1585073225534;
        Tue, 24 Mar 2020 11:07:05 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 203sm10519660ljf.65.2020.03.24.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:07:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 5.5.12 4/5] mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
Date:   Tue, 24 Mar 2020 19:06:49 +0100
Message-Id: <20200324180650.28819-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180650.28819-1-ulf.hansson@linaro.org>
References: <20200324180650.28819-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[ Upstream commit 055e04830d4544c57f2a5192a26c9e25915c29c0 ]

It has turned out that the sdhci-omap controller requires the R1B response,
for commands that has this response associated with them. So, converting
from an R1B to an R1 response for a CMD6 for example, leads to problems
with the HW busy detection support.

Fix this by informing the mmc core about the requirement, via setting the
host cap, MMC_CAP_NEED_RSP_BUSY.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Reported-by: Faiz Abbas <faiz_abbas@ti.com>
Cc: <stable@vger.kernel.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-omap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 083e7e053c95..d3135249b2e4 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1134,6 +1134,9 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
 	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
 
+	/* R1B responses is required to properly manage HW busy detection. */
+	mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.20.1

