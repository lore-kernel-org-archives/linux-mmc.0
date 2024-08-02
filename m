Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196B1DB449;
	Fri,  2 Aug 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594166; cv=none; b=sbMRNilXZW5NisRAlOCaX3rSHISEx6+wcvK86VAIRirPfYVJlv5ckEoRwb/GQHG9NcVKrbs5+josvOyTu0xjctwwFUL2yiOXH4olA69Ur/p+pH0DVJhZZiIvQGKlI2GWWY5fIlLz3GfIwXoDbkBInTUupeK6tQ3UpDRmo9X3h2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594166; c=relaxed/simple;
	bh=IQAZUlNPZoWpHJGkIKUhv6elpxjgoL6OEDDw8Puqvbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PJvixFJkjfpr7qRKdDEcZyCiREuA6gnQE9/xVqhSPnCDIrygX8M+MDSfrrvYClPhjCaT1V2TWWIBvyzd9TkrwesogJuBwZl4a6q4uMUVYP66xhtMcFP8UYGTBEGGDIMSGmue38tAwUm3qHr7K9OLjl3Rbk7zz888woR6XxEgyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=and3q6Rj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="and3q6Rj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710439ad77dso3104257b3a.2;
        Fri, 02 Aug 2024 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594165; x=1723198965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=and3q6RjzeqlrH1lMU74TkNxVnwmPAB2ER/EE6hWneK/tOA5+UDa7D9VUwDTm/4QYo
         x0B6zkqrx/3sPGxSfWZguKvsOYNXWKMVk91K5ifj311gmfZxX2Y8oVX1DzwZ9P3McaWu
         UXUd8Jj02ufJ6mSpXio8LTYyDQODsm85FwajtSqkTj/IlaMk0oBpbmjudPDpaUFCtedu
         vVjIg77rpHtE9EmXVKE6SkmEq0dDR9dMVO/e4f/nfZLMa9J4DpYYOgcgynhPXcsSJJcD
         si/zdOPEB9z/RwwTh6Z4HHdH+Cso48qM7okkfaCvHGGRpmFaN2L1OxEN8WUOmmju4f+4
         7kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594165; x=1723198965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=LdP1uRbeqdnerRk2tcsEf+2Qki3HLE7p/DokuYa65j39avrbRU+mHPBCjkt7Fna98O
         gWjZnMe7DH59SmJImYjdwXoFWOR2liEnuoYWGm0OOT30oB0lLLvvTdUUXwjaJ75ADmHA
         7lUZtsjmice3r4obTs370EUtfiIQ170+4J2Zo3s7E2QeXOzuF9/zVpowYerShsNhvX3v
         Jede90X5m94GN9TnGz6RmARhJeO20LH8kebe41zT/c618ZvQ/3g4JKwrCL6l2aAMb09D
         RUPRwX5krGUFDhmlIC9nIoKHZsYdQvSjlMImOmf3PN9WfZCwusZAFNQJDJhy4EPE/Aqg
         Fu6A==
X-Forwarded-Encrypted: i=1; AJvYcCVpYwrgrjWPTiu31Fm7bgO79yoFMvRtqD7AXljTZ3AzuW0yqdciTgsZp2mu8CbIEDUmynSsc+hpZvkTikdc1p1dVgRNII1rgmjrYpPT
X-Gm-Message-State: AOJu0YxV6WqdDEezJzDRpHyCP8W2EWtI1tw40i6ob3cBhCjj+qKCDSo+
	rDT4y4W6vgvVFahThR5HymY0GvQ08ON/i9KXlEb7ZzR5TRPkfAFL
X-Google-Smtp-Source: AGHT+IE+rXL31b49reR9ibaI+XNhGcKr8SClbGSnTkX62KxiuLmboXfX6IRD8yFJ6lVDBfwYMKW9tg==
X-Received: by 2002:a05:6a00:14c8:b0:70e:91ca:32ab with SMTP id d2e1a72fcca58-7106cf8ffa6mr4413113b3a.6.1722594164566;
        Fri, 02 Aug 2024 03:22:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:22:44 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V18 01/22] mmc: core: Cleanup printing of speed mode at card insertion
Date: Fri,  2 Aug 2024 18:22:08 +0800
Message-Id: <20240802102229.10204-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802102229.10204-1-victorshihgli@gmail.com>
References: <20240802102229.10204-1-victorshihgli@gmail.com>
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

