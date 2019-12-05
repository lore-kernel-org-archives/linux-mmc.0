Return-Path: <SRS0=6ao/=Z3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177A2C2D0C0
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Dec 2019 13:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E161E24648
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Dec 2019 13:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfLENnx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:43:53 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:40060 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbfLENnx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2019 08:43:53 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id aDjr2100e5USYZQ01Djrdt; Thu, 05 Dec 2019 14:43:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icrQ7-0002BE-I9; Thu, 05 Dec 2019 14:43:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icrQ7-0001gF-GV; Thu, 05 Dec 2019 14:43:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] dt-bindings: mmc: renesas_sdhi: Document r8a77961 support
Date:   Thu,  5 Dec 2019 14:43:48 +0100
Message-Id: <20191205134349.6410-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205134349.6410-1-geert+renesas@glider.be>
References: <20191205134349.6410-1-geert+renesas@glider.be>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document support for the SDHI controller in the Renesas R-Car M3-W+
(R8A77961) SoC.

Update all references to R-Car M3-W from "r8a7796" to "r8a77960", to
avoid confusion between R-Car M3-W (R8A77960) and M3-W+.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
No driver update is needed if "[PATCH] mmc: renesas_sdhi: remove
whitelist for internal DMAC"[1] makes it in first.

[1] https://lore.kernel.org/linux-mmc/20191203194859.917-1-wsa@the-dreams.de/
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt b/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
index bc08fc43a9be466b..e6cc47844207049b 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
@@ -23,7 +23,8 @@ Required properties:
 		"renesas,sdhi-r8a7793" - SDHI IP on R8A7793 SoC
 		"renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
 		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
-		"renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
+		"renesas,sdhi-r8a7796" - SDHI IP on R8A77960 SoC
+		"renesas,sdhi-r8a77961" - SDHI IP on R8A77961 SoC
 		"renesas,sdhi-r8a77965" - SDHI IP on R8A77965 SoC
 		"renesas,sdhi-r8a77970" - SDHI IP on R8A77970 SoC
 		"renesas,sdhi-r8a77980" - SDHI IP on R8A77980 SoC
-- 
2.17.1

