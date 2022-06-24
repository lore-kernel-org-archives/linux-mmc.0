Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C42C43334
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jun 2022 18:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiFXSOv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jun 2022 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiFXSOu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jun 2022 14:14:50 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47F114739D;
        Fri, 24 Jun 2022 11:14:49 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,218,1650898800"; 
   d="scan'208";a="125578120"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Jun 2022 03:14:48 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 39E34400F791;
        Sat, 25 Jun 2022 03:14:44 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/2] mmc: renesas_sdhi: Trivial fixes
Date:   Fri, 24 Jun 2022 19:14:36 +0100
Message-Id: <20220624181438.4355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi All,

This patch series adds trivial fixes to renesas mmc driver.

v2->v3
* Fixed Review comments pointed by Wolfram.
* Included RB tags from Geert.

v1->v2
* Fixed review comments pointed by Geert and Wolfram.

v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  mmc: renesas_sdhi: Get the reset handle early in the probe
  mmc: renesas_sdhi: Fix typo's

 drivers/mmc/host/renesas_sdhi_core.c          | 8 ++++----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1

