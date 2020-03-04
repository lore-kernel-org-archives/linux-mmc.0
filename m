Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE9BC3F2CD
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 12:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2092146E
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 12:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cdDjRH1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgCDMC3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:02:29 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:15492 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728953AbgCDMC2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 07:02:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583323348; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=QQMqqVpMxz0yPIDUvYKvdpvB8rCWfWZiR2iKnS4Bka8=; b=cdDjRH1zSr+/f58yDrphOK1qyiXn6KyDBn6aLnCktPpBLtDNKYk1Wq0fa7/C9vikDvOEhmGW
 wd/1uMYl8CDFwojAKCYo/DKQaJjDPAbjaqPieg6wEs/cpr5/9DWum7U4whSyoXzKmo0cygCA
 rfV4HyyOP7QhYC8rdEzAJlSnuhk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5f9895.7fb806279500-smtp-out-n03;
 Wed, 04 Mar 2020 12:01:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DCCE2C447A3; Wed,  4 Mar 2020 12:01:25 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06D27C43383;
        Wed,  4 Mar 2020 12:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06D27C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dianders@google.com,
        mka@chromium.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: [PATCH] mmc: cqhci: Update cqhci memory ioresource name
Date:   Wed,  4 Mar 2020 17:30:49 +0530
Message-Id: <1583323250-23596-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Update cqhci memory ioresource name from cqhci_mem to cqhci since
suffix _mem is redundant.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
Corresponding binding change:
https://lore.kernel.org/linux-arm-msm/1582545470-11530-1-git-send-email-vbadigan@codeaurora.org/
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index e2ea2c4..e24b8ff 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -1077,7 +1077,7 @@ struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev)
 
 	/* check and setup CMDQ interface */
 	cqhci_memres = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "cqhci_mem");
+						   "cqhci");
 	if (!cqhci_memres) {
 		dev_dbg(&pdev->dev, "CMDQ not supported\n");
 		return ERR_PTR(-EINVAL);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
