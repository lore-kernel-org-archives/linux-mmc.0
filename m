Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D11D6C7F;
	Fri, 13 Sep 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223331; cv=none; b=ZpCqhE3wluh8ub+MO4f2VkCyQ8gfkqE9RpI5oUTogQzGC+GV/eukJKTY99PoDJz8kLmw989tUNWnh9XZ+GXs2bC8ZEPGudrwxAfHf005pw2UNDUwb+IJvpthVGNw6lyJirpRrVRFF+WueFAFtXHsiA7OaU2HER3L29OS11wTwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223331; c=relaxed/simple;
	bh=IQAZUlNPZoWpHJGkIKUhv6elpxjgoL6OEDDw8Puqvbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xp0dDBzZGuW2JuY0vkdEoAFK/jjclLAnNPFfincIrbwjOabbg+zRfF4WcT+kyCHp/MwJeDGboY5zrjlSXlk9CPZLUuRhqr09X25D8SmGb9LaV4vyMcyQuyDRy5K5W6taezu2EM7Hc1ldXez2miEk4jhSn4W7j+nhRxD++bvXeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmUPBEdK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmUPBEdK"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so1814077b3a.0;
        Fri, 13 Sep 2024 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223329; x=1726828129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=QmUPBEdKR6tlShvJ9EE1SP81XQLhU85weRHxOFzgVTigNvJ7u3WxOABXOdQi9ijCo7
         MzhOXOqnTPF2wNnsPla4Y3fQvm+pGN+hqLC6Iy4e5qVwe56KuU0WVwoc7K5YG/uy5U3I
         ThBc3NH/ujnU+sTnz78HEfUFFx0iefPaNtM1bLqdVrI0lS/pnfuCzejDcuq1UtxhmjcG
         zgE/moKB0wKSIfI54LX3DG4npVHsWmtvTm6lTJr2QxR1JXOVec1vd2uJz2ep3WtZUZHn
         PGhy1se24ttWcfr86dQDAKmYsYiV/tSjVIYlv3yPhUIskqAKgqvM3OXY4pFJT6uz37fx
         RUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223329; x=1726828129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=gU6wSMKQ3K3h6ylqUPSOYqXvJxlyViKQxmS4Hljt8zE5oSRaQIpyOp5jKQ2FUd1oHe
         fxfRvbj5j39mXQaYL4aRuFAhj0bKjFOAcSIUkkaZqVWkdWCStG2Mmc/QJAOUrSPj3wOW
         v3Frj9L+JP3ra1xol6jounxsJvY3KPIr8fcRyYusW2JmF/A/l11neZj53hpZDXjMiJ+Y
         BKmOePc11vXfd3vb0KJSJKpc+Cut2/zV95pBLpKp7TDCNQLwnSb3nbfkacs2a/y9S9So
         UuEJdpSPxmodAlfz2aT/+TKD9Ix8T0zMxPBOaFKoIVKhsNQ5t95FM9jC3MnTwiku81ny
         4/tA==
X-Forwarded-Encrypted: i=1; AJvYcCX6/yKiIa+W4FIjyCbyj+uU8oQkqOOHJdJ4MjYcm28XLHRHv1bv7co/lG58CVlcFyUDDB/bGyiRUtZY18A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbparHZLvwklqT1ZOIqUuGXg7qJ+BhSSxJcHAPsIabApOCdwh
	WdRKZZF85u0G3i9WcS9KxD+tnzz7B/NZUACEJsNv5LU6CfDHMp+C
X-Google-Smtp-Source: AGHT+IE98jVxFTMHaqMEevVMxdyJgriYN/ox/a+pTzi9hZJt1UpWEceEfTSEF4RtOts4rXxc3TxvhA==
X-Received: by 2002:a05:6a21:394b:b0:1cf:5c1d:83f4 with SMTP id adf61e73a8af0-1cf75eee771mr8027481637.16.1726223329503;
        Fri, 13 Sep 2024 03:28:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:28:49 -0700 (PDT)
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
Subject: [PATCH V22 01/22] mmc: core: Cleanup printing of speed mode at card insertion
Date: Fri, 13 Sep 2024 18:28:15 +0800
Message-Id: <20240913102836.6144-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
References: <20240913102836.6144-1-victorshihgli@gmail.com>
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

