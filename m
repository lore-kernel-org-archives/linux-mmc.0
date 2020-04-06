Return-Path: <SRS0=po4a=5W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57566C2BA1E
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 11:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE02206C3
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 11:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2T3JWKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgDFLhb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:37:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43715 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgDFLhb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Apr 2020 07:37:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id g27so14211525ljn.10
        for <linux-mmc@vger.kernel.org>; Mon, 06 Apr 2020 04:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jomYwKtC32wMHbYmj9/ewVW7gsvr/quou2UrF91WBT4=;
        b=P2T3JWKEiJgGoNNqCbtSuA8+FRYokJOvQcCnrgVj91hvkGOvlGBCowOSg5TajUlGZJ
         Im0vR8guzN2oSr6IX/VWQ5J/nyyo9fRJLhBZq09RwOJJoH7UwmXY6aaakf0eSBTKHOFf
         cFx2dHukRL+BkI+ODNSrvYtmn0YmyGZ9IwocDSqOknWVmIFmMDmcZgOd5T4REHJNf/38
         G52yO38AwasF0NMvfJcSzI0UEUHzeZInOdJNzFshbbmC/VysjW/irUBDqQjWAJHpP1C+
         IyMkJeKh2bU9g8L1yc7HLjVAuqcENk9cm6xXYcW8rttlqEa7bhwuCYLlFdFlPlUF9A9f
         oGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jomYwKtC32wMHbYmj9/ewVW7gsvr/quou2UrF91WBT4=;
        b=B7zO8pYneAZIQolREYXN15sqbVgMRHfc7xBfRmIoo71PCgJoRDduUqBid5ngFZmfB7
         f7CB9QxM9SFehjfUufeKr9ZThISE1Tipw8vKDwXRfuN234RfIwVTF5u42h/jNunWVkFy
         tNsIAWohVMQ9cuI2ndDxV9i38B/3ztxgRMf/opr8kiT21vwW4F/mY93yqfkmOVib4tkP
         gQM3iY3sTRihYGR862LthlsxaSgop9gGAdYrZgmyp0ivPO/25ZzCNs+GjF4AffUso1+Y
         sN4t+hI5vw2a9NAkDH6IHYYQlQs1tjscPzOd+zMG2FFUC2BapZLBNwUpQW0S7yVOuMFu
         ciVQ==
X-Gm-Message-State: AGi0PuY+4qWqpa/SjH+2PFsmYGoOim9bJsXxErIBGvUIzbUDiyeGvOPn
        YWuz61YgZwdg6mlRmmqEWZzvgUG10GQ=
X-Google-Smtp-Source: APiQypKbpd+srlD1TbCF9VLQ7IjyZ3dGBlzEnxmyb/indWWR1O+wMhyGbCHcndqPQdBvP99zQLC5YQ==
X-Received: by 2002:a2e:9c01:: with SMTP id s1mr7585732lji.175.1586173048791;
        Mon, 06 Apr 2020 04:37:28 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id y12sm11982072ljk.18.2020.04.06.04.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 04:37:27 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] mmc: sdhci-sprd: Drop redundant cap flags
Date:   Mon,  6 Apr 2020 13:37:24 +0200
Message-Id: <20200406113724.8504-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The MMC_CAP_ERASE and MMC_CAP_CMD23 flags are already being set in the
common sdhci_setup_host(). This makes it redundant to set them for
sdhci-sprd, so let's drop them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 2ab42c59e4f8..60c3a4c620f9 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -556,7 +556,8 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		sdhci_sprd_voltage_switch;
 
 	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
-		MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
+		MMC_CAP_WAIT_WHILE_BUSY;
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto pltfm_free;
-- 
2.20.1

