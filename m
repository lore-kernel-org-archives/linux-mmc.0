Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75D23BCE7;
	Mon, 25 Aug 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124159; cv=none; b=rBADqJ3ImZTA/K35OvBL82t3QxpKgxhSojW96vP7VVe+WttybQ1BSCtfiED/aGspL4cM6jJWvMmt/LkQoSkkzYXNX5pUW4lVyQ4jyxila6cwu9XV5gupbppTtkHJvjbzu7PtKVfxie2/52n6jLFeIuzAg4ZXR9wok3CGhnz31HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124159; c=relaxed/simple;
	bh=Ti5muMAyeztdYaT7gdOAkMCnChvbp3E+ufomta9VzkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LA4QaBUka6pIT9qj4nRUAmpoNgz+tEVdhS2f5w6miVASESDSGclyBHSm/AVDquk6YfLjVEuq5TBSDh0iKkt1jZCyvMSwcvuDVyV+wYoe6yVzQMOzMKsg9AzfIijF2mSouq/vZbPOMVkSfzZoIyUmmaR6VM+E5ztnKjKuJn5HUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lHJtI1SH; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gdPY8dNU reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lHJtI1SH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gdPY8dNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756124157; x=1787660157;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WSRmMY5jU29CsQJMPn3HB4luU6QMUAIAzwE1ehOyQFA=;
  b=lHJtI1SHL7h/n3urqB1Xk+iC2ELEwirD2Dsb/uLh+rnenoAXaGONgSgy
   Syj2iLsADHf8bYwnNMxsq/XJMbjDW1icPP6QFJ+RYS68On9dS4k/RoiK9
   NJeTQyjiD5YgsrH2AoiPYIfnTb+wR2qzhipk5j2/HHXnOFmHEqbNexUtq
   RzHPs6hEBQt8rWHWeiHgYf0OBX4kosY9r5gXgApekzZN4rDbwpVTH+PDW
   rAIWV2OIk0fnITow0RHTHquTTFKUaDMVe7/ZcIDQ326yo8tir0mkXGL2o
   O3zYu9secNTf/aHJhUpVVauHFdEL9dbZ+U93A7sZ4l04uX1WPuvWFPdQa
   w==;
X-CSE-ConnectionGUID: gYy7aZT2SlqM1DErnKG2hA==
X-CSE-MsgGUID: ixrzK5p5SMWBO5YN5piB4Q==
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="45893231"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Aug 2025 14:15:54 +0200
X-CheckPoint: {68AC53FA-4-20CAA7DA-EC9DC758}
X-MAIL-CPID: C7257E9FBF8196D0A70DD1DDAFECAAF3_0
X-Control-Analysis: str=0001.0A002124.68AC5412.00AB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E53816738B;
	Mon, 25 Aug 2025 14:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756124149; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WSRmMY5jU29CsQJMPn3HB4luU6QMUAIAzwE1ehOyQFA=;
	b=gdPY8dNUI0ok/UvDq5d5vLVuD8qCqnm0GwUHXQmXOpi6jLoje1P80JQzJje8OHdtJL1qhW
	Q2HAnT+XbpUE4MaM2I2xyUFYKK2L6A9gIplTm9dcJWjSxcVhCfBvXFQFqFzKu9mZgPHGtV
	JkGMHZqLsXo0DWY3+lRNH5YY+Tgbss8VQ/Y65Bso8bwJSUEnKdv110i/sGqxpUG4ESbvpa
	Sm1EWg0om+pqRfTCW8BZNBxSl6r9XEeQ765Ri1nmvnXrVy+R7Bnoy2xcAzXp9Ji5Sy4qfi
	1NqZpFzwRyw9JGhx6QpXvaFh7b7Ilc/xBtZGc4sDuhdWITNOltZj7iJ8o1cULg==
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
Subject: [PATCH 1/1] mmc: sdhci-omap: use regulator_get_optional() and reuse pbias in sdhci_omap_regulator_get_caps()
Date: Mon, 25 Aug 2025 14:15:33 +0200
Message-ID: <20250825121534.2167270-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
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

