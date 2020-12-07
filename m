Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FCDC433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 03:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C400222CA0
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 03:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgLGD13 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Dec 2020 22:27:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8954 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGD13 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Dec 2020 22:27:29 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cq7y66F1CzhnWh;
        Mon,  7 Dec 2020 11:26:22 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 11:26:40 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] dt-bindings: mmc: eliminate yamllint warnings
Date:   Mon, 7 Dec 2020 11:26:26 +0800
Message-ID: <20201207032626.1445-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201207032626.1445-1-thunder.leizhen@huawei.com>
References: <20201207032626.1445-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Eliminate the following yamllint warnings:
./Documentation/devicetree/bindings/mmc/mtk-sd.yaml
:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
:33:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 030e3fdce49293a..01630b0ecea773e 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -17,21 +17,21 @@ properties:
   compatible:
     oneOf:
       - enum:
-        - mediatek,mt2701-mmc
-        - mediatek,mt2712-mmc
-        - mediatek,mt6779-mmc
-        - mediatek,mt7620-mmc
-        - mediatek,mt7622-mmc
-        - mediatek,mt8135-mmc
-        - mediatek,mt8173-mmc
-        - mediatek,mt8183-mmc
-        - mediatek,mt8516-mmc
+          - mediatek,mt2701-mmc
+          - mediatek,mt2712-mmc
+          - mediatek,mt6779-mmc
+          - mediatek,mt7620-mmc
+          - mediatek,mt7622-mmc
+          - mediatek,mt8135-mmc
+          - mediatek,mt8173-mmc
+          - mediatek,mt8183-mmc
+          - mediatek,mt8516-mmc
       - items:
-        - const: mediatek,mt7623-mmc
-        - const: mediatek,mt2701-mmc
+          - const: mediatek,mt7623-mmc
+          - const: mediatek,mt2701-mmc
       - items:
-        - const: mediatek,mt8192-mmc
-        - const: mediatek,mt8183-mmc
+          - const: mediatek,mt8192-mmc
+          - const: mediatek,mt8183-mmc
 
   clocks:
     description:
-- 
1.8.3


