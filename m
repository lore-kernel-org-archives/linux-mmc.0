Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DECC4338F
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4E061176
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbhHFLcr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:32:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12975 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbhHFLcq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 07:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628249551; x=1659785551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYqo0be+dvZrTBodvT604I50n0YL2LfsXiX7MNehf50=;
  b=ohGr7YarwksVEdGzm0KWMhNs0oNqIP2vjpcItHlF7l4y5hdRz9+lcWCB
   4CdDCvV4DlI/0UVs8/fgSYlXl3qobmL2MucA/k3YPqi7LzF0DRmbWsfdv
   1FXH+CPT6t3piH7ueiCvW8Hj/IChmobRXrAhk06ADVAg6inuG8WzpjfZv
   z2v2ZhUM8ypQYabUnsUDEvGPSdpfWlx1paTes1eaKqXwmTDwVNf9FzDwQ
   DSSAuZakDSD/DeD+CCvLNd88LWBZOeQu3lzzH99GLJf9J+wkgVYgOmUaU
   oWgUVMByiefvMFd+/0ehf5sfNTAvBxNMtQTgzlhZc0OU523lQQRyEwtD/
   w==;
IronPort-SDR: UkgAR6wJAwZNS04zBjeeVREIZJPzayLIWRAgeLz+klAeltWA5M9rKQcv/NXjPVPmQ1qFZlGTW9
 NV9zeuzUCjsCwg7+uKkhI8Ti0LKpdK3w6dPLIO4trJ/a7a3TVok/nu8Bnx3rYm+f3xqcphdJXg
 v7TjE4K9fdx2vsvEvr7iaMK9N9bL0/vIxr+Abgjrwcnrsw5VC+gaW/as/Yx1PvehsgBTV2LD9X
 jT/ReX1xR0KO7gAaQTN3YBiODwF/85szQ2Ub+nWG0KFMOS+iU7fuU6EqgChd5aUIoE/5q7eOHr
 mUGt6r7PRGE1VFX/lpB/YDse
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="127352552"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2021 04:32:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 04:32:30 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 6 Aug 2021 04:32:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/4] dt-bindings: mmc: pwrseq-sd8787: add binding for delay b/w reset and power
Date:   Fri, 6 Aug 2021 14:29:58 +0300
Message-ID: <20210806113001.821660-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806113001.821660-1-claudiu.beznea@microchip.com>
References: <20210806113001.821660-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add documentation for binding that specifies the delay that should
be introduced b/w reset and power lines when powering up the device.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
index e0169a285aa2..4b1e89750e94 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
@@ -23,6 +23,10 @@ properties:
     description:
       contains a reset GPIO specifier with the default active state
 
+  reset-power-delay-ms:
+    description:
+      Delay in ms between powerdown and reset gpios
+
 required:
   - compatible
   - powerdown-gpios
-- 
2.25.1

