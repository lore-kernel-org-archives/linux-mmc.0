Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C24C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Feb 2022 13:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiBPNoM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Feb 2022 08:44:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiBPNoM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2022 08:44:12 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673911F6BAF;
        Wed, 16 Feb 2022 05:43:59 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21GDhpB7077211;
        Wed, 16 Feb 2022 07:43:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645019031;
        bh=yq8pr2L8RupSYOTXWkiybuvOd6NqNBy13xsFwsS9Ej8=;
        h=From:To:CC:Subject:Date;
        b=m00X+TKc39sArhM6cbLNIzirgoedqylr5tzY9Le6vW24dT2YKMfEnjqKyMPsXejws
         snJdSC9GgnO2HGUW0qZ4iWhKFaHcxlzAAzX7P5NO0g/Z1hJpaKUQOm270M1xcWUiyq
         Ys+8lzMww2Jgps/+2JuSebXZ9Q5XE4CAT99Xdiho=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21GDhpeX118429
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 07:43:51 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 07:43:51 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 07:43:51 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21GDhmdq033503;
        Wed, 16 Feb 2022 07:43:48 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: mmc: sdhci-am654: Add compatible string for AM62 SoC
Date:   Wed, 16 Feb 2022 19:13:46 +0530
Message-ID: <20220216134346.11029-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add compatible string for AM62 SoC in device tree binding of AM654
SDHCI module as the same IP is used.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 9fbf16b3bc8d..0566493c4def 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -21,6 +21,7 @@ properties:
       - const: ti,j721e-sdhci-4bit
       - const: ti,am64-sdhci-8bit
       - const: ti,am64-sdhci-4bit
+      - const: ti,am62-sdhci
       - items:
           - const: ti,j7200-sdhci-8bit
           - const: ti,j721e-sdhci-8bit
-- 
2.17.1

