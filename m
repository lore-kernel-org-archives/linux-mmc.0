Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF66C2D0A3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3BA22280
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604421053;
	bh=dhY+aUcvUDnN3GOi7rmB6auRLoyv4aZXRn9dLCqmgEA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1GZEEyy3dlKr6AYQm4Xd41LLpEW5sgaWz7eYgC4adZT7c8VVMPYnNY0sNiJJiI5Ie
	 b4L8YGD10iVZcQzgs1+lqHImpHec9Fqf6W4oKRZH5WgnL5bFQ27cYuCMc/3DZ3J8r1
	 fgIJi7Z82pJWTN7WClcvH4Gm+Ebhi1t9zMoDDdLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgKCQaw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgKCQaw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Nov 2020 11:30:52 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6493206DF;
        Tue,  3 Nov 2020 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604421051;
        bh=dhY+aUcvUDnN3GOi7rmB6auRLoyv4aZXRn9dLCqmgEA=;
        h=From:To:Cc:Subject:Date:From;
        b=yt4jWbWzqlEY2R57hS3hfeYtDyOOfnCziXVs6pcJPBQIPh+Pu6t/qF6HiCY5NfNGI
         Ykp8dYVQTd23SRWHrIVyf/Dq/w8SgXs71oqeHLQ6teu9q1fN/dxiPJMf3EDM4RJagi
         uCa9Si6/FWe6WiZdwg6TDuEIew1gzziJbdQ5A2yo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: meson-gx: drop of_match_ptr from of_device_id table
Date:   Tue,  3 Nov 2020 17:30:46 +0100
Message-Id: <20201103163046.14336-1-krzk@kernel.org>
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
compile warning (!CONFIG_OF && !CONFIG_MODULES):

    drivers/mmc/host/meson-gx-mmc.c:1252:34: warning:
        ‘meson_mmc_of_match’ defined but not used [-Wunused-const-variable=]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 4ec41579940a..13f6a2c0ed04 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1265,7 +1265,7 @@ static struct platform_driver meson_mmc_driver = {
 	.driver		= {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = of_match_ptr(meson_mmc_of_match),
+		.of_match_table = meson_mmc_of_match,
 	},
 };
 
-- 
2.25.1

