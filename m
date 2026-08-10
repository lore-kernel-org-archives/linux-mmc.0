Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48812407CC6
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376103; cv=none; b=fg2z+cf1mUaqhQKo+88vUD///2AyTK3iCZJYg72FJGABEk167xQiqf6dCBHvBFe5oG91c0tve4Y1u+y+xtWSIk9IM0Ho1Iba1DiMAy+6RMo3nnjMAdpbv6eQ45cKWF/qs3QhlOJp0yMnrBcpbQkF4tkMcXgiT+4B43v9w2gTPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376103; c=relaxed/simple;
	bh=VVXtmPD6AVwG8J4mhj8wmx2imexh+HZn/prsVZcTKEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfMtbZEjA+gjMIFK30Md3WMzwbGpoLEUZIWm8R0sPWPYsYK0SxrpxRu7w5Ijgt1TPv/7rlQfP7TjsBQU97o+eCzcJscfZCoNBH9i/7otbTMFg3jtLpWZ5yzY/5gZ9Pgrtwwu1DX+9w6y/km2VpJJuobN4GKolorJZMiN7X1Ppx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg5v6cGC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg5v6cGC"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso37105a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786376100; x=1786980900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lVTvA31Y4AJaWO2Jy9f6VXb8WvxFMH1yAqUvwvSD+Mc=;
        b=Hg5v6cGCnMykjZWZBhe0cvJJDv3rMM0F6YC+xlyALx6KQ1CSL0e+EfTsjpIcGfOJNe
         +F5hSfZdbavZZ0S0TR+yj0f+A7jM2Sz0Zi8Szfcurpn+eMUg5OJIi58e/Yspb84wIhhV
         lmuocS0gpcKUNUoPt72hRN3r8Pr9WgrVx6HmQuofqPwg1sYt37TrqIBe4drcKzIDU3dH
         pbquMPl9ZX506aDKTWbD452Q2VMXaxdDTeA/YpUviGRsXbWQ9EFZHuuAmIRe6kd2Ni6q
         q1NB/SQlZ/PqUdTdyzAAezqLLIlThnO9TwGuGT4aGSqIr1axwlTsJ0vg/T3Zaw3HSkR5
         3T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786376100; x=1786980900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVTvA31Y4AJaWO2Jy9f6VXb8WvxFMH1yAqUvwvSD+Mc=;
        b=BXGHHNSqYGEUtvHvj65emQvcrdv6MIxL76ujilZ6Iqqn+ZTITaLP1ktRbbIvOlVTEE
         Lg8eE4Maweu5meCaAvkIQwLnuKD+H68KhCVD1+SgQTxvH1yMkGimNYZ+c9jPF5NAG7eW
         9a+UkxvsZxtF8kCD1weompHt7HmR4Pg0Jc8h4ciiEP3sHm5S90pWF4/PD3/0OLo82ohb
         WxumbLbhjRICbjFccBlCI/mDWrvbDmXxppNuwpZNuUj1kAAVGROLTTwD/lAoCjqaPHKS
         iRQOd5oHJY/rZXE+k/phU9KhOtwnIJQn/uJbZv348Fr49GHbQHhEvyfvwoHsWVMHO14v
         WN6A==
X-Gm-Message-State: AOJu0YxxEpm5nhNbA3QrzMgzInK4+wwZ3+PUNiG2q5+0XaoMzxZFOThA
	k5l/vEk1SBcpjyy3VzO2grU7WTPNOC0p+S859/EJHDlvamB72LrsXiRyg7Z2jpdq
X-Gm-Gg: AR+sD10mqsgzDICKaNMh825ixkOeqs3HB9EOcPfuHfWgJAPDDB8/VXVdxomqWN19g8g
	Awl7ApruvSPk0gep6cHQc60XYOSy2s/apdTrM6G/F/vGxqQKC3R3a3+PANybsTwN6lwdVlo+zSM
	vSHNeFClkm6MmSPZMCArcqsaCsAYTxIWcNBNIeGDXHnqCGM6GV8hxskAoAVLuKZIP5r9c2U0fnO
	ZgB0GKB87ysCmxN/5FjRei8NvM7AWT3nr0o6JbAZFapncEOUK418M+Q7YlMu4YC8F2Ls0h0+YSQ
	XLPVVyaTyfnnu+Mbt3mZ4jXtoexUBuWBd6pA5cz+4m+fFHiaNuSssqEC3QjKbxffd80nP/Bn+m6
	A6bUiWZolNd5PESVGIdZxXJJyLYBCYxadHh/IqzksXTiypItD/L1VZQ9oFjIVOIEBXi6MMIwnTG
	wQe1shZHHjXhy+U8eCyYs2fWpWdd5PBEFPZO4nlIP6uDZMAjYjyGMvrLgrWOeXYJbpcNpZwSp/P
	MewbJqULLwg
X-Received: by 2002:a17:906:ee87:b0:c19:5bf1:368e with SMTP id a640c23a62f3a-c208d4f5702mr875952466b.13.1786376100329;
        Mon, 10 Aug 2026 08:35:00 -0700 (PDT)
Received: from torstein-laptop.internal ([2a01:799:3a1:9700:9fe:dfd2:946e:90f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2080cc3bdfsm393966466b.48.2026.08.10.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:34:59 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>,
	Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v6 2/3] mmc-utils: lsmmc: Factor out CID month/year helpers
Date: Mon, 10 Aug 2026 17:34:41 +0200
Message-ID: <20260810153442.132286-3-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810153442.132286-1-torsteine+linux@gmail.com>
References: <20260810153442.132286-1-torsteine+linux@gmail.com>
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
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
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

