Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835B0C282DD
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 15:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562AE20705
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 15:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DwgBmErT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAHPHy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:07:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43344 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgAHPHx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 10:07:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008F7ofC014550;
        Wed, 8 Jan 2020 09:07:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578496070;
        bh=nABr0rOy2x3lVMXTWU5UFQKT88ibNI0DZI1k0DXXm1g=;
        h=From:To:CC:Subject:Date;
        b=DwgBmErTNRTBxZ1yQAz126k7JknMk2vOe8t4wMKOcKueQQLrYFch3xVJwmrPHjMh9
         FbsVBXr+nHW1lSVHNzEJ2my24avSboZ6Anqv87e1jiCdKA5bGDWKb2++vpyfYU+Ot9
         YzyMIIWVbd7po7puPDlMPmoxtGvbeiSk6SyMbxR4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008F7oWA105408;
        Wed, 8 Jan 2020 09:07:50 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 09:07:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 09:07:50 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008F7ln0018107;
        Wed, 8 Jan 2020 09:07:48 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>, <robh+dt@kernel.org>
Subject: [PATCH 0/3] Update phy configuration for AM65x
Date:   Wed, 8 Jan 2020 20:39:17 +0530
Message-ID: <20200108150920.14547-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The following patches update phy configurations for AM65x as given in
the latest data manual.

The patches depend on my fixes series posted just before this:
https://patchwork.kernel.org/project/linux-mmc/list/?series=225425

Device tree patch updating the actual otap values will be posted
separately.

Tested with Am65x-evm and J721e-evm.

Faiz Abbas (3):
  dt-bindings: mmc: sdhci-am654: Update Output tap delay binding
  mmc: sdhci_am654: Update OTAPDLY writes
  mmc: sdhci_am654: Enable DLL only for some speed modes

 .../devicetree/bindings/mmc/sdhci-am654.txt   |  21 +-
 drivers/mmc/host/sdhci_am654.c                | 247 ++++++++++++------
 include/linux/mmc/host.h                      |   2 +
 3 files changed, 192 insertions(+), 78 deletions(-)

-- 
2.19.2

