Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198525333F
	for <linux-mmc@vger.kernel.org>; Fri, 28 Nov 2025 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764307248; cv=none; b=P6rb3y5TshaCD/xaurEp5CFKmQSbVdZCKx1EeBjPcP2JFGYuTi4fIJUjeke2wcM8ToRdfyDHw2dbMOUKIHoTn2mX+sZhIP8J3eI67xCpNuOQ9fqK6wNy3XkFiBnrrM+2ThymLufaYCTIQNVemPaMfjMlIO1HTactTCflq2x2vo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764307248; c=relaxed/simple;
	bh=Cw6P9h/NvQ6iBfc74XMZF9eabj13dM5yS/GOIBCvNzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XxRlscdyWu+OTObZKa05d9T0C3oPS7n3DhjBXIZ9ZTlS5yOp+7f1Gn9ey9r7NZ40LjZVc0gpbgKPI6evRe4frp3FBl9h6Zh8607QcEHkAp3Mtp5lISyV+DdaT96fz71n0tnLyWzJ7+zkPuDlZce58NNrvDSt9RwAi2UxefT+74Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVsK7/Th; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVsK7/Th"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632d9326so8372755e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2025 21:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764307245; x=1764912045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCgNJJqQbanh8wK2IK/TRKuQDv8oqKssL+aaKx20Uzs=;
        b=VVsK7/Th5o/tO2dp279DKFiMsA4gLH5eiUbv9KU7NSw2TEjJ5YUx2r3a3jYwUmnF9o
         EPoDetVIhWelFoKjMkZ/nJpsDhRk9PmelnUNBvlO+8VTWAIJtfIR1Qsi0+WeN36GUXfc
         pTRnOAmpkdxR7q9b2f6xduOsw+5mYz/8B+iaL2Yea/xWhTGh+zvttyIwz21qWFO31ff+
         NbaotOC2VPtpuGJTG8z65p3NEaHZWfhLwm2tpQah612+ziUDk5/d2t3JRSOmhLSwoBQO
         ZxV6K8CJe9wiY5B/UtTSDmRayGl9Oy1RLUoUu0NAWbdJP6kMD8OLy73dsbZD7Cz2vKm+
         qWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764307245; x=1764912045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCgNJJqQbanh8wK2IK/TRKuQDv8oqKssL+aaKx20Uzs=;
        b=DdDSVVLdgPZ5I5pu0GPBiB06UZtFIkXbJjAkhtMOApABvVPLqukU4fbYlAUPxsxOpZ
         NEm540Vu/ylYK272LSbHFdVdbUrdvJJ7PwA0Ro9Oxrq/nny44gqY2K4/HWrD+4DH6lUU
         KjdGRzRZZyTVeQ+x3K5BVT9pfet/dmB14HDO6srfWv6rVkDhF1vRIME2Kz4Rlb+unH4C
         30cBlWiqv5koHTpP2epSVy7gnbFMCdm7s3cWmNkvElrJEG5kKFm1O0yrkGXzwWBxJYIK
         J/cROULJy4KZxYjCsFHecv14d+jXLDb87EveDSP8MUXRo0M6jUYWjJV9utCCGegxTKHp
         +zFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2QG4HabqIMvRm8YmHZAbLkCu2v/PX10yB0qlJMMqN7r0QuuT3Aek+M5c3P1yKPtthf3Lgk6jaSWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mXEbJZC6wcUTFVDZUlVvIUb3BVm9qOkHKZ6zTA90OR0p7Lap
	gMlQ1BjQtNBy3vlMcT+ZkJdJ+Tk5K8lsm/unIzPvS2v9C50VgRJWVOeuid80ESkw6Ps=
