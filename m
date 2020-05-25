Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2944C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 07:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874052073B
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 07:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbgEYHl6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 03:41:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:12119 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389100AbgEYHl5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 May 2020 03:41:57 -0400
IronPort-SDR: ZQRDNMhBSUx6nRkPnDD0ILHp54ZncEzzaOyGQYSXem8tecFP3DHmIrPDEElGmSfYkYL5j4Sebr
 H4GIcICPNfgg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 00:41:56 -0700
IronPort-SDR: EhtfxJKT7puHs//4h3Slq54GHPt/QVzuAECaYnBD8tT1p1zn517rJvIwSricqYg4jfICNRJVFG
 +HVxXShnfa+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="266078332"
Received: from cvg-ubt08.iil.intel.com (HELO cvg-ubt08.me-corp.lan) ([10.185.176.12])
  by orsmga003.jf.intel.com with ESMTP; 25 May 2020 00:41:55 -0700
From:   Vladimir Kondratiev <vladimir.kondratiev@intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-cadence: fix PHY write
Date:   Mon, 25 May 2020 10:40:53 +0300
Message-Id: <20200525074053.7309-1-vladimir.kondratiev@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Accordingly to Cadence documentation, PHY write procedure is:

1. Software sets the PHY Register Address (HRS04[5:0]) and the
   PHY Write Data (HRS04[15:8]) fields.
2. Software sets the PHY Write Transaction Request (HRS04[24]) field to 1.
3. Software waits as the PHY Write Transaction Acknowledge (HRS04[26])
   field is equal to 0.
4. Hardware performs the write transaction to PHY register where
   HRS04[15:8] is a data written to register under HRS04[5:0] address.
5. Hardware sets the PHY Transaction Acknowledge (HRS04[26]) to 1 when
   transaction is completed.
6. Software clears the PHY Write Transaction Request (HRS04[24]) to 1
   after noticing that the PHY Write Transaction Acknowledge (HRS04[26])
   field is equal to 1.
7. Software waits for the PHY Acknowledge Register (HRS04[26]) field is
   equal to 0.

Add missing steps 3 and 7. Lack of these steps causes
integrity errors detested by hardware.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
---
 drivers/mmc/host/sdhci-cadence.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index e474d3fa099e..6b2e7c43cbc1 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -114,6 +114,11 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 	u32 tmp;
 	int ret;
 
+	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
+				 0, 10);
+	if (ret)
+		return ret;
+
 	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
 	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
 	writel(tmp, reg);
@@ -128,7 +133,10 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 	tmp &= ~SDHCI_CDNS_HRS04_WR;
 	writel(tmp, reg);
 
-	return 0;
+	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
+				 0, 10);
+
+	return ret;
 }
 
 static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
-- 
2.20.1

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

