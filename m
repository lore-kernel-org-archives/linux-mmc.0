Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106A4C2D0C0
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D562C24655
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Jc0fYGq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLQCwr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:52:47 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:46181 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbfLQCwr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 21:52:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551167; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=+4mjFn/hXObLLJ1qaBB7b5rDk/LP/QYenFnaWmI9FAw=; b=Jc0fYGq+5vLO+H/ril1ZL/kzrFYLOPzFX8tIB1CXBbPE1TseAuI9rbaA8BNQ7onY+kYLSluK
 zTV9EfHOMSxG0Kq39VQZNhq74sv8+GMTj68zjt89Ufn+m/cnRqb3wtbDVeiQZRfB41KS9Hzr
 4zSTd2Orb4XnuSd2s/WFGfRC/k8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842fe.7f93b36aee68-smtp-out-n02;
 Tue, 17 Dec 2019 02:52:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71212C447A0; Tue, 17 Dec 2019 02:52:46 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63E0AC43383;
        Tue, 17 Dec 2019 02:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63E0AC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 8/9] mmc: core: remove shutdown handler
Date:   Mon, 16 Dec 2019 18:50:41 -0800
Message-Id: <a261a89b6c087404127900c6b0b6ee95442a37c3.1576540908.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

If mmc/sd shutdown callback suspends the card when card's runtime PM status
is still set to "runtime active" then any request issued after mmc/sd
shutdown will not resume the card hence we will end up issuing the request
to host driver while card isn't in a state to handle it.

Right way to fix this issue is not to allow any requests to flow in after
the shutdown callback has executed. Until it is fixed in the right way, we
are disabling the shutdown handling as it anyways doesn't do real useful
things.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/mmc/core/mmc.c | 22 ----------------------
 drivers/mmc/core/sd.c  |  1 -
 2 files changed, 23 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f6912de..a5110f7 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2080,27 +2080,6 @@ static int _mmc_resume(struct mmc_host *host)
 }
 
 /*
- * Shutdown callback
- */
-static int mmc_shutdown(struct mmc_host *host)
-{
-	int err = 0;
-
-	/*
-	 * In a specific case for poweroff notify, we need to resume the card
-	 * before we can shutdown it properly.
-	 */
-	if (mmc_can_poweroff_notify(host->card) &&
-		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
-		err = _mmc_resume(host);
-
-	if (!err)
-		err = _mmc_suspend(host, false);
-
-	return err;
-}
-
-/*
  * Callback for resume.
  */
 static int mmc_resume(struct mmc_host *host)
@@ -2185,7 +2164,6 @@ static int _mmc_hw_reset(struct mmc_host *host)
 	.runtime_suspend = mmc_runtime_suspend,
 	.runtime_resume = mmc_runtime_resume,
 	.alive = mmc_alive,
-	.shutdown = mmc_shutdown,
 	.hw_reset = _mmc_hw_reset,
 };
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index fe914ff..5938caf 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1259,7 +1259,6 @@ static int mmc_sd_hw_reset(struct mmc_host *host)
 	.suspend = mmc_sd_suspend,
 	.resume = mmc_sd_resume,
 	.alive = mmc_sd_alive,
-	.shutdown = mmc_sd_suspend,
 	.hw_reset = mmc_sd_hw_reset,
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
