Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AE1CB126;
	Fri,  6 Sep 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618072; cv=none; b=fzZNOuQIudwoaPjpN/NfDXbixtFCM2a7oPpzQEJ1+4Ct3zaACMYrdK2wUi8SMxPj9qmkNvBbbh8ZMZbFpmIFuvWVyjDXUWsDzCopCYOnAIc5a1DnPQKbfErcrU7J/kAHPw7J2fFvlA4K+82L/8AgZCrpli4IBSoQWksWKXu2i28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618072; c=relaxed/simple;
	bh=6+Nf5/9K+OHRrwoZr6U9n4pyW8vGxOX33Ds13iGam8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWM0WOdbCl95yC7ObtmxhGzduSVZyyrM2rgpsoxgWMTIjd0V6uY2E3F2t8yxrTjcje80tEAtO/mv+rmVARaMfYFmPtb+MvzYYqmAs/8uhGjempMeRvCJaiUkHv0G+jrW59cWfKjaYjWQ0H/t/RruEwwyVkItZybc9O/kweDzBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGqkctW2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGqkctW2"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718da0821cbso299484b3a.0;
        Fri, 06 Sep 2024 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618069; x=1726222869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eNmn+upOObWpmwFmRKwEaFcUhxqumDAQxIm2bYLN7o=;
        b=NGqkctW2p9pJ4adTEH0/v9YpqTReU2keqQvKEkN7SYF34AjtCg/qiXf+ourUgZ2tx7
         rfDVI4RBkQGQ1+46EMD04JKiySCt3/U0pSj4Kg8V8Fcqt2EHcTYO/vq7TlOHX4+k8fvS
         nfqp9kKgvq9XRyG6DVpLK/uYjDBq8QMKNApCHfkTBZTMvAH/KalGgviV7GrOJcwEEza2
         z5rGbLRXOsWMSO3ugV4jjP2Uuta3sp5Lo9se9EYQ4VWz4Ew1uzNMKWY0BedP8eaisfVP
         4WDMi3Re37RXM1zTeIhDHaspXZGI1GYUF4rVv2iNZLsHipKVLNBI6t4sJqXNlIHwpQAo
         /IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618069; x=1726222869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eNmn+upOObWpmwFmRKwEaFcUhxqumDAQxIm2bYLN7o=;
        b=brIrwY3gBH3/xe4ZNq/I3FNeOfuGHU2bPCVknA/5HfrCuADnvgd9uosJxIrQi4hBfe
         Bl8F2zWxxYDOMK2js7MUYgIFNOd+RkJEdWLXudRanwkLzhoSxWoYA8RI9rc3+HFrSt/C
         sqpUOk3Vw9Jb6GB84emfQQGjlY6schxLjWGqVeU85ceJXVYvgwE9DBG4zps9tAfnUbw8
         mmlHDiqju1C7Qf9aqLmfzD0KeQaqzJ7ke1xFnbmGxMVM23tEtYP69Xr4LowiPjdeGf0Z
         rNwTDveIiLhyjc/nDsPe+XtH71AmvZ1EX6ev2AEElRlUiK3vZXhN/cgkm9zHMT/4oZBT
         l7yA==
X-Forwarded-Encrypted: i=1; AJvYcCWhg5c1tcxI1T0tpB34gkC0Ioka65/4ZySs1g4EP1EiHj8Ncx4FYJDZTWDhWRt/bVV07rmiKWrhnMMZ6HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5rYSzl0npPQ97WXTJPMYCYf7gLtC+/MdXVoRKv8f+FPECGsE
	TnG0oiPe7T9n7JiPSY/RaPJZ9LfGYU994a7/PPv8U0kQiAkKTBK0
X-Google-Smtp-Source: AGHT+IF/cuDnjYFW4NDhzfOH9iW0gD6JRDAr0FvIdmS9hNEpd8NIIVrc2ACY9292CqqqHGyjD9D+4w==
X-Received: by 2002:a05:6a21:e85:b0:1c6:fb07:381e with SMTP id adf61e73a8af0-1cce10ed59fmr28539263637.44.1725618069278;
        Fri, 06 Sep 2024 03:21:09 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:5f74:48c1:9f66:fb02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717931fca8csm2072611b3a.139.2024.09.06.03.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:21:09 -0700 (PDT)
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
Subject: [PATCH V21 03/22] mmc: core: Announce successful insertion of an SD UHS-II card
Date: Fri,  6 Sep 2024 18:20:30 +0800
Message-Id: <20240906102049.7059-4-victorshihgli@gmail.com>
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

