Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF436D4E5
	for <linux-mmc@vger.kernel.org>; Sat, 22 Nov 2025 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763795110; cv=none; b=UI52o5uAYdF0+jhVbuErKs34vOVFzsLRTbmHZycAJTUDeL2o1rO17GESzbglO3p3qmmJSy9bvxZ6yqnwGovWu81elCjFIv/GsEr/ysrfPyrG+VZkHtyQukYo4JUlaC0Z+C6mmgx7RAkJG3CPkDYChPauU5O26k4i9+z+zs/BKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763795110; c=relaxed/simple;
	bh=NNdFrvc6peiqxkZRU6uMqZ6y0cpFqPVnxJQv/cjK5Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVJSla6a9dce+tx+71zgZiwVxf4YmIjLbBkJj1kL1XCZpeKCexbqmTq7ITnjA2NJJuLEOIRbxv4OzNB3Gq7/rcIwDerT0y4dlBSvoaWev1OOeUd1D269ktmjGuJEsiVljJtTAVm+TtZ+6Zx1KllH7Y9WQwJ7u4ouodtp2hOYDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Frpn6PGm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Frpn6PGm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so24161835e9.2
        for <linux-mmc@vger.kernel.org>; Fri, 21 Nov 2025 23:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763795106; x=1764399906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YYiYj7BexT+9l9+lr0Xb3WUbuGDBvx1emvTl3EXrNc=;
        b=Frpn6PGmw+kqqdBehhiL9ayjRcxenP2Te1xbc5uiY0Lg4N3ZAwhoPQiRDhMvOmWF+1
         WqvjxMNDBUYpWmy9XOVDRnLTnumIfaptXzyazSBH/DoxRfF8sv1ONd60uA7dNstczMwT
         Pemj7JpI67v785F1lRNihUGgFKGEFgyXUy4ZDEQdihs5kzc7E/I9lYE35f9VluYPBfSP
         DAvM2Rq5kcmzKHBmlT3sVONjBmQqEuo3tZiLQ3F746bGEerUMe1lzGVT0he5r78Hzur/
         KJoQQCtnBf+NbtspkejlcKOAWgaaLPblGY3RC+NqDEHPfd+oMVMK7tIOIjOlfSl8N4Bi
         KotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763795106; x=1764399906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YYiYj7BexT+9l9+lr0Xb3WUbuGDBvx1emvTl3EXrNc=;
        b=k+Id9+S6en92DDhscrVFDIGLdgsFuPuI5LvRXDvDjDZ/aEK4tzJciseG6nmd2eduiu
         gjaNDb8LU9z8oLUmqsa2atRaemnP8G1zdvwCY9XWZWP+SMvVJCDByK1HNFH8xk6nqhzB
         F04wV0hPNqveqvdEFDazKUJv9Tuf2ulJ9PC0FxeFHfeekcq6q30Ns0dKwkjyQKwoO1G8
         Vc5dN5Ulq9rabr6sp7PgqNzLnSPuY1xv/BQtkemXv1e1CwtIwcd+eyoz31NYv4CsRjPt
         wClWrYH7hrGothq2kkqgcj7Ix+Ao8WO+AomulZUHJ7mIk7NtabY9HEBN1C3R23hMYUaE
         izNA==
X-Forwarded-Encrypted: i=1; AJvYcCXaw8JB0q8jdXctJn5rZ7VluLgqAsK3+BONEPII0rdWmk9jnkaxKf3xMY630b+hYwF5dyKN606ankk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KMheZuCRi0JBC0iRIoZzaMpFV5g/+93xxYOlEhO8SPrGkFNU
	lez49sEyHuyp+UfqBI9mD1aqW0Y3oQTJEAdduKYybwSc9O+Ywrxp1dyW
X-Gm-Gg: ASbGnctA8XUenf6klbjruZ22uPbaV3TUYlBTSdqQBLoJB/ps08hegOxFzdHMFASq30b
	2DEYnIe3wRgCyXlEDUcqgzCgoUbATtWCPWSKaYyZVPmcQMgscE2K3xxgf3/vVDgTFBIUzgsbG9M
	TbjRr29dIH7izmm4iu38Fndlh/ddrIbHkgXqA7OmG4bnVTPchg8PFoECW/gS7QwsscCUYtDbN13
	wiZSU0EAtfwK6J3BRJ91AGfpw0/j30MNYr5MNZ590xcXSwr36A8nmqZ+Xeu3CjNEmCOflX2cmL3
	xOG/4ngY9Pq8/YIDdl9myUJE5nXrGkNbEutAlD7XonhlDGkeAUFEJkc6/A6GsI+HSb6CrrB+zj2
	/3g84I7g+zJR0Z6KkmwVEpmZvpBvrhs3B3IkTdX1FQ/b8hyf+ELeIvmzb+YHkBWSKhie7tH8IP+
	wV4q59jfeHJ8u1V43Vy2lS56RZDCCpTOeI7ylXUkHP5fUycGSRR9DkR2M/SY/cjEeAXgmRgJDD
X-Google-Smtp-Source: AGHT+IGz79kMUFgeE+MKikhYj2Jr77x0V1PX4VLa+VLZmSvCkqTk3m4wzQecKp8PrPkMcPbq9qO1IA==
X-Received: by 2002:a05:600c:314d:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-477c01f2cc7mr45838615e9.29.1763795105964;
        Fri, 21 Nov 2025 23:05:05 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com ([129.253.242.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d198a0sm104914505e9.1.2025.11.21.23.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:05:05 -0800 (PST)
From: Avri Altman <avri.altman@gmail.com>
X-Google-Original-From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
Date: Sat, 22 Nov 2025 09:04:42 +0200
Message-Id: <20251122070442.111690-3-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122070442.111690-1-avri.altman@sandisk.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some eMMC vendors need to report manufacturing dates beyond 2025 but are
reluctant to update the EXT_CSD revision from 8 to 9. Changing the
EXT_CSD revision is a firmware modification that would force these
vendors to re-pass an exhaustive and costly set of Approved Vendor List
(AVL) qualifications with their customers.

To avoid this re-qualification process, a workaround is needed. This
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
 drivers/mmc/core/card.h   | 5 +++++
 drivers/mmc/core/mmc.c    | 7 ++++++-
 drivers/mmc/core/quirks.h | 3 +++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 1200951bab08..0d1904d87a39 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -305,4 +305,9 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
 }
 
+static inline int mmc_card_broken_mdt(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_MDT;
+}
+
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4c36029b28a3..564a5fb4dd96 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -676,7 +676,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		        /* Adjust production date as per JEDEC JC64.1 */
 		        if (card->cid.year < 2023)
 			        card->cid.year += 16;
-	        }
+	        } else {
+                        /* Handle vendors with broken MDT reporting */
+                        if (mmc_card_broken_mdt(card) && card->cid.year >= 2010
+                            && card->cid.year <= 2012)
+                                card->cid.year += 16;
+                }
 	}
 
 out:
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c057..7bfd07ad3d7d 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -153,6 +153,9 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+        MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
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

