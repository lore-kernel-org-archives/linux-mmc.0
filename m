Return-Path: <SRS0=tofm=6M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531FFC83000
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 13:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6362075E
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 13:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ixcsAeiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgD1NjX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:39:23 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:41563 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727929AbgD1NjW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Apr 2020 09:39:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588081161; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=CvpLVa06yFg5wgGbRaG4LkdcE+qvF5aIGEckfYVHqJk=; b=ixcsAeiMK2HkDdOlUJDoLKFdJGGlUQ+IHoVLbimbhyhDgoWVsENQUEs4ICyvb0c5GxjJQXfy
 Qvsw8NjhTokVMGVV4AZ4Ajww0OhZFFpMkyKJnp5X2VoywxbzB62lCobZbB4tqKDQFgw5unXQ
 GDYVPO6TUgtJGo5YUPPHSsFcpac=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea83205.7f707e5a3dc0-smtp-out-n01;
 Tue, 28 Apr 2020 13:39:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4CD9C072B7; Tue, 28 Apr 2020 13:39:16 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A8FBC44798;
        Tue, 28 Apr 2020 13:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A8FBC44798
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        linux-mmc@vger.kernel.org
Subject: [PATCH v3 09/17] mmc: sdhci-msm: Fix error handling for dev_pm_opp_of_add_table()
Date:   Tue, 28 Apr 2020 19:02:57 +0530
Message-Id: <1588080785-6812-10-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Even though specifying OPP's in device tree is optional, ignoring all errors
reported by dev_pm_opp_of_add_table() means we can't distinguish between a
missing OPP table and a wrong/buggy OPP table. While missing OPP table
(dev_pm_opp_of_add_table() returns a -ENODEV in such case) can be ignored,
a wrong/buggy OPP table in device tree should make the driver error out.

while we fix that, lets also fix the variable names for opp/opp_table to
avoid confusion and name them opp_table/has_opp_table instead.

Suggested-by: Matthias Kaehlcke <matthias@chromium.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pradeep P V K <ppvk@codeaurora.org>
Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/sdhci-msm.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8a055dd..97758fa 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -244,8 +244,8 @@ struct sdhci_msm_host {
 	struct clk_bulk_data bulk_clks[4]; /* core, iface, cal, sleep clocks */
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
-	struct opp_table *opp;
-	bool opp_table;
+	struct opp_table *opp_table;
+	bool has_opp_table;
 	bool use_14lpp_dll_reset;
 	bool tuning_done;
 	bool calibration_done;
@@ -1967,15 +1967,20 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	}
 	msm_host->bulk_clks[0].clk = clk;
 
-	msm_host->opp = dev_pm_opp_set_clkname(&pdev->dev, "core");
-	if (IS_ERR(msm_host->opp)) {
-		ret = PTR_ERR(msm_host->opp);
+	msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
+	if (IS_ERR(msm_host->opp_table)) {
+		ret = PTR_ERR(msm_host->opp_table);
 		goto bus_clk_disable;
 	}
 
 	/* OPP table is optional */
-	if (!dev_pm_opp_of_add_table(&pdev->dev))
-		msm_host->opp_table = true;
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (!ret) {
+		msm_host->has_opp_table = true;
+	} else if (ret != -ENODEV) {
+		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
+		goto opp_cleanup;
+	}
 
 	/* Vote for maximum clock rate for maximum performance */
 	ret = dev_pm_opp_set_rate(&pdev->dev, INT_MAX);
@@ -2133,9 +2138,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 opp_cleanup:
-	if (msm_host->opp_table)
+	if (msm_host->has_opp_table)
 		dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(msm_host->opp);
+	dev_pm_opp_put_clkname(msm_host->opp_table);
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
@@ -2154,9 +2159,9 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	if (msm_host->opp_table)
+	if (msm_host->has_opp_table)
 		dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(msm_host->opp);
+	dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
