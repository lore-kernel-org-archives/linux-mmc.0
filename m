Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A81991B6;
	Thu,  5 Sep 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531621; cv=none; b=ozdXMb55OEczSytMNC6QIkof6/BxBNskn0qSotfhqEK1V/li4aY/1CBxRd7l+2oTEiUhbMxwWP9KvmPMxpls1dSy0S5GoMb0Xtr4wcwjClAqvL/NwCajTB8qq0JsYUlK7wd5aNDN2AFwzTmk8GS7AweSjh+Cf8LkFrKWrmYNkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531621; c=relaxed/simple;
	bh=6+Nf5/9K+OHRrwoZr6U9n4pyW8vGxOX33Ds13iGam8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ROKiZeXb1pdUMQ0sxpV4Ezz75AheeusGTWPs7Ik6pkw2KAod6KzCtZ4fCsKsoS0o8NMSzu56OCz1cVDA3Lu7JelKZrQeRA/GmNzn90aEt6QD6e285xVdothEhh0M10e01N9cj5UsskSc9sFt3Aog00uGS+76E3b9m+vy8rnbFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiB61SD7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiB61SD7"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-717929b671eso223456b3a.0;
        Thu, 05 Sep 2024 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531619; x=1726136419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eNmn+upOObWpmwFmRKwEaFcUhxqumDAQxIm2bYLN7o=;
        b=jiB61SD73PC9DlLE2uWK4dV6k14RoT5B3h1G2/6s/qUSxeaPkVYY3+OUxRemMHVHp2
         7TV6pEszVMkkhHIlZ0pNgeZgIFxhR/jT37AniyqxyBz3ll3+0fbhIlF9uuh1F9dR209Y
         tvY7ynEx1XX1UGFWY8W3L+EizoBLdsOliSuAEsxqsqfX/XOsbUKq+7e1FVisU274iNmU
         PLeyfkAsTMAV/Kx9mzmdusCUi+WxMf02t9tLsm3eOt+aAOb/8U1gQ0RPgjzMs8yhRBz8
         ZunOYldEsiFKqSIOFIjSEtoqE+jMTQALixNd1mO4VQNF3+IviM6n0bMkeDa6Li4kdJgP
         lE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531619; x=1726136419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eNmn+upOObWpmwFmRKwEaFcUhxqumDAQxIm2bYLN7o=;
        b=Gg3ggS4bsWfwZcyjRsl1Wf4ycXSl4f2V7Hhklwjx3HZq8z8BtSfjLxHK77MOgQ0wqy
         gdvye/3LBu3zKyE55lqfu/JSuKHVD7WFDLGx/y+p28GtyLGC7TJbly1gJxeXi0WhgrIB
         gzs0X88hFHHMMhfSeEQAEY8I/hLnjjxCaDgR/lfbXFHTvVqK48+gtMEz+o6UtuUSOZVM
         63ET04eSW5Dsj7k9UXtpp220zGeDiCMSDsSQeJ7W6PJq2hKmLM6MNeD8vFe4WfEf+CeB
         ylgaGCkLyzb2THzGi4Ee9On2oA5pkQ9ruSIbVz/RSHzCFKlwi4wnihsMa0LyouIZpxy5
         vpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFaq0/V1dQlhjNsDE9DPyGMFV/wV7K2ugFJF0cQv0bQgy0y8NUvcVpq5MNc2XjpeOY8cGrSF27KmbOIE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxK5i0ull1r4Ko/+S6jUcGOdeLy7ahPybcSVFd8Bk6K3Kip69
	jdyXWtUR2Zhf67PBPxjNAppZdojkzmujlOCsjQ9PgI09x3b2BQDV
X-Google-Smtp-Source: AGHT+IH9oHo1UZNfNJdFRCFGs5QD5j6y6RcJzxSLfj15EjSwpX9WpzQ1zCETnO8BP4ew+OP+fr6koQ==
X-Received: by 2002:a05:6a21:6f83:b0:1ce:e952:c0dd with SMTP id adf61e73a8af0-1cee952c1a2mr11717601637.43.1725531619261;
        Thu, 05 Sep 2024 03:20:19 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:20:19 -0700 (PDT)
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
Subject: [PATCH V20 03/22] mmc: core: Announce successful insertion of an SD UHS-II card
Date: Thu,  5 Sep 2024 18:19:41 +0800
Message-Id: <20240905102000.5020-4-victorshihgli@gmail.com>
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

