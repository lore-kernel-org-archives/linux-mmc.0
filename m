Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FF197A76;
	Thu,  5 Sep 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531613; cv=none; b=hJeXmzbH+LGc94X9eN6tjPa2chNomMfq0r5gBcUkyRi+kB5xRC2AYsRh3L8sbPeS3KJQ/3oC0r4Yk3kVFK+4nGt9DgBHCrRRbFRe67DZIjvSTVxYYFo5nYj14ayulgaEKbqoDqHRxRxfzVnKZHp9JEVvBiBwf6v9w2+QssIbOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531613; c=relaxed/simple;
	bh=IQAZUlNPZoWpHJGkIKUhv6elpxjgoL6OEDDw8Puqvbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnLa29yUB47bCyNdQrXb6cr2xOKGYq44ejrdybYRougTUhBHw2yGngrBQj3VAK8t6hEb12LsLvfX5948vI6Jc/qLwC4H5jHdeaHdqV2YdHXC7gChdgoPlP5wWAvm3IL946XBdnbQ8TAdg3BBRScht8ncJkQjNGDJ34FoelVBZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF/BDqB5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF/BDqB5"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7176645e501so456392b3a.1;
        Thu, 05 Sep 2024 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531612; x=1726136412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=cF/BDqB5D9KQpkmcwqlszjPR3MwC9+CcKHNUSVzKOIdfpToEV4UYt1oFtHUdnCZjgH
         I7IiUoaih1SgZmmG2RXDO2yvgulT+pBk9Q4Lo04JP/BsZL4sZ8P+Nvx1cWz7bhna00L8
         9j8boClqiMWcmqa9a67fw3bOLfhksC7ZjBexkl44+VTI2XpGSOe3OMlNzB0SdPXrisTd
         r+tx+Idq1sOEHGSmkm21NQwjjp8HbmfBXpcyan8X9hC63g6b/a0yIfpF35q92ZEc7AG0
         M81pAUs3p1O/1XweDZVoc1yq52UnOlxYfkDotRftmjEWqNpwiHfTs3xzxkokHz/f4cJp
         +Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531612; x=1726136412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=g6KsZko5SHN7l0hZlG0NQqOE1ClQgyUXOOxiJZhvctzSgBp+z6oSmO8GJUvKz2rV2e
         oCpR2ITlKgP0W06iCgJTYoqGSTBaz3B56CVY4VDLTk7AS2zDyTCQB2NhCH8LAGFUjSGp
         YbyPNChsOcCkMHL5yzRgZL/4qyZNkxIfesEkagxLKGPHh3Aqj56lRduXekSwOVDX4FoJ
         Z85MaMSeB4+ILw4lwyEMuCblhu7GGD7mbOsdyDDmSw6wilmLSqbI32An+lY02QhKYXF0
         igorEWaQ7OVHmEOOrGgf7exBIcQa4df2/tcsw91zrAxr53Zf/fN1NSIhkPwp0oW7hKEQ
         dK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6YpfVy59ZxQF7tV2yZ3nzo+WUDvcCGrnsynmkku1DNxU2Kj7ctcndrBn3dZmnTpJQvxTuuAcKrHKnlAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDqWF5nx8nVrPrnYSmwMaG9/+qMzfQTG5dEfIO4Js/Et3+GgWp
	g6qjSovAKZb3skoWJ2J4uY/J7jSCAHiEJPHmjdbkWRfqWuUUQGd69ion1LlH
X-Google-Smtp-Source: AGHT+IFe5xx+mNpeQx/Paju6dhjUdCOXO2vp6mbAPlqJA91VEBWvXe1fOwhVdnHwgZV/k97+0/CK7Q==
X-Received: by 2002:a05:6a21:1693:b0:1cc:dedd:d8ff with SMTP id adf61e73a8af0-1ced62de827mr15874145637.43.1725531611777;
        Thu, 05 Sep 2024 03:20:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:20:11 -0700 (PDT)
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
Subject: [PATCH V20 01/22] mmc: core: Cleanup printing of speed mode at card insertion
Date: Thu,  5 Sep 2024 18:19:39 +0800
Message-Id: <20240905102000.5020-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905102000.5020-1-victorshihgli@gmail.com>
References: <20240905102000.5020-1-victorshihgli@gmail.com>
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

