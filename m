Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698521;
	b=EjtXJc8XHMTJrS7W+TLfR+J819NsYdxR/MK9RJRtbSbnrYmYZF3K7VawbDCwWit6xCsz
	 axT1tsyr7iCIdR7EQC6DMddYdYyM9m8+kfj9v6ft0nR7HPQ5r1Eeq+Ux5fHyFkIVSSoWb
	 kP5RFGAi6OiKbyj4/rGO2trrkg7ocQBjyPwfjAh04OpVTUW98G1kcLhFKVSLNgL4g+3r4
	 z6i0qRrgx4gmJX0Ci+YEydXTXHMOJPYKQilmdgUnjR9Euu3Ykg3iJZagg3Ncrs43Oo/3d
	 oD671bgRzONUAN8wG/3f3Av46VUQtvxn7POOPzYL6AteWpgdFILyaZH0iTFTom51Xcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698521;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=6o537cHF3ZsBsyeLBKkxyQxJxv6nVsc5mI6mjoRRjxc=;
	b=J6IpIBPPn7uBrbXOHeav0gIPa3EZr5zt/MwvsUVUdBEUncKVLd6jqXMXZ6XECOBEYc9i
	 N5O//cOffTjN5fjgCGd+sW6SmXsT3zhw4kPfv9NxGufS6VOndb/8ub2vUSKX3wk+OvED/
	 BJSzC6mGAqCTT2Z6qpFa7oG2ifzQ7KPn9wArYnW03iZgGarL1cK8p7oTg7waVF+gfNULZ
	 NlHVvK1akM0vcZO82ayN39KNY4rTx/+GeBEgx4S3XD+f8BH93SrtsKyW2ZkYnsEsOAuwH
	 NeyxDj+WQAFoysqsrNe92gzjb1lRQTwpVzn7sgAESPlKDFscJMlz0n2RPq1RkZd00Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nNuECPAC;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44089606A327
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 09:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44089606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nNuECPAC
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CD6B9C4FEE1;
	Tue,  3 Nov 2026 09:36:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F93A6046C;
	Tue,  3 Nov 2026 09:35:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DEDB10328C5E;
	Tue,  3 Nov 2026 10:35:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793698517; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=6o537cHF3ZsBsyeLBKkxyQxJxv6nVsc5mI6mjoRRjxc=;
	b=nNuECPACV+cGKmPfxJhqKNk7MK/aKdFSJwRREPIFUAYzyMsUAVdqXl14Ey7ijgjRfjWTdm
	wDvJePyaAGHPefamMXBytyWpCXIoosdDVl4CiC0FPuaNoFT9tcWlDJ6p86vKbCAlFm/jFo
	s8LEalw8+fL2QhA+O+f59W4KZnwffpqkfd0lU7KlMDMJmUQtyX3yxr9ahn9CcjbHSlVx4J
	KsXeA6/3ll4T1oAQye1WI0Yw18RCunwC7jZEP25PeC4MyctaB5j+p/PXqlynBxfr/m86yh
	P+RksDFY5JrxEImLKO8IdcqSWOjRwWXANhrUYr8pXSov2Shrxe+qJrD+iztRow==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH] mmc: sdhci-cadence: enable probing from ACPI
Date: Tue,  3 Nov 2026 10:35:00 +0100
Message-ID: <20261103093501.218232-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Use the device property API instead of the OF-specific property API.
This way, the driver will also probe from ACPI.

Note the change in the core's probe function for SD6HC. We can't have
named clocks in ACPI.

Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/mmc/host/sdhci-cadence-core.c   | 22 ++++++++++++----------
 drivers/mmc/host/sdhci-cadence-phy-v6.c | 10 +++++-----
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
index 745455743b01..c5a4fa8e2fc6 100644
--- a/drivers/mmc/host/sdhci-cadence-core.c
+++ b/drivers/mmc/host/sdhci-cadence-core.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2026 Altera Corporation
  */
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/dma-mapping.h>
@@ -145,26 +146,26 @@ static int sdhci_cdns4_write_phy_reg(struct sdhci_cdns_priv *priv, u8 addr, u8 d
 	return ret;
 }
 
-static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
+static unsigned int sdhci_cdns4_phy_param_count(struct device *dev)
 {
 	unsigned int count = 0;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++)
