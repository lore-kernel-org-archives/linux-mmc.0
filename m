Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0D4C433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 20:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBA5207EA
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 20:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599079749;
	bh=s+F12H96PgtRNsd1OHfWDfQQChwh5OhgEc9C9LdXm9Y=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aD4oj8pLLKIhuT07SZvhgRvjyMGLwjI0UI4dDA9/HXxyYaeC6/1UhE8KNmyjJjRC4
	 xsQuD3sEukza1rpxZVGM44BrLvSMxM0VnjH/mz6VoFmGgg0GJCZSfrW3FX0sEGuxyz
	 fRKDaievJkg5/22ppvxwXIwe8yaJCDGtOef543P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIBUtH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgIBUtC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 16:49:02 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAC5208C7;
        Wed,  2 Sep 2020 20:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599079742;
        bh=s+F12H96PgtRNsd1OHfWDfQQChwh5OhgEc9C9LdXm9Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X5jBvMBSiU0fnDH4PWicRH3OqFscHWmjwayDx66UpI40A/o8ofDnneqY9E2Wc0NLo
         zDSTOqsxYqszZ5pUR8x6Sc+fK3JyQo5k0HRNxyPSYPg1RWRmzOGtiZdsotBi/zlgYy
         t4Qkj0Bans2B565n+00hI6Eeq/7D8qFNiC4PCGZM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] mmc: s3cmci: Cast driver data through long
Date:   Wed,  2 Sep 2020 22:48:47 +0200
Message-Id: <20200902204847.2764-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902204847.2764-1-krzk@kernel.org>
References: <20200902204847.2764-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since driver data is a pointer, direct casting to integer causes
warning when compile testing for 64-bit architecture:

  drivers/mmc/host/s3cmci.c:1495:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

The actual driver data can be only 0 or 1, so cast it via long and do
not care about any loss of value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/s3cmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 3fb597095079..ac94f926624d 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1492,7 +1492,7 @@ static int s3cmci_probe_dt(struct s3cmci_host *host)
 	struct mmc_host *mmc = host->mmc;
 	int ret;
 
-	host->is2440 = (int) of_device_get_match_data(&pdev->dev);
+	host->is2440 = (long) of_device_get_match_data(&pdev->dev);
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.17.1

