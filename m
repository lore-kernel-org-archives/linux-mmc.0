Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F76AC433F5
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Sep 2021 23:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A3A61059
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Sep 2021 23:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhIKX3W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Sep 2021 19:29:22 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:56438 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231745AbhIKX3T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 11 Sep 2021 19:29:19 -0400
Received: from localhost.localdomain (ip-213-127-63-121.ip.prioritytelecom.net [213.127.63.121])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CDEF7CB0EB;
        Sat, 11 Sep 2021 23:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1631402884; bh=wNer6jHcAlMTCQrEt+Z/Z80KUeA53kL3zGKiA7X4cjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pFfaSY3uToNFIG352a3JWSqfZah0umgnY/lvwgqEg5N0OM6JbVKN+VAY54ZiQYnrC
         yAiXLbLT8WKkdAc2klIH+a6N0U4fGpuXbhzhahn7hKpuILgYthjVXNqPqjawJfiVRq
         0IspktjKNufnQU3CCXBbPw2rA2MX6iBXkEP8z4ZM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, bartosz.dudziak@snejp.pl,
        Luca Weiss <luca@z3ntu.xyz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: mmc: sdhci-msm: Add compatible string for msm8226
Date:   Sun, 12 Sep 2021 01:26:56 +0200
Message-Id: <20210911232707.259615-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911232707.259615-1-luca@z3ntu.xyz>
References: <20210911232707.259615-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add msm8226 SoC specific compatible strings for qcom-sdhci controller.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 365c3fc122ea..50841e2843fc 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -13,6 +13,7 @@ Required properties:
 		string is added to support this change - "qcom,sdhci-msm-v5".
 	full compatible strings with SoC and version:
 		"qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
+		"qcom,msm8226-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
-- 
2.33.0

