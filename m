Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456936FB0;
	Wed,  4 Sep 2024 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413889; cv=none; b=BqEedwe2vvQlMgvCQ+ZXepTooDIQ/uNx4kf8CkUnG9F15wBy4f4mTUVA0HjO+xZmXo1jcLMXmcTad71HdGHDEwwttcAWcks3l88WbDK8T7BbJ+AT0zXPXvRxAJH515BxGbY4eCQLd2UpBU2MXPo1qcJ3CdLYXm+zR/ZwtkFuYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413889; c=relaxed/simple;
	bh=Aja1O6PAMokZW0to6KKT/oc52hf5QRLToddF8g94+T8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a9mnSrqfRJpOsqphWcLeaXbKccA6Ko9ojgDzi8SAfyoVtUzT/YH6DYW1l8uxaHq9BFA1zEoLlt2LVipylIG3VfRWd/R7DYs+PXoqMgTJJQFOipz327qr7GtnBgCZfHR+x4FYeRsYixMC/W3BaKK4d+BJ6xaBQL6ZGkaPiyhXfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wz4nm5X3wzgYtK;
	Wed,  4 Sep 2024 09:35:56 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id CEB5818005F;
	Wed,  4 Sep 2024 09:38:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:38:03 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next] mmc: sdhci-cadence: Annotate struct sdhci_cdns_phy_param with __counted_by()
Date: Wed, 4 Sep 2024 09:46:36 +0800
Message-ID: <20240904014636.2033138-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add the __counted_by compiler attribute to the flexible array member
entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/mmc/host/sdhci-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index be1505e8c536..2690bcaeaad5 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -73,7 +73,7 @@ struct sdhci_cdns_priv {
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	struct reset_control *rst_hw;
 	unsigned int nr_phy_params;
-	struct sdhci_cdns_phy_param phy_params[];
+	struct sdhci_cdns_phy_param phy_params[] __counted_by(count);
 };
 
 struct sdhci_cdns_phy_cfg {
-- 
2.34.1

