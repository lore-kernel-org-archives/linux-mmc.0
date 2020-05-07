Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03830C47247
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 08:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBED20753
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 08:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEGIC4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 04:02:56 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:9282 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgEGIC4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 04:02:56 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 May 2020 13:32:52 +0530
Received: from minint-dvc2thc.qualcomm.com (HELO sartgarg-linux.qualcomm.com) ([10.206.24.245])
  by ironmsg02-blr.qualcomm.com with ESMTP; 07 May 2020 13:32:38 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id 2D2C3261C; Thu,  7 May 2020 13:32:38 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>
Subject: [PATCH V1 0/7] Target specific DLL configuration for qcom SDHC
Date:   Thu,  7 May 2020 13:32:07 +0530
Message-Id: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sarthak Garg (6):
  dt-bindings: mmc: Add information for DLL register properties
  mmc: sdhci-msm: Update dll_config_3 as per HSR
  mmc: sdhci-msm: Update DDR_CONFIG as per device tree file
  mmc: sdhci-msm: Read and use DLL Config property from device tree file
  mmc: sdhci-msm: Introduce new ops to dump vendor specific registers
  mmc: sdhci-msm: dump vendor specific registers during error

Veerabhadrarao Badiganti (1):
  mmc: host: sdhci-msm: Configure dll-user-control in dll init sequence

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  14 +++
 drivers/mmc/host/sdhci-msm.c                       | 103 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                           |   3 +
 drivers/mmc/host/sdhci.h                           |   1 +
 4 files changed, 118 insertions(+), 3 deletions(-)

-- 
2.7.4

