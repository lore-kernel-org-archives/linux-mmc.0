Return-Path: <SRS0=u+69=AA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F505C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF7B20776
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zQg1S8qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgFSM6a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:58:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54210 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbgFSM63 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2020 08:58:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05JCw7df021167;
        Fri, 19 Jun 2020 07:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592571487;
        bh=627WHwGqg1ZFjaV1G7jF2Zn5SB1SAYdN7x254Mzb8dg=;
        h=From:To:CC:Subject:Date;
        b=zQg1S8qRaYA0R9d5rlvOyzr4N1JM7LPGBuivht4YIfUY3CcKOw3/IJVsUrjZu5syS
         2//i38fVpIExO8tLY0/1rx4+DDZzNYLwvsM0sNU1dDF2Y5iQBmo0nwX7drvit0KLtT
         aDptFDxQTogVilKCyQABNV526HrHtaa7A9vNGhRk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05JCw70r080908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 07:58:07 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 19
 Jun 2020 07:58:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 19 Jun 2020 07:58:06 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCw2Hk015675;
        Fri, 19 Jun 2020 07:58:03 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
CC:     <faiz_abbas@ti.com>
Subject: [PATCH 0/7] Add support for SD card in AM654x-evm
Date:   Fri, 19 Jun 2020 18:27:54 +0530
Message-ID: <20200619125801.9530-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The following patches add driver support for SD card on the
am654x-evm. It only enables high speed mode with UHS mode
support coming in a future series.

DTS support will be added in another series as well.

Faiz Abbas (7):
  dt-bindings: mmc: sdhci-am654: Add ti,clkbuf-sel binding
  mmc: sdhci_am654: Add flag for PHY calibration
  mmc: sdhci_am654: Add Support for SR2.0
  mmc: sdhci_am654: Fix conditions for enabling dll
  mmc: sdhci_am654: Update delay chain configuration
  mmc: sdhci_am654: Add support for clkbuf_sel property
  arm64: defconfig: Enable AM654x SDHCI controller

 .../devicetree/bindings/mmc/sdhci-am654.txt   |  1 +
 arch/arm64/configs/defconfig                  |  1 +
 drivers/mmc/host/sdhci_am654.c                | 86 ++++++++++++++-----
 3 files changed, 65 insertions(+), 23 deletions(-)

-- 
2.17.1

