Return-Path: <SRS0=wp20=6U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD24C28CBC
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B4E20757
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 13:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgEFNwH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 May 2020 09:52:07 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:17634 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728712AbgEFNwH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2020 09:52:07 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 May 2020 19:20:40 +0530
Received: from minint-dvc2thc.qualcomm.com (HELO sartgarg-linux.qualcomm.com) ([10.206.24.245])
  by ironmsg01-blr.qualcomm.com with ESMTP; 06 May 2020 19:20:26 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id B68AE2654; Wed,  6 May 2020 19:20:25 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>
Subject: [PATCH V1 0/2] Introduce new quirk to use reserved timeout
Date:   Wed,  6 May 2020 19:14:29 +0530
Message-Id: <1588772671-19675-1-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Introduce a new quirk for letting vendor drivers to use reserved timeout
value (0xF) in timeout control register.

Sarthak Garg (2):
  mmc: sdhci: Introduce new quirk to use reserved timeout
  mmc: sdhci-msm: Use maximum possible data timeout value

 drivers/mmc/host/sdhci-msm.c | 3 ++-
 drivers/mmc/host/sdhci.c     | 3 ++-
 drivers/mmc/host/sdhci.h     | 5 +++++
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.7.4

