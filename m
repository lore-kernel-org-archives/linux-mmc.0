Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F40C4338F
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 06:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2735611C6
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 06:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhHFGw4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:52:56 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:62210 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhHFGw4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 02:52:56 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 05 Aug 2021 23:52:40 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Aug 2021 23:52:38 -0700
X-QCInternal: smtphost
Received: from sartgarg-linux.qualcomm.com ([10.206.24.245])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Aug 2021 12:22:14 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id 20D6B34DF; Fri,  6 Aug 2021 12:22:13 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>
Subject: [PATCH V3 0/2] Introduce max_timeout_count in sdhci_host for vendor
Date:   Fri,  6 Aug 2021 12:21:53 +0530
Message-Id: <1628232715-24089-1-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627534001-17256-2-git-send-email-sartgarg@codeaurora.org>
References: <1627534001-17256-2-git-send-email-sartgarg@codeaurora.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Introduce max_timeout_count in sdhci_host_struct to let vendor's modify
the max timeout value as per their needs.

Sahitya Tummala (1):
  mmc: sdhci-msm: Use maximum possible data timeout value

Sarthak Garg (1):
  mmc: sdhci: Introduce max_timeout_count variable in sdhci_host

 drivers/mmc/host/sdhci-msm.c |  3 +++
 drivers/mmc/host/sdhci.c     | 16 +++++++++-------
 drivers/mmc/host/sdhci.h     |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.7.4

