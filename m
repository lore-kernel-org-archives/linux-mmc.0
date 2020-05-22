Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA5DC433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 09:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AD8206C3
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 09:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgEVJdY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 05:33:24 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:30354 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728424AbgEVJdY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 05:33:24 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 May 2020 15:03:21 +0530
Received: from minint-dvc2thc.qualcomm.com (HELO sartgarg-linux.qualcomm.com) ([10.206.24.245])
  by ironmsg01-blr.qualcomm.com with ESMTP; 22 May 2020 15:03:08 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id DD14E179E; Fri, 22 May 2020 15:03:06 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>
Subject: [PATCH V2 0/8] Board specific DLL configuration for qcom SDHC 
Date:   Fri, 22 May 2020 15:02:22 +0530
Message-Id: <1590139950-7288-1-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
References: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Changes since V1:
        -Splitting documentation change into two patches to
		avoid confusion
	-For the rest of patches retaining Andrians Ack.

Sarthak Garg (7):
  dt-bindings: mmc: Add new compatible string for sm8250 target
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

