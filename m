Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B81CC433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 23:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000206144A
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 23:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhD1XGH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Apr 2021 19:06:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55746 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD1XGH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Apr 2021 19:06:07 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13SN58Vg033804;
        Wed, 28 Apr 2021 18:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619651108;
        bh=1Xg6ZKtmjPdG2EnSCdMjyLIofKdPAcqa9KgUukLd/Do=;
        h=From:To:CC:Subject:Date;
        b=Ild6o63w/7smD/y9dDBobcbudokjMjOfs2dPj122s6nZUVwhVr436ALcevs4EmRu4
         9/35zd9hpjlDXIVSM5pvgHgyEV3AYPLZKu3Y+8SYJl5uxIL9Y0crC1fRZmmYRQGoK3
         v4zEaZbMHUFo38tYoebNSdvgPTnViI1WES29+pfE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13SN580D036775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Apr 2021 18:05:08 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 28
 Apr 2021 18:05:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 28 Apr 2021 18:05:08 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13SN58wn040581;
        Wed, 28 Apr 2021 18:05:08 -0500
Received: from localhost ([10.250.34.141])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 13SN58ZT100793;
        Wed, 28 Apr 2021 18:05:08 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH] dt-bindings: mmc: sdhci-am654: Remove duplicate ti,j721e-sdhci-4bit
Date:   Wed, 28 Apr 2021 18:05:00 -0500
Message-ID: <20210428230500.19214-1-s-anna@ti.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The commit 7c7905df68c5 ("dt-bindings: mmc: sdhci-am654: fix compatible
for j7200") switched the compatible property from a regular enum to an
more appropriate combinatorial oneOf convention, and in the process has
introduced a duplicate ti,j721e-sdhci-4bit.

This generated the following warning on J721E boards that use the
ti,j721e-sdhci-4bit for two nodes:
 "mmc@4fb0000: compatible: More than one condition true in oneOf schema"
 "mmc@4f98000: compatible: More than one condition true in oneOf schema"

Remove the duplicate to fix this.

Fixes: 7c7905df68c5 ("dt-bindings: mmc: sdhci-am654: fix compatible for j7200")
Signed-off-by: Suman Anna <s-anna@ti.com>
---
Hi Ulf,

The warning is a bit more verbose, I have minimized the log in above
commit message. You can see the issue with dtbs_check on both latest
master and linux-next using DT_SCHEMA_FILES.

regards
Suman

 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 3a79e39253d2..29399e88ac53 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -19,7 +19,6 @@ properties:
       - const: ti,am654-sdhci-5.1
       - const: ti,j721e-sdhci-8bit
       - const: ti,j721e-sdhci-4bit
-      - const: ti,j721e-sdhci-4bit
       - const: ti,am64-sdhci-8bit
       - const: ti,am64-sdhci-4bit
       - items:
-- 
2.30.1

