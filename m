Return-Path: <SRS0=q8Wp=7D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC0C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 07:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110262083E
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 07:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgEUHBV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 May 2020 03:01:21 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:14295 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727030AbgEUHBV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 May 2020 03:01:21 -0400
X-IronPort-AV: E=Sophos;i="5.73,416,1583161200"; 
   d="scan'208";a="47438472"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 May 2020 16:01:19 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5229E400C45F;
        Thu, 21 May 2020 16:01:19 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/3] mmc: tmio and renesas_sdhi_internal_dmac: fix dma unmapping
Date:   Thu, 21 May 2020 16:01:03 +0900
Message-Id: <1590044466-28372-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series is based on mmc.git / next branch.

I guess we should add such a code into renesas_sdhi_sys_dmac and
uniphier-sd drivers too. But, for now, I fixed
renesas_sdhi_internal_dmac only.

Yoshihiro Shimoda (3):
  mmc: tmio: core: Add end operation into tmio_mmc_dma_ops
  mmc: renesas_sdhi_internal_dmac: clean up the code for dma complete
  mmc: renesas_sdhi_internal_dmac: Fix dma unmapping in error cases

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 28 +++++++++++++++++++++++----
 drivers/mmc/host/tmio_mmc.h                   |  3 +++
 drivers/mmc/host/tmio_mmc_core.c              |  8 ++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.7.4

