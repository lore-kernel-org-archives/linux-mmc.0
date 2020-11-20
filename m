Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87256C56201
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 16:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3303F22269
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 16:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTqQL3vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgKTQXv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 11:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbgKTQXv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Nov 2020 11:23:51 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E556B22269;
        Fri, 20 Nov 2020 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889431;
        bh=aSF6SATY94f3SCCfihTWZ93+pWsbZlyve0AT/9JM6Z0=;
        h=From:To:Cc:Subject:Date:From;
        b=qTqQL3vbAEjG8Kws/X5afIQvgWuOZxzorslh51q/1/MPxbh9/brWBGMP/G1CaSbY/
         0f5FdgV2lvlNj/3/R1Ei0KBEj9K47VjsFMMALHjq4qZr8wYDuSMnFcbNetVUk7Y+9f
         Xb/7kFppSxglRNaRkTYyM6iLsrxggW3vWtuZRonc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] mmc: sdhci-sprd: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:23:43 +0100
Message-Id: <20201120162344.485921-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

    drivers/mmc/host/sdhci-sprd.c:723:34: warning:
        ‘sdhci_sprd_of_match’ defined but not used [-Wunused-const-variable=]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 58109c5b53e2..f85171edabeb 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -788,7 +788,7 @@ static struct platform_driver sdhci_sprd_driver = {
 	.driver = {
 		.name = "sdhci_sprd_r11",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = of_match_ptr(sdhci_sprd_of_match),
+		.of_match_table = sdhci_sprd_of_match,
 		.pm = &sdhci_sprd_pm_ops,
 	},
 };
-- 
2.25.1

