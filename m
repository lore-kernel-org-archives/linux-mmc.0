Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3EAC352BE
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882B222240
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgDPQhD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:37:03 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46287 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgDPQhC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 12:37:02 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4934cq4K1Pz1r6R5;
        Thu, 16 Apr 2020 18:36:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4934cp4Bn5z1qr47;
        Thu, 16 Apr 2020 18:36:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ZoZDHDCLihue; Thu, 16 Apr 2020 18:36:57 +0200 (CEST)
X-Auth-Info: 762ekcraQhPWqvLrHV+UHKpIstfAt+4zYBipCVN2Z4s=
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz [86.49.35.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 16 Apr 2020 18:36:57 +0200 (CEST)
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
Subject: [PATCH V2 2/3] mmc: Return 1 from mmc_regulator_set_vqmmc() if switch skipped
Date:   Thu, 16 Apr 2020 18:36:48 +0200
Message-Id: <20200416163649.336967-2-marex@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416163649.336967-1-marex@denx.de>
References: <20200416163649.336967-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adjust mmc_regulator_set_vqmmc() to return 1 if the voltage switch was
skipped because the regulator voltage was already correct. This allows
drivers to detect such condition and possibly skip various voltage
switching extras.

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
V2: - Rename variable curr_voltage to current_uV
    - Update mmc_regulator_set_vqmmc() to handle the fact that
      mmc_regulator_set_voltage_if_supported() can return value > 0
---
 drivers/mmc/core/regulator.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index b6febbcf8978..96b1d15045d6 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -136,6 +136,8 @@ static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
 						  int min_uV, int target_uV,
 						  int max_uV)
 {
+	int current_uV;
+
 	/*
 	 * Check if supported first to avoid errors since we may try several
 	 * signal levels during power up and don't want to show errors.
@@ -143,6 +145,14 @@ static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
 	if (!regulator_is_supported_voltage(regulator, min_uV, max_uV))
 		return -EINVAL;
 
+	/*
+	 * The voltage is already set, no need to switch.
+	 * Return 1 to indicate that no switch happened.
+	 */
+	current_uV = regulator_get_voltage(regulator);
+	if (current_uV == target_uV)
+		return 1;
+
 	return regulator_set_voltage_triplet(regulator, min_uV, target_uV,
 					     max_uV);
 }
@@ -198,9 +208,10 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * voltage in two steps and try to stay close to vmmc
 		 * with a 0.3V tolerance at first.
 		 */
-		if (!mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
-						min_uV, volt, max_uV))
-			return 0;
+		ret = mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
+							min_uV, volt, max_uV);
+		if (ret >= 0)
+			return ret;
 
 		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
 						2700000, volt, 3600000);
-- 
2.25.1

