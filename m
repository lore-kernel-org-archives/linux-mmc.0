Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8BC6379D
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 16:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47EA22269
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 16:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2oFen2HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgKTQXy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 11:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbgKTQXx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Nov 2020 11:23:53 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC882245F;
        Fri, 20 Nov 2020 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889433;
        bh=GJfKj0+znNqvKhf1I7W33R1RdCE9XjaBwdh/slqRzUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2oFen2HULEQMcQhwW6Rn2nvYN0TOq1V+4mSVP47yjglwV2jTjWAKVmsjJqstnvdUu
         96RR3jDpHNMoTPvOzxutW/1cbY59Cb1XhM+c4U/rZpC0uPaDFs+T2VpMjv8WX0R6W3
         kMx8wv7KdQE0Nr364l8wZ939p6AUVpW3otCTyiAc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] mmc: sdhci-st: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:23:44 +0100
Message-Id: <20201120162344.485921-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120162344.485921-1-krzk@kernel.org>
References: <20201120162344.485921-1-krzk@kernel.org>
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

    drivers/mmc/host/sdhci-st.c:512:34: warning:
        ‘st_sdhci_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 4e9ff3e828ba..962872aec164 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -523,7 +523,7 @@ static struct platform_driver sdhci_st_driver = {
 		   .name = "sdhci-st",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		   .pm = &sdhci_st_pmops,
-		   .of_match_table = of_match_ptr(st_sdhci_match),
+		   .of_match_table = st_sdhci_match,
 		  },
 };
 
-- 
2.25.1

