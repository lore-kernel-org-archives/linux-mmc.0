Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CABC433DB
	for <linux-mmc@archiver.kernel.org>; Sat, 16 Jan 2021 18:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3264A22510
	for <linux-mmc@archiver.kernel.org>; Sat, 16 Jan 2021 18:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbhAPSFn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:05:43 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:60892 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbhAPSFn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jan 2021 13:05:43 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DJ5Y02NHvz1qs3P;
        Sat, 16 Jan 2021 19:04:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DJ5Y01XH7z1qqkn;
        Sat, 16 Jan 2021 19:04:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id LKD8K6MrV008; Sat, 16 Jan 2021 19:04:34 +0100 (CET)
X-Auth-Info: phBnIXuFT8YPJ4snd2G2PTyqNWn7WKdVWsH6wtiYXrw=
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 16 Jan 2021 19:04:34 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: [PATCH 1/4] mmc: mmci: Add bindings to operate CMD, CK, CKIN pins as GPIO
Date:   Sat, 16 Jan 2021 19:04:21 +0100
Message-Id: <20210116180424.57331-1-marex@denx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add DT bindings to describe GPIO line associated with CMD, CK, CKIN pins.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ludovic Barre <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: devicetree@vger.kernel.org
---
NOTE: Depends on mmc: mmci: Convert bindings to DT schema
---
 .../devicetree/bindings/mmc/arm,pl18x.yaml    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index 0129d622fb67..0908dbeaa472 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -132,6 +132,26 @@ properties:
       driver to sample the receive data (for example with a voltage switch
       transceiver).
 
+  st,cmd-gpios:
+    maxItems: 1
+    description:
+      The GPIO matching the CMD pin.
+
+  st,ck-gpios:
+    maxItems: 1
+    description:
+      The GPIO matching the CK pin.
+
+  st,ckin-gpios:
+    maxItems: 1
+    description:
+      The GPIO matching the CKIN pin.
+
+dependencies:
+  st,cmd-gpios: [ "st,use-ckin" ]
+  st,ck-gpios: [ "st,use-ckin" ]
+  st,ckin-gpios: [ "st,use-ckin" ]
+
 additionalProperties: true
 
 required:
-- 
2.29.2

