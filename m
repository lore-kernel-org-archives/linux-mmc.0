Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03832C433E1
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 15:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDA72177B
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 15:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BkSNnJtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgH0Pdm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Pdl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2020 11:33:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97B8C061264
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 08:33:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t185so3776506pfd.13
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLogCY9snthkks89Ea8CnKQB+BmwpQEsk4ur1DM2HdU=;
        b=BkSNnJtZWr1nebAVtZFleChfEIZX1Ul2Ahd6LQna22QOuwjvS4znFuCi9Rk5uCwoAo
         wsweWskmO00ZS9A+jlYlaoiiuhf1RG6P3uYkNM+xWSd6b++ZfHGc5fkClqFv1mH8aEUK
         nlb5HA7p159z1jRabNuNV/qxS6WRAP55aadI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLogCY9snthkks89Ea8CnKQB+BmwpQEsk4ur1DM2HdU=;
        b=NbgQsnluh+2gBiQgbiMdizPl0sh7kfv29UUilAU4Bmtb1ybVE9c0NsAB8smMfSApnt
         Y6PnYiGnFI3yK3rRX9HtWqwDdju2B5mcE/7Es/vKOrVIhttFPY4Gm/JaYAQdACrp53yr
         A7hwtOcs2bcIPpkbfe80BROn548yb3XcgYfODxYbv2POgDlpcHG1Vs15xtkkpKvZ849Z
         enCKSlpSZFSSrBQ5V5QARMKS6x/Ufw9oSsCZHyUbLmI3XdAlzT4SvZvM1beC3+6axJw+
         nXJkcK+gwsfOL1BgcgKGAUAO9ZAL2+Rr8bROcdPUZXBrgF69EUPmUBVN2/a199FdbW8r
         QtLg==
X-Gm-Message-State: AOAM532D8HmVBn19ShE6X59GxZKRIUBpDqQwIf4E35mHQyzqQ8fSxB8M
        fA9kDjL71CUZVKR4WYUZ8ztJ3Q==
X-Google-Smtp-Source: ABdhPJwbYpqy+gzLGlY7DU9mHynPfbjLpramh455uzAwuYGrfuMQFSgWKylzRDRhuQdd5ch+5tlRkg==
X-Received: by 2002:a65:52c5:: with SMTP id z5mr15387187pgp.105.1598542419246;
        Thu, 27 Aug 2020 08:33:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id y7sm3192105pfm.68.2020.08.27.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:33:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     arnd@arndb.de, naresh.kamboju@linaro.org, vbadigan@codeaurora.org,
        rnayak@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-msm: When dev_pm_opp_of_add_table() returns 0 it's not an error
Date:   Thu, 27 Aug 2020 08:33:34 -0700
Message-Id: <20200827083330.1.I669bb4dc3d92bd04e9a695f97904797dc8241b79@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The commit d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call
dev_pm_opp_of_remove_table()") works fine in the case where there is
no OPP table.  However, if there is an OPP table then
dev_pm_opp_of_add_table() will return 0.  Since 0 != -ENODEV then the
"if (ret != -ENODEV)" will evaluate to true and we'll fall into the
error case.  Oops.

Let's fix this.

Fixes: d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b7e47107a31a..55101dba42bd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2284,7 +2284,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (ret != -ENODEV) {
+	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
 		goto opp_cleanup;
 	}
-- 
2.28.0.297.g1956fa8f8d-goog

