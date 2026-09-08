Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284A4E8E19
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860345; cv=none; b=gDQ+nBovcc8pv8M0dnjTl9qHG0si8By75Yf3M4098SYnuZV90+WTZvgLkZsReiVxHxU1vvThf8BknDdmj0pjQ83ggD7xYQ1Co31syIGGvSTz6WCvrC1JqVSRwWhPntfeNn9M5y0O4TlgFqRw2rmSpacpFulIFUGsLNiME3wuruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860345; c=relaxed/simple;
	bh=znCoxd6YU0vaytcLOKCB6Mo6LM/P8R4MM75M2jk8Ivs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0awFOyl+pRSYeva7IZ+eDPg1og2z/hDrE8m6cBTpyfbY3u8DJ7Rg3DKiFnKpqOAVsSicO5hUZYYwm3uZVhIxY2OuTSU3N8lqVOzbGYVSXDKME/ThbR33mB7pJuN1dAmOA7/kqnwdurjCoRjOdFUKDW+3o7N824VPieQbiDwwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIn2LAOX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIn2LAOX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d9520b9155so36380445ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788860344; x=1789465144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=veiyGrZ979vQEs7rWnsg+eWwwTfAHUYngaFq2JYfcfY=;
        b=BIn2LAOXolZATB7eddG2gr2Wd1a5J60cdJtuSGFOWF6fItW7VoILhHMQQi8/rKbw4F
         5pLVHp6L+p1eTX1QLlPKR9Q776mkqThDUOWqHd2IBkfMcTMl8hz6pjZl+3+StPOiJijD
         /7HdkfxnEqKkmjlk9zXSR/3Z3aTkDjEXhQOVUqpQ/QhajGwjepV3q+QFWmCmaq/JWKmg
         uHm6VVZSVjSGGYWS3xSWePNOHMRx7DPZJq/C6Bpj7PKhZZmy848jyn3eX/0ldVx/RPaa
         TOH5VipxPSLUDmEJw09OY6bvzpCJjYc/SJ/1z5jWIGLnj96RUMc8OEUecYqkxejTVWnA
         WklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788860344; x=1789465144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=veiyGrZ979vQEs7rWnsg+eWwwTfAHUYngaFq2JYfcfY=;
        b=fDqNjgDw06GMplKyZHWj5hViLFT/lJWDweaOV3KAHRt/71UEWmRIIk6xDvru/G7J1c
         3oZoXSfcMgQUs+O/32JrFpnjuIJwyujIT53fSRJEds+9qgtYeWPfkgsUMdy8u3vKugnj
         ii0JfrMWLyvtIBtorK8XHsr8hEdXo+QpPmpta+EYifaOcAZFhsSOJcil6Iubot5oNOG3
         3p+a8a0ooi43Tr2nzZcdBvCLzlAKJ9WfP9/nOeD1iB2ZOKaI/5bqquK2oBYeSnNjYo14
         sknrKwExkgDqO+plF6DBZPytl1ogmIzqe2T7Kl24lWX3STfbE2UNZoDrLOz5j4+LTZz5
         6x5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwONimb13V3Sh5TOZ8Mm83qe0tbdP+OQ9QvGmySmtsoqhEenEQ+5eMHW497reJRUTRsfPBNOTnvp3s=@vger.kernel.org
X-Gm-Message-State: AFuF++mjP2omQaPvqodToi1ZLJSY91V8QCKQrBe7YwH6Gl6yaIoBtGwx
	OTyV//NYBq1a46zwwgZWu02jQBmLX4ahgDb80bxj+1XMxrq2yxzFz34z16vv+LVZqBA=
