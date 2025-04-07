Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419C18E743;
	Mon,  7 Apr 2025 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744064832; cv=none; b=tJHVg9T6HleQ/QyK6OArWDhFhxLNjXxRlG5ZBQt2bRnsHsPSU5gTfWr4a1juBaD3kcUD/A+8DodqbP/+WzDe1arbmQyWo5m4QwUXW9XPfJJ1nybWUParnzHCqOA0NVxU8pJcF1RMsjfwEcSdvpOJGTsAKHosw0fqNcv6iaf9Fiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744064832; c=relaxed/simple;
	bh=QBBGdTOap4TTUmiPVlt8m+1Kw6mDb9jrIOwV2YJn2es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqwJ7icjd0+3hoh2ingDSc6TJOSl5ysMd9VKw7adgK4QGHyz+TBt5CeR4gZB3M6LGwaKbvsjW+ri6W9AaN8tp987qyBLNihPUS7pnRdXlbJz/jTuDWieHH05nJwkwMOP5cyalyCPc9pX1mtjLnbVP1vgz6Ek4r4TlHkBN8TF9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YWJY8TYi; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YWJY8TYi"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 537MR3KC984374
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 17:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744064823;
	bh=ZzA8TVtzp+E7ibh8aZ6+b+ehe2yA3To0p+8jBVMjF2g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YWJY8TYimEExP/ZzSBc3YwmcZqtfZp/2bDxPpWsDJP2MaRr/5OBpP8uc1gIl/RFGk
	 qJgYYoA4ZeY+IUOYeqBd8S6sgOX2oBF1XEyq7hoTpVnE3clMs23i5BTBe2UZd+D2Zm
	 cUtD9ZSd2mPtFaB8zgnvxb8YE00L/5XCgN9n4e1g=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 537MR3Xo026292
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Apr 2025 17:27:03 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Apr 2025 17:27:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Apr 2025 17:27:02 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 537MR229073249;
	Mon, 7 Apr 2025 17:27:02 -0500
From: Judith Mendez <jm@ti.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>
Subject: [PATCH 1/2] PENDING: mmc: sdhci*: Add set_hs_ena to sdhci_ops
Date: Mon, 7 Apr 2025 17:27:01 -0500
Message-ID: <20250407222702.2199047-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407222702.2199047-1-jm@ti.com>
References: <20250407222702.2199047-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch adds set_hs_ena call to sdhci_ops so that host
controller drivers have the option to implement a custom
callback for SDHCI_CTRL_HISPD control.

On TI devices (for HS modes and legacy mode), timing was closed on
half cycle timing. If any of HIGH_SPEED_ENA, UHS_MODE_SELECT, or
V1P8_SIGNAL_ENA is set for these modes, host controller switches to
full cycle timing which may cause read/write failures and/or cqe error
logs.

So add set_hs_ena() to sdhci_ops so each host controller driver
can implement their own .set_hs_ena callback.

Also add sdhci_am654_set_hs_ena to sdhci_am654 driver and only set
HIGH_SPEED_ENA, for modes > MMC_TIMING_SD_HS.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci.c       | 55 +++++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h       |  2 ++
 drivers/mmc/host/sdhci_am654.c | 16 ++++++++++
 3 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5f78be7ae16d7..3a878cf0c59b9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2355,6 +2355,27 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
 	       (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
 }
 
