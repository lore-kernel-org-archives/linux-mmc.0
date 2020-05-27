Return-Path: <SRS0=ylMS=7J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9682C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 10:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A5B20888
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 10:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M50TPks8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbgE0K53 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 May 2020 06:57:29 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:12826 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgE0K52 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 May 2020 06:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590577047; x=1622113047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qRA+oC9tZx1B+vIUo3ULzvQS5oErAP6UNoXsB48BUDA=;
  b=M50TPks84vymU1Dmg3u62HHkXrThJsjxu5SMJGLa9vdZX3A247Yi9ITJ
   T9d3KInQtwbYmF7/jv9jAvG24MXFRXPpt32NpHMIH58qZPNcLd+XaXKED
   6539tq8jGMcHaIkCsWX7AxZwQc2suYvpqTkYH3trA/VqTIo+3zgf3eq6r
   0Zy/RBUELphOIC/Dc93Yz6tIHw1JhgpWrXL37tw7iN02kSc0I3A/CAn1t
   D8kSCTpe+MPvgJ9SSw3Nm/+EeQsqBGqXldIvcPOWtFWBFv20cdUVRKEn9
   it/kZq4WnpiUn6DncvwFlb9PxtbrdImO8at657wbRb79iOz8vwM0DxidG
   A==;
IronPort-SDR: AZDZqxdfCTzspJ/Gm4ZZw0RNHGplphn57NF+/SJJdoQzSqBpVLiNFiPBI+NnlMFWVWesqcFQPG
 uLYxGJeRp6PKuYGdO+IsXxfJoAr0jEV3Ns6I3xVVyaBspezSlJRN1uS8PbTvhBux5+sMcp5V/p
 BvwqTqFYEAsjFG3eNFLQtf7HUv1KYq/djmn8YuuUbOO90rXnHgJlpdGYcVSjoskBkEsDmVrwea
 pZNSNdmwehjm7qJbCD9sEEBg7HTCcdbh2C43Kvp2KxRIYmdwlQNlvKbpUGMaPzNLTPJd3RSatS
 xes=
X-IronPort-AV: E=Sophos;i="5.73,441,1583218800"; 
   d="scan'208";a="74602760"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 May 2020 03:57:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 May 2020 03:57:20 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 27 May 2020 03:57:15 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linux-mmc@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] mmc: sdhci-of-at91: fix CALCR register being rewritten
Date:   Wed, 27 May 2020 13:56:59 +0300
Message-ID: <20200527105659.142560-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When enabling calibration at reset, the CALCR register was completely
rewritten. This may cause certain bits being deleted unintentedly.
Fix by issuing a read-modify-write operation.

Fixes: 727d836a375a ("mmc: sdhci-of-at91: add DT property to enable calibration on full reset")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 25f4e0f4f53b..1ece2c50042c 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -121,9 +121,12 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
 	    || mmc_gpio_get_cd(host->mmc) >= 0)
 		sdhci_at91_set_force_card_detect(host);
 
-	if (priv->cal_always_on && (mask & SDHCI_RESET_ALL))
-		sdhci_writel(host, SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
+	if (priv->cal_always_on && (mask & SDHCI_RESET_ALL)) {
+		u32 calcr = sdhci_readl(host, SDMMC_CALCR);
+
+		sdhci_writel(host, calcr | SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
 			     SDMMC_CALCR);
+	}
 }
 
 static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
-- 
2.25.1

