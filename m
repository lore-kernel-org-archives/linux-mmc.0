Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC5DC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jun 2022 17:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiFVRgc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiFVRga (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2022 13:36:30 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 628EC32EE7;
        Wed, 22 Jun 2022 10:36:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,212,1650898800"; 
   d="scan'208";a="123778458"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jun 2022 02:36:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1C33C4003892;
        Thu, 23 Jun 2022 02:36:21 +0900 (JST)
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
Subject: [PATCH v2 0/2] mmc: renesas_sdhi: Trivial fixes
Date:   Wed, 22 Jun 2022 18:36:12 +0100
Message-Id: <20220622173614.12778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi All,

This patch series adds trivial fixes to renesas mmc driver.

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

