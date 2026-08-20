Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1248423D
	for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246233; cv=none; b=jyg6MXSIIyfWldwhBSmvsVL7WlkX5QB24BhvB3NqyEH8OWLLCEQCAgjNE/MQGeilbfb8WbFfy4h7bBpJO/ZyyqoupxPPMY02jS3GVAaB7btPnKU5Lel7FrTdZ3gHqCzhT5ZM3J6bt/Lds5bqwyI1ruWAE9cuduXfrALY6YABIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246233; c=relaxed/simple;
	bh=uvEVZrsTmsZfHrJ6REwxpuKWQsGP/OMPoPdCJOMN3uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmDiotwnXxYj2pkWaBd2uVkyoS1HfuqdxeTzm9v5hQ6907ggFdsa6lz1R7SvFWIMd5ajY+nHU63ZLXad/eOYrFl0TszqqyaVbmxsB4SpMdgu82pME170uUexL3cSPkfpFkvJQAZjiBOkRKxRx0iISG7/SeQcFVJMDQwNmo/D/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln8Jq261; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln8Jq261"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49978908b35so630325e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246227; x=1787851027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZruPNUmecmT47tLASIyFaVykHI9/Lk+W+uqbdFD73Vo=;
        b=ln8Jq261fZGFwZJI0I9q4b/zC0bVXBwC+gY2dUmVR3dIzNXvCYGWisdA4jvhqL3Zk6
         DKyEsvRMRHXKvvm13o4pK1uGVdEftkTEQjA6WzVq+7jPTixWyiYExf57FXJCnW1zgm0g
         bnnVsk81+qY3YLiPEkovisn0mPnqHOxnuFE2HT6lsUGnZXAVFNeMXROlB5mA2YQRifxg
         UeGPu4br62RG2HNdOTb3Vwcg9+tondSDN/2U5D7ENvhNiGC7vUmqBo/nS7zW1JaKdAJa
         aHSJf2ZzoMYN0KRo5Cb2P1veQf13+QhjzSAXyjfzL3Y9AM8OEPGun8kSqkx+OKGE5Q4V
         4CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246227; x=1787851027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZruPNUmecmT47tLASIyFaVykHI9/Lk+W+uqbdFD73Vo=;
        b=mMVpx1/R3JVKL77czkY2/Fht6aDjsHmLoBroOz6vQbSzDLY632HfF4ukxItfDPbK2n
         g0yrYjVb638jwfuWngttAX80fzvulfmJJBMzUqgnfMJda7FqJzvQO11+Mz1WvtAh2+mt
         uDSXnOaBVs13galRvKGN3KR3j8xWr7gJ4TBWNljqB5UvDWD+icZajf6AuY76pGgIcloE
         HzReFkG2Ns5b2HCYDR+58hUbzlEHNjujByfcxreFD12MsZ9zOiTXWw69ugn5IdCa8sXi
         tySyIUtMQqGnMdrptTx9hz8IrYPm5ElLDZWPzmnpWp8wrhaPuAXAlc8ihkDyiol8HPzo
         IkXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq148vvWia2DimTRHR3B4AYA3S+lllXi3F/GbIKRHEXPdKODDuIHfwrGNdrSqirz0peqYBku3a6d94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfAmSpo+r/TFDuT/IAvwTQyXD1QkIpfWbFoh253REWDnqlZp1
	cEJBFSjIumA7EtE7ey6fR1vYwpNJV9LeGco6bMCUkYtMbh7ObycjBaG2
X-Gm-Gg: AR+sD13jBSEpbC44HGDa/ZV14EuBSC0v59sJj0/C46f7GVYkBmcEE3liOhBczWgC0Zj
	u1LdQKfpfAPFR6eKA4uLBPbPbv5jCox9ujEOCrq6EUZ+uELWIv4xdCzoHuBQ6xx6VY3vBm+9Iyh
	SduFeoNv5/hb6UjGoGpRwidUXcEPHncEtg+SjDP6P6eCoUzavFDwF6QqtUyeS9fCdIWW4KfX5ej
	UnTDpiurWy2sxyh9tqZox7Ggh0+bRnN4+pPNJ7i0RW5EyfCjIwTAA//6n5BvZL+pvAKnAGnWVy9
	LPr1nVbffo4AvqxU38VR/9Ea9E2ZsFndWc0C0NFb1WLyf5jLhNUrWCJMvpupHelimdBeeBuLHOh
	IRW32jK8fVqGRQPAs2HeAqFKaTdO69UFzmNFJsAud/rrL5v7rsev8Mnb/amkpWxpvgeFlTuZJZz
	RhJ+BFBwXTpa7D36LlVs3sR0jrV//zBbO0wUJPmxJ9+FldDr4Pe9sX2gNCLD0q3ukvohKG7Yg0X
	w==
X-Received: by 2002:a05:600c:3b08:b0:499:b402:6c0 with SMTP id 5b1f17b1804b1-499b830d671mr5964415e9.3.1787246227251;
        Thu, 20 Aug 2026 10:17:07 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:eda0:8ef1:e1ab:c2b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm219313495e9.3.2026.08.20.10.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:17:06 -0700 (PDT)
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
Subject: [PATCH v24 08/15] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
Date: Thu, 20 Aug 2026 18:16:38 +0100
Message-ID: <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L has a fixed internal /2 clock divider active in all bus
timing modes except HS400, where the divider is bypassed. Add a
TMIO_MMC_INTERNAL_DIVIDER flag to mark controllers with this
divider.

Add renesas_sdhi_clk_get_rate() to fold the /2 division into the
reported clock rate when the flag is set, and use it in
renesas_sdhi_clk_update() in place of clk_get_rate(). HS400 is not
yet supported in software for this SoC. Adjust clkh_shift for the
internal divider case.

No existing platform sets this flag, so this is infrastructure only,
with no functional change for current SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v23->v24:
 * No change.
v22->v23:
 * Updated commit description.
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
index ff428b6187bb..b5f2ff68db75 100644
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
index abf4134a8bd8..8d435f7690a5 100644
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