-		if (of_property_present(np, sdhci_cdns4_phy_cfgs[i].property))
+		if (device_property_present(dev, sdhci_cdns4_phy_cfgs[i].property))
 			count++;
 
 	return count;
 }
 
-static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdns4_phy *phy)
+static void sdhci_cdns4_phy_param_parse(struct device *dev, struct sdhci_cdns4_phy *phy)
 {
 	struct sdhci_cdns4_phy_param *p = phy->phy_params;
 	u32 val;
 	int ret, i;
 
 	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
-		ret = of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].property, &val);
+		ret = device_property_read_u32(dev, sdhci_cdns4_phy_cfgs[i].property, &val);
 		if (ret)
 			continue;
 
@@ -204,7 +205,7 @@ static int sdhci_cdns_set_dma_mask(struct sdhci_host *host)
 	struct device *dev = mmc_dev(host->mmc);
 	int ret;
 
-	data = of_device_get_match_data(dev);
+	data = device_get_match_data(dev);
 	if (!data || !data->dma_mask)
 		return 0;
 
@@ -649,13 +650,13 @@ static int sdhci_cdns4_phy_probe(struct platform_device *pdev, struct sdhci_cdns
 	struct sdhci_cdns4_phy *phy;
 	unsigned int nr_phy_params;
 
-	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
+	nr_phy_params = sdhci_cdns4_phy_param_count(dev);
 	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
 	phy->nr_phy_params = nr_phy_params;
-	sdhci_cdns4_phy_param_parse(dev->of_node, phy);
+	sdhci_cdns4_phy_param_parse(dev, phy);
 	priv->phy = phy;
 
 	return sdhci_cdns4_phy_init(priv);
@@ -673,7 +674,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
 
-	if (of_device_is_compatible(dev->of_node, "cdns,sd6hc")) {
+	/* Note: ACPI only provides one unnamed clock */
+	if (!has_acpi_companion(dev) && device_is_compatible(dev, "cdns,sd6hc")) {
 		clk = devm_clk_get_enabled(dev, "ciu");
 		if (IS_ERR(clk))
 			return dev_err_probe(dev, PTR_ERR(clk), "failed to enable ciu clock\n");
@@ -687,7 +689,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 			return PTR_ERR(clk);
 	}
 
-	data = of_device_get_match_data(dev);
+	data = device_get_match_data(dev);
 	if (!data)
 		return dev_err_probe(dev, -EINVAL, "missing platform driver data\n");
 
@@ -723,7 +725,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	 * For SD6HC, sdhci_add_host() will automatically read capabilities
 	 * and version from the host controller registers.
 	 */
-	if (of_device_is_compatible(dev->of_node, "cdns,sd4hc")) {
+	if (device_is_compatible(dev, "cdns,sd4hc")) {
 		__sdhci_read_caps(host, &version, NULL, NULL);
 		ret = sdhci_cdns4_phy_probe(pdev, priv);
 		if (ret)
diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
index 22d56bb46d75..551a0e3b58ad 100644
--- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -880,17 +880,17 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
 	 * Cadence-recommended defaults (2500 ps IO-cell delays, 24 ps DLL
 	 * delay element) that are valid for typical SoC packaging.
 	 */
-	ret = of_property_read_u32(dev->of_node, "cdns,iocell-input-delay-ps",
-				   &phy->iocell_input_delay);
+	ret = device_property_read_u32(dev, "cdns,iocell-input-delay-ps",
+				       &phy->iocell_input_delay);
 	if (ret)
 		phy->iocell_input_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
 
-	ret = of_property_read_u32(dev->of_node, "cdns,iocell-output-delay-ps",
-				   &phy->iocell_output_delay);
+	ret = device_property_read_u32(dev, "cdns,iocell-output-delay-ps",
+				       &phy->iocell_output_delay);
 	if (ret)
 		phy->iocell_output_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
 
-	ret = of_property_read_u32(dev->of_node, "cdns,delay-element-ps", &phy->delay_element);
+	ret = device_property_read_u32(dev, "cdns,delay-element-ps", &phy->delay_element);
 	if (ret) {
 		phy->delay_element = SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT;
 	} else if (!phy->delay_element) {
-- 
2.47.3

