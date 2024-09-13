Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCDD1D86EE;
	Fri, 13 Sep 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223339; cv=none; b=aXBfirO8lyIvlEqjzWKDdGKuQ90gHwYD9NZs9by9LUJYzEg2/iv+3fwBYETmyI1ABWqDlkZHvCsG2TpsUXSBCxsxq9k2VMP+DD3FL7UBdLz34VxW9yy6SqL3qf9FNQ+PASvh0W2b31ziNjH/hTwqZEhnE8bP2q9VjLlvGgvpGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223339; c=relaxed/simple;
	bh=6+Nf5/9K+OHRrwoZr6U9n4pyW8vGxOX33Ds13iGam8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5A+3cIc0KdtN8P9WxrgV8Zu44kyzyhA1DH7lMB0Eevcgy+MEpPuesOAzyqh1edZdqTecDjifAS3SA71uOkVYpAZqrP+tEDytyE1Kvu2w7O0nNrNze6vjQ2096sTQDtGsRyUR+foRNWlOSazyjIkdKZ+zMMTmbwXihosLAT0NE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVU0clXb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVU0clXb"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053616fa36so23179735ad.0;
        Fri, 13 Sep 2024 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223337; x=1726828137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eNmn+upOObWpmwFmRKwEaFcUhxqumDAQxIm2bYLN7o=;
        b=UVU0clXbW2A2fb+N0cnf1oQSt3JMZNCFtLzyAkOKw3NKuOge4MdnfVDCxuUmddcTUf
         FO+FL4X2QZEByBKMc9WqD7O52/neu/VWNOxHhjYgOY/W4N3/aupOkkGIGdnxqGXPrvBr
         gKSK4Q59m4vDs4/fAsAP8fyL/SQlZrjiR3MIfHjVTVJU2UJEzT75bVzOAkxV02wk8G3n
         9qDyECDy76UPs6tKz+rk0hZY3391ymWUI8aYVQ0Drgl4tGRrOvRO6KFdDKG1J2rUcZHI
         Iwd2x6Dq9xl/fYA8S4IrOtRe9n0ICObiUHIAPEXEYh6LRAcPPESZD5I9P/eObNpthujt
         3o0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223337; x=1726828137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eNmn+upOObWpmwFmRKwEaFcUhxqumDAQxIm2bYLN7o=;
        b=OCCy3GNzdxPtTfKlVp7N1H1ajlSFStJLELEPEpXcuQ044zJliReMXYTf5CrmNU4PIU
         93cN3KO0p8OPa2zmhevXfvnNgGB6LgnyzFWBWKtzRknOVltHfFxjP6LHJKqgDQAswlTk
         HpopApai8baax1wqAjC3yYcjN2kAbEzyNcDWwB3QQ3s4yc96U0L3iKAmX5K7SQqxfo3B
         NQnQauQndvZKkzCPTBeljPVnTWtIiI+vut6VwQvcyFChpmfK0TFSS58tqCGx+TXMAuw+
         9XZVnNMa7r1Oh8U1bosiXC+QDkT4G1zbKiADKfWGsf2XDFAsCQHVGk9dw8cueKb4Am2C
         /hBg==
X-Forwarded-Encrypted: i=1; AJvYcCW6UGlIkHRUWgNtP/8FBmOCMImV2hOoSuQmIEWD91RrkbXeR56n/EK1PhVKULBlgQX13Yb5OBEDEYbIQ/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUus3bGN9bHiqZpe4A3NlvqNueqXF+YeJO2Mc6RAi/kq0NnEJ
	/NVtwdo7WP6Kr53x0Q37tF+qTL+RZWiSIbgbHIyYpKEhPrPrh9it
X-Google-Smtp-Source: AGHT+IFol6J4f8mKy5zxqL7tMcOKYqkpgoG/jO4MwSoZJByLiUku3W/KdxITPORce8ONPwY+lFxPfw==
X-Received: by 2002:a17:903:18f:b0:205:810a:190a with SMTP id d9443c01a7336-2076e305f90mr98819225ad.2.1726223337170;
        Fri, 13 Sep 2024 03:28:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:28:56 -0700 (PDT)
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
Subject: [PATCH V22 03/22] mmc: core: Announce successful insertion of an SD UHS-II card
Date: Fri, 13 Sep 2024 18:28:17 +0800
Message-Id: <20240913102836.6144-4-victorshihgli@gmail.com>
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

To inform the users about SD UHS-II cards, let's extend the print at card
insertion with a "UHS-II" substring. Within this change, it seems
reasonable to convert from using "ultra high speed" into "UHS-I speed", for
the UHS-I type, as it should makes it more clear.

Note that, the new print for UHS-II cards doesn't include the actual
selected speed mode. Instead, this is going to be added from subsequent
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Updates in V14:
 - Move mmc_card_uhs2() to include/linux/mmc/host.h, so that
   mmc_card_uhs2() can be available for host drivers.

Updates in V10:
 - Modify the commit message.

Updates in V7:
 - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
   mmc_card_uhs2 function.

Updates in V4:
 - Make mmc_card_uhs2() take struct mmc_host* as in-param.

---

 drivers/mmc/core/bus.c   | 4 +++-
 include/linux/mmc/host.h | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 6731b46e855f..f9a67beb68f0 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -344,7 +344,9 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_card_hs(card))
 		speed_mode = "high speed ";
 	else if (mmc_card_uhs(card))
-		speed_mode = "ultra high speed ";
+		speed_mode = "UHS-I speed ";
+	else if (mmc_card_uhs2(card->host))
+		speed_mode = "UHS-II speed ";
 	else if	(mmc_card_ddr52(card))
 		speed_mode = "high speed DDR ";
 	else if (mmc_card_hs200(card))
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 21df3d6f7473..f1cf09ea1f72 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -637,6 +637,14 @@ static inline int mmc_card_uhs(struct mmc_card *card)
 		card->host->ios.timing <= MMC_TIMING_UHS_DDR50;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
+}
+
 void mmc_retune_timer_stop(struct mmc_host *host);
 
 static inline void mmc_retune_needed(struct mmc_host *host)
-- 
2.25.1

