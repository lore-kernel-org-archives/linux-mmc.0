Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E831AAE0F;
	Thu, 20 Jun 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880299; cv=none; b=C9stu1mD5oxoG17EuCADksN9KFtZwBnV0DmECCCHCfcDdPO4GzOKjy1qFiD1/0F4c68+US2C492fQTMJ5ntq97Y5G40rpjYDKW4oeDegCJK++g1d64TA8JuFjef465L1jx0XKLAtm5dsAFjxU9XHf0mEqWpXX4QOQmLjDCUu+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880299; c=relaxed/simple;
	bh=IQAZUlNPZoWpHJGkIKUhv6elpxjgoL6OEDDw8Puqvbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYh5svBSn2OXWmOx8qm9GpdPf0VkAL0nnGpZLSzdOYg6ewaYbK0wvIxpFdewAwGlN+rKKJPgTclFzOLrkunSccLkQr1VNSxVnfzFerxNd4fBT3nf/ZujnkeQfd1LT/OfpKEJ0qtF25hplXfRPsDaliDT83TFcfPcH/U4/v62Yec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbpUOD6p; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbpUOD6p"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f9a78c6c5dso6554465ad.1;
        Thu, 20 Jun 2024 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880297; x=1719485097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=HbpUOD6pgb95y1sARCeRamoCkOnMwQoRpE/TJL0+nZZTcoHy9xw5J9cuflf5ijQsYR
         nMNJ/DpBqHW0nT7niMSOeK/yGdJYQyhwYYdAn9E7zaDha42IXM+k7vJ91LiZSUQ9OEnO
         ZR4DHEUf7+Fc6duejV4gcrfmwRQpGMhkkSjF44uAKF9du6sfPaPYHDY0iGrTC1oEZgxL
         pN4qFv0I3sTl5/0uSs800wco4DIwdsfWtw5rI/DMh9vFYSKJA76aIO2Zv5X/sxFDc/kk
         piLYThEGzgFAnD+ZJfRyznsG3d3XJ8TthfM9xNqDQKGt1IYkKEnPuaq/zrKhRhoVS95q
         FD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880297; x=1719485097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=RDqQcvfrfredIjsUmHh9qBpZpV9E53pFVzJe/RJuHpP7Vwu7D14DjX5LTfcETFh5ru
         1LLc0y+MDMw4/Y7HMM61OAGVaL0cXjB9iQCEoraGj6nU9DaU2V2HLDuT9JPJmCxNVueF
         ot/5bkiNeli/3ZDg/bPNpsrPDLKLvA/mFV73i/NYf4XXFgQulzz8HgcRpaOYp7Tz1BdA
         MhkA64T046MdZ+egKww5twJA7bctWYKTqvUbCOsetov8YIaofz6Hg64OmSsRI7hMTANT
         OxS2d6CvsJTgLBeqP/1me1mucZIK68Gbpo3L97FzPfdLVA3p4Xz5+v/hDe8dHrwydZrc
         pR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIRTPbD7YjVCtYBgpJiIZ1MICwAKpMYG73BDfop6GxkVRj1Dr9xHek5EfW8HBSHqgUsWtwGbRxzJzRVsv9+QaZ7k0NZURkrI+MSwkP
X-Gm-Message-State: AOJu0YyalToSMwUCRjrFihOr6nM0vCr7WJfFJffY4DBwos36ztSgdAvw
	ACxWt04oniSIAP+zW6LytRa6NH9HmCCwxGA2+EMz5G9SX5+5/RNo
X-Google-Smtp-Source: AGHT+IEXAR38DTkt/T0+IqxDNSCo7vL4OV0PQH4pTSZRWQo55l+OQ//jLWqk4Hb0nJMLYpOcvYyyUw==
X-Received: by 2002:a17:902:e88a:b0:1f8:67e4:3983 with SMTP id d9443c01a7336-1f9aa3ecf7dmr51434855ad.4.1718880297387;
        Thu, 20 Jun 2024 03:44:57 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:44:56 -0700 (PDT)
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
Subject: [PATCH V17 01/22] mmc: core: Cleanup printing of speed mode at card insertion
Date: Thu, 20 Jun 2024 18:44:23 +0800
Message-Id: <20240620104444.5862-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
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

