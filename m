Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6893C48BE6
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 03:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE218613F5
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 03:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFODDT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:03:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52191 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230239AbhFODDR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jun 2021 23:03:17 -0400
X-UUID: a1200e2a633a473c888e2293e4ade251-20210615
X-UUID: a1200e2a633a473c888e2293e4ade251-20210615
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1742974138; Tue, 15 Jun 2021 11:00:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Jun 2021 11:00:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Jun 2021 11:00:39 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v1] dt-bindings: mmc: change compatiable string for MT8195 mmc host IP
Date:   Tue, 15 Jun 2021 11:00:33 +0800
Message-ID: <1623726033-16073-2-git-send-email-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1623726033-16073-1-git-send-email-wenbin.mei@mediatek.com>
References: <1623726033-16073-1-git-send-email-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

MT8195 mmc host IP is compatible with MT8183, and currently it shows:
properties:
  compatible:
    oneOf:
...
      - items:
         - const: mediatek,mt8192-mmc
         - const: mediatek,mt8195-mmc
         - const: mediatek,mt8183-mmc
which means the compatible string in the device tree would be:
	compatible = "mediatek,mt8192-mmc", "mediatek,mt8195-mmc",
		     "mediatek,mt8183-mmc";
The bindings is wrong and that isn't the result we want.
instead we want:
properties:
  compatible:
    oneOf:
...
      - items:
         - const: mediatek,mt8192-mmc
         - const: mediatek,mt8183-mmc
      - items:
         - const: mediatek,mt8195-mmc
         - const: mediatek,mt8183-mmc
which would give us:
	compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
and
	compatible = "mediatek,mt8195-mmc", "mediatek,mt8183-mmc";

Fixes: eb9cb7227e5c (dt-bindings: mmc: Add compatible for Mediatek MT8195)
Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 8648d48..adaba90 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -31,6 +31,8 @@ properties:
           - const: mediatek,mt2701-mmc
       - items:
           - const: mediatek,mt8192-mmc
+          - const: mediatek,mt8183-mmc
+      - items:
           - const: mediatek,mt8195-mmc
           - const: mediatek,mt8183-mmc
 
-- 
1.9.1

