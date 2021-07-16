Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F39C07E95
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jul 2021 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BBD613F7
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jul 2021 14:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhGPOG1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:06:27 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:31205 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGPOG1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jul 2021 10:06:27 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Jul 2021 07:03:31 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Jul 2021 07:03:29 -0700
X-QCInternal: smtphost
Received: from minint-dvc2thc.qualcomm.com (HELO sartgarg-linux.qualcomm.com) ([10.206.24.245])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 Jul 2021 19:33:07 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id D137034DF; Fri, 16 Jul 2021 19:33:05 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     stummala@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>
Subject: [PATCH V1 0/2] Introduce max_timeout_count in sdhci_host for vendor needs
Date:   Fri, 16 Jul 2021 19:33:00 +0530
Message-Id: <1626444182-2187-1-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Introduce max_timeout_count in sdhci_host_struct to let vendor's modify
the max timeout value as per their needs.

Sarthak Garg (2):
  mmc: sdhci: Introduce max_timeout_count variable in sdhci_host
  mmc: sdhci-msm: Use maximum possible data timeout value

 drivers/mmc/host/sdhci-msm.c |  3 +++
 drivers/mmc/host/sdhci.c     | 15 +++++++++------
 drivers/mmc/host/sdhci.h     |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.7.4

