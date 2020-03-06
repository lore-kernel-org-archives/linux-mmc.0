Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5193C3F2CD
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 04:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC1120848
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 04:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YvBZ1kWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCFE7Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:59:24 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:55349 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgCFE7Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 23:59:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583470763; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=WZi02PQIcWxOofn2zJpdxNdKBMBRPTUWVVvGceBRIeg=; b=YvBZ1kWX3qDzlSMhupIvKgTnAbVmds1iEyI9Pa6kdyBEkNqgEYRRDYfU7jCfaHvjxu4aXSrW
 24RHDuNVZ7yVcpWKAfNYKs3tF6+9FnpxPi2nVsmOVEBwpXNex97obxCi6qqAAN/IeL9QGgom
 tA9jeRN1mKRNULgG07UzVwLsMAs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e61d8a9.7f27aa2a0d50-smtp-out-n03;
 Fri, 06 Mar 2020 04:59:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0BD5AC4479D; Fri,  6 Mar 2020 04:59:20 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59053C447A0;
        Fri,  6 Mar 2020 04:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59053C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, asutoshd@codeaurora.org,
        cang@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Murali Palnati <palnatim@codeaurora.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [PATCH v2 2/4] mmc: core: Attribute the IO wait time properly in mmc_wait_for_req_done()
Date:   Thu,  5 Mar 2020 20:58:16 -0800
Message-Id: <cdcb59cbadcebbe3186a6f6d9ef401e45e6f7919.1583470026.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583470026.git.nguyenb@codeaurora.org>
References: <cover.1583470026.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1583470026.git.nguyenb@codeaurora.org>
References: <cover.1583470026.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

In mmc_wait_for_req_done() function, change the call wait_for_completion()
to wait_for_compltion_io(). This change makes the kernel account for
wait time as I/O wait and through another configuration, this io wait
is treated as busy which makes the acpu clock to scale up.

Signed-off-by: Murali Palnati <palnatim@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 94441a0..97a384a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -399,7 +399,7 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 	struct mmc_command *cmd;
 
 	while (1) {
-		wait_for_completion(&mrq->completion);
+		wait_for_completion_io(&mrq->completion);
 
 		cmd = mrq->cmd;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
