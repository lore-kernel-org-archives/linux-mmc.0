Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8518C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A165561211
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 08:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbhIXIap (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 04:30:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28217 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244751AbhIXIan (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 04:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632472150; x=1664008150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6RFw3CEdx2ujGv1ZMTk7ZmOvBNCWxk2140ohyeWFgKQ=;
  b=Dc4gGNjDVYzaRIViJLoYYyLjAOudP95icpcLCByDTB2uqQzJ65Nc5ppt
   TqfeuO3PXBhB6YIz1X7Fma7rRp68czAJCxfgUEaAREK9R3wXvoucVxYMV
   CNd/jBQKrMnyHqGxajatRz27jDlw9ilySkC98Z5BUR0bKkDPcZrRi204s
   Crfbuu5RadEx9UGkeW/gangP0a8ES2UueYg9vGAEX4KSCgYFfEzKdaBm0
   p3x5tS2DO1eHWSK9TBu+Aqm6PEyv4K6UYZ3tDpwMxtJvA6nulBo567YMv
   YJ+JVEJj2iA1hoFeAB/zbAvFADXqBcvHOM6NiVZLk7PLVAdKBs4B3j2c7
   A==;
IronPort-SDR: ONtq2d+CxrUYaZU1ULS83K/qDMjINXdbZ1EKg0Af13hYHiuDfXjGrICKN+8Xl5yDAdCcUkEAKB
 S/iuZnIerzZL7Vv4TGobsGpIvIycP09J9XzRkN+T4elZuv1OUbNncXgs728OOzeq3ZupskcLM8
 LqRpvFLg/wsm/Os2GNc1NPGzV63xhPr4gSVZj9y9RlKZq3tzqxzoVbXG7c7KLAp/Z43Mo0L+hd
 57mbIOiRnXAJcqt1MWvaVyf9sord2vIsaVrlam1q/UL+beBI4nCdD1S5LHUio1B6RVMjl5CnNG
 qm02uMEa6oHOzIvabUtr1zef
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="130489842"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 01:29:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 01:29:06 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 01:29:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/2] mmc: sdhci-of-at91: replace while loop with read_poll_timeout
Date:   Fri, 24 Sep 2021 11:28:51 +0300
Message-ID: <20210924082851.2132068-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
References: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Replace while loop with read_poll_timeout().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 134ba01d3063..d1a1c548c515 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -62,7 +62,6 @@ static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
 static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	u16 clk;
-	unsigned long timeout;
 
 	host->mmc->actual_clock = 0;
 
@@ -87,16 +86,11 @@ static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 	/* Wait max 20 ms */
-	timeout = 20;
-	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
-		& SDHCI_CLOCK_INT_STABLE)) {
-		if (timeout == 0) {
-			pr_err("%s: Internal clock never stabilised.\n",
-			       mmc_hostname(host->mmc));
-			return;
-		}
-		timeout--;
-		mdelay(1);
+	if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
+			      1000, 20000, false, host, SDHCI_CLOCK_CONTROL)) {
+		pr_err("%s: Internal clock never stabilised.\n",
+		       mmc_hostname(host->mmc));
+		return;
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
-- 
2.25.1

