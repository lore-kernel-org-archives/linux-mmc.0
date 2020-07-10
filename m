Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7E1C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FDC2078B
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m608z0q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgGJLLH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJLLH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:11:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E729C08C5CE;
        Fri, 10 Jul 2020 04:11:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so2104815pld.12;
        Fri, 10 Jul 2020 04:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3VOa+Y0HTmbN1kJlGhfKpuHNVKRU2nXIafR93epWKM=;
        b=m608z0q3Dxy2rh5vH1gGrZfO2x7yIKk6ZWGZTzGMDJ9EAJtG64jdzVyuR72ci1PyDK
         sviN2r1yqZ9c4qZVmV+fg39bGWfLjbj+qIXBOm76dILQgVzsQMtkT2W30KUdUrLbrbkQ
         UcTStnHn7UJJTxkGJ95mH1mFicZGRUjdSJbRP1aWO8FJ00xMceUY+ArCg1oUIEK/5al4
         FUiT0Uu6/uQ90Dn25DZvwERz9WdtvCgJz0EofahrhpDm5kZQadLjxpog8W9v2hQTsJk6
         FGnrvbKcy/pMxKtZ+UU6pj+O4RAWYd22mPnD0rVjdOxCDrvYWlsEx8kMyXws13Kq+OVo
         /BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3VOa+Y0HTmbN1kJlGhfKpuHNVKRU2nXIafR93epWKM=;
        b=RE0ZnBnoA76YzN79MQpyICWO5xvMIRxmN/8pO4BTDytVHqH5fAk40rdCj99wIoCHV4
         ppjWlCTAhPeQb/kEQ9YxqPfkAJCRPQKy/vzTiySAPGtQTHuGHuaTohrtiUoN4Czu9U7H
         SfwDtZOBLIWcj9vXX+uWyYsrRsaKWairbtz6U7jOQGTMqDwA3esUfYobaLYMNQaCYnOL
         EwCRDPrRn7nwhnlyZKC3mxAUzgRgIYoS9ni56jySX7JOu6HUB2XCB4tJNB5Y7xErI62H
         uneQAEfJV/aLl2uCIlHvFldHfTDznvZcDAUXm+P/ZGVB9SadRfmsdUJRPX+ONVjaqzlG
         wnig==
X-Gm-Message-State: AOAM531HUYhABaC7BjhgA5AN6aBWDElTgQ4Q0AxOJva18KZTv4udYhkH
        eIQCUHo9BNryIBv9pL7dhr2G7Utf
X-Google-Smtp-Source: ABdhPJwIJC1SSYNiZZSL03Zy9Nj63dzhvrE/+Bv1ETUo6pTvMwARn8QU77b8M3yL3g9+3XQXbvbm2w==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr18325011ply.140.1594379466687;
        Fri, 10 Jul 2020 04:11:06 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id h6sm5825010pfo.123.2020.07.10.04.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:11:06 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 15/21] mmc: sdhci: UHS-II support, modify set_power() to handle vdd2
Date:   Fri, 10 Jul 2020 19:11:40 +0800
Message-Id: <20200710111140.29725-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

VDD2 is used for powering UHS-II interface.
Modify sdhci_set_power_and_bus_voltage(), sdhci_set_power_noreg()
and sdhci_set_power_noreg() to handle VDD2.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-omap.c     |  2 +-
 drivers/mmc/host/sdhci-pci-core.c |  4 +--
 drivers/mmc/host/sdhci-pxav3.c    |  4 +--
 drivers/mmc/host/sdhci-xenon.c    |  4 +--
 drivers/mmc/host/sdhci.c          | 42 ++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.h          |  9 +++----
 6 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 1ec74c2d5c17..1926585debe5 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -678,7 +678,7 @@ static void sdhci_omap_set_clock(struct sdhci_host *host, unsigned int clock)
 }
 
 static void sdhci_omap_set_power(struct sdhci_host *host, unsigned char mode,
-			  unsigned short vdd)
+			  unsigned short vdd, unsigned short vdd2)
 {
 	struct mmc_host *mmc = host->mmc;
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index bb6802448b2f..40f5a24a8982 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -629,12 +629,12 @@ static int bxt_get_cd(struct mmc_host *mmc)
 #define SDHCI_INTEL_PWR_TIMEOUT_UDELAY	100
 
 static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
-				  unsigned short vdd)
+				  unsigned short vdd, unsigned short vdd2)
 {
 	int cntr;
 	u8 reg;
 
-	sdhci_set_power(host, mode, vdd);
+	sdhci_set_power(host, mode, vdd, -1);
 
 	if (mode == MMC_POWER_OFF)
 		return;
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e55037ceda73..457e9425339a 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -298,12 +298,12 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 }
 
 static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
