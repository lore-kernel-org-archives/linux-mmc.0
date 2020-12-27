Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76265C4332E
	for <linux-mmc@archiver.kernel.org>; Sun, 27 Dec 2020 17:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2B62250E
	for <linux-mmc@archiver.kernel.org>; Sun, 27 Dec 2020 17:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgL0RnQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Dec 2020 12:43:16 -0500
Received: from www.zeus03.de ([194.117.254.33]:46744 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgL0Rmx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 27 Dec 2020 12:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=bTxj01yyHGlKGI
        pnBSuC9wuFrkSh8yqin9kLTHv75GA=; b=IykiVQFI7E/NFoyKOZgYyW5lTACL+L
        Cb+KTs3nA8VqY2wrH6J7cqi7BOuvUQEG1QKBM2+MZoWGwryfKjqEc0Mj75BoZE0f
        ZqklRnA+dxZuaFEtNqXLo4Nba0d+JbLs2KJKYzH2sDz/46CEyBPC8lOSIHCasz1S
        GCeQ8QH2S3XhU=
Received: (qmail 1556996 invoked from network); 27 Dec 2020 18:42:10 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Dec 2020 18:42:10 +0100
X-UD-Smtp-Session: l3s3148p1@1l1RrXW3UJ5UhsuJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: mmc: renesas,sdhi: Add r8a779a0 support
Date:   Sun, 27 Dec 2020 18:41:55 +0100
Message-Id: <20201227174202.40834-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201227174202.40834-1-wsa+renesas@sang-engineering.com>
References: <20201227174202.40834-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 6bbf29b5c239..5908a717d2e8 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -59,6 +59,7 @@ properties:
               - renesas,sdhi-r8a77980 # R-Car V3H
               - renesas,sdhi-r8a77990 # R-Car E3
               - renesas,sdhi-r8a77995 # R-Car D3
+              - renesas,sdhi-r8a779a0 # R-Car V3U
           - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
 
   reg:
-- 
2.28.0

