Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC203911B2
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784381933; cv=none; b=RbJSk333gOscLY11SCybim4/Rruf13hBz9p9odwzaplKzEDZR+H+fnRnx+ap2kktr3WFfRzJjpKsZtVNO5xtZ42JzmGmiMms0TQtEjxD1gWEfMSkEn3SB1uq/ciX//MhDOAWvvxz9uwjG6U1CeA3lTXFGGrTk5IOyX/r6YbSqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784381933; c=relaxed/simple;
	bh=dYo9FKDRCB4K7n5y+rKmgO7EDTJp/lIMUaRHj8sTZRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6dnhxHRTm7d0LX1p8c2L57PLn/B58qZIAY/Rn/wkD+SMQZu5VUDfLxzdm2p48CBB7CZskxI7Qz1y03mqaunsGSiMCd+Fmr7QBJvv807iQNO7vks9U9HTdaKXjlsbWKjA04+sZ5PVEzqEldhvdaLvNy8rPh3rXMNNr1UCU2J3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7A0aRN1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7A0aRN1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so61086985e9.1
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784381929; x=1784986729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHNZzuYPNrUsKIj/JY3ysvghN9YMlJCSYF0jtF0u5bY=;
        b=R7A0aRN1tx5KwMnPi0YsBnfewZUC7CHSCh8Oc+VpSQOVwRDa7aSO3rmpfubhP038Ne
         bvqHn3Bo5oVUxGD0oBIEhpavuBC64zQ4MB61tJEuC1RynHtvNtaIGoGMXmfWRWfaPPDD
         3ChE8IvluS/qds4jBG1STgw74X2kZs+XN7tCEbZemlq3c2elNvTe4Bytwoc+LgnNGyHK
         03eKtohLJQkgBxpcy+z0Kh89QJ8Hy3Yu13cWuQlBKIeZbPRabFnW5BY7D2bggMzrnK+h
         ByfHrDcc3x3Diei50JkPKcSvd00M1xTRCo1NndYYOf4ghhBPh6Ix7EKzWkPyZqZL/VBQ
         OmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784381929; x=1784986729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kHNZzuYPNrUsKIj/JY3ysvghN9YMlJCSYF0jtF0u5bY=;
        b=kGxPfp3zlON+25fy0jDQOxpfW6rfIzVKhpmE1gh0SFb09SulUMypweFYRcBIWOPp57
         X48bPIjG9P5pczzyhvmAKw/DJQk9RAwUUfL6Qv+TUdcdr/Asf5ltv97Hpq46J5MSbCU3
         85s2NQRcTyGjdtfRTXQQbUZCv2XkNIge8jD+8bypksUX+ILkUSIhgFKKD0w0aYNf/xFx
         CoVDxR3aIyXdVJY2u/CKEirhFbF9xuI9exnFO+P5tAAVZboaJoOIBoBKlu8owEgcMkh8
         /kKDPhdlAFJRfTaBi9PS5kCRjmdl6v1EBiYHs3ZtWE8+1QLABw6BQhYlm+yQwbGDiTpe
         BRoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSnIhdPf9F3tRT6RJ00iDxHR1/cpIOxHjVHGDN8c+Ciq8Z2RNcarVsARgSeJVqzzvKvy0rs9OVeTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVPlYeipIg9rpLQM9SxSFOd547Vzr9RNRpsXuBfg/EqW4nqpd
	OYn8VXW7UpQzuNCBCD8FCK/suKH2ncCFk2E1RF8iye7528Isdo6Plfys
X-Gm-Gg: AfdE7cnZ6Spct5dKXraav5GBovrhQwyXy6wz+FvL6kvTpL3Gj7M9cPzI53h6HRHM8ci
	3H2nFhGMiBRDyBQ9sF3CHLqL2cXh59M3d/fSJFxeTfdjDRBXf0VJVmYt3xZ1ZHNB9xoMDNT+eKK
	qa5dtioooWb0TwLukqNPtIMFQwS02sZtXgV7IYW0no42b/2oo4/La2yzt+TqfUq6tLhgm3QaxLw
	Du7EVwCHOx2YdSLmrLIDp3ctiqIRhWHm7SCT2ks9ZRFqizKNun4ojCim0/gNf8kReH852oO9kxP
	sNgdOTSSVKDA/hFUaa3LAGXcv9w0eYHrj5u90RZKApOrhhNtGvsFfKE0JakxiHCDCXc53peSiC5
	36ohwxtiu8O+N97hP0YtYVH+uYC7PSv8nxDkVPBW/eulQnXIduGgEa5mHYL4kK5hSkwA/symyNZ
	KGvm9E1KtyFYVE9VocIiiPk1xcYh8=
X-Received: by 2002:a05:600c:45d3:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-495503fd2a0mr29744115e9.9.1784381928604;
        Sat, 18 Jul 2026 06:38:48 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c53f:e1cf:6009:4c03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96ff7sm121717845e9.10.2026.07.18.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:38:47 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v21 07/12] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
Date: Sat, 18 Jul 2026 14:38:27 +0100
Message-ID: <20260718133838.152905-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
References: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3L SoC integrates a fixed internal /2 clock divider that is
active across all bus timing modes except for HS400.

Introduce a new feature flag, TMIO_MMC_INTERNAL_DIVIDER (bit 14),
inside the TMIO platform headers to mark hardware profiles carrying
this integrated divider scheme.

Modify renesas_sdhi_clk_update() to inspect this flag when setting
and reporting clock rates. When the flag is set, the function
bypasses the standard base division logic via a modified clkh_shift
adjustment, then factors the physical /2 division step directly into
the final calculated frequency value, provided the current bus
timing is not MMC_TIMING_MMC_HS400.

As no existing platforms configure this newly introduced bitmask
flag, this patch delivers the underlying operational infrastructure
with zero functional impact on existing supported chip variants.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v20->v21:
 * No change.
v19->v20:
 * No change.
v18->v19:
 * Updated commit description.
 * Dropped divider variable from struct renesas_sdhi.
 * Updated renesas_sdhi_clk_update() to return rate for HS400mode
   and nonHS400mode(uses 1/2 internal divider).
v18:
 * New patch using flag.
---
 drivers/mmc/host/renesas_sdhi_core.c | 13 +++++++++++--
 include/linux/platform_data/tmio.h   |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 9c0062865866..456d52f5fbe9 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -184,10 +184,19 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 
 	clk_set_rate(ref_clk, best_freq);
 
-	if (priv->clkh)
+	if (priv->clkh) {
+		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+			clkh_shift = 1;
+
 		clk_set_rate(priv->clk, best_freq >> clkh_shift);
+	}
+
+	freq = clk_get_rate(priv->clk);
+	if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) &&
+	    host->mmc->ios.timing != MMC_TIMING_MMC_HS400)
+		freq /= 2;
 
-	return clk_get_rate(priv->clk);
+	return freq;
 }
 
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 77d3dc91c828..09b3411a59c9 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -53,6 +53,9 @@
 /* Some controllers have tuning delay */
 #define TMIO_MMC_TUNING_DELAY		BIT(13)
 
+/* Some controllers have internal divider */
+#define TMIO_MMC_INTERNAL_DIVIDER	BIT(14)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

