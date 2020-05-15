Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BE9C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 15:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE9F207C3
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 15:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgEOPKi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 11:10:38 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:32716 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728243AbgEOPKf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 11:10:35 -0400
X-IronPort-AV: E=Sophos;i="5.73,395,1583161200"; 
   d="scan'208";a="46974914"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 May 2020 00:10:33 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C1CCE400D4CD;
        Sat, 16 May 2020 00:10:29 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 14/17] dt-bindings: power: renesas,apmu: Document r8a7742 support
Date:   Fri, 15 May 2020 16:08:54 +0100
Message-Id: <1589555337-5498-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589555337-5498-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1589555337-5498-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document APMU and SMP enable method for RZ/G1H (also known as r8a7742)
SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/power/renesas,apmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.yaml b/Documentation/devicetree/bindings/power/renesas,apmu.yaml
index 078b2cb..60a23b3 100644
--- a/Documentation/devicetree/bindings/power/renesas,apmu.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r8a7742-apmu  # RZ/G1H
           - renesas,r8a7743-apmu  # RZ/G1M
           - renesas,r8a7744-apmu  # RZ/G1N
           - renesas,r8a7745-apmu  # RZ/G1E
-- 
2.7.4

