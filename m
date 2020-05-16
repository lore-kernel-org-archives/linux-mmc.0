Return-Path: <SRS0=UNP7=66=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE1C433DF
	for <linux-mmc@archiver.kernel.org>; Sat, 16 May 2020 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F9E20756
	for <linux-mmc@archiver.kernel.org>; Sat, 16 May 2020 15:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e21cNtvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgEPPoV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 16 May 2020 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgEPPoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 May 2020 11:44:21 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB58C061A0C;
        Sat, 16 May 2020 08:44:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id e125so3556484lfd.1;
        Sat, 16 May 2020 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/VX1vyjPaZkfuYoHi0upfiopwVhKsLaoMAnz354uIg=;
        b=e21cNtvcbU9P2bVOYcM0XDuiUivXQQzLsTpXzYYxIaoehSCHurHfJOJpaitIaVLIRR
         hq3nIN0eCqTI2ngL/OS4FNmXTEHRvDuCLuU9P0FcmW5cTS6rPf0IOHdbmKAdHyixOLcQ
         4tcQvaNEF3noc5bh+KDSSGmlT7JEb5Uo7g2ST6mXkQPQ1q6pX/bJfjLAOeIMaqupUl4g
         gF8sNbe2/rixQ9tNSR6Ia0PptW7K+HMRlM6Cd3aQDPBMa0k6/jtWZGVvMZ2PgMQbYGrc
         /jXetNJiuE1cHqSyVZ2+Yvj3Q2x4aX5ZcREANi2TMuZWztanfSWT23dxZmebeoAxF3eY
         RvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/VX1vyjPaZkfuYoHi0upfiopwVhKsLaoMAnz354uIg=;
        b=Ud9JD+GH0IKbuR+9hwA0vtg85/Le51cwdas+qbDIAIMxSAwH5iSsBhBg7g4//StahD
         DcZZyq9gj8AZLlqBA59F235PY739Ub9htgj+wqPffdgDd6XA+O4hjZgcgL8f5l4V+9EW
         /njTa/HSjPo5tg44XxENfP16FhMnDYDG1orR6TWce0ESj3qOZFBAA4ty15eohtCMW4ys
         /BW9vY+bYwVSjyI0OPPLHFb7lrN8qu5MXTV4LVL55lNo2BerrYxJbKi0gH93EKlFMAbO
         pJyYWp8r44hHnmkV7exkFmDBo2rEo6W/wwREonNdRAmAnExTj9eDU7cqHOu858kuxTZC
         Cigw==
X-Gm-Message-State: AOAM5319Qb9oWNV3WeN54QIiAOquDO04a5Q7lVqUCrq86A8Lqvl2/3Oc
        tEUaSKl/X+jpkO3KmrRz3Mg=
X-Google-Smtp-Source: ABdhPJw4/hyk4jMm+lUZN4PMDAtHP6vSDhQO/jmufuSCzzNnE1IBgC5QfaLZXm/AHPShBxx3ZTuaHQ==
X-Received: by 2002:a05:6512:44e:: with SMTP id y14mr5963865lfk.190.1589643859115;
        Sat, 16 May 2020 08:44:19 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id h3sm3399288lfk.3.2020.05.16.08.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 08:44:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] sdhci: tegra: Remove warnings about missing device-tree properties
Date:   Sat, 16 May 2020 18:43:14 +0300
Message-Id: <20200516154314.14769-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Several people asked me about the MMC warnings in the KMSG log and
I had to tell to ignore them because these warning are irrelevant to
pre-Tegra210 SoCs. It should be up to a board's device-tree writer to
properly describe all the necessary properties. Secondly, eventually all
device-tree bindings will be converted to YAML, which allows to validate
board DT files, giving a warning about missing properties. Hence let's
remove the noisy warnings to stop the confusion.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 3e2c5101291d..83867629013d 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -607,46 +607,26 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-up-offset-3v3-timeout",
 			&autocal->pull_up_3v3_timeout);
-	if (err) {
-		if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
-			(tegra_host->pinctrl_state_3v3_drv == NULL))
-			pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
-				mmc_hostname(host->mmc));
+	if (err)
 		autocal->pull_up_3v3_timeout = 0;
-	}
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-down-offset-3v3-timeout",
 			&autocal->pull_down_3v3_timeout);
-	if (err) {
-		if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
-			(tegra_host->pinctrl_state_3v3_drv == NULL))
-			pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
-				mmc_hostname(host->mmc));
+	if (err)
 		autocal->pull_down_3v3_timeout = 0;
-	}
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-up-offset-1v8-timeout",
 			&autocal->pull_up_1v8_timeout);
-	if (err) {
-		if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
-			(tegra_host->pinctrl_state_1v8_drv == NULL))
-			pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
-				mmc_hostname(host->mmc));
+	if (err)
 		autocal->pull_up_1v8_timeout = 0;
-	}
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-down-offset-1v8-timeout",
 			&autocal->pull_down_1v8_timeout);
-	if (err) {
-		if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
-			(tegra_host->pinctrl_state_1v8_drv == NULL))
-			pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
-				mmc_hostname(host->mmc));
+	if (err)
 		autocal->pull_down_1v8_timeout = 0;
-	}
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-up-offset-sdr104",
-- 
2.26.0

