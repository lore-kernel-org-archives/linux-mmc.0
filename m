Return-Path: <SRS0=xqUN=54=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3EC2BBC7
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 16:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA66020708
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 16:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OWCrSURB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDLQAO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgDLQAG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Apr 2020 12:00:06 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 12:00:06 EDT
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info [104.130.122.26])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 67B1DC0A3BF0
        for <linux-mmc@vger.kernel.org>; Sun, 12 Apr 2020 08:54:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586706851; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=JNwr0CYpXlkkkH3QmBGoB9z4dUS/S2kpKt/5/ceO538=; b=OWCrSURBFUEutljmJJacKXblDfkoMZHI0t4Xpw+i96zm+y4VbGgvy2DooJEP6JefZdO8IhQ8
 MReDi+H/d+C832UE9+Dd3PdG0g9SR74qB0AlPe03ru+14b+o003WwvoIt8FY8vFKOev9HmCJ
 z4NQ+PiHs404UfNc6iHffCdtIb8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e93399a.7ff158e6bd88-smtp-out-n02;
 Sun, 12 Apr 2020 15:54:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A268C43636; Sun, 12 Apr 2020 15:54:01 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 305C7C433CB;
        Sun, 12 Apr 2020 15:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 305C7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V1 0/4] Minor fixes to sdhci-msm 
Date:   Sun, 12 Apr 2020 21:23:24 +0530
Message-Id: <1586706808-27337-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable a couple of CAPS that qcom sd host controller supports.
Set a quirk for enabling support for auto cmd12.
And enable adma length mismatch error interrupt.

Veerabhadrarao Badiganti (4):
  mmc: sdhci-msm: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
  mmc: sdhci-msm: Enable MMC_CAP_NEED_RSP_BUSY host capability
  mmc: sdhci-msm: Set SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
  mmc: sdhci-msm: Enable ADMA length mismatch error interrupt

 drivers/mmc/host/sdhci-msm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
