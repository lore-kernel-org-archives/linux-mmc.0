Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B58BE67
	for <linux-mmc@vger.kernel.org>; Mon, 31 Mar 2025 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403457; cv=none; b=sJswIQhG8mc6ect2MI0FNr/QOUec0ftRazTXSAnuSYpjMIKhY9sifkh49vDBKJhPxXTZY7T5z2ww6XA36jp19QPMjTbI4ZUItah8l/RJsLFoMLNiElggsRNVL10YhA/czhSU8cMFyRnLb4CJItztOQIF7evoVozeamGnZZ49hRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403457; c=relaxed/simple;
	bh=L9eQS5LRGLrf6MgkurT5HPQycpxQOrmbZ5qTqgJUZuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELcNOaNEYmLLvTfd9ij74Q56o7bWrv/l3dY4N3YztTGCLgautZsKo0SShGX3Oqr7k25863xDmzTP2z9fn+QmZ3oBU+bq0+8pDxvQOMozMkd9miYO0pYSMukaT7cXUkvYtiLH27GSEfCkO8WBaSlGCmy154fjs+Y/vNckMGl9SZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cFr9LRJ0; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cFr9LRJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=CWhMMHXdY7wGZN
	B48i2lMT30hIxIkaT6qwU4OIC1SBM=; b=cFr9LRJ0iF2mJu7eH46JcMemjz4H9b
	Gudo4KSk/PrFHN6IB16fi1TDoyvberpSa0QPQX1aur/MBT7eN9OeVa7Tyjywba6d
	+0gf87outXBf3FqmdB8WDwqptEzqNWRA/74v7NaKGz5O+hXVyHhtUc2miWN+4BpC
	Z/uOnacWz/G/JnI82HNA1DffkILpcmUrACLteV0Ha1IMxBugrfki/7h/wLip80NG
	uVqE58ESSdK8Okfg/ICbFPwu+266i1e7YA4T1jzPlwWJgimzFpI645OYLPkJOO/w
	RDIns3TRrJBWeX9UIOTlNvwNUFAVNBw/bskwpVsFtLhjtt8X2IGpibQg==
Received: (qmail 1123123 invoked from network); 31 Mar 2025 08:44:08 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 31 Mar 2025 08:44:08 +0200
X-UD-Smtp-Session: l3s3148p1@UVA1v50xiMBQ8qei
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: renesas_sdhi: improve registering irqs
Date: Mon, 31 Mar 2025 08:43:17 +0200
Message-ID: <20250331064400.16677-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe() function is convoluted enough, so merge sanity checks for
number of irqs into one place. Also, change the error code for 'no irq'
because ENXIO will not print a warning from the driver core.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested on a Renesas Spider board (R-Car S4)

 drivers/mmc/host/renesas_sdhi_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 8c83e203c516..4642fdb8bf65 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1240,15 +1240,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
 
-	num_irqs = platform_irq_count(pdev);
-	if (num_irqs < 0) {
-		ret = num_irqs;
-		goto edisclk;
-	}
-
 	/* There must be at least one IRQ source */
-	if (!num_irqs) {
-		ret = -ENXIO;
+	num_irqs = platform_irq_count(pdev);
+	if (num_irqs <= 0) {
+		ret = num_irqs ?: -ENOENT;
 		goto edisclk;
 	}
 
-- 
2.47.2

