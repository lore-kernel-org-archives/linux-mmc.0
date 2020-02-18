Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CFAC3403B
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 13:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C52824654
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 13:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgBRNBU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:01:20 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:1082 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgBRNBT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2020 08:01:19 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 Feb 2020 18:31:16 +0530
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg02-blr.qualcomm.com with ESMTP; 18 Feb 2020 18:30:41 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id A544A4C42; Tue, 18 Feb 2020 18:30:40 +0530 (IST)
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
Subject: [RFC v4 0/2] Add SDHC interconnect bandwidth scaling
Date:   Tue, 18 Feb 2020 18:30:31 +0530
Message-Id: <1582030833-12964-1-git-send-email-ppvk@codeaurora.org>
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
 drivers/mmc/host/sdhci-msm.c                       | 204 ++++++++++++++++++++-
 2 files changed, 218 insertions(+), 4 deletions(-)

--
changes from RFC v3 -> v4:
- Addressed review comments from Bjorn and Matthias
1.9.1

