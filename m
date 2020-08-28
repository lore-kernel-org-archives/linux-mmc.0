Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09B2C433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 06:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9652B20791
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 06:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHxrgc08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgH1GI5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgH1GI1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 02:08:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4422C061233
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 23:08:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so1425553plb.12
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1O4RY3xhuvkoEFzZpCQj6200V2Vqk24TL8ijKSG6Muc=;
        b=YHxrgc08UC1m38a1Dl9/EMqZvlm1VnCvNkcD5izm8rqm0YvG045fdqTeSSWU3zP84e
         BcHHK7aom3QnCZXtUYQLKNwtzO8Ep+4tdG162+rjOVRMJzAe9ar/ApD7pQMI2nyLOMUH
         VHxAUkL2Zi7UuCJwfo7ZzxrnFHu1NDpn9oVgClh9Tx+29Pdty6EV9otz6UhKGUR891SW
         wkvRExXAFgi7fFHZQNrEqAV0/zj9YKpaYfC9Dhuk56XSCOmiDcaepwAo98fzbxuDipUH
         6vj1UnT8LoXRzXROKT2eUIwLnX1yD4R4GhACqleeeiYO5gST/E+Tw2Aaja92+f/5DDMD
         pKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1O4RY3xhuvkoEFzZpCQj6200V2Vqk24TL8ijKSG6Muc=;
        b=NWEKXG+xgZUVAoVSU5ua9rVaSweVPDD9xg93peb9DFgtUcXet3Qj0bSMm5IYdewOcE
         M7BAoyVjwhVXF3LoYxnk2eslvpG999Reu2ejnw5y15S1XOWvcw7sQ1Mq5VFv1HOayZsI
         LujP47DmYh+rJABfJnX3+v2YJmVEQ2sdJ0c3z/ETIfv+77vW5pS5+VxYoOwrbCfSSe/y
         aAjccDBKwrvcVYp3IhUh3GO/cFHOvAsN2asUx0Icu/hlCYXGrN8GJhe1Gu2IqVFN2Wr1
         VDYkSeolbcC7RjdsLRcTUbeyKONVTOYprrPr0HFtL1FPyPomk0NZl3I/u7e9yBstDRl9
         wp0w==
X-Gm-Message-State: AOAM531mpXg5vi3CceZDjMhc5Qgi4xMkDnH5Xvt3us1L6rVQDmQPk8aD
        klc9W7t+q3gu5E4GnS2ahTsE0A==
X-Google-Smtp-Source: ABdhPJzzOn4s+bHlp/tecgCMbtWwHe8wbvcQ++dsCXro+voefVp33ciwr2Rsvu03Ia3822LnjIRAVw==
X-Received: by 2002:a17:902:76c3:: with SMTP id j3mr73551plt.227.1598594906914;
        Thu, 27 Aug 2020 23:08:26 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id d76sm169607pfd.63.2020.08.27.23.08.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 23:08:26 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Fri, 28 Aug 2020 11:37:49 +0530
Message-Id: <1d7c97524b9e1fbc60271d9c246c5461ca8a106c.1598594714.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598594714.git.viresh.kumar@linaro.org>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V2:
- Compare with -ENODEV only for failures.
- Create new label to put clkname.
---
 drivers/mmc/host/sdhci-msm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5a33389037cd..f7beaec6412e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -263,7 +263,6 @@ struct sdhci_msm_host {
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	struct opp_table *opp_table;
-	bool has_opp_table;
 	bool use_14lpp_dll_reset;
 	bool tuning_done;
 	bool calibration_done;
@@ -2285,11 +2284,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (!ret) {
-		msm_host->has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
-		goto opp_cleanup;
+		goto opp_put_clkname;
 	}
 
 	/* Vote for maximum clock rate for maximum performance */
@@ -2453,8 +2450,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 opp_cleanup:
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
+opp_put_clkname:
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
@@ -2474,8 +2471,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.0.rc1.19.g042ed3e048af

