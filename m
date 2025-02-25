Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4A1C27;
	Tue, 25 Feb 2025 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449929; cv=none; b=FaFsap+/HYvfQkZYFMzVlMRuhvGLY0hZHzpORuIUHeocIr+oQ8ggZ0ShtE3Vw6f0XYamDpIdrWspPXrwY2fZR+8fg0b28FoNI/HTCuvnMC5TNL+/Rnc5+wjKx7oJ6JA/fMrxwFVa4FVXZEXS4aNG7C+cmJIOlgFEyFSEHrGcDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449929; c=relaxed/simple;
	bh=8y0Rwfc3Hi5n6TjYkSM8+RV/G0U0BsPaviMrVlxjhgo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FoJxbOy2erFczHbej/XuFrcDEsa1zITC2rixTbTVQTy031pPlQFM3Y/LObQfMXh5BkdRSaQyYfAuZY5eZU8wNH/5M/KGnNH+WM1G/IV0sl0qgoGz1/gLxNFMxSPNuTPh7k1BkO9zAXkPpFCP+gGrsPcq+rCdraYbTzx12E5Zt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z21Q45C0rz2CpdY;
	Tue, 25 Feb 2025 10:14:36 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id B12CD1A016C;
	Tue, 25 Feb 2025 10:18:38 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 25 Feb
 2025 10:18:38 +0800
From: Gu Bowen <gubowen5@huawei.com>
To: <aubin.constans@microchip.com>, <ulf.hansson@linaro.org>
CC: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <ludovic.desroches@atmel.com>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>
Subject: [PATCH -next] mmc: atmel-mci: Add missing clk_disable_unprepare()
Date: Tue, 25 Feb 2025 10:28:56 +0800
Message-ID: <20250225022856.3452240-1-gubowen5@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100007.china.huawei.com (7.202.181.92)

The error path when atmci_configure_dma() set dma fails in atmci driver
does not correctly disable the clock.
Add the missing clk_disable_unprepare() to the error path for pair with
clk_prepare_enable().

Fixes: 467e081d23e6 ("mmc: atmel-mci: use probe deferring if dma controller is not ready yet")
Signed-off-by: Gu Bowen <gubowen5@huawei.com>
---
 drivers/mmc/host/atmel-mci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index fc360902729d..24fffc702a94 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2499,8 +2499,10 @@ static int atmci_probe(struct platform_device *pdev)
 	/* Get MCI capabilities and set operations according to it */
 	atmci_get_cap(host);
 	ret = atmci_configure_dma(host);
-	if (ret == -EPROBE_DEFER)
+	if (ret == -EPROBE_DEFER) {
+		clk_disable_unprepare(host->mck);
 		goto err_dma_probe_defer;
+	}
 	if (ret == 0) {
 		host->prepare_data = &atmci_prepare_data_dma;
 		host->submit_data = &atmci_submit_data_dma;
-- 
2.25.1

