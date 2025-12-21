Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8931C69D
	for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2025 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304047; cv=none; b=ofF4GcH2DrHEmFHg9mGOi6mdDMReQG7HozWcQv+mvGlFIl4JMrl0VJyWhYf3IbNqDrmuq5CYdzS5xSyN5QvG/8Dm6Jm5Ipox/9vOb0QGN60qYFJl7LzHA8jQSteEpaVqooo+cxgDmZywZj7UdKSPoy6TTc6SXJl9wW84pbQLO9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304047; c=relaxed/simple;
	bh=y2pAxzKR9TUrrvwEKkVj2yU/cF89B3Z5apc2cJ30qfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frkAgqf9YMHJdsLIG1ZKSOpvoQeUrs98hCPmrOguMnwGR9DqiU4kKYEgdffB7LGm0JFf6Sj0C1rMiuj+6JssRqd5XLXZgURXKiMm7aEFq3YvUBPS49evZqArXqjkOh8E0yhhZ3aJ7AG3qiT79Gdu4IUQINFOPJDoT2thZrkvABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmB1Gpqy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmB1Gpqy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so23451715e9.2
        for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2025 00:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766304044; x=1766908844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvH0sKczdoEEmB3rSknanQrZ3PQnI7/zvmgVIM1EiAk=;
        b=MmB1Gpqyy+p9H271VCSH8kFiJDQzIP8go9y0Z6sGYXgX0BakLFVHyINAWZnu5otgIW
         qXxN1rtDrs2L4TnPqMDxcmIaCvzP3rF3NUrngqZk67EXxWJqtki5x9RFgPXdMIqBcBfV
         Gn9VDcrq1bqjNQPGwpry8aD7bvjbJnCUId3LGBo2ybC7zIgF0TdJBoeOE0d7ZZjDOolc
         Npn3Tsq7qXLYNQmA4FUzcI4e8Q65bBtkPVsMj6Ml1XpdZ6YAElnVY+n2OHsjq3Lx4VKK
         WSAhBuwd6b0YR4Pas1HlhGSLTEoBsmNcxJIOC83eZbEtpTtVKY4TPfsqisicWlHPcOcj
         kfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766304044; x=1766908844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GvH0sKczdoEEmB3rSknanQrZ3PQnI7/zvmgVIM1EiAk=;
        b=FwzFwuVs3nFfVhgxBWUGuCozJKvh4++jNWL5ZcAz1LAOE0rbNZTSa7dwMS234UmnW0
         x0Z46kDyW3d0xdkgZpQ3FMpteZRo8iQ9O4bLYCKx9faKS0ZmMiSsCFkogFSslevBrKQ2
         P5zOlx1tZkv1ISkXL+9fYhABogyl5qdvvjSPw01Sz7albnlhcUbrzRu6XYVIiZgM3uUi
         tckwUo6iedxzGzGIDOY3m2Tj9k/CeVDkwNnRjMbRCDf6bvafvm8VsYkKtEMw9ytn2XEz
         pkSWX0LxDlkb/kp7YB8vlUa3ZkYHNLVr8R2oUQVsrgaoLcXAcp1db/fvLgDcLpPweBnP
         kB9A==
X-Forwarded-Encrypted: i=1; AJvYcCUjcBNCV9l2M6TJ4bPQioFOsn4z0d2vf8H/VXnaHDM6rW5B/03ozg5SDsLnzpek4LW7xZLToHqugQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0whQZabXcNVgjjtIRcXfHLYb1cD8l5F4VaZaJ3zsp0Fk7rp/
	gLEr8P+yaJ9iiVFZsgoQmyMKGR1l8CbH9IXJsu/ctoDL+gbcWkUVIJlw
X-Gm-Gg: AY/fxX7J4J2Jissq8ebS6vDTaleh8edTmP27oKzbM4w84DKkZ/WCsFuvkciuidtm5hM
	XyaJp8/I928BhSsGOEOFXwlM3WOOc3wZAYedXx1pkLH5sDOoFjxodt0WEfvrPW5Depyf1zCCGo0
	6rZTDTn60LmU7DlqAYKR5uAPJjRUwXB/j+hYraw6xvk3DgppQG+4zovkYSFWD6Gs6UOmuqjXH52
	N+zyIKqxMgYPGmTSZ6rhfl78CO+hKiN5TVM8T+FlHXJ7PNhku/E1YAGe5JOXVCyH7o/UlEzwtvE
	7PWms68MOxPmr6KiYFonOWJXxzgl5xvzSjo39URl0e3abjKLb8xb1iL1qldHllqYH5zz9ZaYBsB
	U2y+hm0GtY04tRtj2KMdhxmz2a9X2f6YUoPAaSo9d5SgrHRc623wbyoqHPYfzG7e+TXyg79zlJN
	3CgILwRTEgLgFXkpMRQD2wu05L5d+LESW1ddSVz+OLudxZjk33OjTk6nbjCVG05FbF+2tvgA1YO
	RamPaQn9GVXpRoE8ehpBLck6QVLe2B1x3w=
