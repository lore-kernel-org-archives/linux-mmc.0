Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84DFC32772
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Aug 2022 19:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350942AbiHSTIR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351109AbiHSTIE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2022 15:08:04 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED502109A33;
        Fri, 19 Aug 2022 12:08:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27JJ7qur115819;
        Fri, 19 Aug 2022 14:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660936072;
        bh=eBu2pgu1VeQ+NaqR9wXC6lFf6JSg7YZjVoFqF5avpjg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ktCxk06OhPmWhSfFArtcOTvp55w6QvJV6iBRrUyRN5wTfLUMd4RERE1cbeiqSBhGo
         dwanur5+nfd7+g5OAnQUP7GTg5MUqJE9Vao/t1V5IrCmMNJNzyN8orT6LACnvwlwlX
         DDe70GasBYEcvnX3ZucUgd1bPDPb7V01eEea/bu4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27JJ7qEO008343
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Aug 2022 14:07:52 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 19
 Aug 2022 14:07:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 19 Aug 2022 14:07:51 -0500
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27JJ7T2v051038;
        Fri, 19 Aug 2022 14:07:46 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH 3/3] dt-bindings: interrupt-controller: Fix 'reg' was unexpected
Date:   Sat, 20 Aug 2022 00:37:29 +0530
Message-ID: <20220819190729.32358-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819190729.32358-1-a-nandan@ti.com>
References: <20220819190729.32358-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix the following warning in dtbs_check
interrupt-controller@a00000: Unevaluated properties are not allowed ('reg' was unexpected)

Add the reg property in the schema.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 .../devicetree/bindings/interrupt-controller/ti,sci-intr.yaml  | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
index e12aee42b126..c99cc7323c71 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
@@ -58,6 +58,9 @@ properties:
         1 = If intr supports edge triggered interrupts.
         4 = If intr supports level triggered interrupts.
 
+  reg:
+    maxItems: 1
+
   interrupt-controller: true
 
   '#interrupt-cells':
-- 
2.17.1