X-Gm-Gg: AYBFou3BvO1pR0gOQjWcVc0WKCNpWUlGhXNg4BMPD1qkhV8AR2OJ+1z1mIUcW1eyI1E
	Z+JVv3xdTCJJ6zUG/wDMwQW7lNFRKYIROQT8D8ALwxROL77zOccAB/iRSsQrs+//0ZvUfAVh1zf
	PVyk+2MgAlb3muD2b+mF0qmM1dsFzRtHRb0QVBVFXRt2q2o228+bted5uf7KMmXwPWhDDN+kDx9
	v45pEaHXrJQAqsjqnPdAwqfqgdbZkN4hPjWmsCgTAYEl5dYVdjQ14I1GrySs+2+2QNzsKq6mqQd
	9FHIMEGijyYvkFgs0+Cr/j3E1x12wB8qC5qQdGFdNE8ycmj9CIKnYBm6Xiwn2kQquXmg5sIMhj2
	TRz3ywyO1OTkGTKiVOkHzyvfBtdaMJI28byL+5+avr/k3Bu8kyR5magva7BtY2Nsb60KlX/H1PX
	mR7iUbf6baRI7OqNoL2IDmZxc4bRgbwdtLkHeaemh1bXS7n0wPvHOB2eyk262QyfUcHAu1J0tj7
	TghM2gYj6nUulpwBlGtKezCc9bSg+PzuyD9GPS2reWWCe6J1s1Mm0w082c6k1jXB+0OP5FzfXpa
	Qw==
X-Received: by 2002:a17:903:3910:b0:2d9:383a:30f1 with SMTP id d9443c01a7336-2db6c699f35mr115521875ad.4.1788860343901;
        Tue, 08 Sep 2026 02:39:03 -0700 (PDT)
Received: from nxpwireless-Inspiron-14-Plus-7440.tw-tpe02.nxp.com (114-25-99-144.dynamic-ip.hinet.net. [114.25.99.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497d9f9sm54848085ad.32.2026.09.08.02.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:39:03 -0700 (PDT)
From: Jeff Chen <chunfan.chen@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	francesco@dolcini.it,
	linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH wireless-next 2/4] mmc: core: add NXP IW610 base ID and block size quirk
Date: Tue,  8 Sep 2026 17:37:56 +0800
Message-Id: <20260908093758.596444-3-chunfan.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908093758.596444-1-chunfan.chen@gmail.com>
References: <20260908093758.596444-1-chunfan.chen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Chen <jeff.chen_1@nxp.com>

The NXP IW610 SDIO chipset identifies itself with a base card ID
(0x0214) during the initial MMC bus scan, whereas the WLAN function
reports a different ID (0x0215).

Like the IW61x, the IW610 requires MMC_QUIRK_BLKSZ_FOR_BYTE_MODE for
correct byte-mode block size handling. Since SDIO fixups are applied
before function devices are enumerated, the quirk must be associated
with the base card ID rather than the WLAN function ID.

Add the SDIO_DEVICE_ID_NXP_IW610_BASE definition and apply the required
fixup in the SDIO quirk table.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/mmc/core/quirks.h    | 3 +++
 include/linux/mmc/sdio_ids.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index ae3ece89d0aa..98cb680e3ace 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -211,6 +211,9 @@ static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_NXP, SDIO_DEVICE_ID_NXP_IW61X_BASE,
 		   add_quirk, MMC_QUIRK_BLKSZ_FOR_BYTE_MODE),
 
+	SDIO_FIXUP(SDIO_VENDOR_ID_NXP, SDIO_DEVICE_ID_NXP_IW610_BASE,
+		   add_quirk, MMC_QUIRK_BLKSZ_FOR_BYTE_MODE),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 5eff5e348eb0..dfffda3d8002 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -123,6 +123,7 @@
 #define SDIO_VENDOR_ID_NXP			0x0471
 #define SDIO_DEVICE_ID_NXP_IW61X_BASE		0x0204
 #define SDIO_DEVICE_ID_NXP_IW61X		0x0205
+#define SDIO_DEVICE_ID_NXP_IW610_BASE		0x0214
 #define SDIO_DEVICE_ID_NXP_IW610		0x0215
 
 #define SDIO_VENDOR_ID_REALTEK			0x024c
-- 
2.34.1

