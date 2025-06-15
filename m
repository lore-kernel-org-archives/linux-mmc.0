Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468F26528E;
	Sun, 15 Jun 2025 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749959919; cv=none; b=r+a5cElkhvl+YcfpYs/1cIrD8Vh2Yjmj3Oa4doyOQKNKcl8/Q13Xwl0a/w+JOmaZD73j70HdQ/Yx9BQcIhCncelLbqiG7suk3N+Z51BqAqH3zf07hfsReN3+Fkvl+AvDsildlKYDZiwq8x8dW8merZBEQfUyGnZVc71yt6Dk7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749959919; c=relaxed/simple;
	bh=lSminI9thQ4D1Cmx3meEA7cWQlap1VEYZBL1D6u9zH0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVwSi+vihrnq4ToRMynWKvNTgy5yGeyVunGL2buxRjfJyzWir8WzQSnWnFbnnWrbevURfABgQQ7xYhXWDzdr61Makf/BixLB4zF4EtV/Tz5qFs6b0ZZLsBGEqlvds0m1ezylhCXcU8qSRoJl0W6QQBDA9WpGB1yDcnGt+2IUwZE=
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
Subject: [PATCH 8/8] mmc: sdhci-of-aspeed: Add sdr50 support
Date: Sun, 15 Jun 2025 11:58:03 +0800
Message-ID: <20250615035803.3752235-9-cool_lee@aspeedtech.com>
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

Add support for SDR50 mode in the Aspeed SDHCI driver by setting
capability shadow register.

Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 365c02215273..ec6833295b6a 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -41,6 +41,7 @@
 #define ASPEED_SDC_CAP1_1_8V           (0 * 32 + 26)
 /* SDIO{14,24} */
 #define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
+#define ASPEED_SDC_CAP2_SDR50		(1 * 32 + 0)
 
 struct aspeed_sdc {
 	struct clk *clk;
@@ -427,11 +428,17 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	sdhci_get_of_property(pdev);
 
 	if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
+	    of_property_read_bool(np, "sd-uhs-sdr50") ||
 	    of_property_read_bool(np, "sd-uhs-sdr104")) {
 		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP1_1_8V,
 					       true, slot);
 	}
 
+	if (of_property_read_bool(np, "sd-uhs-sdr50")) {
+		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP2_SDR50,
+					       true, slot);
+	}
+
 	if (of_property_read_bool(np, "sd-uhs-sdr104")) {
 		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP2_SDR104,
 					       true, slot);
-- 
2.34.1