X-Google-Smtp-Source: AGHT+IHJ3kc2Q9onnmhT0GGz6ScNFsTspSopXXNZaY5Xhcr4U2dsrah6iav9N/wMfVG0Sxf4XhaCQg==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr80767245e9.16.1766304043937;
        Sun, 21 Dec 2025 00:00:43 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com (212-235-122-32.bb.netvision.net.il. [212.235.122.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193621c8sm127174335e9.7.2025.12.21.00.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 00:00:41 -0800 (PST)
From: avri.altman@gmail.com
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 1/2] mmc-utils: lsmmc: fix CID manufacturing date decoding
Date: Sun, 21 Dec 2025 10:00:19 +0200
Message-Id: <20251221080020.4532-2-avri.altman@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251221080020.4532-1-avri.altman@gmail.com>
References: <20251221080020.4532-1-avri.altman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avri Altman <avri.altman@sandisk.com>

The CID register contains a 1-byte Manufacturing Date (MDT) field, where
4 bits represent the month and 4 bits represent the year offset.
Originally, the base year was 1997.

However, as the 4-bit year field wraps around every 16 years, newer
MMC specifications defined new base years based on the Extended CSD
Revision (EXT_CSD_REV):
- Rev <= 4: Base 1997
- Rev > 4:  Base 2013
- Rev > 8:  Base 2029 (with specific overlap handling for 2026-2028)

Previously, lsmmc hardcoded the base year to 1997, causing newer cards
to report incorrect manufacturing years (e.g., reporting 2000 instead
of 2016).

This patch adds logic to calculate the correct base year using the
cached ext_csd_rev. It also adds a warning if the EXT_CSD revision is
unavailable, as the date cannot be guaranteed accurate without it.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 lsmmc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index dd3ab83..b7b9378 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -67,6 +67,7 @@ struct config {
 
 	enum bus_type bus;
 	char *reg;
+	unsigned int ext_csd_rev;
 };
 
 enum REG_TYPE {
@@ -586,6 +587,7 @@ static void print_mmc_cid(struct config *config, char *cid)
 	unsigned int mdt_year;
 	unsigned int crc;
 	char *manufacturer = NULL;
+	int base_year = 1997;
 
 	parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
 		&mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
@@ -595,6 +597,18 @@ static void print_mmc_cid(struct config *config, char *cid)
 
 	manufacturer = get_manufacturer(config, mid);
 
+	if (config->ext_csd_rev) {
+		/* Adjust base year according to ext_csd_rev */
+		if (config->ext_csd_rev > 8) {
+			base_year = 2029;
+			if (mdt_year >= 13)
+				base_year = 2013;
+		} else if (config->ext_csd_rev > 4) {
+			base_year = 2013;
+		}
+	}
+
+
 	if (config->verbose) {
 		printf("======MMC/CID======\n");
 
@@ -626,7 +640,10 @@ static void print_mmc_cid(struct config *config, char *cid)
 		printf("(%u.%u)\n", prv_major, prv_minor);
 		printf("\tPSN: 0x%08x\n", psn);
 		printf("\tMDT: 0x%01x%01x %u %s\n", mdt_month, mdt_year,
-		       1997 + mdt_year, months[mdt_month]);
+		       base_year + mdt_year, months[mdt_month]);
+		if (!config->ext_csd_rev)
+			printf("\tWarn: ext_csd_rev not provided, "
+			       "manufacturing date year may be wrong.\n");
 		printf("\tCRC: 0x%02x\n", crc);
 	} else {
 		if (manufacturer)
@@ -637,8 +654,11 @@ static void print_mmc_cid(struct config *config, char *cid)
 
 		printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
 		printf("serial: 0x%08x\n", psn);
-		printf("manufacturing date: %u %s\n", 1997 + mdt_year,
+		printf("manufacturing date: %u %s\n", base_year + mdt_year,
 		       months[mdt_month]);
+		if (!config->ext_csd_rev)
+			printf("Warn: ext_csd_rev not provided, "
+			       "manufacturing date year may be wrong.\n");
 	}
 }
 
-- 
2.34.1

