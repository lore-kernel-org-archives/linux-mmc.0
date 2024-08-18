Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51E1BC3C
	for <linux-mmc@vger.kernel.org>; Sun, 18 Aug 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723991035; cv=none; b=TNo4xZjKTSX+lxT9J57ne5kYbHP7a9Wkp9K42CZDlKCe8BrNk4O/jUfZHbASiz58Lr7I4wOBVF0PE0a6vNd1KukIMxAq2fkLuNjr7eaKpC/yuB+LCtsIjPYfTuzL/J61GlN1F5af9lBra2BhGknLw/2531XgWv7u4yyriAJxRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723991035; c=relaxed/simple;
	bh=GKnvc5j9d3UGQN/RmRiNw1hnAhh8yCXMvbd2GnUbKL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKOnG/R6r9LpLyCse/tMfFQXGatUlFpM1SO8xMQNErdpCYIBOAO/1U4e9q7zAeHPCoqMOlgIagp8CTVA2lQ7h1sZOrXJACBL0sQlyVWuU2JAXmtrSs7fc2OloH6qB3FYiAR6EV8GHYW0eAj/30BIA0w5cTMg8fEPdYFVAPKY958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=bQbdcC6e; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="bQbdcC6e"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so489504866b.1
        for <linux-mmc@vger.kernel.org>; Sun, 18 Aug 2024 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723991032; x=1724595832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84N+5XgwWf1nwoq814fYSNnKDtDJw7Qd1tBkSaBztTo=;
        b=bQbdcC6e9MlohmJhxfy3W29nBlUm3cQ8eaKyEO7NcX4yLAgu8qlQF915rqFw3mYmK8
         KbeP71lZzVj/XMPLBRQiNY+JefVoy+df5Mu6Esu2UIWdFkOxlf60khlShHMCS2h4RRGz
         Xb6dYjJ57pOBwUvXPDf+tGgI4r3oUFqPHyIJOrm72vCeu48XAwGoefq5V1nEnW0rPv3U
         NFUBqZd9SrKoorwIDghF8nEamu0p2OHbRFSYsozLl1QuEayBF+FYG3twaB/Kz5LnxsQT
         3PmLQJ09J6/UgIzh9WJTOvLJ2i5JtTslpebA2R2nx0x/67pIaV2IgfGOhbjbEuR/vixs
         1e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723991032; x=1724595832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84N+5XgwWf1nwoq814fYSNnKDtDJw7Qd1tBkSaBztTo=;
        b=VaOYcHfjjOM0V/Amm4fq1kByOYRIWVbsc/D+uZj7Ee5UOhl85dse6cZIx0qglTtNMX
         BoItO0QnvI9ItTSLHX2bR7/RiLSHzmBiYZ5UsKTou06VUP1Q9OjAv6F4pzfQLNxaG6Y0
         o84b/kbzGcY/cTFfS5/lwSSUcs6flZEdbgarxxS41ITpkz9m9JE9mq04/qK4iFbHgf7p
         OCRJ7cE5iQcIf/i+OI3vpWxNBaG2YimzOsBVcJ9oS3cJYncEnLKVUPX3WEUbUU0SJ3tv
         hqQKdBySitELxDqV5Z0y56eqkriBrhymt60uIToNBx36mEBbmn9uArvFyx3LknXeeHjp
         X+TQ==
X-Gm-Message-State: AOJu0Yyk9OjHp8yS39PBya0KqWP8hOnNwq4LqSG+O56TFlJY1aU2oZ4u
	YnZOrBhKogImyuapLgbs1/Qg8uQMX4F3byA279aa0Pb6dPh89AmANcV+Q08nOe/MuUt3FDTWaeb
	FpU4=
X-Google-Smtp-Source: AGHT+IGf2pCDxIA75jH/7/L+NTnSfTLwTcnLAynOVUmTnc/INCAsrC+TWCaYgIwOf2GFYNoBXz2Lfw==
X-Received: by 2002:a17:907:f1dc:b0:a7a:a89e:e230 with SMTP id a640c23a62f3a-a839295469fmr583647666b.30.1723991032263;
        Sun, 18 Aug 2024 07:23:52 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d023dsm519702566b.64.2024.08.18.07.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 07:23:51 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: chaotian.jing@mediatek.com,
	ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v3] mmc: mtk-sd: Improve data type in msdc_timeout_cal()
Date: Sun, 18 Aug 2024 16:23:01 +0200
Message-ID: <20240818142300.64156-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local variable clk_ns uses at most 32 bits and can be a u32.

Replace the 64-by-32 do_div() division with a standard divison.

Since do_div() casts the divisor to u32 anyway, changing the data type
of clk_ns to u32 also removes the following Coccinelle/coccicheck
warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Use min_t(u32,,) to simplify the code and improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Address kernel test robot feedback and replace do_div() with a
 standard division
- Link to v1: https://lore.kernel.org/linux-kernel/20240815234602.59684-1-thorsten.blum@toblux.com/

Changes in v3:
- Use min_t() instead of max_t()
- Link to v2: https://lore.kernel.org/linux-kernel/20240817170726.350339-2-thorsten.blum@toblux.com/
---
 drivers/mmc/host/mtk-sd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a94835b8ab93..edeab9a4a83b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -795,14 +795,13 @@ static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
 static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
 {
 	struct mmc_host *mmc = mmc_from_priv(host);
-	u64 timeout, clk_ns;
-	u32 mode = 0;
+	u64 timeout;
+	u32 clk_ns, mode = 0;
 
 	if (mmc->actual_clock == 0) {
 		timeout = 0;
 	} else {
-		clk_ns  = 1000000000ULL;
-		do_div(clk_ns, mmc->actual_clock);
+		clk_ns = 1000000000U / mmc->actual_clock;
 		timeout = ns + clk_ns - 1;
 		do_div(timeout, clk_ns);
 		timeout += clks;
@@ -831,7 +830,7 @@ static void msdc_set_timeout(struct msdc_host *host, u64 ns, u64 clks)
 
 	timeout = msdc_timeout_cal(host, ns, clks);
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC,
-		      (u32)(timeout > 255 ? 255 : timeout));
+		      min_t(u32, timeout, 255));
 }
 
 static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
@@ -840,7 +839,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
 
 	timeout = msdc_timeout_cal(host, ns, clks);
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_WRDTOC,
-		      (u32)(timeout > 8191 ? 8191 : timeout));
+		      min_t(u32, timeout, 8191));
 }
 
 static void msdc_gate_clock(struct msdc_host *host)
-- 
2.46.0

