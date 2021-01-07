Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2B6C433DB
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jan 2021 05:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF69922E03
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jan 2021 05:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbhAGF4n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jan 2021 00:56:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42176 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbhAGF4n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jan 2021 00:56:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1075t6d2052309;
        Wed, 6 Jan 2021 23:55:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609998906;
        bh=/QI3+09DvV2knCjkBtoiAnZ1FWH8h0+S/wf3RSIDwfs=;
        h=From:To:CC:Subject:Date;
        b=XGar1MFMS50Q+2jVX/FGP+iEEVIBF1c/xPM4x3R+sE1l1htit9Dmmd6CKNcW7ZmpF
         zz04Kos9dav4t7QhZwvgcwvoi3Xd6HA3JTwnQKyZ1GpeNeXSWskxTHHXJRnJaFd3CZ
         PAyWOaehNMmAK98qL3QhUC2Bk8pBz9kTg/nbUDRg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1075t5H2004338
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jan 2021 23:55:06 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 Jan
 2021 23:55:05 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 Jan 2021 23:55:05 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1075t0JD112728;
        Wed, 6 Jan 2021 23:55:02 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: mmc: sdhci-am654: Add compatible string for AM64 SoC
Date:   Thu, 7 Jan 2021 11:24:57 +0530
Message-ID: <20210107055457.14948-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add compatible string for AM64 SoC in device tree binding of AM654 SDHCI
module as the same IP is used.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 1ae945434c53..34e53db29428 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -21,6 +21,8 @@ properties:
       - ti,j721e-sdhci-4bit
       - ti,j7200-sdhci-8bit
       - ti,j721e-sdhci-4bit
+      - ti,am64-sdhci-8bit
+      - ti,am64-sdhci-4bit
 
   reg:
     maxItems: 2
-- 
2.17.1

