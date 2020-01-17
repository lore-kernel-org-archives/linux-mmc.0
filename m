Return-Path: <SRS0=ySr4=3G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DEFC33CB1
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 06:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE2020661
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 06:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgAQGlF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jan 2020 01:41:05 -0500
Received: from inva021.nxp.com ([92.121.34.21]:33260 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgAQGlF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Jan 2020 01:41:05 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B088200239;
        Fri, 17 Jan 2020 07:41:02 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 039EB200D3B;
        Fri, 17 Jan 2020 07:41:00 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6D536402A8;
        Fri, 17 Jan 2020 14:40:57 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: fix transfer mode register reading
Date:   Fri, 17 Jan 2020 14:38:58 +0800
Message-Id: <20200117063858.37296-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The standard SD controller uses two 16-bit registers for
command sending.
0xC: Transfer Mode Register
0xE: Command Register

But the eSDHC controller uses one 32-bit register instead.
0xC: XFERTYPE

For Transfer Mode Register and Command Register writing,
the eSDHC driver will store Transfer Mode Register value in
a variable first. When Command Register writing happens,
driver will directly write a 32-bit value into XFERTYPE
register.

But for Transfer Mode Register reading, driver just returns
a actual value. This may cause issue for some read-modify-write
operations. We should make both reading and write on that variable
for Transfer Mode Register.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8c06017..3ef4973 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -173,6 +173,9 @@ static u16 esdhc_readw_fixup(struct sdhci_host *host,
 	u16 ret;
 	int shift = (spec_reg & 0x2) * 8;
 
+	if (spec_reg == SDHCI_TRANSFER_MODE)
+		return pltfm_host->xfer_mode_shadow;
+
 	if (spec_reg == SDHCI_HOST_VERSION)
 		ret = value & 0xffff;
 	else
-- 
2.7.4

