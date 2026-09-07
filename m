Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59F4E8DEC
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787602; cv=none; b=BJoghR6jCKwUyqZlbPiB9k3eO/87KfH3MHkDqPV6vMKfz3p27PHLHgSloWIr55f2aUAf9Dgsbl2H0iCn3VEnvVLQwOX2p8OZ6qJrmxbGRMHsU88leeVDkr4teyLGsuUj5A+hgcHxdYO9NAE5/kaMuqvWKyz8dxI1h2SCL2vM5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787602; c=relaxed/simple;
	bh=9bW10oDtwJZs/PWwTIIe6hHafffSVv0XlaaCvr6TyAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swfu2TyDHy1IJIHf3waUu+UV/IrjDQktURPrk9GsaysYUG/CwG5dA7j2kbNK7AVG9kGi0tZpRm51DFcIs16I29aVmCnt2p2GpP3QRHOkkFVkIKEJLbYr0cc/isvjJgpZasHk8ilZXZxxkUP+r6WzFVvv1dmmGn42dPwUOmH92GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=skAQ8+Iu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="skAQ8+Iu"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2544ff970dso476892966b.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1788787592; x=1789392392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ze692xwI5jsqaKUMaqkOILgz7h+mY9HSH9sWUthU9v4=;
        b=skAQ8+IuTKuSrtMfR9KmnbAz+azZwlO9R34ng+ZXaJklyMUR3J7LgWQo//p6ifjMD+
         GEPpmk38RxI8BCWDHxezes6ThDJBsq1enUuJ1f61JGdrFTVEud/1rkwjkcF+/DxYIcIp
         JjXtatGQNZfoMkSW1yFlC6wg8Y+hcxwm80ekjpI0E4s+cTqDH6k+Fqvwyc8r9QfbUrMl
         NuKVP1Pma3aORWkz/JrudwLVkIvD0t/gzzA+Niqmt/N73W18YTwtTTlhQ/7+m42Xt6D/
         /Slq0qBk/G6sNupPNBgtNzFNd8KEL0roBXPlmu9500GujXsR6NUeqmkdCaLXOJJl4jsS
         RTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787592; x=1789392392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ze692xwI5jsqaKUMaqkOILgz7h+mY9HSH9sWUthU9v4=;
        b=EA6WK3SXFdMbciM4RRVd7ekAdcYFM32Iam6tuJQcE6E9zCNeyKLDnqQll+7B8dtJTV
         LP/vF09gBJJBHUx5hzwsPxeo8thnU+d393CIIUxN0aiqvN9QWCtDVtrIladg0w5P2Rvm
         1kOVilQYA24LGWi0j5NuGwNxaqWtcZ6yDxTJcpUKCyejyEErKbBO/MhsG0zf3VuXySyW
         +HFb2r1tYtMncrkJ2Il/MMxBOF58MyDBWcIh+VTEql+4RUcKAlwKBuQwMSAJdAJSgwWF
         A2ge3fc175lQWcHWtdgThDw6kWf5Z4VxiBjXDc1aXPB87LEhefnshnAzoWCeU2Pw3HIc
         HnwA==
X-Forwarded-Encrypted: i=1; AKwUvBx/AgWUyXxT8UwXs20Q5cDkr/bHTXranc1hetrtliEAKhJvh0giNAPHS+h+6LZiAALEBqkAqYNmZU8=@vger.kernel.org
X-Gm-Message-State: AFuF++lEornTqN8QPM54LKxL1Wzk26KdWyX9GRDBRinZ+Z1YvJ6viBRY
	KbWnaiOUHZlmttlE72f3M68b4zjIcLyW/iI4EFAW0fv9Qi600OGmjuXQND1djZ44Oi4=
X-Gm-Gg: AYBFou1fRDAM/N4ns0Sa/P8MkSqxYmRNLYMg3pFqjTQMUG5i2I2+31+AWCslx1nAvsK
	w2wp0W5payREorGRvm/mkJ3evBGVjleVg2uuHcxdSyN19fmNAHYN/vtnykWHbJhJezrL0qe2sB7
	X/IgdzaA64/iYLCDSRhuxfqxCB6405IhKhNgLuriHs5Ef+smvdjYDUB81fyUzhg8yQ6WSh5zcIy
	Ir5dFbubS8pE3QKVzRyctXNPqFqVqgrrLw3JH8twAlsh6J8un2c+OSJ2zmwPNxuEFkQKmgkEemf
	g3m93sDdenltWE/kVi7D4HPwRn3REcN0zRdk7FXGrW7tvTDh6hIu9URmT2C+wAsy2xu1xKOjfsb
	PQ2/kxVNuw6nHvOsgy3fs/RbDRvDSEFi0KQ632fRXpLGaXSPmjzJyfQ0v+pewNFmVIeAKr5xZLE
	fi2mMIB6Dw0ruspaNEcCStRaGjU6W6Z3pC/GK7wSp3rwCgN2AEa0nxEbqi6D30dRJeBM1JsfKoV
	kiSVkAXKbhYsuVTeOiZqo6HfW6wi89pbZSmz0BpBI6wGGhVPMVEjHUt3Nanm43YF6xtUTQdLXef
	iA0xJTmsy2HuOMsz1AEpsBxcntJAh7eszYdWVw==
