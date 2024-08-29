Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D481537CB;
	Thu, 29 Aug 2024 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926554; cv=none; b=eeYM9nOwRxNxCdGPdvio0Pb5djGpa1WioYGuys8qLynrFF7DvNWmEzcwHoiMUpcc31JTQV33KIjVTQXW5pi8fVPhYP1BVwnkIghnVLd9k6Rf8ySNBwYhtLdZ4JHersA9UFoLfj6YEM6291lUxQCfoLoSs4/iQgdbgdSF3uIdzB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926554; c=relaxed/simple;
	bh=IQAZUlNPZoWpHJGkIKUhv6elpxjgoL6OEDDw8Puqvbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzlxexyBhdFZPgjUtafW5RrwEWxnnnq6T5E5ZN9wqYWUrd1BCieHJeuRG47mxleCzaRtOvpVa0rtyVFGGhiCh3HIow2dQPFK7rPbRM4kP1iqCPO4YjdBU5PxPbgIv3Fzf1IKRFCec8pJRFFJrgcba82oJ8PSn+vpHoC7++eTqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNmS+Chn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNmS+Chn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714186ce2f2so422338b3a.0;
        Thu, 29 Aug 2024 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926552; x=1725531352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=jNmS+Chnb9DExBQshpuwEjTFG2s8MQsNebTu5Tu0Lld7o8G0obLSPVjcDelbB4z4kd
         ajwdHnFxYMEDYOhxNZaSwmi+vphKGib7HKnHCDH5RWVeeTU57rG2ny3GPio+Nke5gpC7
         bOR67HPaYg8/27ZMhRasU+zexVC4me4DuRRE5+LCXDUUwx6xIoiEawWswwV7pgpQ/el1
         X+tO9byMmCCgZ0UDoDyJno+xneA2sU9hvPNaNcrd/B97GYixNJx9zxYvvJPBmRaOoDoo
         u/eIvhV0KnfwWlnvGOQQiqnLD20sadRvukPJLwWB6+YYeCmjxyCyncDMQp4BU/zuGySr
         slpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926552; x=1725531352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=X5cSoQOYfl0HvjBlBucXyF1/9EEdcCdlIgixBjZfbGXLJ5daDCUx8n/Ot/txdbHXtw
         wGlVz4ovJKR3hrCZLWAszgIkIZZf4EMbqYenny3ujhYODbUtOeSza3YHvmeOxMPZzqUY
         oP93gvG9VYuyi+lBZ8/tKbLdX7QmC+AbiFaBm7m7BM4z0izrVLxngfp7YjP/4If83817
         Fkl5RRZho32Z5xc8gex7G5CZl2KIkAu4pzUf2G66E8WFWbc9qMxqM+J5V86heruB1DOO
         T1MiqH/eR4rQD3OC4butYM9tkF9aRp2kUL196I5UNjuCwMbq89U+2ZjRC3wtWTZVhBKB
         zUlA==
X-Forwarded-Encrypted: i=1; AJvYcCX+6eIEHYoe1Iu7dYb0U3ljdce04jEo1xs2BOSOMiFBKFcDBOP8KwwyXNoaQBHt+k3+R0oCwn8lgwD9fA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEvCl5O5nPy15eQcZuRFvgzsReYXL9m9M5tT0HxiIA55lSDCo
	9p6vR+u2yX8ex+5jRF/wiTu8Z7ZAzCOoCKPFbae9VE75gZLRVnYl
X-Google-Smtp-Source: AGHT+IFG5ZSyBODct8PGlb4nT4T5Rk3qEIPHLyfEFhfb9RTimc4nE9Td88nmH5ZAn0+HmHXIu9ckig==
X-Received: by 2002:a05:6a20:5601:b0:1cc:e7a2:2bd0 with SMTP id adf61e73a8af0-1cce7a23174mr487285637.31.1724926551981;
        Thu, 29 Aug 2024 03:15:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:15:51 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V19 01/22] mmc: core: Cleanup printing of speed mode at card insertion
Date: Thu, 29 Aug 2024 18:15:18 +0800
Message-Id: <20240829101539.5058-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829101539.5058-1-victorshihgli@gmail.com>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
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