X-Gm-Gg: ASbGncuN2PvZJpoeqDCg38PtUl7XBkVKvL6w3fW5/nE94i1YBQNIjkHmmi7Efd8Kwo/
	aQ2lDuLktPj3vtUt5cughkibnHTwTSS5k/XzdKmmdinO6VE1zSxkgt9OssXdQAqe4L/XDtGAmxP
	d14lKVUZTZoVC3wAAlQBGoFpHmJw5WdQR/ACpgwJyHU9IK0Dwo9i5RCk0y6x68gZccL6EbKg9eK
	cmt0Cd63ZOQPY/LSrLNMXlGL5Z1u4+qL2Ex3SjioJaBf6HVu6O0N5LPdRvlsF+hhS83kaVaJasH
	Om74aNo1Vhgnr880jVAKuL4wvDU+b9XJ6Hyf4fN/ZCdum6FBHUBYk4vvXtswXmQ+jsv4kY+QcMZ
	DA8A5CbydKIrrKMAntFErrnuGVKLwAekJY4y9QlFZZohTi1IiuBBqqnq/gbmnLV2AWV/Iw5iQR/
	valjUWhS7CuCTPAbQL/eHWVjujzOwCRRcZoxGovb+az5YRVL//oInXMVVqkClnePtpTM2b2gm41
	2KJBUC5dF0=
X-Google-Smtp-Source: AGHT+IEV5QvtJtBq9vloX8fdev3KM4KZRgVL/v+kmQhu2iykvQqIgUpkovcTG5UqwBb439A45eQkzA==
X-Received: by 2002:a05:600c:474b:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-477c01ee377mr258683695e9.27.1764307245163;
        Thu, 27 Nov 2025 21:20:45 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com ([129.253.242.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791116c3c0sm65802385e9.8.2025.11.27.21.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 21:20:44 -0800 (PST)
From: Avri Altman <avri.altman@gmail.com>
X-Google-Original-From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v2 2/2] mmc: core: Add quirk for incorrect manufacturing date
Date: Fri, 28 Nov 2025 07:20:11 +0200
Message-Id: <20251128052011.204735-3-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128052011.204735-1-avri.altman@sandisk.com>
References: <20251128052011.204735-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some eMMC vendors need to report manufacturing dates beyond 2025 but are
reluctant to update the EXT_CSD revision from 8 to 9. Changing the
Updating the EXT_CSD revision may involve additional testing or
qualification steps with customers. To ease this transition and avoid a
full re-qualification process, a workaround is needed. This
patch introduces a temporary quirk that re-purposes the year codes
corresponding to 2010, 2011, and 2012 to represent the years 2026, 2027,
and 2028, respectively. This solution is only valid for this three-year
period.

After 2028, vendors must update their firmware to set EXT_CSD_REV=9 to
continue reporting the correct manufacturing date in compliance with the
JEDEC standard.

The `MMC_QUIRK_BROKEN_MDT` is introduced and enabled for all Sandisk
devices to handle this behavior.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 drivers/mmc/core/card.h   | 6 ++++++
 drivers/mmc/core/mmc.c    | 5 +++++
 drivers/mmc/core/quirks.h | 3 +++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 15 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 1200951bab08..a9619dd45270 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -89,6 +89,7 @@ struct mmc_fixup {
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
+#define CID_MANFID_SANDISK_MMC  0x45
 #define CID_MANFID_SWISSBIT     0x5D
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
@@ -305,4 +306,9 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
 }
 
+static inline int mmc_card_broken_mdt(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_MDT;
+}
+
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f744dd501842..8846550a8892 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -676,6 +676,11 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			/* Adjust production date as per JEDEC JESD84-B51B September 2025 */
 			if (card->cid.year < 2023)
 				card->cid.year += 16;
+		} else {
+			/* Handle vendors with broken MDT reporting */
+			if (mmc_card_broken_mdt(card) && card->cid.year >= 2010 &&
+			    card->cid.year <= 2012)
+				card->cid.year += 16;
 		}
 	}
 
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c057..f5e8a0f6d11b 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -170,6 +170,9 @@ static const struct mmc_fixup __maybe_unused mmc_ext_csd_fixups[] = {
 	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
 			      0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
 
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_MMC, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_MDT),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index e9e964c20e53..4722dd7e46ce 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -329,6 +329,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
+#define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.34.1

