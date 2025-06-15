Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442E263C9B;
	Sun, 15 Jun 2025 03:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749959911; cv=none; b=mJZFWwzYJp8XE9NEUXENTAK+cb5QntFxSnVefJnEMWrlww5culfytg2LD+zh/oCmI2+EQUWoofQ4qfBXyAsxxJqESqU4Kp9upjlxYzuFRVwKN4tjY4GdBhOb3wRa5Z5x7Ujfh6Fx0PesUkN8/WCP+ekZInXiS3R14h2Y9POom/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749959911; c=relaxed/simple;
	bh=HarTzHrwSyFQg+FX83UEhgHlcVli7cTOblv9vvMb3ZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLbRPNcEb3vI78okDfWiTUGTwim4zoW5WLwpPZ+QojVF0lxo/+GH2YdwMeiIQLvXh84QpJUy/u8uH9RyFh4P+nvG3NyZ5TYAGKDNAPsZ+a0xBb8WelhBAhhDmiazgS7aZS+ggSDfjCPxHYguDeNczyaQlVaYCJVmEp/vwtygL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 15 Jun
 2025 11:58:04 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 15 Jun 2025 11:58:04 +0800
From: Cool Lee <cool_lee@aspeedtech.com>
To: <andrew@codeconstruct.com.au>, <adrian.hunter@intel.com>,
	<ulf.hansson@linaro.org>, <joel@jms.id.au>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] mmc: sdhci-of-aspeed: Fix null pointer
Date: Sun, 15 Jun 2025 11:58:00 +0800
Message-ID: <20250615035803.3752235-6-cool_lee@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Platform data might be null.

Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 2bdd93a3f91f..22dde915e51b 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -241,7 +241,7 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_pltfm_host *pltfm_host;
 	unsigned long parent, bus;
 	struct aspeed_sdhci *sdhci;
-	int div;
+	int div = 1;
 	u16 clk;
 
 	pltfm_host = sdhci_priv(host);
@@ -257,6 +257,9 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (WARN_ON(clock > host->max_clk))
 		clock = host->max_clk;
 
+	if (sdhci->pdata)
+		div = sdhci->pdata->clk_div_start;
+
 	/*
 	 * Regarding the AST2600:
 	 *
@@ -273,7 +276,7 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	 * supporting the value 0 in (EMMC12C[7:6], EMMC12C[15:8]), and capture
 	 * the 0-value capability in clk_div_start.
 	 */
-	for (div = sdhci->pdata->clk_div_start; div < 256; div *= 2) {
+	for (; div < 256; div *= 2) {
 		bus = parent / div;
 		if (bus <= clock)
 			break;
-- 
2.34.1

