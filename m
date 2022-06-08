Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B7CCA47E
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jun 2022 12:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbiFHMYB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jun 2022 08:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbiFHMYA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2022 08:24:00 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837221F5E3F
        for <linux-mmc@vger.kernel.org>; Wed,  8 Jun 2022 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=4+g6dudEtGLGNWp0TlEsk7B5ZZb
        Jl/eGMXhPbDhQFW8=; b=yvKP1qSv0Zall+gQKrckI82Xv46R1jMLRpnP1v52fhD
        oa6RDNQg0jrzGcauAVQy6MJ1vjZjgEk9WMDoFl1gBhhDny0xT9muOgn+OZXGV9l2
        9n/kXm5dTa5zVe+VQ/NAbhKfF8WQ3dheZ3Ns4biELFt8k26FDWkvSD2awOfVOWR8
        =
Received: (qmail 2895419 invoked from network); 8 Jun 2022 14:23:53 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Jun 2022 14:23:53 +0200
X-UD-Smtp-Session: l3s3148p1@Hc8/x+7gGA9ZD+7M
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: mmc: renesas,sdhi: Add R-Car Gen4 clock requirements
Date:   Wed,  8 Jun 2022 14:23:44 +0200
Message-Id: <20220608122344.3431-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The patch enabling generic Gen4 support forgot to add the clock
requirements which are the same as for Gen3. Update the binding.

Fixes: 6aa26be14d2a ("dt-bindings: mmc: renesas,sdhi: Document R-Car S4-8 and generic Gen4 support")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index d5b29728704b..14945ebc31d2 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -145,6 +145,7 @@ allOf:
               enum:
                 - renesas,rcar-gen2-sdhi
                 - renesas,rcar-gen3-sdhi
+                - renesas,rcar-gen4-sdhi
       then:
         properties:
           clocks:
-- 
2.35.1

