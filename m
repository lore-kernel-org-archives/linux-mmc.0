Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605B394EB0
	for <linux-mmc@vger.kernel.org>; Sun,  9 Aug 2026 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786263732; cv=none; b=ARZAEWArvpkttHwkLiJFpIypQuJuQPQ+AfuNEwGwHDtwZAz7nxKJ3Ru9BA0+DowKEHiJEjfatKzI1Ls1z1nH+VcIz8Kb66th6AAhVeJYKD/LVxBLVy3oWOovyd8sHtTGlyNHd+xWz79QXVGo2Q7RSt8p8NjfV2uW8GRfjxhz8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786263732; c=relaxed/simple;
	bh=2RrI2zKsoB485KESqaLSbaG4As/TZyTDOYOxVFOC8sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0+ZwI85IGdRlefW8HqoTh4gNGBUTHmyxWyqN6Vm0/cMRKFQCMON/eU81QiewtQx9MmNqg3QszzfUWaswvyiXbB3kWPlqDQYayQAWgIF2DKoGx/OHfLHV+Nk7Wlp3sZgZDMNX432Zdpu5CdW3LQWSANFbdsIvV/bPqxwF6zvT0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6Uoo5Rk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Uoo5Rk"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1fbe461f59so99978866b.2
        for <linux-mmc@vger.kernel.org>; Sun, 09 Aug 2026 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786263729; x=1786868529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42SObGziyQpvr6XJM73ZQjg6znCmagRDoXDk31ZIIHw=;
        b=a6Uoo5Rk2hD5XnUO8fseBMG+kNsNryPqyWfZnjmuSUT7xhFPU2SwX3lC1DEfpqnBlm
         PgpQJ0HD4AiG8zmjB3/Td+uqYbQD0Y4pMixYWUHwhDgA6G5BD+Z1uRqRMtpihbPBpS2E
         CG3j+SEfG1BwyP7PO6ChAgxZ4PdQb/odeCmxwkj945zX6ZjfVEfkePPEQAfKKgp7nfMa
         yzF3PhtOqv0X7GhWwU4DYTcnHTxVn5ZmEBb2zqi7wdVd3Atdgku0WQ264RAsbhpSlJ8v
         +lTuy2DKs6em/b9hh1wBCkfI9OzrDiFIPvsmbIL+9GtnCW18WLAnXzt5YFdkuYqesLAe
         EA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786263729; x=1786868529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42SObGziyQpvr6XJM73ZQjg6znCmagRDoXDk31ZIIHw=;
        b=fnuwJ1rQ/HOtNPbVDbQ39T7jVz7vT6MFqV/z0NhWlVkSsjYiq7QKYVJV8qm1cZXaYB
         RWVbkQZfv9y+zMwUFkhZIol/eH7SAtq+GJJ+FoJBg2huiAmnz9Kkwnzghcpb09V6CgYR
         v133sYe4Xhu5Hi7zBHXLfPnqiexCRtbvPsNTP1MFDSnxZZwiLhbP3aFbvpGzePm+BZBa
         J/gDPwryS1vxu5NvwdzR+RGYuy13xTSxVG0tL0XaWX/UJ8tBd4kmYbtEohzYGiLOtLvl
         IqCF94IIrkIDss20z5RdYyGC5OrQiVc11hZkfUPtT67YIN+NkoNznc9/UTqkmdO9d+c5
         t2QQ==
X-Gm-Message-State: AOJu0YxzzsUX10GLWgN24XMXRoGARgt/+9hRhoPSBg8cFnNTQ0Dk0xqS
	jZNlBl1YDZ3tzFAOHGUwnRkbl4tU+ZTRzhkMLGAYbxxRbXGBin2kGsP5oRufgw==
X-Gm-Gg: AR+sD10rV30BMvrJJeHfTYFNS77IEJ4KG2qmpykReNoMrZdgGq1OlUdEKjOS5GQbaEF
	j1Ze+3XzjMqsF2XxMOce8f/TmpPVqHkrPdHFNTUXaoGp+u4s5oyUqlFbToN5CG83GSiifdhZaah
	hzJotEyk/f2lbGJYdiEEGVuW9yNnLzuLWVwG+TppU1bqeQkuaml2HZjMQ7rcAFSp1W3Vvll16pd
	RwDk6xb/lYFzMTz1CuxK2v43sb8X2HHSJQVL0iHIpOW4hRTd/2XtpI00S6p094ofcgRrBNLOoVh
	ZYAvfNYQebDEQdkYKQu+1X3LLGhDvFpsATwG+kwACp8GcvwzwjJOTg7ZTrQu833diwYyGcfP4NN
	iGxeQ3AriP7onJ1+iquF6TStCW9zEVFLpWYkCdGzqMRZiO1gg7TdV5VwWyS+RNm55szO1ak5BSf
	Hse7xbAUFXJD55PnmqzC16X6CyM6onV5joNc7xLq2Yiq9X6UK6/VUDlzY8d6k0XXIQxsXjH/PKu
	Kdh1t6ArOIqfoo7juvqvCYn
X-Received: by 2002:a17:907:7ba5:b0:c15:f26a:342f with SMTP id a640c23a62f3a-c2073392a89mr1039973066b.23.1786263728399;
        Sun, 09 Aug 2026 01:22:08 -0700 (PDT)
