Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980721C9DFB;
	Fri,  6 Sep 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618065; cv=none; b=sr+q1twwUy0Xmwopp8YWzKZE0qF0gU64acwd4jtA8YLF1RkAKaiQnsZGtRsQbaLGew3vHe24jmb1cfi0V3XGXpmW2PLrC6WUzxrr7iqLINVWQlFmn7kdS7HFnkcnJczJGdUjWv7uUxFdVXFcJMPd1pbIKuzT4/8g//N6BuyQjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618065; c=relaxed/simple;
	bh=IQAZUlNPZoWpHJGkIKUhv6elpxjgoL6OEDDw8Puqvbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=npFfyA2quh1d5cbBDI9kACDL89EHKr04vMOn21P6GWW+88Xxer+K0qmem5Onf9+IGVbWffl1khkyt5Dv6GEM7l5ksKlgXGkdfNN3Ia+Kgkj4aMaHTQc7R9fGxHfyTDUbtJiApdK0xwcKN9SzdBIKxLrhUZQgShyvtnnUJfqx7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlUqPquK; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlUqPquK"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-277c28fac92so1762271fac.3;
        Fri, 06 Sep 2024 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618062; x=1726222862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=QlUqPquK4gLtsmCsYAmxfvQGymM/9kKx+ScvQuIiDDNVFxdOYbc7vPueeVq7T159gt
         R2Ju9e6bvw5VxcUDNP1mbiKHrjzzKDIQ3qOyJeUwCjF9+x47FeUVze68Ee8Zy8hEtPIW
         g8q4IIxyRE0Rgg/aIqRaAUMzNkvbGKBHF4oEGBmpauyA7PXEGp2h/469FRIoUu04y2xL
         xPupHjFCje/auek8MffcaHYwJpmrpSd1Peu0HPlebQZ6FWcDKf447Pwf3Ya2HRoeBvlk
         wK0PC2TA3haVBhNZyuJ54KZCxRl8rBMHNNFZeNmTMt+ZetsVude+KsxgwXdE0f5bM0OD
         ZftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618062; x=1726222862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=VMk5MGVd5glR4suJgbGyJ6dTrCQWaG+pD2Jipnb1SaCDwdgQM3MJPyzKdbA6T30xU9
         Lu7kE+iaAyHZPDuuXqAYNnVVVDUS8T6XoAKFiwWhTxu7+NS+T1Qbou+SNNjB7CWKIw9z
         l5mQ9n86dgwHzE5upJf59+tVvlPlZHowX++XRd83Rw283T5zY1foBwnv9r+uxElbzd/l
         RYFGZG1Eemvnt7gF6yamKh7z/yyHBXstHekdTVFUZelsWLHbo71DzcS58hV+dMW7uaVv
         Ub9JYvfdtMT/ID7YCMpjRsO0cpfLbFegPrS9Jdma5ffajI7BEhWAWJa9WnWmtbduop7B
         kdrA==
X-Forwarded-Encrypted: i=1; AJvYcCV/vndhuJqqSg2JucnL8UJ36eam/dZtiFTL4tDJ43P30RZ4GFu5oBl58X5QuaRwC71aueuqdH+MqchnnbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qvKt+S1px8MoTxoktdonZF/gEjhlL2KiWqxpj87fA73HmeRc
	vIEBzkIzAJAjpvYpRvYfwooT7W5fHQdUB8bU70l3UpfRNgSWrhEyAj6fuNPt
X-Google-Smtp-Source: AGHT+IF7RnB30vhHmigvPcM9GNs3nlF9p859doX9OTWDQuRfQd2rlIU+INxnQsmHlFQcCpb0eo2sZw==
X-Received: by 2002:a05:6870:1586:b0:270:735:96e with SMTP id 586e51a60fabf-27b82e59a70mr2726584fac.12.1725618061611;
        Fri, 06 Sep 2024 03:21:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:5f74:48c1:9f66:fb02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717931fca8csm2072611b3a.139.2024.09.06.03.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:21:01 -0700 (PDT)
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
Subject: [PATCH V21 01/22] mmc: core: Cleanup printing of speed mode at card insertion
Date: Fri,  6 Sep 2024 18:20:28 +0800
Message-Id: <20240906102049.7059-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906102049.7059-1-victorshihgli@gmail.com>
References: <20240906102049.7059-1-victorshihgli@gmail.com>
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

