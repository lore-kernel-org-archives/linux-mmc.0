Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1595AC43216
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA45A60E0B
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhHTJbH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:31:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62490 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbhHTJbG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2021 05:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629451830; x=1660987830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TdDRDMfVoTPK1Q7o5kfoovXTat92cjHCtwq8sj87Sj4=;
  b=fZLqCpfm42h+gsKAydjWYNkXGdXACl0sTTcMN1hnSzw87IH2kUFTFa+0
   olMW7BUj5QARAPaqGhbJhHdNJoGv9SoSwEioPT5ZJFN7VgF5mVMiX1tn7
   9Bp0NcdL9gtZ5iE6vl9eISacLB919lLZp0HSZERukonDxDOJwwAcX6Uf8
   m8FcSWgho8roXqDlLGiY0UXkfWxZ8G3v4paC+TOMPqbmNzkL6tEb32hn4
   BSjykjnJkb4Ut4o6ykbkRtBa034Zkx8NGKldpdLwukK8rgDf8O09WKYee
   7x88ZPzW6AENtXvlwwfPUduvUv+yLvLg6kZINB+DjYg0XzU/3Yc7DpvW5
   g==;
IronPort-SDR: U29ARp0vf/BHn3rYi7961NJAfUHdAQJ1h4xhnHs8TYGhbz+peTAbbDxEVAudUGoXT9/JIRcyEP
 qxPPu+2cM0sl/NCxaKcP5By3t8S7ucAxt5RuGnWn/m9BG0fgFGz219kqTJ4Q7KWsD2ZAyGxS8J
 dB5nJaIMuGnaaPjdRmDAMhV4kd7N8AIjAbqwgpeO4oboJN66f0T+3iEvzmD7n/VqgWW18yprLO
 CcKdtmbkVSc3bdkplOHrskdfMYB2hvUE+tP9a6vXA1VL1IfkflvtmiocNIoqQPLm/QBWVN0Wwl
 WWGLZHBxsu4oCdsC3lFKa2DR
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="128997109"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2021 02:30:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 20 Aug 2021 02:30:28 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 20 Aug 2021 02:30:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/4] dt-bindings: pwrseq-sd8787: add binding for wilc1000
Date:   Fri, 20 Aug 2021 12:28:00 +0300
Message-ID: <20210820092803.78523-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820092803.78523-1-claudiu.beznea@microchip.com>
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
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
index e0169a285aa2..9e2396751030 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: mmc-pwrseq-sd8787
+    enum:
+      - mmc-pwrseq-sd8787
+      - mmc-pwrseq-wilc1000
 
   powerdown-gpios:
     minItems: 1
-- 
2.25.1

