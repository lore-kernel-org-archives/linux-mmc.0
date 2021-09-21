Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE65DC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CA061183
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhIULCC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:02:02 -0400
Received: from muru.com ([72.249.23.125]:35618 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232173AbhIULCB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Sep 2021 07:02:01 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id F22E580A8;
        Tue, 21 Sep 2021 11:00:59 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 0/5] Prepare sdhci-omap to support more SoCs
Date:   Tue, 21 Sep 2021 14:00:24 +0300
Message-Id: <20210921110029.21944-1-tony@atomide.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Here are changes to prepare to add support for more SoCs to start
deprecating the old omap_hsmmc driver. I'll send another series
of changes to add support for more SoCs.

Regards,

Tony


Tony Lindgren (5):
  mmc: sdhci-omap: Fix NULL pointer exception if regulator is not
    configured
  mmc: sdhci-omap: Fix context restore
  mmc: sdhci-omap: Restore sysconfig after reset
  mmc: sdhci-omap: Parse legacy ti,non-removable property
  mmc: sdhci-omap: Check MMCHS_HL_HWINFO register for ADMA

 drivers/mmc/host/sdhci-omap.c | 61 ++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

-- 
2.33.0
