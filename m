Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39DA1DD397;
	Fri,  2 Aug 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594176; cv=none; b=qD+1e73Ak3ty6V0SdIkCoZHPBIoLE7A/NZszU/03Bo5JAJCbypdPdVTJjL+ITR2KJZ9fbbrNLQ2cfn26Y9onVqFsRZnWv/5AObzBAC4bXu7RNs4hSDduMpv3t5bsPi/oOLICY1IT9+/EyZiQnYIZ8vnlCJFRlCIzIQXDFxXqAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594176; c=relaxed/simple;
	bh=/r3ihupXukcVISswAY9xfhq7UtI47LcaapaG3/yujwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POAmUeJSuk4gVGYQCc/FfuMX656aQeiusq34h/3LV5Z3zWS1HtClJ2GuuuciV2asWOB5AncauJaiWgd9ZQuoih4sw8FYBqy6H0T9t6rmkJt0xRtP/CWa4iR1Pr2JwPcNMYXYm9VlUN7o/D3tYxU7Ep0wOWyqzn2+jVXsiV4SFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfFKhLXC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfFKhLXC"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-709485aca4bso3542741a34.1;
        Fri, 02 Aug 2024 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594174; x=1723198974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSv/ViTvfqX7lB/6JXrxBSUt+tEYItM1Aj5/L2UcPAA=;
        b=DfFKhLXCt70OwUVrk5PeuHWNuDotCA5tytoe1UR8zTO/YJy7LLev0dnqhcn81ujh70
         d3IVhO3PCf3bw2tr6+0FEQJhXNGp7nlOMp3bPxLpt4wvbIoWSA1iIYmXmd+Lriq/q0tM
         mUDrgQRK1MSUy4L6oiuffRPGBjK2ryhr7E12rncD1iE/C5qhD8PHEw0wD7L3Dnkj3o4o
         pR+PT3YntDLsZsWSOtU6p/Vul7VDGOVZtFsuBir4y+B8zyCLE0ZG1anXYAS+nyYjoEFk
         NEmM+o//IBf+UiWkOQCl0LwbaLlv4BJcUqILSYw9ys7aHqEn0jHdveBEhJmIKK0BP1nE
         43zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594174; x=1723198974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSv/ViTvfqX7lB/6JXrxBSUt+tEYItM1Aj5/L2UcPAA=;
        b=D6uh2A+XTV25E9yejYHX8FgUNlybx45T2RB9dOGqqvkNZLCMDjUSe0UNprNVFMAAkK
         QjO7bCvvqyNRrJrJcU3N8JDvGN+m1vHLwGj+UZKEygWNPqpuBBoOkx/fxhqO0PtFLSyI
         Xk6JP6tKJkXm5ZT1qo1ne1ykhATu3U8QK/AQoJLeLYae/3DZE+FUrAdztW7M6VtiNl12
         D986roB9iiyMOHwdWKLismtFOLyUhugeEnnuYCEwucvNZNmMaruKhUqrd3csKYp6W+LB
         U/fRoP3eZFUdDrDI46kcX24pvwLpWCEt5nI7rFo6qtKPuJMa3fWwx6yupsIQdD/Q3M8J
         UeyA==
X-Forwarded-Encrypted: i=1; AJvYcCVL73cz0GExeg3mx0AXVJDECKPJRrAjuMftqoiMuOF3S/uglnoW2SdWsveIgIeUnXzIVbEo2so3ZfFjbx1FD6EOTIuqD7MYUqXg8ZgD
X-Gm-Message-State: AOJu0YzwjgE4g634UR1RlJDj5uqw4qqAx7+Zp6LzRLna/BgQMm91KwYh
	ESogYlMmc+Ypr3jE3sKLWEu75a8flcoP67Z7krYes3ASxoMp8Gns
X-Google-Smtp-Source: AGHT+IE+caw49/C7JJJEJ6Bb6Qe1O+uU0LJrJollYMiMAQp3LxS+JrkbJgF0KscOim3NS5ZxphVCgQ==
X-Received: by 2002:a05:6830:6183:b0:709:4793:8757 with SMTP id 46e09a7af769-709ac262499mr4669417a34.2.1722594173911;
        Fri, 02 Aug 2024 03:22:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:22:53 -0700 (PDT)
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
Subject: [PATCH V18 03/22] mmc: core: Announce successful insertion of an SD UHS-II card
Date: Fri,  2 Aug 2024 18:22:10 +0800
Message-Id: <20240802102229.10204-4-victorshihgli@gmail.com>
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
index 1779910b3c46..a744440bc276 100644
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

