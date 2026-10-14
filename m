Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC440801E;
	Wed, 14 Oct 2026 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009708; cv=none; b=GswmAavocp42QI0GD/1yx+wTPtUAqm731NQGNzhX1ECn7bOHklG90/TX8r615jYiA/Tzi5h/veUY7t8xS7/4FjNXwchjgc89zLCsol1usWQ0+L+68koIMDj0woQ30OiZEO9r8Z+uGv+Ulz6RB7VoTUiAR3KMrqCMOB6Q2I/U0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009708; c=relaxed/simple;
	bh=c5kTXmOvgSqIYT6Hs/HhiyaSTu6YGk6E/XaeA6AWj08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fE0cDR7YB+PYk0BQt1N6vBwCUoAcIoTGMFv+7zHITe7DpT70sMHYeJ71AB2AfGJdPlHgqURb5A8ZYi9xz7vzafw55r3PHUzxkjAdzTXavQX80rOUhg+VFTdn0lWyauhhC3jHjvIWirNA84jbhm+grDqa78KmRO5O00jbgVVA9Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mD2gC9Mf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mD2gC9Mf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792009707; x=1823545707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c5kTXmOvgSqIYT6Hs/HhiyaSTu6YGk6E/XaeA6AWj08=;
  b=mD2gC9MfOZNwaRuCRa6g8eVL2IlUkNzL3BsAhJnaAWn79dAT4IDgu+51
   07xqNSHFzHuOhaTRuPoSTcd96ZIfHwa1UuoXCnbL900/0jbPnGL17T5Z7
   uZuVD4jyI0naIvcNpIp69wsDCkWeEV7NhK8hmH+k7I97phkUllH4fWtg0
   BQL8tWFZp0u/7IvLrIuxast/HfEIpxvflC6ieLBEmAK4/SVYXLH8AyYBP
   KBjxWluU6RlJ7ByZB8qRbJnJ2wVnIfct8CnV/z/lAwD76IAFqEAslHSxx
   DduqUB2dRDu1Gz9QudxrjvBbLpDbkrJt0qL/71JxUUdCYSJS0xxzFBzp9
   A==;
X-CSE-ConnectionGUID: zv7YhBbySSSm7hs3J5Vahw==
X-CSE-MsgGUID: v9B0qLJ1TgmQYWoK/O8m6A==
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="65328629"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 13:28:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 13:28:25 -0700
Received: from ROU-LL-M51280.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 13:28:22 -0700
From: Aubin Constans <aubin.constans@microchip.com>
To: Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Eugen Hristev <ehristev@kernel.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Romain Sioen <romain.sioen@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Robert Marko <robert.marko@sartura.hr>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ryan Wanner
	<ryan.wanner@microchip.com>, <linux-mmc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Aubin Constans" <aubin.constans@microchip.com>
Subject: [PATCH v2] mmc: sdhci-of-at91: disable selectively clocks on pm runtime
Date: Wed, 14 Oct 2026 22:26:18 +0200
Message-ID: <20261014202619.715573-1-aubin.constans@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Claudiu Beznea <claudiu.beznea@microchip.com>

SDMMC run-time clock disabling is not supported in newer SoCs, including
SAMA7G54, SAMA7D65 and LAN969x.

Make the clock disabling scenario conditional:
- still enabled for the sama5d2 and sam9x60 compatibles (which are all
  those implemented at present),
- otherwise avoided by default, for subsequent SoC families.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
[Romain: Fix unbalanced clock activation/deactivation]
Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
[Aubin: Rebase before sama7g5 support and edit the commit msg]
Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
Tested-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
- Edit the commit msg to say the patch prepares SAMA7G54/SAMA7D65/LAN969x
  SoC support w/o immediate change.
  Also, move and summarize Romain's own commit msg close to its sign-off.
- Restore Claudiu's author and sign-off email to the microchip.com address
  he had upon writing the patch.
- Link to v1: https://lore.kernel.org/r/20260918153414.909333-1-aubin.constans@microchip.com

 drivers/mmc/host/sdhci-of-at91.c | 36 ++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 7c4ac65f247d..399856643e57 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -39,6 +39,7 @@ struct sdhci_at91_soc_data {
 	const struct sdhci_pltfm_data *pdata;
 	bool baseclk_is_generated_internally;
 	unsigned int divider_for_baseclk;
+	bool pm_runtime_disable_clks;
 };
 
 struct sdhci_at91_priv {
@@ -149,12 +150,14 @@ static const struct sdhci_pltfm_data sdhci_sama5d2_pdata = {
 static const struct sdhci_at91_soc_data soc_data_sama5d2 = {
 	.pdata = &sdhci_sama5d2_pdata,
 	.baseclk_is_generated_internally = false,
+	.pm_runtime_disable_clks = true,
 };
 
 static const struct sdhci_at91_soc_data soc_data_sam9x60 = {
 	.pdata = &sdhci_sama5d2_pdata,
 	.baseclk_is_generated_internally = true,
 	.divider_for_baseclk = 2,
+	.pm_runtime_disable_clks = true,
 };
 
 static const struct of_device_id sdhci_at91_dt_match[] = {
@@ -164,7 +167,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
 
-static int sdhci_at91_set_clks_presets(struct device *dev)
+static int sdhci_at91_set_clks_presets(struct device *dev, bool start_clks)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -174,7 +177,14 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
 	unsigned int			gck_rate, clk_base_rate;
 	unsigned int			preset_div;
 
-	clk_prepare_enable(priv->hclock);
+	/*
+	 * Manage clock prepare/enable procedure depending on if the board
+	 * support runtime clock disabling and if we come from the probing
+	 * or restoring procedure (for backup+self refresh).
+	 */
+	if (start_clks)
+		clk_prepare_enable(priv->hclock);
+
 	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
 	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
 
@@ -223,8 +233,11 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
 	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
 	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
 
-	clk_prepare_enable(priv->mainck);
-	clk_prepare_enable(priv->gck);
+	/* Same clock management as for hclock */
+	if (start_clks) {
+		clk_prepare_enable(priv->mainck);
+		clk_prepare_enable(priv->gck);
+	}
 
 	return 0;
 }
@@ -254,9 +267,11 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-	clk_disable_unprepare(priv->gck);
-	clk_disable_unprepare(priv->hclock);
-	clk_disable_unprepare(priv->mainck);
+	if (priv->soc_data->pm_runtime_disable_clks) {
+		clk_disable_unprepare(priv->gck);
+		clk_disable_unprepare(priv->hclock);
+		clk_disable_unprepare(priv->mainck);
+	}
 
 	return 0;
 }
@@ -269,7 +284,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 	int ret;
 
 	if (priv->restore_needed) {
-		ret = sdhci_at91_set_clks_presets(dev);
+		ret = sdhci_at91_set_clks_presets(dev, priv->soc_data->pm_runtime_disable_clks);
 		if (ret)
 			return ret;
 
@@ -277,6 +292,9 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 		goto out;
 	}
 
+	if (!priv->soc_data->pm_runtime_disable_clks)
+		goto out;
+
 	ret = clk_prepare_enable(priv->mainck);
 	if (ret) {
 		dev_err(dev, "can't enable mainck\n");
@@ -344,7 +362,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
 				     "failed to get multclk\n");
 
-	ret = sdhci_at91_set_clks_presets(&pdev->dev);
+	ret = sdhci_at91_set_clks_presets(&pdev->dev, true);
 	if (ret)
 		return ret;
 
-- 
2.43.0

