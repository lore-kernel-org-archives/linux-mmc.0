Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F10C3F68F
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 17:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CC82081E
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 17:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="F91F41bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgAPREH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:04:07 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:58583 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387667AbgAPREG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 12:04:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579194245; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jyDX0RkCRR3RXyVljn8CGp1pK1triQLesamc/wgsgLM=; b=F91F41bi6tDQ85feQfn1HvKPoczWeDUhoJrwCmNL/p7Y4b1+eFOYxUhwB4kh8bDB/gYf4o2y
 xMvTyL84BxvOk/3AisExkcg02YfgsADlApN+gBUCe4Bu0W0E/iHhJctslBiO4NMqcf1gjq2e
 dlWbYoU8faYjnuZYJ5IJrpmYYUk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e209783.7fe471b55a08-smtp-out-n02;
 Thu, 16 Jan 2020 17:04:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2885DC447AB; Thu, 16 Jan 2020 17:04:02 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E419C447A9;
        Thu, 16 Jan 2020 17:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E419C447A9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, cang@codeaurora.org,
        rampraka@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V2 0/2] Add CQHCI support for sdhci-msm
Date:   Thu, 16 Jan 2020 22:33:09 +0530
Message-Id: <1579194192-7942-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Changes since V1: (https://lkml.org/lkml/2019/12/17/455)
	- Select MMC_CQHCI in Kconfig
	- Making use of host->alloc_desc_size variable for allocation
	  of ADMA table and host->desc_size for updating decriptor
	  size dynamically.

Changes since RFC (https://lkml.org/lkml/2017/8/30/313)
	- Updated settings so that TDLBA won't get reset when
	  CQE is enabled.
	- Removed new compatible string and moved to supports-cqe
	  dt flag to identify CQE support.
	- Incorporated review comments.

Tested on: qcs404, sc7180

Ritesh Harjani (1):
  mmc: sdhci-msm: Add CQHCI support for sdhci-msm

Veerabhadrarao Badiganti (1):
  mmc: sdhci: Let a vendor driver supply and update ADMA descriptor size

 drivers/mmc/host/Kconfig     |   1 +
 drivers/mmc/host/sdhci-msm.c | 133 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c     |   7 ++-
 drivers/mmc/host/sdhci.h     |   1 +
 4 files changed, 139 insertions(+), 3 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
