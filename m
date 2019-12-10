Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB9EC2D0CD
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0086207FF
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q8dAHncS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfLJJuu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:50:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37864 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJuu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 04:50:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBA9odiL055607;
        Tue, 10 Dec 2019 03:50:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575971439;
        bh=3/2/4TqPWi9y2MRMMJxSgZoD8FE5fToV9VA4meBh3OA=;
        h=From:To:CC:Subject:Date;
        b=Q8dAHncSrM3uAXx+oqmTTbaP2ZM5fvhRt4JtSZEqGol6IwcOqZPp/qoBlDx7vIOhy
         6zY1XNZTbZnHKMI6e7YF6hulKH24u7KAUbJo7EKBlzQyObS2KncALKfEFMZfoNqGLr
         4UBZgD2MzPUBTYyTStApIt+MznIqqof6lUqJoYvg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBA9odNO018132
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 03:50:39 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 03:50:39 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 03:50:39 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBA9oZVj048503;
        Tue, 10 Dec 2019 03:50:36 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <adrian.hunter@intel.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>,
        <zhang.chunyan@linaro.org>, <tony@atomide.com>
Subject: [PATCH v3 0/7] Port am335 and am437 devices to sdhci-omap
Date:   Tue, 10 Dec 2019 15:21:44 +0530
Message-ID: <20191210095151.15441-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The following add driver patches for porting TI's am335x and am437x
devices to the sdhci-omap driver.

This involves adding external DMA support to sdhci (first 3 patches from
Chunyan) plus some miscellaneous patches to take care of deviations of
the controllers from the sdhci model.

DT changes will be posted in a separate series.

Untested versions of Chunyan's patches were posted before[1].

Tested on: am335x-evm, am335x-boneblack, am335x-sk, am437x-gpevm,
am43xx-gpevm, am437x-idk, dra7xx-evm, dra72x-evm.

I need some help with testing all the other beaglebone variants and SDIO
Wifi cards.

v3:
1. Dropped patch 1 because the tasklet was removed by Adrian in an
   earlier series.
2. Added dma bindings in sdhci-omap as optional properties.
3. Rebased on top of latest mainline.

v2:
1. sdhci is using two bottom halves. One threaded_rq for card detect and a
   tasklet for finishing mmc requests. Patch 1 removes the tasklet and
   moves its function to the threaded_irq. This enables me to
   terminate_sync() in sdhci_request_done()

2. Factored out common code for between the normal adn external dma case

3. Using existing API sdhci_data_timeout_irq for disabling DTO during
   erase commands.

4. Fixed subject line for dt-bindings patch.

[1] https://patchwork.kernel.org/project/linux-mmc/list/?series=54897


Chunyan Zhang (3):
  dt-bindings: sdhci-omap: Add properties for using external dma
  mmc: sdhci: add support for using external DMA devices
  mmc: sdhci-omap: Add using external dma

Faiz Abbas (4):
  mmc: sdhci: Add quirk for disabling DTO during erase command
  mmc: sdhci-omap: Add DISABLE_DTO_FOR_ERASE Quirk
  dt-bindings: sdhci-omap: Add am335x and am437x specific bindings
  mmc: sdhci-omap: Add am335x and am437x specific compatibles

 .../devicetree/bindings/mmc/sdhci-omap.txt    |  11 +
 drivers/mmc/host/Kconfig                      |   4 +
 drivers/mmc/host/sdhci-omap.c                 |  27 +-
 drivers/mmc/host/sdhci.c                      | 290 ++++++++++++++++--
 drivers/mmc/host/sdhci.h                      |  10 +
 5 files changed, 313 insertions(+), 29 deletions(-)

-- 
2.19.2

