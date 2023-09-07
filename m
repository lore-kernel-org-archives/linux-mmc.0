Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68488EC8743
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Sep 2023 17:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbjIGRJL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbjIGRJK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Sep 2023 13:09:10 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1851BDA
        for <linux-mmc@vger.kernel.org>; Thu,  7 Sep 2023 10:08:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so21366001fa.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 Sep 2023 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694106459; x=1694711259; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFwKknQkIgVeziygM7f8fcopzSN1Ty3LUsYRVOQc1fo=;
        b=RT/0ZAH/9BfgYRRXvhg42BIfsa3zFjIBLAnWKkUCYFZRbgydSYpDOTVjrILkF3UjmH
         BaRaonHy4wmRf4b7KbCvl/5d1Zl8OozIbNHix6qRh8o2AFjuJWDF7hbQNKTLYDhmUXDJ
         x1ZnB7MzqlqME+jjOgbrQIeaOOrrdtUiSDz9w2+QCPcASHBBUAYrCHrj48TPLD0pzTdd
         H2G5IhxXdvbGseCLb9eKVCVSBBjMMWeXI61w1pJVY20ytJnfAWJBqjx4KFdWKLxZBhxY
         BYnlwM15pW1Qv3cBKuG1XieHnWUg1SDDVcU2XgIRiZ8kXqFXZ8+zjJYRUWacG3uUuRW8
         WKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694106459; x=1694711259;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFwKknQkIgVeziygM7f8fcopzSN1Ty3LUsYRVOQc1fo=;
        b=Au8rsk4bat+s8g8ZMw21R3OoW/Yq0sY0RzQABOsAOkHXz289/6xQbIL2rA0HXBA4F4
         dz6oJKr34s7O0CDLB3YVn3grbiTBwoQp6kf/q6gp3sHkUAogvNxFzd4dZw96Rpc6Ud/8
         A3DeRASR0wwo4SZOfyoWb1OsDDuDRJXtiIkWU71sdliRTIs1I6hKY87pbWrL1QzI1DbV
         2cjliilERHqo45nyyaOm604n7zKCf9oGyppwXbrTSh2alIPRIJ7KcrWVYDulhy+V8HHX
         1D4wgocutyWtegX3woOtprwdhDcmDxpCAKv8rcW3VOzfxGjbZ5f0SROOmsnqrl8Oy9Nr
         Pf/g==
X-Gm-Message-State: AOJu0Yzyo3n6zX4+YJQJiDUdksaXPSgJlpzi7aaQ5oDEBVm1vrc/uo3c
        Fhos0xlsh/bsZiS8CbRF5weFezUXSzNFSrjG5XE=
X-Google-Smtp-Source: AGHT+IH7LwAYk5bN2j2hB6H8pGnORfTqQHKJiXsJKF10TLPkNCZgbFLJyTMJUh+jPrwUJvfzZm7QFQ==
X-Received: by 2002:a7b:ce91:0:b0:3fe:4900:db95 with SMTP id q17-20020a7bce91000000b003fe4900db95mr4383812wmj.37.1694080494181;
        Thu, 07 Sep 2023 02:54:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b004013797efb6sm2128337wms.9.2023.09.07.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:54:53 -0700 (PDT)
Date:   Thu, 7 Sep 2023 12:54:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mmc: sdhci-sprd: Fix error code in sdhci_sprd_tuning()
Message-ID: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Return an error code if sdhci_sprd_get_best_clk_sample() fails.
Currently, it returns success.

Fixes: d83d251bf3c2 ("mmc: sdhci-sprd: Add SD HS mode online tuning")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is from static analysis and has not been tested.
---
 drivers/mmc/host/sdhci-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 649ae075e229..6b84ba27e6ab 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -644,6 +644,7 @@ static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *card,
 	best_clk_sample = sdhci_sprd_get_best_clk_sample(mmc, value);
 	if (best_clk_sample < 0) {
 		dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n");
+		err = best_clk_sample;
 		goto out;
 	}
 
-- 
2.39.2

