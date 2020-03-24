Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2855C54FCF
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16C52074D
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWMyskle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgCXSHv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:07:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38654 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgCXSHv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:07:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so19612592ljh.5
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55Q5nK7DG2eakt4E8m0DEdylbWI2T3RG1qzE0tCmg/8=;
        b=NWMyskleY9eJWjYdCvQ+/NqIDOzRSCQbR0LU7/GUPYjNm0T+CHou6ccJZzwcfXW+6p
         QHf2UckHJ02LLAgMmmzUNTLKt4PA4GTjoYCktFmXmWoBcskpirSW1QKwE0B6Vkm9kz0c
         G/89uEce64Otm1B2/bqB7jbx2q/tYGYml8p880Nbv1X7E86oGzla+AulO3qFCMnRX99R
         QJ2Z4s2qqJysOQxNv4EKSGBIThJx+rYu6xX4x5tkCTJCmVwF5zuvFADOWAawj3p4LUtZ
         H8PN8ToLOtjXCdir37eTdqTgE27JHi/VI3Xlj8eNNfvOmAE+TcE889St9jmKVBgALzTV
         wZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55Q5nK7DG2eakt4E8m0DEdylbWI2T3RG1qzE0tCmg/8=;
        b=SOjt+rDVZ5binglPQp4KnhpKZqVvumMdeQ53CNEWVgsLGoT7ts0NvQ78G++rYaQAO0
         gZJnRV7DycKYVW2iBSjt41/dIBfQN9cKCCCKbgKchANWTa7zuffTmyk8WRYx2eKceRfR
         iKz/ooazHg3SawAelhPEXYVQ9rmRiJQ1WVWK1GNBUGJQVx4OcReb7K6T0d+A3xt3QAc3
         MYHDtmHCGUIddPQVReDV3TzqFVYyGOxi5rw7r7SQWJSlyXWHoVWYSNWL3BUmKSE7ts7j
         2Sx4Nat6dNY6W5w8zXLyOk1GlE4gAF0mC1V5gdbdgKwTllT8L9ZdyqQ/Q2UPnw5j/d4i
         uYXA==
X-Gm-Message-State: ANhLgQ3Tb0MmU6izj8UnZqn3ZVfzPKh1MnnzlXR5zyK1RVfkJkaAgr0R
        0WY+AIhajt13DbNRBIVjfq7MxA==
X-Google-Smtp-Source: ADFU+vsWje7Gx+Xxmh/DTRmbz7CClsl9rSEKazxZiE9j73uVqUHiPP1G+1UbxANWtMf2I8+dj0OhNw==
X-Received: by 2002:a2e:894e:: with SMTP id b14mr8761357ljk.103.1585073268587;
        Tue, 24 Mar 2020 11:07:48 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 3sm12113809ljq.18.2020.03.24.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:07:47 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 5.4.28 4/5] mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
Date:   Tue, 24 Mar 2020 19:07:37 +0100
Message-Id: <20200324180738.28892-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180738.28892-1-ulf.hansson@linaro.org>
References: <20200324180738.28892-1-ulf.hansson@linaro.org>
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

