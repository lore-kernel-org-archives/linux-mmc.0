Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F740C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Apr 2022 06:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiDYGeo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiDYGej (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2022 02:34:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E7636C;
        Sun, 24 Apr 2022 23:31:36 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23P6VRiH115027;
        Mon, 25 Apr 2022 01:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650868287;
        bh=4QBJHNetsb9nr0Gngo4I1V9MZEueDFepjXgelnO7xyo=;
        h=From:To:CC:Subject:Date;
        b=u210ydZQmbE25kWcIUlWzhuZwvHsp7BTLOdn01GIVOQndwi7SWD6Ri+uwMe3/ka6G
         A9sldnJAV5Z5m5F9ELSzAjRr/jWzIisQvE6L9TLsRc5Y7p58cqnvsu8bQPGvL6u58H
         xhlHY9zvLW1CtVSrJGnsSsnsSlbjGYPePKAKZVak=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23P6VRJY125619
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 01:31:27 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 01:31:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 01:31:26 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23P6VNNN079479;
        Mon, 25 Apr 2022 01:31:24 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] MMC: Add quirk to set the TESTCD bit
Date:   Mon, 25 Apr 2022 12:01:18 +0530
Message-ID: <20220425063120.10135-1-a-govindraju@ti.com>
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

Changes since v1:
- Rephrased the commit message in patch 1 to decribe the hardware
  and not the sw support
- Made the reset function static in patch 2

Aswath Govindraju (1):
  dt-bindings: mmc: sdhci-am654: Add flag to force setting of TESTCD bit

Vignesh Raghavendra (1):
  drivers: mmc: sdhci_am654: Add the quirk to set TESTCD bit

 .../devicetree/bindings/mmc/sdhci-am654.yaml  |  7 ++++++
 drivers/mmc/host/sdhci_am654.c                | 23 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.17.1

