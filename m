Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08261A2C11
	for <linux-mmc@vger.kernel.org>; Sat, 28 Jun 2025 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075618; cv=none; b=EWmbz3NckDVkMAcTABXpoeAP/+iZBvvL7guKZJn+jpdZcgigVxNlTbx+ymAx/TK9ZkoFbrRiHJxFeW7CaDnQMWuhVLklP2RyiKUs/DMSQfJ2Z/f91OBTTUEa4jXhPHHkUJ5jbvdAeDAgskUwP5nHEzBCg591MTwjpNV34kRzftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075618; c=relaxed/simple;
	bh=xAVEsFJaJpe1cuzT3LWf6Yt7wVSF7ac/1D8++/chJis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tbtgwe8ZHf12GGtly30ZEv7oGmI7TcFcfGTaUm/h1xiCH+KfPWMhxeQQ4wUPU1DiIxpXypWS3FWVAO3Av9FKIGKHFV3OdWdIvQkzwoFtrVZtVIKcAFeyDYJMDCALqfiLbwlzd+BgYvGUZ+q030DsR8FkLlAZzeaQ6w6lP/LX8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=gk8BRuiP; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="gk8BRuiP"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d3f1bd7121so38480785a.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jun 2025 18:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1751075616; x=1751680416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDgANBooOaHABbpjHHyBVc8hQrSombBZ6qXbl2V9NGc=;
        b=gk8BRuiP6zV7SsQTXRzhKoEH1aAVPWlIyRbasH9Q8uDyT3xyc0s5EuWKXDabUbBgXP
         DzxnnOdNCg6uh22ool2WDzIqoiUwuKVTmu+i9naxLUJzarn1Pktm/37KhMoD2f1C5hZx
         MSrnsUAHKwVs0Nx1LyNHsfMBjjGMtkjm/5avxei9yDmRhYcFcDMPvEfpSFUitUzOLImh
         TbQOeYOTu9gRTWfG0hn0Dj3ShTPA8fTzcftpblPTjNHrd8eJfDJdsGKbt+YWc/0LiPjn
         fY393AyVSEEES0RjM4L2llXdiusOcP3wWdlizBJa5p7JCAE4/m76A8TaPNCPbu+AmVgl
         54iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751075616; x=1751680416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDgANBooOaHABbpjHHyBVc8hQrSombBZ6qXbl2V9NGc=;
        b=a5swuVx5MIHzvzwL5miIDWbEJx6tRdXP2ncHIN257y33uqcdOlwLLL0sMcv3+EKobD
         5JhCRQXIB31Ihd3qowL48Wd0BsSG7C5hQoFFtx/41qK23k9sr0REI31SB65SwzzLJyZ5
         saml66oMqPOMrcGh8VH2QjbNggIKofHGGr3Wjc5Q1ZhoomROwkbSFimf39UQaGouskNO
         3zyHkJ2kcdmq7ZPRc4JaOcebJHaJ51HtFTqjsFl0beNf0tDJLeas54YWqVnXw6PFb9xR
         VBV8ImcNzm+BRg4/qt4npJBr5oG11v1dc+9ZVHQuDv1M6N2bOHTN+Esi4DHVe6zohrl+
         vGDg==
X-Forwarded-Encrypted: i=1; AJvYcCX/pThBBU5Vj9kpxaD5Ncaf2k5KcmdTVB37lgJc37FBzJW7AuDk79zqeloiUa5200yeVOnUuIJToE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIU2Iy0t0G/CpbFUqOiOtRcCz/VI1eId5POAX7vRIb/utrW+hJ
	FIbnx1x+0ktwGeGX6wktUSNIn6Gna6viRrlOKI9o9UHi43NNPSbjANVagYXbtQmfbQ==
X-Gm-Gg: ASbGncsvLZxYaJq/pWIj4u7Z9cns9kKA1EV2BN59jKBG1PVUDNNKMhdaGHE8jeuwPEA
	4dMz/FutSMkkhxa114PRpaApSpDMiD6X5eyVq4A703jPAyxXr1wM3e8zFCjj5LxHwuUjQGXDWdW
	7Jqb6L1yQBbvGokk6MEWZclAq3BNsozgVU8QECb2glX6ql108PGovLdelx6bXsOIYHH+fQhm2Jj
	8epGmmAmzVA0Xmp1YGWNl2HB9yqqjAypKeXjxkvM+6eqbroMi9LV9FIx8jQVV9zwfq3J3g2VmfQ
	AzatQ4oOzUr6oqJQJrgu6DACAkUEPtGhflOUfCG5AsatY40aOSTdrihfGQAS5ULUJpvL3A==
X-Google-Smtp-Source: AGHT+IHDOFs/ZbAzvN7ioQVvaBO3tKspbKCC2PmmEG/e0ea92CY3dBFRoIiyAncqYqaZi3cyXQ2vdQ==
X-Received: by 2002:a05:620a:198b:b0:7d3:f3e1:b8c4 with SMTP id af79cd13be357-7d443944e85mr816887085a.15.1751075615803;
        Fri, 27 Jun 2025 18:53:35 -0700 (PDT)
Received: from localhost ([2607:fb90:6159:6306:aa35:a456:78ca:2103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc55c396sm21861621cf.50.2025.06.27.18.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 18:53:35 -0700 (PDT)
From: Da Xue <da@libre.computer>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Da Xue <da@libre.computer>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] mmc: meson-gx-mmc: add delay during poweroff
Date: Fri, 27 Jun 2025 21:53:28 -0400
Message-Id: <20250628015328.249637-1-da@libre.computer>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regulators controlling the SD card power need some settling time for SD
cards to fully reset from UHS modes. The regulator framework seems to
ignore falling times set in the device tree causing a few boards with the
same hardware implementation to hang on reboot because the SD card still
had some voltage and did not reset properly to be initialized again.

Add a delay sufficiently long for the voltage to drop so that the SD card
can reset properly. Otherwise the reboot will hang at missing SD card
especially with Samsung cards.

Signed-off-by: Da Xue <da@libre.computer>
---
 drivers/mmc/host/meson-gx-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 694bb443d5f3..a39906079d29 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -605,6 +605,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_OFF:
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 		mmc_regulator_disable_vqmmc(mmc);
+		msleep(50);
 
 		break;
 
-- 
2.39.5

