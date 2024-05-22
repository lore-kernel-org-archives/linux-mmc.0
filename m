Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0980C07;
	Wed, 22 May 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376171; cv=none; b=e5YFetgGXafTK9mW+Qg598LWoMz2qQdrCyPPtJbKS5xjRPbYyG6oZMFeIUVy23HzuHLPCFsmVRYY1hzjtj+/vuG46oyKvzZPzmcKsvGXXPonYbXjs+3+PTX1bqqAoigPzBPiDv2852CM6yvw2crfWrpnMT9JpGhGXfk/+lsIkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376171; c=relaxed/simple;
	bh=OGtEAdD7dw2omBkJ9nOfQmxnHB5yrP/FtvV8LB645q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H0Pt9mAY+/gmbD5ECPNW2GlUnWbm1HTXXHrxhk8oCg7YTSI3N3aP9XvXs9mB/iSSX5DgdkweEYZwj7UEWg6m9rLWSEoQZrxvuvYlzhkNEif8DUNXf6NQ4yx4SSa3iGjYlKD/uLkFILOhszTdIpWtRUgWKpSBPIsaKWlYxQykogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US5exU4M; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US5exU4M"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36dc410c051so22984695ab.2;
        Wed, 22 May 2024 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376169; x=1716980969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDs+d4/tnVJir9Vj/JzDA8awGIauH4+78L9fkQUktx4=;
        b=US5exU4MeeS7+/RhTDxOfFuQfl4/s74DQl3g47MpWvSwr7F4sv3UknKXumj8xVLjIc
         8hsSbnretNaGdvUtz2rkNk0AZfiCU9w23f5fzmc4VZXyeGnZALKd/q2QKlE3grWEIn6w
         FGerS5qEW1+BE34oYuQA2cpYG8PwDmRnPfPjnnNcQyFGCTceSzp515wCypIOma2SQlFT
         4bh1jf9qkC4cW8j1ru97WoBGDZhdVXR+EeA0YcIMCfH5P221GQcFiaoX7oeyqHjCs0RX
         4wXBrbDoRxmtHF/c7lbHwSqIYQcIvnbWFgMqWNDUqYXdJvy8wwxP9ALYkCPvkt822Tox
         Hxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376169; x=1716980969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDs+d4/tnVJir9Vj/JzDA8awGIauH4+78L9fkQUktx4=;
        b=MbUtbzI6x0Ktmcb2T8fe8SYf2uVc/9yjzmTCczR74s7YigBV0fiOEFReJqyiUhoJgF
         hqwsXH1Ompz+wIckin4+VeipxQxAgD3YG/GwDAUhIkuel2L19xU4EbCag5XGp2K133iO
         qzf8m2yhCO8BglLCQRSoL3aAYTph8oPWNbaBdZsQtQKr+keVWKwRH8/qeRE/Tb3wFX+B
         HjUUX/C+1qgkqWLfrqMcXNW6F+hmhluwf7qlR3mNpikLbVxLPHBT7w5UhlxjAx25FOyc
         48ZWnRx/PqM+1s6ISxC7N7PzDMkv9anxHUv94BCG8lU5cOk9UYBxt7boC0ScT8A4IgPk
         A9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVn7Jo5Bvn5/EORu5odV8wCDQFV90lkLbaMoCEImSB9bjmdehIvEimZkGbmm8bntuBnNDx85dTHj49uc/Anegc7baIJkesHPuAczAxC
X-Gm-Message-State: AOJu0YyJCkHqsqnPsqWGgLKy5YwVKzKF1CFtLUYYO2ZYN+qk2B4rBV04
	8E+wwIz8JvwgndsccnUFzW/hSqhtzlmeI0Ggpc4TbMSFk1QCLIkr
X-Google-Smtp-Source: AGHT+IGXYipOJk0ALk8jTwe1J4pVSidyM0uHCpPO3wV65NPdAO1v7haYoKDd1sKZrnizwPdI79LJ5g==
X-Received: by 2002:a05:6e02:1909:b0:36c:8c58:c554 with SMTP id e9e14a558f8ab-371f8654062mr17314775ab.7.1716376169000;
        Wed, 22 May 2024 04:09:29 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:09:28 -0700 (PDT)
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
Subject: [PATCH V16 03/23] mmc: core: Announce successful insertion of an SD UHS-II card
Date: Wed, 22 May 2024 19:08:49 +0800
Message-Id: <20240522110909.10060-4-victorshihgli@gmail.com>
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
index 85ab5753c22a..3e823ef5f672 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -661,6 +661,14 @@ static inline int mmc_card_uhs(struct mmc_card *card)
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

