Return-Path: <SRS0=mt+k=2U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F62C2D0CE
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 09:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8C620748
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 09:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xjAuaiR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfL3JWj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:22:39 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40452 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfL3JWi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2019 04:22:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBU9MQ5E106905;
        Mon, 30 Dec 2019 03:22:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577697746;
        bh=sk5S0MGte4P9MP9ui73XhGoTdxKtKisMFY7hjWYkuvI=;
        h=From:To:CC:Subject:Date;
        b=xjAuaiR0lCElbE4MHymXNGqBSJTdEhcuV8qi1BE2eg/gC3wantEns9yY8T5pFWCfR
         HSDlBrbS3HQelG/EdYUgjD+eWpRt94oMhi6NcmeSKgKtFBI7cY0ir3wu2cGBLGQ/ia
         /UCV5w+RBU1cuNwz2jtTTnin4loi838hKU393wT4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBU9MQsn044598
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Dec 2019 03:22:26 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 03:22:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 03:22:26 -0600
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBU9MOJi109856;
        Mon, 30 Dec 2019 03:22:24 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>, <shawn.lin@rock-chips.com>
Subject: [PATCH 0/3] Fix issues with command queuing in arasan controllers
Date:   Mon, 30 Dec 2019 14:53:40 +0530
Message-ID: <20191230092343.30692-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In some Arasan SDHCI controllers, after tuning, the tuning pattern data
is leftover in the sdhci buffer. This leads to issues with future data
commands, especially when command queuing is enabled. The following
patches help fix this issue by resetting data lines after tuning is
finished. The first two patches have been tested with TI's am65x and
j721e SoCs using the sdhci_am654 driver.

I have a strong suspicion that this is the same issue with
the sdhci-of-arasan driver where they are forced to dump data from the
buffer before enabling command queuing. I need help from someone with a
compatible platform to test this.

Faiz Abbas (3):
  mmc: sdhci: Add Quirk to reset data lines after tuning
  mmc: sdhci_am654: Enable Quirk to reset data after tuning
  mmc: sdhci-of-arasan: Fix Command Queuing enable handling

 drivers/mmc/host/sdhci-of-arasan.c | 21 ++++-----------------
 drivers/mmc/host/sdhci.c           |  3 +++
 drivers/mmc/host/sdhci.h           |  4 ++++
 drivers/mmc/host/sdhci_am654.c     |  9 ++++++---
 4 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.19.2

