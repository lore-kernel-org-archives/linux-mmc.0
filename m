Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D27A715;
	Wed, 22 May 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376164; cv=none; b=csBSbXpZfTB9/OzV+TuMa3VCUfEbgQ2aYAyKB59wvekh1dJ13JEgbLXoEe7EDTMSHYG3MSOgTNUAFpOClv0KD/bfTGZR0o+naKO9XULc+M4jOQV2FhTx5ohByFBOMCLam+bmfNWpBv+xul69SCujjQ2AMcMRDc7pAyVJSaESjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376164; c=relaxed/simple;
	bh=IQAZUlNPZoWpHJGkIKUhv6elpxjgoL6OEDDw8Puqvbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQkKYh+Kyy4Q7tXJx0+7NySw4+l0gJebjF6CXrw1BTsDQzIiWP4GmoNgq5JREN0ww5oC7jjGUMGjiZtWMipnI2z88DFe5S85eYeWSdUzw591Bu09VFc6FPlUywbXeeoAEp9ILzeNQjEy6zzdUyHom27L7bktT507gffCkDuk/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+3hBrQc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+3hBrQc"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f693306b7cso1657093b3a.1;
        Wed, 22 May 2024 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376162; x=1716980962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=g+3hBrQc8J/I156PDyvSF0HWiVYce2yIVaHp0ybJI96XE8kPy5u1i1mSiooyUZGtVO
         2W1PakKCxHMr5+t/vtb1w0fvFcEh9juvAMNmcbod8FBSboPRwuF+YN/yEqentmpOCB0j
         8frD2znnao+pKExvHeas28UB7NAxu6cdrkjdxI1lPaiBH+Sa8N8Gl4Da/hqSr3GWwI88
         8jpUo8R776CZg8TNi+46n+RJcXHw9t+OnRUxGcIHCA08SkPT0IqNvyFBzHuXdfM6DCOh
         RK7O1AW9Aa0AVNfeQo0nQEFFo7b0CwCX0BJ/ncNrfYlSZNGrI310LE2eaEYILPWLMT+4
         Xbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376162; x=1716980962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=ck6iu2YIos4bUg/1uovaBp3V8HwWQ53DbuqbzAluFtOQFfJK0DD9tnwjRc7UsfOSwe
         prVk0IWIA0vKk3j1QgIg2aduTcsYCCxb3AV9BsxxKwKU4GudxPvXn/zfGyLFi2s8tKyl
         K6i0QPJBqowClV9qU0PIXQrQW/Z54N16aRgYOWaFoHBvXi6mm+ulzsqHf6J+0goKbING
         1TsvNq9MBL4Dml2Jmi8TXw/gnzGPgYwUW3yB3ayLv7bvcmpj80GVs/6jTt6oQSGtMSqx
         +YLfI5qXd0NMY7jEgE2K10AirZlpqjQdB36yNIsQSMmrOmQPWKfW2rMWI4jZWQZSzi1g
         B0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUi8/1c+CbRLpeqHFaOfGDrlWZ0haqpgCEerOb0FG2cF6KCVf/rBEKWVPxT3+WxN6hR2ADX761c6QXycVyh5XRwzN4eTsE6tPxLSJ0X
X-Gm-Message-State: AOJu0YyHCE4h0Yx70uFwWZKhvV8T8a7Lgk2mNNUl/KmF2SVxncprjWGV
	h4Rf+q4Q1vgnFvxd+yhyB3ZZPGeo9WMY5vjFDS2gtHaWmUYwNu15
X-Google-Smtp-Source: AGHT+IEl4M8hAFt3MbxsMiYNiuggdtQXuPE1wTndzkGVSbE3Yj2ugHn2eSyaf/NFhdLu90WxmT76Rg==
X-Received: by 2002:a05:6a00:2d10:b0:6ea:afcb:1b4a with SMTP id d2e1a72fcca58-6f6d60430f0mr1709135b3a.8.1716376162294;
        Wed, 22 May 2024 04:09:22 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:09:22 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V16 01/23] mmc: core: Cleanup printing of speed mode at card insertion
Date: Wed, 22 May 2024 19:08:47 +0800
Message-Id: <20240522110909.10060-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522110909.10060-1-victorshihgli@gmail.com>
References: <20240522110909.10060-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ulf Hansson <ulf.hansson@linaro.org>

The current print of the bus speed mode in mmc_add_card() has grown over
the years and is now difficult to parse. Let's clean up the code and also
take the opportunity to properly announce "DDR" for eMMCs as
"high speed DDR", which is according to the eMMC spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 0ddaee0eae54..6731b46e855f 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -299,6 +299,7 @@ int mmc_add_card(struct mmc_card *card)
 {
 	int ret;
 	const char *type;
+	const char *speed_mode = "";
 	const char *uhs_bus_speed_mode = "";
 	static const char *const uhs_speeds[] = {
 		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
@@ -340,27 +341,30 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	}
 
+	if (mmc_card_hs(card))
+		speed_mode = "high speed ";
+	else if (mmc_card_uhs(card))
+		speed_mode = "ultra high speed ";
+	else if	(mmc_card_ddr52(card))
+		speed_mode = "high speed DDR ";
+	else if (mmc_card_hs200(card))
+		speed_mode = "HS200 ";
+	else if (mmc_card_hs400es(card))
+		speed_mode = "HS400 Enhanced strobe ";
+	else if (mmc_card_hs400(card))
+		speed_mode = "HS400 ";
+
 	if (mmc_card_uhs(card) &&
 		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
 		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
 
-	if (mmc_host_is_spi(card->host)) {
-		pr_info("%s: new %s%s%s card on SPI\n",
-			mmc_hostname(card->host),
-			mmc_card_hs(card) ? "high speed " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
-			type);
-	} else {
-		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
-			mmc_hostname(card->host),
-			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_hs(card) ? "high speed " : ""),
-			mmc_card_hs400(card) ? "HS400 " :
-			(mmc_card_hs200(card) ? "HS200 " : ""),
-			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
+	if (mmc_host_is_spi(card->host))
+		pr_info("%s: new %s%s card on SPI\n",
+			mmc_hostname(card->host), speed_mode, type);
+	else
+		pr_info("%s: new %s%s%s card at address %04x\n",
+			mmc_hostname(card->host), speed_mode,
 			uhs_bus_speed_mode, type, card->rca);
-	}
 
 	mmc_add_card_debugfs(card);
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
-- 
2.25.1

