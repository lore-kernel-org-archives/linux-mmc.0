Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9123E359;
	Mon, 25 Aug 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124588; cv=none; b=Aj+fN3a13GxDgLGIZETv1bhh8cqJAn2oBuJz9xZofO8S0dPtJmPRONUGMXsM6XvXKuk+WTI3xpG5qzdtVJ4laHEyDtjV1eqB/YzXY4/dbSuWH8ew6v0puzFRzTyfHwceX+olbFg307OfIIzOqwKoQy1G2ayWEXfsIK2fFu10hyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124588; c=relaxed/simple;
	bh=Ti5muMAyeztdYaT7gdOAkMCnChvbp3E+ufomta9VzkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTiwepdk6HyaCrSM/93ga3uur9Uk/yIqQYnPjXMZdn5GPiPYJ+URV1aGJz4vb1jDc3v2HFhpNZWP0kGhf2csGWmTF+Aa9wgOoscSb2ZOrtS/+umvQxq7YNcrr+nK04/NOR0+W05FclJIK7bKk30pdA+y4AYB8AeIrjZacumxHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ii7mioXC; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gFp9ICHj reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ii7mioXC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gFp9ICHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756124585; x=1787660585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WSRmMY5jU29CsQJMPn3HB4luU6QMUAIAzwE1ehOyQFA=;
  b=ii7mioXCdYcyt1ciKK+8mgXKzBb8tAImIFeGxLI0ksKbldhFkDB5tbuS
   psnGOOZAayx5s+bG/mBCMQj6QGk1prtsT3oJWemQi93yC6CD87WRFGKvC
   P/bLHU5+83ZXHitdQOINiqhqyLQMrGEvM8l1NMtH2TxPXQoQ8YAfQmakd
   TOvSrqGbaJDymTUG0MzcZXYpySRGxIgI22aajBU79PENXt9z+kATvBrPo
   Jp+9CnY6pWcaQ7/9g5Ceed8Rx19LtCuktFff0CMQHhKyGvjQ3uFh37rXL
   8N2bjAe9XtILe60tovs72kL3wpHSfDFOpqeB/pHDmiJ3xtE+Dvzwf7/Gx
   g==;
X-CSE-ConnectionGUID: iryiftpsQK2JAAFomD2WLQ==
X-CSE-MsgGUID: Ve9ITUb6Th2+qx+Mj/FkEQ==
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="45893376"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Aug 2025 14:23:02 +0200
X-CheckPoint: {68AC55A6-16-AD8F5F64-F0EACAA5}
X-MAIL-CPID: 6E30C4E634C714040A742E56E9F2F571_1
X-Control-Analysis: str=0001.0A002106.68AC55A9.000E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C67A31673C8;
	Mon, 25 Aug 2025 14:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756124578; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WSRmMY5jU29CsQJMPn3HB4luU6QMUAIAzwE1ehOyQFA=;
	b=gFp9ICHjC/RUDTe5DfGzx8w1Aq7E8hMwY8F+C1wK2cPF2uYcFzfVt3jwGys5Ep6qfO5TE0
	mwcLTL5C6LiK18XwLRnuogS0OEiPs1WaKnVH3anmXpLRdQ5dYi6Kkae0r67+B3xV95Lyoz
	VwZdEu59Bd/P0ONyee5XjjKTrOzQ1CGAZcHhVRe65fWpol+7O9OE1GZ6tLQZA2CFOuwq0M
	46++6KpFqEbo0lQIUux8GwmETmAWHsOm8jVKRPNOxNrSZYFpsdffbWj+g9SS0FLtd4+FK/
	45X62oc6ncNuUmvdpJlJPv0lOFN1iawPNaSKPW7r0ro1z7RGG5bAxVOFu5btnQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: Matthias Schiffer <matthias.schiffer@tq-group.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 2/2] mmc: sdhci-omap: use regulator_get_optional() and reuse pbias in sdhci_omap_regulator_get_caps()
Date: Mon, 25 Aug 2025 14:21:47 +0200
Message-ID: <20250825122149.2169502-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825122149.2169502-1-alexander.stein@ew.tq-group.com>
References: <20250825122149.2169502-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

We actually want to get an error return instead of a dummy regulator
when a supply is not set. Change regulator_get() to
regulator_get_optional() for the vqmmc supply and reuse omap_host->pbias,
which is already initialized at this point.

This change also avoids warning messages:

    sdhci-omap 48060000.mmc: supply pbias not found, using dummy regulator
    sdhci-omap 48060000.mmc: supply vqmmc not found, using dummy regulator

Fixes: de5ccd2af71f ("mmc: sdhci-omap: Handle voltages to add support omap4")
Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mmc/host/sdhci-omap.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 08d5a82b7d01b..4623781adba7b 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -939,16 +939,10 @@ static const struct sdhci_ops sdhci_omap_ops = {
 	.set_timeout = sdhci_omap_set_timeout,
 };
 
-static unsigned int sdhci_omap_regulator_get_caps(struct device *dev,
-						  const char *name)
+static unsigned int sdhci_omap_regulator_get_caps(struct regulator *reg)
 {
-	struct regulator *reg;
 	unsigned int caps = 0;
 
-	reg = regulator_get(dev, name);
-	if (IS_ERR(reg))
-		return ~0U;
-
 	if (regulator_is_supported_voltage(reg, 1700000, 1950000) > 0)
 		caps |= SDHCI_CAN_VDD_180;
 	if (regulator_is_supported_voltage(reg, 2700000, 3150000) > 0)
@@ -956,8 +950,6 @@ static unsigned int sdhci_omap_regulator_get_caps(struct device *dev,
 	if (regulator_is_supported_voltage(reg, 3150000, 3600000) > 0)
 		caps |= SDHCI_CAN_VDD_330;
 
-	regulator_put(reg);
-
 	return caps;
 }
 
@@ -967,11 +959,20 @@ static int sdhci_omap_set_capabilities(struct sdhci_host *host)
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
 	struct device *dev = omap_host->dev;
 	const u32 mask = SDHCI_CAN_VDD_180 | SDHCI_CAN_VDD_300 | SDHCI_CAN_VDD_330;
-	unsigned int pbias, vqmmc, caps = 0;
+	unsigned int pbias = ~0U, vqmmc = ~0U, caps = 0;
+	struct	regulator *reg_vqmmc;
 	u32 reg;
 
-	pbias = sdhci_omap_regulator_get_caps(dev, "pbias");
-	vqmmc = sdhci_omap_regulator_get_caps(dev, "vqmmc");
+	if (!IS_ERR(omap_host->pbias))
+		pbias = sdhci_omap_regulator_get_caps(omap_host->pbias);
+
+	/* mmc->supply.vqmmc is not initialized yet */
+	reg_vqmmc = regulator_get_optional(dev, "vqmmc");
+	if (!IS_ERR(reg_vqmmc)) {
+		vqmmc = sdhci_omap_regulator_get_caps(reg_vqmmc);
+		regulator_put(reg_vqmmc);
+	}
+
 	caps = pbias & vqmmc;
 
 	if (pbias != ~0U && vqmmc == ~0U)
-- 
2.43.0

