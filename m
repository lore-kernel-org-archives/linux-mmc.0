Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64668C4320E
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D45561B48
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhHPI6O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 04:58:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16223 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbhHPI6N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 04:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629104263; x=1660640263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5Um85a163Mv7pkkXoHd1V4ZSq/GFRUVPlIyt5VmkFg=;
  b=eRYF4RaTciTihUHDpjwgEsEAbO5jxWdCo2YjRT3h9MTLR4MkTemx7fBP
   G1XwbEIxnJcwsEOi7v4eJZlcT//Y8q00nIv2GRuKFV0pUdhr44GbXJjEj
   wQuh0TG5ZKgmgABtklNnwX006FCZRqJhklgDAL76ZcNRtR2t+7wt3pPwk
   VfcEaImIwYOhinl0RAS/K4AkEXQzngeO5npwCgUci6ZkiXnTdDyMB3/Fg
   P0LJQu42hGJK3EydUnijGqvvmivW7y7HNnbt1glkQwCJWdSyFetnTDZYy
   790KU5sDM8l14dbbkkXK7RsfT7YRd21XvpGEBbJ4n+551YlyT3CpwtEI8
   A==;
IronPort-SDR: zXgvwnIDWcLSDtfpl/odq2M90Q0YjFZq0j7DkKgiKRQVoxLILLCU0G25RKIcXoiZnv+mstmYEA
 lBzGUxfMG8aVUtPsgywuiaZpC4Ju+BJe105OyEhD8YqkeGE6HMsD173yutUu6lEaFImU787/Ky
 z9SZeHWGg0+7q4de1YMpYjkS0YMxhEJ2GFJRvr220hZDsdEvwPwX804SmFDY5OLlgSOhN+oTJ9
 gBnoQ7Ab8V34VbqzgH6bl/dlbFnggDFVBATaD2NHkUAX17sb0fSfOBEBZN5bGOHSW/hynJBwOX
 Zc5i4i8HIT1f8ntlrsm1V6aa
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="132377649"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2021 01:57:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 16 Aug 2021 01:57:41 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 16 Aug 2021 01:57:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/4] dt-bindings: pwrseq-sd8787: add binding for wilc1000
Date:   Mon, 16 Aug 2021 11:55:27 +0300
Message-ID: <20210816085530.1723402-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816085530.1723402-1-claudiu.beznea@microchip.com>
References: <20210816085530.1723402-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add binding for wilc1000 devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
index e0169a285aa2..e1a51ef70e77 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: mmc-pwrseq-sd8787
+    oneOf:
+      const: mmc-pwrseq-sd8787
+      const: mmc-pwrseq-wilc1000
 
   powerdown-gpios:
     minItems: 1
-- 
2.25.1