Received: from torstein-laptop.internal ([2a01:799:3a1:9700:1e75:8b0f:2e1:e0bd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2080cc3b88sm226094066b.51.2026.08.09.01.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 01:22:07 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v5 2/3] mmc-utils: lsmmc: Factor out CID month/year helpers
Date: Sun,  9 Aug 2026 10:21:52 +0200
Message-ID: <20260809082153.104311-3-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809082153.104311-1-torsteine+linux@gmail.com>
References: <20260809082153.104311-1-torsteine+linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

print_sd_cid() and print_mmc_cid() each keep their own copy of the
month-name table, and print_mmc_cid() open-codes the ext_csd_rev
based base-year adjustment inline. Extract both into shared helpers,
month_name(), sd_cid_year() and mmc_cid_year(), so there is a single
place to fix or extend the manufacturing-date decoding.

No functional change.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
---
 lsmmc.c | 66 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index d5a26b6..3139a7d 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -490,13 +490,45 @@ static void parse_mmc_cid(char *raw, struct mmc_cid *c)
 }
 
 /* MMC/SD information parsing functions */
-static void print_sd_cid(struct config *config, char *cid)
+static const char *month_name(unsigned int month)
 {
 	static const char *months[] = { "invalid0",
 		"jan", "feb", "mar", "apr", "may", "jun",
 		"jul", "aug", "sep", "oct", "nov", "dec",
 		"invalid1", "invalid2", "invalid3",
 	};
+
+	if (month >= ARRAY_SIZE(months))
+		return "invalid";
+
+	return months[month];
+}
+
+static unsigned int sd_cid_year(const struct sd_cid *c)
+{
+	return 2000 + c->mdt_year;
+}
+
+static unsigned int mmc_cid_year(const struct mmc_cid *c, unsigned int ext_csd_rev)
+{
+	unsigned int base_year = 1997;
+
+	if (ext_csd_rev) {
+		/* Adjust base year according to ext_csd_rev */
+		if (ext_csd_rev > 8) {
+			base_year = 2029;
+			if (c->mdt_year >= 13)
+				base_year = 2013;
+		} else if (ext_csd_rev > 4) {
+			base_year = 2013;
+		}
+	}
+
+	return base_year + c->mdt_year;
+}
+
+static void print_sd_cid(struct config *config, char *cid)
+{
 	struct sd_cid c;
 	char *manufacturer;
 
@@ -514,15 +546,15 @@ static void print_sd_cid(struct config *config, char *cid)
 		printf("(%u.%u)\n", c.prv_major, c.prv_minor);
 		printf("\tPSN: 0x%08x\n", c.psn);
 		printf("\tMDT: 0x%02x%01x %u %s\n", c.mdt_year, c.mdt_month,
-		       2000 + c.mdt_year, months[c.mdt_month]);
+		       sd_cid_year(&c), month_name(c.mdt_month));
 		printf("\tCRC: 0x%02x\n", c.crc);
 	} else {
 		printf("manufacturer: '%s' '%s'\n", manufacturer, c.oid);
 
 		printf("product: '%s' %u.%u\n", c.pnm, c.prv_major, c.prv_minor);
 		printf("serial: 0x%08x\n", c.psn);
-		printf("manufacturing date: %u %s\n", 2000 + c.mdt_year,
-		       months[c.mdt_month]);
+		printf("manufacturing date: %u %s\n", sd_cid_year(&c),
+		       month_name(c.mdt_month));
 	}
 
 	free(manufacturer);
@@ -530,29 +562,13 @@ static void print_sd_cid(struct config *config, char *cid)
 
 static void print_mmc_cid(struct config *config, char *cid)
 {
-	static const char *months[] = { "invalid0",
-		"jan", "feb", "mar", "apr", "may", "jun",
-		"jul", "aug", "sep", "oct", "nov", "dec",
-		"invalid1", "invalid2", "invalid3",
-	};
 	struct mmc_cid c;
 	char *manufacturer;
-	int base_year = 1997;
+	unsigned int year;
 
 	parse_mmc_cid(cid, &c);
 	manufacturer = get_manufacturer(config, c.mid);
-
-	if (config->ext_csd_rev) {
-		/* Adjust base year according to ext_csd_rev */
-		if (config->ext_csd_rev > 8) {
-			base_year = 2029;
-			if (c.mdt_year >= 13)
-				base_year = 2013;
-		} else if (config->ext_csd_rev > 4) {
-			base_year = 2013;
-		}
-	}
-
+	year = mmc_cid_year(&c, config->ext_csd_rev);
 
 	if (config->verbose) {
 		printf("======MMC/CID======\n");
@@ -581,7 +597,7 @@ static void print_mmc_cid(struct config *config, char *cid)
 		printf("(%u.%u)\n", c.prv_major, c.prv_minor);
 		printf("\tPSN: 0x%08x\n", c.psn);
 		printf("\tMDT: 0x%01x%01x %u %s\n", c.mdt_month, c.mdt_year,
-		       base_year + c.mdt_year, months[c.mdt_month]);
+		       year, month_name(c.mdt_month));
 		if (!config->ext_csd_rev)
 			printf("\tWarn: ext_csd_rev not provided, "
 			       "manufacturing date year may be wrong.\n");
@@ -592,8 +608,8 @@ static void print_mmc_cid(struct config *config, char *cid)
 
 		printf("product: '%s' %u.%u\n", c.pnm, c.prv_major, c.prv_minor);
 		printf("serial: 0x%08x\n", c.psn);
-		printf("manufacturing date: %u %s\n", base_year + c.mdt_year,
-		       months[c.mdt_month]);
+		printf("manufacturing date: %u %s\n", year,
+		       month_name(c.mdt_month));
 		if (!config->ext_csd_rev)
 			printf("Warn: ext_csd_rev not provided, "
 			       "manufacturing date year may be wrong.\n");
-- 
2.53.0