+void sdhci_set_hs_ena(struct sdhci_host *host, unsigned char timing)
+{
+	u8 ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+
+	if (timing == MMC_TIMING_SD_HS ||
+	    timing == MMC_TIMING_MMC_HS ||
+	    timing == MMC_TIMING_MMC_HS400 ||
+	    timing == MMC_TIMING_MMC_HS200 ||
+	    timing == MMC_TIMING_MMC_DDR52 ||
+	    timing == MMC_TIMING_UHS_SDR50 ||
+	    timing == MMC_TIMING_UHS_SDR104 ||
+	    timing == MMC_TIMING_UHS_DDR50 ||
+	    timing == MMC_TIMING_UHS_SDR25)
+		ctrl |= SDHCI_CTRL_HISPD;
+	else
+		ctrl &= ~SDHCI_CTRL_HISPD;
+
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+}
+EXPORT_SYMBOL_GPL(sdhci_set_hs_ena);
+
 void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -2436,23 +2457,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	    !sdhci_presetable_values_change(host, ios))
 		return;
 
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-
-	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
-		if (ios->timing == MMC_TIMING_SD_HS ||
-		     ios->timing == MMC_TIMING_MMC_HS ||
-		     ios->timing == MMC_TIMING_MMC_HS400 ||
-		     ios->timing == MMC_TIMING_MMC_HS200 ||
-		     ios->timing == MMC_TIMING_MMC_DDR52 ||
-		     ios->timing == MMC_TIMING_UHS_SDR50 ||
-		     ios->timing == MMC_TIMING_UHS_SDR104 ||
-		     ios->timing == MMC_TIMING_UHS_DDR50 ||
-		     ios->timing == MMC_TIMING_UHS_SDR25)
-			ctrl |= SDHCI_CTRL_HISPD;
-		else
-			ctrl &= ~SDHCI_CTRL_HISPD;
-	}
-
 	if (host->version >= SDHCI_SPEC_300) {
 		u16 clk, ctrl_2;
 
@@ -2468,7 +2472,12 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 		}
 
-		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+		if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
+			if (host->ops->set_hs_ena)
+				host->ops->set_hs_ena(host, ios->timing);
+			else
+				sdhci_set_hs_ena(host, ios->timing);
+		}
 
 		if (!host->preset_enabled) {
 			/*
@@ -2510,8 +2519,14 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		/* Re-enable SD Clock */
 		host->ops->set_clock(host, host->clock);
-	} else
-		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	} else {
+		if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
+			if (host->ops->set_hs_ena)
+				host->ops->set_hs_ena(host, ios->timing);
+			else
+				sdhci_set_hs_ena(host, ios->timing);
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(sdhci_set_ios);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cd0e35a805427..ebecb49792ca1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -704,6 +704,7 @@ struct sdhci_ops {
 	void		(*set_timeout)(struct sdhci_host *host,
 				       struct mmc_command *cmd);
 	void		(*set_bus_width)(struct sdhci_host *host, int width);
+	void		(*set_hs_ena)(struct sdhci_host *host, unsigned char timing);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
@@ -857,6 +858,7 @@ int sdhci_get_ro(struct mmc_host *mmc);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
+void sdhci_set_hs_ena(struct sdhci_host *host, unsigned char timing);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f75c31815ab00..67a64de4972c9 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -429,6 +429,19 @@ static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return 0;
 }
 
+static void sdhci_am654_set_hs_ena(struct sdhci_host *host, unsigned char timing)
+{
+	u8 ctrl = 0;
+
+	if (timing > MMC_TIMING_SD_HS) {
+		sdhci_set_hs_ena(host, timing);
+	} else {
+		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+		ctrl &= ~SDHCI_CTRL_HISPD;
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	}
+}
+
 static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
 {
 	int cmd_error = 0;
@@ -578,6 +591,7 @@ static const struct sdhci_ops sdhci_am654_ops = {
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.set_bus_width = sdhci_set_bus_width,
+	.set_hs_ena = sdhci_am654_set_hs_ena,
 	.set_power = sdhci_set_power_and_bus_voltage,
 	.set_clock = sdhci_am654_set_clock,
 	.write_b = sdhci_am654_write_b,
@@ -608,6 +622,7 @@ static const struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.set_bus_width = sdhci_set_bus_width,
+	.set_hs_ena = sdhci_am654_set_hs_ena,
 	.set_power = sdhci_set_power_and_bus_voltage,
 	.set_clock = sdhci_am654_set_clock,
 	.write_b = sdhci_am654_write_b,
@@ -632,6 +647,7 @@ static const struct sdhci_ops sdhci_j721e_4bit_ops = {
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.set_bus_width = sdhci_set_bus_width,
+	.set_hs_ena = sdhci_am654_set_hs_ena,
 	.set_power = sdhci_set_power_and_bus_voltage,
 	.set_clock = sdhci_j721e_4bit_set_clock,
 	.write_b = sdhci_am654_write_b,
-- 
2.49.0