X-Received: by 2002:a17:907:3eaa:b0:c26:37fb:3461 with SMTP id a640c23a62f3a-c2637fb36b0mr464023066b.46.1788787592611;
        Mon, 07 Sep 2026 06:26:32 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-94-253-164-142.zg.cable.xnet.hr. [94.253.164.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2622a7c677sm366362766b.9.2026.09.07.06.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:26:31 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: ulfh@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	adrian.hunter@intel.com,
	aubin.constans@microchip.com,
	ehristev@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/6] mmc: sdhci-of-at91: add option to keep clocks enabled
Date: Mon,  7 Sep 2026 15:25:30 +0200
Message-ID: <20260907132617.1198548-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907132617.1198548-1-robert.marko@sartura.hr>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sdhci_at91_set_clks_presets() both enables the controller clocks and
programs its capabilities and preset registers. This prevents callers from
restoring the registers without changing the clock enable counts.

Move clock enablement to callers and add a SoC data flag for controllers
that must keep their clocks enabled. Use it in the runtime PM paths while
keeping register restoration separate from clock enablement.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>

 drivers/mmc/host/sdhci-of-at91.c | 39 +++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 7c4ac65f247d..b7e2a89da348 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -38,6 +38,7 @@
 struct sdhci_at91_soc_data {
 	const struct sdhci_pltfm_data *pdata;
 	bool baseclk_is_generated_internally;
+	bool keep_clks_on;
 	unsigned int divider_for_baseclk;
 };
 
@@ -164,7 +165,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
 
-static int sdhci_at91_set_clks_presets(struct device *dev)
+static void sdhci_at91_set_clks_presets(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -174,7 +175,6 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
 	unsigned int			gck_rate, clk_base_rate;
 	unsigned int			preset_div;
 
-	clk_prepare_enable(priv->hclock);
 	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
 	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
 
@@ -222,11 +222,6 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
 	preset_div = DIV_ROUND_UP(gck_rate, 50000000) - 1;
 	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
 	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
-
-	clk_prepare_enable(priv->mainck);
-	clk_prepare_enable(priv->gck);
-
-	return 0;
 }
 
 static int sdhci_at91_suspend(struct device *dev)
@@ -254,9 +249,11 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-	clk_disable_unprepare(priv->gck);
-	clk_disable_unprepare(priv->hclock);
-	clk_disable_unprepare(priv->mainck);
+	if (!priv->soc_data->keep_clks_on) {
+		clk_disable_unprepare(priv->gck);
+		clk_disable_unprepare(priv->hclock);
+		clk_disable_unprepare(priv->mainck);
+	}
 
 	return 0;
 }
@@ -269,14 +266,23 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 	int ret;
 
 	if (priv->restore_needed) {
-		ret = sdhci_at91_set_clks_presets(dev);
-		if (ret)
-			return ret;
+		if (!priv->soc_data->keep_clks_on)
+			clk_prepare_enable(priv->hclock);
+
+		sdhci_at91_set_clks_presets(dev);
+
+		if (!priv->soc_data->keep_clks_on) {
+			clk_prepare_enable(priv->mainck);
+			clk_prepare_enable(priv->gck);
+		}
 
 		priv->restore_needed = false;
 		goto out;
 	}
 
+	if (priv->soc_data->keep_clks_on)
+		goto out;
+
 	ret = clk_prepare_enable(priv->mainck);
 	if (ret) {
 		dev_err(dev, "can't enable mainck\n");
@@ -344,9 +350,10 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
 				     "failed to get multclk\n");
 
-	ret = sdhci_at91_set_clks_presets(&pdev->dev);
-	if (ret)
-		return ret;
+	clk_prepare_enable(priv->hclock);
+	sdhci_at91_set_clks_presets(&pdev->dev);
+	clk_prepare_enable(priv->mainck);
+	clk_prepare_enable(priv->gck);
 
 	priv->restore_needed = false;
 
-- 
2.55.0
