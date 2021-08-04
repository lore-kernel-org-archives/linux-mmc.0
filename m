Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A763C4320E
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BA960FC4
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 16:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhHDQNq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:13:46 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:16292 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233239AbhHDQNq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2021 12:13:46 -0400
X-IronPort-AV: E=Sophos;i="5.84,294,1620658800"; 
   d="scan'208";a="89832262"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Aug 2021 01:13:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AA1754010DEA;
        Thu,  5 Aug 2021 01:13:29 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/2] Document RZ/G2L SDHI controller bindings.
Date:   Wed,  4 Aug 2021 17:13:23 +0100
Message-Id: <20210804161325.26996-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series aims to document RZ/G2L SDHI controller bindings.

v2->v3:
 * Created a seperate patch to fix the dtbs-warning check reported by [1].
 * RZ/G2L SDHI binding patch depends up on the above the patch.
 [1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210804091940.23983-1-biju.das.jz@bp.renesas.com/
v1->v2:
 * Fixed dtbs-check issue for RZ/A{1,2} platforms.

v1->
 * newpatch

Biju Das (2):
  dt-bindings: mmc: renesas,sdhi: Fix dtbs-check warning
  dt-bindings: mmc: renesas,sdhi: Document RZ/G2L bindings

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 119 ++++++++++++------
 1 file changed, 79 insertions(+), 40 deletions(-)

-- 
2.17.1

