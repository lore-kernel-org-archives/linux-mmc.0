Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED926280C;
	Sun, 15 Jun 2025 03:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749959907; cv=none; b=gG2DCbtMz4WtoiPHHbpT6YIE8PC0II71fSTtbsY64r6bYMIMtoRYVQSM2OUJh4k9KNyHOkWB1r/zerHWHklRmqnoA1bC6QCPDf9Wzj804vePxeQxjZhtzW7GlkafhXwdJXzBS8GhJmjeaz993LaeSfBMsmf/gQ9t2/RMweH4YbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749959907; c=relaxed/simple;
	bh=YjPzTdmH7xkSjl38iTCRT6bZwtjPhBKYF1MCvlsqp+M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PThY4Eg2+xBMuoXsE+CCPuLcK7b2pB20y75JOtFLNx85v2u38g9IkHzkzewTGcqt+2KkqMMtMpGzAUz/hS5DdVp5eQsOmo8mtC0qqFjD7fhLrE0jmXoGte802KumO8FnGbeDYOgZA0gxrpcbGbqXgFRNeHGs/GxR/Y8r1Ar+kIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 15 Jun
 2025 11:58:03 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 15 Jun 2025 11:58:03 +0800
From: Cool Lee <cool_lee@aspeedtech.com>
To: <andrew@codeconstruct.com.au>, <adrian.hunter@intel.com>,
	<ulf.hansson@linaro.org>, <joel@jms.id.au>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] mmc: sdhci-of-aspeed: Patch HOST_CONTROL2 register missing after top reset
Date: Sun, 15 Jun 2025 11:57:58 +0800
Message-ID: <20250615035803.3752235-4-cool_lee@aspeedtech.com>
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

HOST_CONTROL2 register will be cleared after top reset,
it needs to be saved/resotred while reset.

Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 5e5ae1894456..10160a706334 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -336,14 +336,15 @@ static void aspeed_sdhci_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_priv;
 	struct aspeed_sdhci *aspeed_sdhci;
 	struct aspeed_sdc *aspeed_sdc;
-	u32 save_array[7];
+	u32 save_array[8];
 	u32 reg_array[] = {SDHCI_DMA_ADDRESS,
 			SDHCI_BLOCK_SIZE,
 			SDHCI_ARGUMENT,
 			SDHCI_HOST_CONTROL,
 			SDHCI_CLOCK_CONTROL,
 			SDHCI_INT_ENABLE,
-			SDHCI_SIGNAL_ENABLE};
+			SDHCI_SIGNAL_ENABLE,
+			SDHCI_AUTO_CMD_STATUS};
 	int i;
 	u16 tran_mode;
 	u32 mmc8_mode;
-- 
2.34.1

