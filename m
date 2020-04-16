Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864BDC2BB55
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2712222D
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgDPQhD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729697AbgDPQhC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 12:37:02 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC50C061A0F
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 09:37:01 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4934cr3fK6z1ryXR;
        Thu, 16 Apr 2020 18:37:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4934cr2Fbyz1qr41;
        Thu, 16 Apr 2020 18:37:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id gSXwYY6dOFts; Thu, 16 Apr 2020 18:36:58 +0200 (CEST)
X-Auth-Info: MJkMHv5+LxYhi+3b5NCVG7TqxEiY2WjNpwVZlByK5To=
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz [86.49.35.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 16 Apr 2020 18:36:58 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V2 3/3] mmc: mmci: Switch to mmc_regulator_set_vqmmc()
Date:   Thu, 16 Apr 2020 18:36:49 +0200
Message-Id: <20200416163649.336967-3-marex@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416163649.336967-1-marex@denx.de>
References: <20200416163649.336967-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Instead of reimplementing the logic in mmc_regulator_set_vqmmc(),
use the mmc code function directly.

This fixes a real issue on STM32MP1 where, if the eMMC is supplied with
VccQ=1.8 V, the post voltage switch code will spin indefinitelly waiting
for the voltage switch to complete, even though no voltage switch really
happened. But since mmc_set_signal_voltage() would return 0, then the
condition for calling .post_sig_volt_switch() is not satisfied if the
switch did not happen.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ludovic Barre <ludovic.barre@st.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Patrick Delaunay <patrick.delaunay@st.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-mmc@vger.kernel.org
---
V2: Reword commit message
---
 drivers/mmc/host/mmci.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 647567def612..a69d6a0c2e15 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1861,31 +1861,17 @@ static int mmci_get_cd(struct mmc_host *mmc)
 static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmci_host *host = mmc_priv(mmc);
-	int ret = 0;
-
-	if (!IS_ERR(mmc->supply.vqmmc)) {
+	int ret;
 
-		switch (ios->signal_voltage) {
-		case MMC_SIGNAL_VOLTAGE_330:
-			ret = regulator_set_voltage(mmc->supply.vqmmc,
-						2700000, 3600000);
-			break;
-		case MMC_SIGNAL_VOLTAGE_180:
-			ret = regulator_set_voltage(mmc->supply.vqmmc,
-						1700000, 1950000);
-			break;
-		case MMC_SIGNAL_VOLTAGE_120:
-			ret = regulator_set_voltage(mmc->supply.vqmmc,
-						1100000, 1300000);
-			break;
-		}
+	ret = mmc_regulator_set_vqmmc(mmc, ios);
 
-		if (!ret && host->ops && host->ops->post_sig_volt_switch)
-			ret = host->ops->post_sig_volt_switch(host, ios);
+	if (!ret && host->ops && host->ops->post_sig_volt_switch)
+		ret = host->ops->post_sig_volt_switch(host, ios);
+	else if (ret)
+		ret = 0;
 
-		if (ret)
-			dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
-	}
+	if (ret < 0)
+		dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
 
 	return ret;
 }
-- 
2.25.1