-			    unsigned short vdd)
+			    unsigned short vdd, unsigned short vdd2)
 {
 	struct mmc_host *mmc = host->mmc;
 	u8 pwr = host->pwr;
 
-	sdhci_set_power_noreg(host, mode, vdd);
+	sdhci_set_power_noreg(host, mode, vdd, -1);
 
 	if (host->pwr == pwr)
 		return;
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 4703cd540c7f..2b0ebb91895a 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -214,12 +214,12 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
 }
 
 static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
-		unsigned short vdd)
+		unsigned short vdd, unsigned short vdd2)
 {
 	struct mmc_host *mmc = host->mmc;
 	u8 pwr = host->pwr;
 
-	sdhci_set_power_noreg(host, mode, vdd);
+	sdhci_set_power_noreg(host, mode, vdd, -1);
 
 	if (host->pwr == pwr)
 		return;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d38d734ec83f..ca3d4a506e01 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2089,12 +2089,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
 static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
-				unsigned short vdd)
+				unsigned short vdd, unsigned short vdd2)
 {
 	struct mmc_host *mmc = host->mmc;
 
 	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 
+	if (mmc->caps & MMC_CAP_UHS2 && !IS_ERR(mmc->supply.vmmc2))
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, vdd2);
+
 	if (mode != MMC_POWER_OFF)
 		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
 	else
@@ -2102,7 +2105,7 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 }
 
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
-			   unsigned short vdd)
+			   unsigned short vdd, unsigned short vdd2)
 {
 	u8 pwr = 0;
 
@@ -2133,6 +2136,20 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 		}
 	}
 
+	if (mode != MMC_POWER_OFF) {
+		if (vdd2 != (unsigned short)-1) {
+			switch (1 << vdd2) {
+			case MMC_VDD2_165_195:
+				pwr |= SDHCI_VDD2_POWER_180;
+				break;
+			default:
+				WARN(1, "%s: Invalid vdd2 %#x\n",
+				     mmc_hostname(host->mmc), vdd2);
+				break;
+			}
+		}
+	}
+
 	if (host->pwr == pwr)
 		return;
 
@@ -2159,7 +2176,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
 
 		pwr |= SDHCI_POWER_ON;
+		if (vdd2 != (unsigned short)-1)
+			pwr |= SDHCI_VDD2_POWER_ON;
+
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
+		mdelay(5);
 		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		mdelay(5);
 
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_on(host);
@@ -2175,12 +2198,12 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);
 
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
-		     unsigned short vdd)
+		     unsigned short vdd, unsigned short vdd2)
 {
 	if (IS_ERR(host->mmc->supply.vmmc))
-		sdhci_set_power_noreg(host, mode, vdd);
+		sdhci_set_power_noreg(host, mode, vdd, vdd2);
 	else
-		sdhci_set_power_reg(host, mode, vdd);
+		sdhci_set_power_reg(host, mode, vdd, vdd2);
 }
 EXPORT_SYMBOL_GPL(sdhci_set_power);
 
@@ -2192,14 +2215,15 @@ EXPORT_SYMBOL_GPL(sdhci_set_power);
  */
 void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned char mode,
-				     unsigned short vdd)
+				     unsigned short vdd,
+				     unsigned short vdd2)
 {
 	if (!IS_ERR(host->mmc->supply.vmmc)) {
 		struct mmc_host *mmc = host->mmc;
 
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 	}
-	sdhci_set_power_noreg(host, mode, vdd);
+	sdhci_set_power_noreg(host, mode, vdd, -1);
 }
 EXPORT_SYMBOL_GPL(sdhci_set_power_and_bus_voltage);
 
@@ -2377,9 +2401,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	if (host->ops->set_power)
-		host->ops->set_power(host, ios->power_mode, ios->vdd);
+		host->ops->set_power(host, ios->power_mode, ios->vdd, -1);
 	else
-		sdhci_set_power(host, ios->power_mode, ios->vdd);
+		sdhci_set_power(host, ios->power_mode, ios->vdd, -1);
 
 	/* 4.0 host support */
 	if (host->version >= SDHCI_SPEC_400) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index ecf55394ea46..f6732f33f29f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -689,7 +689,7 @@ struct sdhci_ops {
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
 	void	(*set_power)(struct sdhci_host *host, unsigned char mode,
-			     unsigned short vdd);
+			     unsigned short vdd, unsigned short vdd2);
 
 	u32		(*irq)(struct sdhci_host *host, u32 intmask);
 
@@ -852,13 +852,10 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
 void sdhci_enable_clk(struct sdhci_host *host, u16 clk);
-void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
-		     unsigned short vdd);
 void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned char mode,
-				     unsigned short vdd);
-void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
-			   unsigned short vdd);
+				     unsigned short vdd,
+				     unsigned short vdd2);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
-- 
2.27.0

