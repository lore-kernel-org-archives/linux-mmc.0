Return-Path: <SRS0=5kc2=33=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759CCC35250
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Feb 2020 14:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D79120720
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Feb 2020 14:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgBGOpv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:45:51 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:2101 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbgBGOpv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Feb 2020 09:45:51 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Feb 2020 20:15:45 +0530
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg01-blr.qualcomm.com with ESMTP; 07 Feb 2020 20:15:11 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id DE9F947EB; Fri,  7 Feb 2020 20:15:10 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     adrian.hunter@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org,
        mka@chromium.org, Pradeep P V K <ppvk@codeaurora.org>
Subject: [RFC v3 0/2] Add SDHC interconnect bandwidth scaling
Date:   Fri,  7 Feb 2020 20:14:53 +0530
Message-Id: <1581086695-16645-1-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add interconnect bandwidths for SDHC driver using OPP framework that
is required by SDHC driver based on the clock frequency and bus width
of the card. Otherwise, the system clocks may run at minimum clock
speed and thus affecting the performance.


This change is based on Georgi Djakov [RFC]
(https://lkml.org/lkml/2018/10/11/499) and

Saravana Kannan [PATCH v6]
(https://lkml.org/lkml/2019/12/6/740)

change from RFC v2 -> v3 changes:
- Modified interconnect bandwidth support using OPP framework.
- Addressed review comments on v2.

Pradeep P V K (2):
  mmc: sdhci-msm: Add interconnect bus bandwidth scaling support
  dt-bindings: mmc: sdhci-msm: Add interconnect BW scaling strings

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  18 ++
 drivers/mmc/host/sdhci-msm.c                       | 251 ++++++++++++++++++++-
 2 files changed, 265 insertions(+), 4 deletions(-)

-- 
1.9.1

