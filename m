Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF70C43217
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 12:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1666361241
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 12:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244393AbhIQMkV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 08:40:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52306 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240600AbhIQMkU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 08:40:20 -0400
X-UUID: ed5b0f4050da4da58f9a9a684d51620c-20210917
X-UUID: ed5b0f4050da4da58f9a9a684d51620c-20210917
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 581002337; Fri, 17 Sep 2021 20:38:54 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 20:38:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Sep
 2021 20:38:53 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Sep 2021 20:38:52 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
Date:   Fri, 17 Sep 2021 20:38:49 +0800
Message-ID: <20210917123851.22741-2-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917123851.22741-1-wenbin.mei@mediatek.com>
References: <20210917123851.22741-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add hs400 dly3 setting for mtk-sd yaml

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index e866e985549e..82768a807294 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -119,6 +119,18 @@ properties:
       If present, HS400 command responses are sampled on rising edges.
       If not present, HS400 command responses are sampled on falling edges.
 
+  mediatek,hs400-ds-dly3:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Gear of the third delay line for DS for input data latch in data
+      pad macro, there are 32 stages from 0 to 31.
+      For different corner IC, the time is different about one step, it is
+      about 100ps.
+      The value is confirmed by doing scan and calibration to find a best
+      value with corner IC and it is valid only for HS400 mode.
+    minimum: 0
+    maximum: 31
+
   mediatek,latch-ck:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.25.1

