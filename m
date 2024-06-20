Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B180617;
	Thu, 20 Jun 2024 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880306; cv=none; b=SIoyqXtB3/IGk2NJMg5Sj791zbAJ3cP3RFh2jaDaVkAdrWCqxHB+Ftz7vLrjWMmf3TBJtrWrlZP87pn3gyhi/WOAgupS1OPBuV2VPdoaDs60fE8nXESo+LtrWLmE/Berw5faoPw6ibMQmVO3OY7FmehDYhQS47b/ZbDdthVaQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880306; c=relaxed/simple;
	bh=/r3ihupXukcVISswAY9xfhq7UtI47LcaapaG3/yujwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9nKDdWzYDovz+jTVOHPflCB3+R2ScpOe0kVtFaz9i+WXXNSMheAMOKrrSEv/DwDemp4BRVXaA3xBe1w/BtsbEONDccpx6bUYv1yxe6XbmoAS0HnTGLsjkq26smsv/qujviejtlaK43+a1em8RpqUTlM7Xee4sBLh98V8pNm/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIRh32+6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIRh32+6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9b364faddso6165975ad.3;
        Thu, 20 Jun 2024 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880304; x=1719485104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSv/ViTvfqX7lB/6JXrxBSUt+tEYItM1Aj5/L2UcPAA=;
        b=EIRh32+6Tk0dqc1HKEWDEGtmDdtyC0ZWoNqYX0HAIDq3/HRcOhGjdNR5rpJUuzrxL3
         Zg/ha4hYr8n6MNu/mQd71nAUyf208jdPuubO3sh9klTEBv92hNsfAed3B3KVXhTOPj3L
         vTBQD5Ci0xrj33v9tPfFgFsk6MN2C+G5mwrLAkS0tAC5HqY6FBMUz6pMqUBrGZnkdXe3
         RLu69mOTrFjsEXeC8pyhBezIImeRNCP+uJyKcxJ/E7KeLHm0abr+FnY2DEpRIUEMilVa
         6tQMntoop75Iots0GjKh0k3G57X5wfQb3PwgwhkGZPRXD5USqCgLm/B1yBhzW/6n/lR/
         W1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880304; x=1719485104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSv/ViTvfqX7lB/6JXrxBSUt+tEYItM1Aj5/L2UcPAA=;
        b=BYxK5F8LXZC5pMi8V9htu3KpzTNakbddKADK8mGK7QNtCdCfoVb0QcRVL6HVPop6N/
         VuPeBzgnJj4quDV+HNoVMNjncF8upMSHVZjLmB8Ii6ge5pWhXWbzcwG51tMHSJwJM5nU
         v72Lt2KOanChHCs5TIUzRJOqUaujw7g/wkQBA5qiIzU/e5xz7IDxYdCIvWnqhUSX02rI
         SFTYy7hKQPH71sWT5jR0zBDPOsffeJOdiES+8Z4eJ2G5j6eyPt8iE3X86BfuYmuzYM5+
         6KHPSRWkHtNsfIY0rzBG39PEf3yNmy+UtsKoegpVWSCTP5HKSNWcut+Zuko57rGVRZkD
         tQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVKoWpSASJyxMDlGhwYqxu3aZV3gYCrBrU4Rsnk3+STyBj3GxC6kSCv+zmdleM0UiNiH/+iXeGE1Oz3hwGwmYGaTFqxKdL8axNn0WUp
X-Gm-Message-State: AOJu0YyAEiDKpkbSFRK8sYvYvgs/2in3aywJLCniM6MG65GQ6Bigb7aA
	RybFEd6O0Ee1CcQ8dkfnMJpNktfE5SS9kTtXIbhM5ILTfDGldH9L
X-Google-Smtp-Source: AGHT+IHnzjsmE8MwAs7tWc16/trGOmnVEWY1i5vc1HMa92bbCV7HwzYJmQfSxAHoxpdEmYO5iEBEhg==
X-Received: by 2002:a17:902:c404:b0:1f8:904a:d6f3 with SMTP id d9443c01a7336-1f9aa41202fmr57282755ad.40.1718880304456;
        Thu, 20 Jun 2024 03:45:04 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:45:04 -0700 (PDT)
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
Subject: [PATCH V17 03/22] mmc: core: Announce successful insertion of an SD UHS-II card
Date: Thu, 20 Jun 2024 18:44:25 +0800
Message-Id: <20240620104444.5862-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
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

