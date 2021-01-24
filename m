Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65FAC433E0
	for <linux-mmc@archiver.kernel.org>; Sun, 24 Jan 2021 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A2922CF6
	for <linux-mmc@archiver.kernel.org>; Sun, 24 Jan 2021 17:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbhAXRFI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbhAXRFI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2021 12:05:08 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189DC061574;
        Sun, 24 Jan 2021 09:04:12 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DNzpS0MQ6z1ryp5;
        Sun, 24 Jan 2021 18:03:12 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DNzpR6md0z1tYWh;
        Sun, 24 Jan 2021 18:03:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id NsfvXDq33VMl; Sun, 24 Jan 2021 18:03:10 +0100 (CET)
X-Auth-Info: KujytKdU44tHqH5uTUUJPPtHQLl6rK9B9LlFlPOA1U0=
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 24 Jan 2021 18:03:10 +0100 (CET)
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
Subject: [PATCH V2 1/4] mmc: mmci: Add bindings to operate CMD, CK, CKIN pins as GPIO
Date:   Sun, 24 Jan 2021 18:02:55 +0100
Message-Id: <20210124170258.32862-1-marex@denx.de>
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
V2: Rebase on next-20210122
---
 .../devicetree/bindings/mmc/arm,pl18x.yaml    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index eddc1f6bdbe5..47595cb483be 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -127,6 +127,26 @@ properties:
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
 unevaluatedProperties: false
 
 required:
-- 
2.29.2

