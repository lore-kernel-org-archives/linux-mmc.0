Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F277C5ACD3
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 06:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3E4206E2
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 06:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbgCLGDP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:03:15 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:20487 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387767AbgCLGDP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 02:03:15 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Mar 2020 11:32:29 +0530
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 Mar 2020 11:31:58 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id 258634D31; Thu, 12 Mar 2020 11:31:57 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, rampraka@codeaurora.org,
        vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, mka@chromium.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: [RFC v5 0/2] Add SDHC interconnect bandwidth scaling
Date:   Thu, 12 Mar 2020 11:31:49 +0530
Message-Id: <1583992911-12001-1-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add interconnect bandwidths for SDHC driver using OPP framework that
is required by SDHC driver based on the clock frequency and bus width
of the card. Otherwise, the system clocks may run at minimum clock
speed and thus affecting the performance.

This change is based on
[RFC] mmc: host: sdhci-msm: Use the interconnect API
(https://lkml.org/lkml/2018/10/11/499) and

[PATCH v6] Introduce Bandwidth OPPs for interconnects
(https://lkml.org/lkml/2019/12/6/740)

Pradeep P V K (2):
  mmc: sdhci-msm: Add interconnect bus bandwidth scaling support
  dt-bindings: mmc: sdhci-msm: Add interconnect BW scaling strings

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  18 ++
 drivers/mmc/host/sdhci-msm.c                       | 231 ++++++++++++++++++++-
 2 files changed, 245 insertions(+), 4 deletions(-)

-- 
RFC v4 -> v5:
- Added Rob's Acked-by and Bjorn Reviewed-by for the DT patch.
- Rewrote the icc interconnect get handlers and its error handling
  and allocated vote data after handling all icc get handler errors.
- Removed explicit error check on ICC handlers.
- Addressed minor code style comments.
1.9.1

