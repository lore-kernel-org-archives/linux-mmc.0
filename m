Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42BC433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 07:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A19C222F9
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 07:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgLWHbP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Dec 2020 02:31:15 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:2516 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbgLWHbP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2020 02:31:15 -0500
X-IronPort-AV: E=Sophos;i="5.78,441,1599490800"; 
   d="scan'208";a="66692938"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Dec 2020 16:30:43 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BE2B1400F2B5;
        Wed, 23 Dec 2020 16:30:43 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] mmc: host: tmio/renesas_sdhi: Add data timeout error detection
Date:   Wed, 23 Dec 2020 16:30:20 +0900
Message-Id: <1608708622-29668-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series is based on the mmc.git / next branch. The patch 1/2
is a updated patch from Wolfram-san submitted [1]. And, I talked
him locally, I can write this Reviewed-by and Tested-by instead of
SoB. The patch 2/2 is a new patch for retuning a card when
the host controller detects cmd/data timeout. And, I got Wolfram-san's
Reviewed-by locally.

Note that I don't include Hayakawa-san's email account which is
the author of the patch 1/2 in To/CC because he left from Renesas
now.

[1]
https://lore.kernel.org/linux-mmc/20201120150647.123237-3-wsa+renesas@sang-engineering.com/

Masaharu Hayakawa (1):
  mmc: tmio: Add data timeout error detection

Yoshihiro Shimoda (1):
  mmc: host: renesas_sdhi: Add a condition of cmd/data timeout for
    retune

 drivers/mmc/host/renesas_sdhi_core.c | 16 +++++++++++++---
 drivers/mmc/host/tmio_mmc.h          |  2 +-
 drivers/mmc/host/tmio_mmc_core.c     |  8 +++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.7.4

