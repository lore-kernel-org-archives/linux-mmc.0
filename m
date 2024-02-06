Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF612B174
	for <linux-mmc@vger.kernel.org>; Tue,  6 Feb 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208760; cv=none; b=WRtU1PmbUGuZ4BQZMyotey3rsYCENKtpGpxF9Ks3KzgW0ytGNTLJQ6jjWEEBctz1pGa5gN7dWlJvz7x5RUTKN1HL0IFhpu91H6gWRxsPcgOGTILCwJ0Y1OWH4ZWioQzPqPT9GlyTb/tS6EWN20V1Ul509VscDQFNELkx5wiTaDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208760; c=relaxed/simple;
	bh=ItzBObVNFf5Ww5omJn03/6tOVeHYQwUXRcIHkhfOTdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vtd7oXzCvcSwAPRJRs+eQ9P6wRoF9IaDHUvLa8kjjUEz2IL4CTG6CSFBNOYwuJXJkIxTDLVANevmMwdEiNXuhuECZ1+095oIsKu3SRjEhwME8Ie2pnhwPK36aeYEXGVTE43Y6Uoxtn1mMoOJ3DxszxLm40onWPb/wVbt9YaU2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZUzr/wQA; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZUzr/wQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707208757; x=1738744757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xdRnqWW9LQq6iZ9mbIt89YuaLgU2sTKUep7+qFpjrJI=;
  b=ZUzr/wQADSgPb1CNfMOClbhCJPO5ubpdTw+h1cqxwsiXmX8Je97eLwGX
   z9gkdUSnLoNgcU+RV1sSJhde9hGhRpcm/4QPfKo6UipV0cD5S/XgT64KD
   KrMWQnbs1602eviuCrK2ycM+j+ccJur2VTvIArmp8Ylr4rSP7xf1Mpyr6
   LcksZDDOMMumkS72y1ticcKaBA+nIr5sTLBMPr95IXZRKxNafSC2+lvCB
   gXydBeyu9rMr3y6uQ0AJy7MMWO9R8W47kLtuML7w45Tahzi1SfwzCXzNp
   zYdbQauHYkyzNJqfiKWFqzcqhYAzA9uDhJH2uSdUKbJNcDj0NDH+ohz+e
   A==;
X-IronPort-AV: E=Sophos;i="6.05,246,1701126000"; 
   d="scan'208";a="35263735"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Feb 2024 09:39:13 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3A1BB280075;
	Tue,  6 Feb 2024 09:39:13 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH 1/1] mmc: slot-gpio: Allow non-sleeping GPIO ro
Date: Tue,  6 Feb 2024 09:39:12 +0100
Message-Id: <20240206083912.2543142-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change uses the appropriate _cansleep or non-sleeping API for
reading GPIO read-only state. This allows users with GPIOs that
never sleepbeing called in atomic context.

Implement the same mechanism as in commit 52af318c93e97 ("mmc: Allow
non-sleeping GPIO cd").

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
With commit 5d5dfc50e5689 ("gpiolib: remove extra_checks") thw following error
is showing on my imx8qxp-tqma8xqp-mba8xx.dts platform:
> BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:3740

The reason is that mmc_gpio_get_ro() is called from within atomic context from
sdhci_check_ro(), which uses spin_lock_irqsave().

The problem was always there, so I assume I didn't actually deadlock cause
nobody was using SD card with a sleepable read-only GPIO.

 drivers/mmc/core/slot-gpio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 2a2d949a9344e..39f45c2b6de8a 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -75,11 +75,15 @@ EXPORT_SYMBOL(mmc_gpio_set_cd_irq);
 int mmc_gpio_get_ro(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
+	int cansleep;
 
 	if (!ctx || !ctx->ro_gpio)
 		return -ENOSYS;
 
-	return gpiod_get_value_cansleep(ctx->ro_gpio);
+	cansleep = gpiod_cansleep(ctx->ro_gpio);
+	return cansleep ?
+		gpiod_get_value_cansleep(ctx->ro_gpio) :
+		gpiod_get_value(ctx->ro_gpio);
 }
 EXPORT_SYMBOL(mmc_gpio_get_ro);
 
-- 
2.34.1

