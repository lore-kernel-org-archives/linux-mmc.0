Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91C0C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Apr 2022 10:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiDRKXj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Apr 2022 06:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiDRKXh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2022 06:23:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB691209A;
        Mon, 18 Apr 2022 03:20:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23IAKkqR036615;
        Mon, 18 Apr 2022 05:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650277246;
        bh=zY22PNRLriaOjHB5QGlSiuJXOyutP2Csb5FCgW8BC9s=;
        h=From:To:CC:Subject:Date;
        b=ExlFsMKOs8MUmxbBWfjWYVxuUs9pa91H4yb0uMIT1GcGSYsFphtTr60+GlDnrAY4R
         epkBJJjLIc2TBvKIIMEgtHuONb6YodsP49RQJe6FUfGh7mhd8aIh2orARuMCjrCHwz
         kHnoay9tBAZCQ/nmBYkRiORfUphGZ2s69LAu+QHQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23IAKkt6070455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Apr 2022 05:20:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 18
 Apr 2022 05:20:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 18 Apr 2022 05:20:46 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23IAKgTY021324;
        Mon, 18 Apr 2022 05:20:43 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] MMC: Add quirk to set the TESTCD bit
Date:   Mon, 18 Apr 2022 15:50:38 +0530
Message-ID: <20220418102040.4993-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The following series of patches add support for setting TESTCD bit
when SDCD line is connected to the controller, in the sdhci_am654.c
driver.

Aswath Govindraju (1):
  dt-bindings: mmc: sdhci-am654: Add flag to force setting to TESTCD bit

Vignesh Raghavendra (1):
  drivers: mmc: sdhci_am654: Add the quirk to set TESTCD bit

 .../devicetree/bindings/mmc/sdhci-am654.yaml  |  7 ++++++
 drivers/mmc/host/sdhci_am654.c                | 23 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.17.1

