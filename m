Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365084570E6
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819446; cv=none; b=Y5aeMZkW3S6/F64e3AAErDGq0H5ZPQJj4RROjjIgfH4oMkAuTyJPWRA90g6CbuQdIa+qluh+M/NJjzXmgq/HXsv2pi+Lbnd0jpd2FA3Gb9+NzQ6Q6G3D16ZU9HJbBrSCTfH5ImWoGLxKWIZpBVvikwvPEGmlQzLsWPWEgF9ZDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819446; c=relaxed/simple;
	bh=D3ccJqgDFfTn4g2TEg745jzpV+AEj2Ms2jwr0Nxv1CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj8CghUBpDcDUPjlK7X0XcfQa2aDTxWOaK5njYn/M2GlKIcX46sB+DlrndIQS899hs2PtR+6iZcISJDFPBVdOjshtUeqclMqHwV/K0IDPWNncCKcDZP2Ay3vZm0wX/AOZgndFq6rmz1HyDBUsxFkZwBRVTu5VmMWNuB5yoJ42Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDljLkkY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDljLkkY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f703a9d05so492979f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819433; x=1785424233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLv6HDvKcwi+pAKbx+mZWoF9tWmEN0zknYgE+FKHLA8=;
        b=NDljLkkYJC15wQA/CKSq7Uiep1Fnn9aQy3iQKZtBzJiM0+L3BP0nRe6wuhJ8rUJ6DN
         QaL1p5al1Ty13acFlVz4WwO2gO6CUD1XiJY12uox94V+tX7LGjUW/rmbvDyidvfiyDQG
         6CNH0pUUmqEdf3hUK9Ct4QK5yd9Ew8uS/YAVao6NhBBJ13SN4Jkkgrc0RjpKzzSVqYgX
         KJM2UhaYq4O3Vh3BE3F+l4LZv0cQw1g6jzggNNPpLyWa/hAK2WH/JW6/1pvKfUup6tQJ
         +wD7xyLAFaqKuiLkuNxRAss/70fsRNd1ftU0UI2ARAz2RWWivAONyI0shtPMc7GluS3K
         IbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819433; x=1785424233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lLv6HDvKcwi+pAKbx+mZWoF9tWmEN0zknYgE+FKHLA8=;
        b=En2/AJa0rlUnmRB2IRXd9xDeXJkeQ7N/mqcP4HJDr+dtPQNFHGw5vio1aAf0wyWIsj
         EDb2Q30L2mVVt/4TxdIX2sQ1no727jiDRST1bogDNPVrg37y6c/hBXgtJHi9AQSdf1rs
         nIiQJCMaAdUS6+HtSwz1IiWN6yZ6d/+uuAAOlk5Y9PEo1Bx5ostnybXbnkA4LkbD72hk
         zfxpc8Btu55Sz6fZHC5NmEw97/dWRFSlaqANYM8YIPlrrrvjvPW4Vj3XdZFKQi6STJxz
         N4YZUT8t3+mO2nrb2V6/TDG3xEjoGkSkCw8BqH+lbIdA53Z4FlR6LdQFGUpjJJTX7rcJ
         T2iQ==
X-Forwarded-Encrypted: i=1; AHgh+RohP5xFLviOF+DIgCAwe483Ytq5Ci0mmz0Fu07Ux4MQ+eb2fayTe0gOAmBd2CVJd5TXcKnB9mrFBkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUiXbRtyHNnQO92cHgyk4jdrvjEKcezuleHqfUQHV57BXvqAx
	YR+UQqZly4hjLFKXBCu0uqjTIjgGpu6gK3I5g83JvsUfuapauGSAbfGz
X-Gm-Gg: AR+sD11OIKeIJ4ZbhSR6QjZCaGjkoN5rDQaAq3Gso6qwtBm4IamSFbNHw/vxmawmHrl
	YugpraraqwzQJjxfh1w6OtMlWbp++0W16NeIs4nwo0lM+pPdkjcp3E4a35VZ06MEA4UcjZ7ejQq
	Cy0l4pmnaq/d2B9DHPk9LZcQQIEBTapxvUN/Px4SxgPjQBwxeelB6P7TKTK9MU1dt4FJT1Wm0p4
	9s3gwKpz74OufhOgXm6RiTBiai+ul74thFUjz56MJC8Fqb9dC+kZWDm7ovJSM+GhVeVMdJsJ0vy
	jgXyqrnc7fVRocVpztFBc9rIDzVjPnmzHRxBNCV7cj2iJqsE9lTE0PngzwcIm7gf1dGkaLWo6vp
	4J8S6fSdsYUq81QLUS19efNzFIevJ2xWaDFvYpEH6VBJcr7pf93mT4iXTLG8A2aabTCo3Xpk8QL
	wJTozTADficrkljP98AX2KpwK9jD0=
X-Received: by 2002:a05:6000:4310:b0:47f:71dc:d848 with SMTP id ffacd0b85a97d-47f8da6e589mr4824699f8f.12.1784819433488;
        Thu, 23 Jul 2026 08:10:33 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:33 -0700 (PDT)
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
Subject: [PATCH v22 07/13] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
Date: Thu, 23 Jul 2026 16:10:11 +0100
Message-ID: <20260723151024.318918-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
References: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L has a fixed internal /2 clock divider active in all bus
timing modes except HS400. Add a TMIO_MMC_INTERNAL_DIVIDER flag to
mark controllers with this divider.

Add renesas_sdhi_clk_get_rate() to fold the /2 division into the
reported clock rate when the flag is set, and use it in
renesas_sdhi_clk_update() in place of clk_get_rate(). Also adjust
clkh_shift when computing the clkh rate for these controllers.

No existing platform sets this flag, so this is infrastructure only,
with no functional change for current SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v21->v22:
 * Updated commit description.
 * Added renesas_sdhi_is_internal_divider_enabled() and
   renesas_sdhi_clk_get_rate() to simplify the clock rate logic.
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
 drivers/mmc/host/renesas_sdhi_core.c | 31 +++++++++++++++++++++++++---
 include/linux/platform_data/tmio.h   |  3 +++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 9c6a3c5fbc8d..638bbc990096 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -125,6 +125,27 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 	return 0;
 }
 
+static bool renesas_sdhi_is_internal_divider_enabled(struct tmio_mmc_host *host)
+{
+	bool enable = false;
+
+	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+		enable = true;
+
+	return enable;
+}
+
+static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *host,
+					      struct clk *clk)
+{
+	unsigned int freq = clk_get_rate(clk);
+
+	if (renesas_sdhi_is_internal_divider_enabled(host))
+		freq /= 2;
+
+	return freq;
+}
+
 static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 					    unsigned int wanted_clock)
 {
@@ -141,7 +162,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	 * clock during tuning, so we don't change the external clock setup.
 	 */
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2) || mmc_doing_tune(host->mmc))
-		return clk_get_rate(priv->clk);
+		return renesas_sdhi_clk_get_rate(host, priv->clk);
 
 	if (priv->clkh) {
 		/* HS400 with 4TAP needs different clock settings */
@@ -184,10 +205,14 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 
 	clk_set_rate(ref_clk, best_freq);
 
-	if (priv->clkh)
+	if (priv->clkh) {
+		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+			clkh_shift = 1;
+
 		clk_set_rate(priv->clk, best_freq >> clkh_shift);
+	}
 
-	return clk_get_rate(priv->clk);
+	return renesas_sdhi_clk_get_rate(host, priv->clk);
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

