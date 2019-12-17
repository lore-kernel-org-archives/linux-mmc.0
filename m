Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D942C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E89A206D3
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kLshkbie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfLQCwe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:52:34 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:46181 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfLQCwd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 21:52:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551153; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=ga4CL8oGqhYMCX/pJoNEL8bDtLlDEhOXVO1r46JdqYQ=; b=kLshkbie3+k9gAJhjw6zWOUWy+AwxCx+zrwajZkkVc72m19tqRczR/h731sZu09s0HKYTR48
 RISR0eaRSVOhR9bGo3kuKfUSy5uK9dVUvlw9rFWdr7dMY81mJD6hEGE+9qALcBHHmxuUkT0j
 vUxPOac/d8bo5wD0iz0S2Myge7o=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842f0.7f94a45ce570-smtp-out-n01;
 Tue, 17 Dec 2019 02:52:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0FA12C4479C; Tue, 17 Dec 2019 02:52:32 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BCDFC433A2;
        Tue, 17 Dec 2019 02:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BCDFC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Ziqi Chen <ziqichen@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 2/9] mmc: core: allow hosts to specify a large discard size
Date:   Mon, 16 Dec 2019 18:50:35 -0800
Message-Id: <2d5981ed379f29a4def9710b7401c4b1dbe4fa6a.1576540907.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ziqi Chen <ziqichen@codeaurora.org>

max_busy_timeout is used to decide whether R1B response should
be used or a R1 response should be used. This is also used to
decide what the discard size of mmc queue (registered with block
layer) can be set to. In order to keep both the features in place,
this change will allow for hosts to specify a larger discard size
while still specifying max_busy_timeout.

Signed-off-by: Ziqi Chen <ziqichen@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/mmc/core/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index abf8f5e..1e37f78 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2059,6 +2059,10 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 	struct mmc_host *host = card->host;
 	unsigned int max_discard, max_trim;
 
+	if (!host->max_busy_timeout ||
+			(host->caps2 & MMC_CAP2_MAX_DISCARD_SIZE))
+		return UINT_MAX;
+
 	/*
 	 * Without erase_group_def set, MMC erase timeout depends on clock
 	 * frequence which can change.  In that case, the best choice is
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
