Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6E155727;
	Mon, 26 Aug 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677026; cv=none; b=MyA5KSEgK/g2pl9i62MrrB7LG6Eg+X+cwc79VX7yd1uWS1zXpd155kKNSdf8v90JCUKLB+WFJWg2d4kaMjRdh6sR81bf6rrs+g36K6gAKQ58hFc60z4/F8RMTNdtTwxwlJtsJyL8RhBHrfe5yrJ/QTYnjgRE2IEJDVvFTaxYHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677026; c=relaxed/simple;
	bh=/5B8H7qfi9GW2W9Wpi79TnVvt5efYx3P5wIeU8M22XM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PnV47JYOGta45F8xaZnL48EN46ZBWQs/O2DU5Tam6i+cbbCShEQ2WwsOAFmWPh4R0ESY7G0eq/e4A669jWceAbNdxcVW2HwFTphd1GzKmMCjW7HGWgpsz59bOTpden68cun8IG+IPFv6dB9dq5Ud2RpeABw3s+wUzgj49vZEu5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WsrJx2GScz146qY;
	Mon, 26 Aug 2024 20:56:17 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id F069818006C;
	Mon, 26 Aug 2024 20:57:02 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 20:57:02 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <andrew@codeconstruct.com.au>, <adrian.hunter@intel.com>,
	<ulf.hansson@linaro.org>, <joel@jms.id.au>
Subject: [PATCH -next] mmc: sdhci-of-aspeed: fix module autoloading
Date: Mon, 26 Aug 2024 12:48:51 +0000
Message-ID: <20240826124851.379759-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 430c1f90037b..37240895ffaa 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -510,6 +510,7 @@ static const struct of_device_id aspeed_sdhci_of_match[] = {
 	{ .compatible = "aspeed,ast2600-sdhci", .data = &ast2600_sdhci_pdata, },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, aspeed_sdhci_of_match);
 
 static struct platform_driver aspeed_sdhci_driver = {
 	.driver		= {
-- 
2.34.1

