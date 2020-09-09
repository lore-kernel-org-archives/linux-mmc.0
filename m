Return-Path: <SRS0=Un3z=CS=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3071C43461
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Sep 2020 16:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B9E21919
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Sep 2020 16:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5/6z0oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgIIQsg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbgIIQHj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2020 12:07:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F49C061368
        for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2020 07:12:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s65so1096098pgb.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2020 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEpsLMY/SzXPuKyd94ggDGQBM1KAJawGy/J+J7m+TbM=;
        b=x5/6z0oMFgBrDNTOE56l/HJqO2aTwjfjoshWHmkKERda91T4n+E4jltXDNGvp39j5m
         rhZJBpvky0khJwsP9tjvtfns5MaCTeqq//9eqwJ65H+KOW5edNOfJejeAmd0nbkPosam
         EGXc3U3xvAlN+UrjDnqy2CWOfK83GxFuXrLwsUyU/Du7Bjz0usbzz+PGvFjMumqUz44O
         3HqD2u2pM/vQ6gSW4R2b1XFoC3raAOYcQpqu5zvXgHSQY3/v+D42dFAeTgYZEH0N52Uq
         vvltyYvWZTOWzqaMHWPmST62gS5CurJ9d4o44UL+npL5lJBdyuqD6mMYdn41nBbVKbtF
         zuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEpsLMY/SzXPuKyd94ggDGQBM1KAJawGy/J+J7m+TbM=;
        b=ksr+2fy6shak1Xl6g+vnIQt1NQRaKHOVYE5M4wKwRLAnfNq2pHYM6HH+piBVeWqZrf
         cIB/ZeV8wkUkAvn9MPhYF+0x1Io0wcBTMUlc6jT7cHK7z3ZtBeMBA6dHpwLxFt7XpdGm
         EkwSnSUFoQygZLXe1Cp8A96/ahOezqZu148zD6srUTyh6RjQ1mvW1I6DL3/r9IgrFWX0
         3q6zrtzWgeQIQTMrGUwbpwE8Ig4u0niiEu1UdZhH8ObFFCtmANckYdfaF7y9hHjQ+MB9
         Cok+fBsVGz+kOGkQ28BpDoVdR2g1N17KlqoqDTtibDqT16j8DyhsU8ix6LHQBL8zW6Y2
         YW8A==
X-Gm-Message-State: AOAM5316SD+xXtrWPp6yTF+7n2h/F2xt1KfMFUrMoPOi0d+dKxubAHd6
        8iq9tAFZB1yZ81q+eXovMEmx+w==
X-Google-Smtp-Source: ABdhPJzO5eLyiP0IbrquTJ2zVRcTiM/Yj6JzZ0urfYY4aED3CS9F/9RjcGXeqX0eB5yE1hS7Ikupgg==
X-Received: by 2002:a63:64c2:: with SMTP id y185mr764751pgb.125.1599660723422;
        Wed, 09 Sep 2020 07:12:03 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id s20sm3003970pfu.112.2020.09.09.07.12.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:12:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        naresh.kamboju@linaro.org, anders.roxell@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 resend] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Wed,  9 Sep 2020 19:41:53 +0530
Message-Id: <890ae5601594fca5de104695a682f4b6efbc631b.1599660554.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
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
- Based on 5.9-rc4
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

