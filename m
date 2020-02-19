Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A619EC34022
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770E32464E
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBSIaI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:30:08 -0500
Received: from inva020.nxp.com ([92.121.34.13]:48068 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgBSIaH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 03:30:07 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DDCEB1A14A3;
        Wed, 19 Feb 2020 09:30:05 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BD6B1A0706;
        Wed, 19 Feb 2020 09:30:02 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F1A19402A0;
        Wed, 19 Feb 2020 16:29:57 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v4 00/14] few fix for sdhci-esdhc-imx
Date:   Wed, 19 Feb 2020 16:22:39 +0800
Message-Id: <1582100563-20555-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

---
Changes for v4:
Add Adrian's ack for patch 9~12
for patch 13, change to add the check for pinctrl error
for patch 14, change to judge the dev->dma_parms first, if it not exist, then alloc it.

Changes for v3:
Add Linus Walleij's ack for patch 2
for patch 9, drop the use of 'sdhci,auto-cmd23-broken' from dts, change to add flag ESDHC_FLAG_BROKEN_AUTO_CMD23 in the related esdhc_soc_data.
for patch 10, add a new esdhc_soc_data for i.MX8MM

Changes for v2:
Add Adrian's ack for patch 1~8
Patch 9~10, change to use 'sdhci,auto-cmd23-broken' instead of 'fsl,auto-cmd23-broken'
Patch 11, clear cqhci irq status and halt cqhci, move this change to sdhci_esdhc_imx_hwinit()
and add some comment to explain the reason.
Patch 12, add error return check for pinctrl_pm_select_sleep_state()
Patch 13, clear the DMA_SEL in sdhci-esdhc-imx.c instead of sdhci.c
Patch 14, add the dev->dma_parms in core/queue.c, instead of host/sdhci.c.


Haibo Chen (14):
  mmc: sdhci: do not enable card detect interrupt for gpio cd type
  mmc: sdhci-esdhc-imx: no fail when no pinctrl available
  mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs
  mmc: sdhci-esdhc-imx: restore the per_clk rate in PM_RUNTIME
  doc: dt: fsl-imx-esdhc: add strobe-dll-delay-target binding
  mmc: sdhci-esdhc-imx: add strobe-dll-delay-target support
  mmc: sdhci-esdhc-imx: optimize the clock setting
  mmc: sdhci-esdhc-imx: optimize the strobe dll setting
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_BROKEN_AUTO_CMD23
  mmc: sdhci-esdhc-imx: Add an new esdhc_soc_data for i.MX8MM
  mmc: sdhci-esdhc-imx: clear pending interrupt and halt cqhci
  mmc: sdhci-esdhc-imx: clear DMA_SEL when disable DMA mode
  mmc: sdhci-esdhc-imx: restore pin state when resume back
  mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt |   5 +
 drivers/mmc/core/queue.c                      |  11 +-
 drivers/mmc/host/sdhci-esdhc-imx.c            | 167 +++++++++++++++---
 drivers/mmc/host/sdhci-esdhc.h                |   1 +
 drivers/mmc/host/sdhci.c                      |   2 +-
 include/linux/platform_data/mmc-esdhc-imx.h   |   1 +
 6 files changed, 161 insertions(+), 26 deletions(-)

-- 
2.17.1

