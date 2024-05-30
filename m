Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228611F947;
	Thu, 30 May 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717106157; cv=none; b=N5PWXNZt/i5+gs5+751K8jb3Ul/8DDYkmhZ+SCplc59lEiS581Na7/B3osKhdATmcSSTXRjRZbyJ3Sp2cR8b16HkumXfbuLQMwhEHXbZVujxZetdxI4HITdydobccwj0pqAst0TpiOZvQTazd8QqzJ3cZQKxNeHvMESTlF42vwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717106157; c=relaxed/simple;
	bh=5Mef2cWpT6UZal7WPBUCtYagsM8Kk69zAlssm2lhikQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HiBTeYEpMgFoWBZp9F5EFp6pJ7J400wuleJLHyuKh26vUHaORAhYE2aMjkFVzRlgFTmlHzmhaFejHB2xDsejzz8LWFd3dD+1AHYIUWoAQCw1ZpGXEKihaybSEUVC6duMHUrBKH6IBF4IyEAcz0IF+4Ye5Y9XKIUUTxLmW6PUQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875bfd.versanet.de ([83.135.91.253] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sCnkT-00069A-VK; Thu, 30 May 2024 23:55:50 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: serghox@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: set CQE irq-handler for rockchip variants
Date: Thu, 30 May 2024 23:55:47 +0200
Message-Id: <20240530215547.2192457-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The dwcmshc used on Rockchip rk3568 and rk3588 can use cqe, so set
the needed irq handler.

Tested on a rk3588-tiger SoM with dd, hdparm and fio. fio performance
does increase slightly from

Run status group 0 (all jobs):
   READ: bw=209MiB/s (219MB/s), 209MiB/s-209MiB/s (219MB/s-219MB/s), io=4096MiB (4295MB), run=19607-19607msec

without CQE to

Run status group 0 (all jobs):
   READ: bw=215MiB/s (225MB/s), 215MiB/s-215MiB/s (225MB/s-225MB/s), io=4096MiB (4295MB), run=19062-19062msec

with CQE enabled.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 4410d4523728d..3c203857189f9 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -908,6 +908,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
 	.get_max_clock		= rk35xx_get_max_clock,
 	.reset			= rk35xx_sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.irq			= dwcmshc_cqe_irq_handler,
 };
 
 static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
-- 
2.39.2

