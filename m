Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625FEC43460
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Apr 2021 10:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4473C613C6
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Apr 2021 10:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbhDFKta (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Apr 2021 06:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245157AbhDFKtQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 6 Apr 2021 06:49:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CC99610C8;
        Tue,  6 Apr 2021 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617706148;
        bh=DFk3dXLYmsPJjfudy+xMdqagxU7hU8tqH5bkWHWtwnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFilJV3I5rZ6iIRvPY7OMr8e24p4PCHsJ9fqFmMwmXsdvnBPTAkgmmAIPf/axYU/N
         SufOyO6rPvvJZOQaHEXlI3bdj/1iiYFIGiUOhM4BP6eOx1SbL6qBmVPNyBwtMrb2jM
         TIxPbXUJ+7PrWAh2ApmOK7eNyBNRtKS+lnIZlo6KYt/oDT3hwlq1J+o4H/3SAbUJ/y
         7LmZEbdSNm6hom2XkRJOl8t64xBHAGGxmoqC4l6dQZzDiN9gOYOVdXsvn/DD1UCfSD
         QfiIBdJkKHppOI51tcu2aTQbDteQZifT+RS7ckx/FbFklYYMFveIoGVRL6kT0WOZf4
         /q93FGDWKYBUg==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Saenz Julienne <nsaenz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, alcooperx@gmail.com,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        robh@kernel.org, stefan.wahren@i2se.com
Subject: [PATCH 3/3] mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711
Date:   Tue,  6 Apr 2021 12:48:05 +0200
Message-Id: <20210406104802.20898-4-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406104802.20898-1-nsaenz@kernel.org>
References: <20210406104802.20898-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The controller doesn't seem to pick-up on clock changes, so set the
SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN flag to query the clock frequency
directly from the clock.

Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 drivers/mmc/host/sdhci-iproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 1ef888e91f73..31f61ea474f0 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -295,7 +295,8 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
 };
 
 static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
-	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.ops = &sdhci_iproc_bcm2711_ops,
 };
 
-- 
2.30.2

