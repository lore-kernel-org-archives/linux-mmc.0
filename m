Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C9C07E98
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 20:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B73611C6
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 20:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbhI1UKE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:10:04 -0400
Received: from www.zeus03.de ([194.117.254.33]:60856 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242644AbhI1UKD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Sep 2021 16:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=UGvGeAAprZ3MW+
        UV1/y4GsGrKriFpX7VMGJ4v/EgCGo=; b=zkeIViSYKTf+LFMrFRS3iF0OvPi47Z
        8dr5BeIateCA4nvs6sd5trfksQmcFz8huJqVuTOE47Dc4L2ha2bWPN9DH6bLfWNH
        cYShEZ5RaKrMR0rzmuPMQ7brWgEMWJriiOeYqkMIts4et+vpl3nkSsRE+lCYqEQk
        GMjyusJauSeaI=
Received: (qmail 1377374 invoked from network); 28 Sep 2021 22:08:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Sep 2021 22:08:20 +0200
X-UD-Smtp-Session: l3s3148p1@/URjxhPNfNIgAwDPXxnDADNsFyRXxb9N
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 6/9] dt-bindings: mmc: renesas,sdhi: add optional SDnH clock
Date:   Tue, 28 Sep 2021 22:08:01 +0200
Message-Id: <20210928200804.50922-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928200804.50922-1-wsa+renesas@sang-engineering.com>
References: <20210928200804.50922-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 9f1e7092cf44..762a424ca76e 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -132,12 +132,13 @@ allOf:
       properties:
         clocks:
           minItems: 1
-          maxItems: 2
+          maxItems: 3
         clock-names:
           minItems: 1
           items:
             - const: core
             - const: cd
+            - const: clkh
 
   - if:
       properties:
-- 
2.30.2

