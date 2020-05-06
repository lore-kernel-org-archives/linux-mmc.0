Return-Path: <SRS0=wp20=6U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E8C47256
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 14:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376EB20870
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 14:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="JmxkVvfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgEFOfC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 May 2020 10:35:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31972 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729041AbgEFOfB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2020 10:35:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588775701; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BxYWW/V07NnyjLGX0Gsq/lFAzNYmsfwcD2OCxNrEX1o=; b=JmxkVvfUWZ/uSQJsmiIqCo3c+k6Bjk59pEK0BRX13dPNAi5QcLebLf8HvEqtxmz1GvO285tv
 DrrjYqZkbB5IIf8qQODTSgofVFcKRogRIEozSHn01K2eI2gs17jWJrFqDKLKSJt3Z8BA7eD6
 gSeJ42ygE4lrFuKp3DXcnNkAwPU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb2cb01.7f3cb7d7fbc8-smtp-out-n05;
 Wed, 06 May 2020 14:34:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D32E9C43636; Wed,  6 May 2020 14:34:40 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D2E2C432C2;
        Wed,  6 May 2020 14:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D2E2C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     stummala@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V1 0/2] CQE fixes
Date:   Wed,  6 May 2020 20:04:01 +0530
Message-Id: <1588775643-18037-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixes for a couple of issues observed with CQE. One with CQE completion
path and the other one is with CQE recovery path.

Sarthak Garg (1):
  mmc: core: Fix recursive locking issue in CQE recovery path

Veerabhadrarao Badiganti (1):
  mmc: core: Check request type before completing the request

 drivers/mmc/core/block.c |  3 ++-
 drivers/mmc/core/queue.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
