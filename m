Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A248095C
	for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246228; cv=none; b=JXRSE7KqVTfIZbhoWwz1t0TnAoZd6mgsdbyxYy8GcW+KfjYjXnnRD63mHMA2gQFAgb9SyMKegaHdE9YXg75suU271Sa75K2SWZD/IUYEmrt1vabVry3k0zMhDS0X61AKjE5Cgqqux9AwnIIXphGq97szQUmoTJxlYwZnzoYbWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246228; c=relaxed/simple;
	bh=LMVqByU38FdLjG5rLAA7ZHIC7mjY2Ws+ctnXmi6/sFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyIEQw1MnzU2sB4VoCY6h2PgD33s0evhBGJeYREMPzvI0luNZQoeqhVSlLK4Y80xIadcN7pr4cwtPhGzwgVYrDk0TD4EvgM9pzIXIvxgrolnwFPmXkspDCpAKGHv6snw/0HRFuz+ZaxEuzHoVGsvcMT/V8r2Fwp9UF/8HwbXVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo7pnHop; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo7pnHop"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso686565e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246224; x=1787851024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Evee9pCw6wURFV/VMZdiihB+PWUJ4VouwconvXAOZkM=;
        b=Zo7pnHop9ef+0pFsqEgAIf5hZ8cpbfHDFw6ItDwRxlFQvqa8177yf0PB8hkKyYVl3H
         kox9QZA6D5D8Kfed2yJch8Yx9WS68/t7ybxNLGFuOihtFekoOQZ5DacmqD6lHn8CzMvL
         0T9WrOKmlvZt5mszrsnQgQeuWecacFonr3AhHk0QUYI6TwALQlM2Civje9U54q/yw6Hw
         XQKHqipXIuSX14EtAVr+5kdX4OvwCqr8kN2Aro0Lrlf9uCpE9S+XOZX88SBgxzkaiWgs
         BF3xRhRgTFpuXTcudd6lrU97hBT+G5oPPfsrXoP1egBQXcKb0ajQDjmbd1bb9ZRSopp4
         gAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246224; x=1787851024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Evee9pCw6wURFV/VMZdiihB+PWUJ4VouwconvXAOZkM=;
        b=pFOyYUs5vxflFtJ0LRjphV014WS+jBBvqo1jVC0xshlvSws8myrNX801qVHwiWov6r
         ERhGymGDrc9iXyQVk/E3jF4xfVADNN/b2ozsip+9a7zez2tyKauyB14PQklK30cuGAp3
         mwNCJqOVoq3Zit0AP5Ytcm9RaJx72Bc5iNrIBKatLHXwmbQQrpQ6X7qQun1d8fBGiWE9
         tlD+fyaTb54PFRl/4QuwU8t2mJRSosNcLNW+oIaW9dJDUJdhg6QSrTVwM5b96Dfqekob
         xh75PjAAPxIbRQJ90XJWspTSHiYsHxwr6V0eTTmNB90PBOut+MV7ssVyRqgEdccpMyRp
         5F+Q==
X-Forwarded-Encrypted: i=1; AHgh+RriIVhU4FWTG1wWd5cweUATxViGN2gaaFHOlmBnQVYKgXtPIMThHLa1FQes8xb96R9kF1fW6kxt8Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckfV03PjOwQfdKPORU1Gz8BHn6r0lphGyYAilL7TcDZBtgq05
	O3Q8snOeTp3LB4mG/9+gLiS0JIhgi3CJySnGloedOTL/i1CrPdLeAvFs
X-Gm-Gg: AR+sD11/FC4wNIQfUl2Se1aJvWml2KXJVkP3m+y2fXk76v2WvQ7tVMpd4z9ZpMOG7KP
	rTvMm0A3CJuJJakjLL6mfF3Jj8Dcp4TFP+v6/sPw/UOxjPjidwTi9SRcg5V+LRxgj5kkdd1nuI5
	0SXrT9kB3AXZX/7+tV7He8zHqngnMZYA+iQJcwcAjcwqEpXCmQcNRZ1y/KbJBMkgnwc0ogbMmpp
	GXPAVaFAbIJbf36VqZ7zmyQK0JQ2FEuogxgjV+Q6HJ5xT+fHWNWJdAg1xudlOx5SDBUbQ2Jt72d
	DryoVa9/k6gIE9Eb6QLpS79ZCvrcX9IFxoZLh4HpAWEWEz1SngFfCsG4k7LOh4KSwot/6SdoGCh
	g0E7CQyHGsMnjAi0xVX7yztUS/Zbn0c5Om18+KCmWJOTyeIFK8o0sXXOVp5svGM18hr49m1SBsf
	UgKbIhGNxtXcWyxJbxHxC9FClT3ldouQx4PcS+3Mn7xT7wcp29ZSzHhq/i6Qt8XUm4T8rY
X-Received: by 2002:a05:600c:1d07:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-499b857fa7bmr5025685e9.15.1787246223525;
        Thu, 20 Aug 2026 10:17:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:eda0:8ef1:e1ab:c2b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm219313495e9.3.2026.08.20.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:17:03 -0700 (PDT)
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
Subject: [PATCH v24 05/15] mmc: renesas_sdhi: Add SDHI_SD_CLK_CTL_DIV1 macro for 1/1 option
Date: Thu, 20 Aug 2026 18:16:35 +0100
Message-ID: <20260820171657.62815-6-biju.das.jz@bp.renesas.com>
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

Replace the magic number 0xff, used for selecting the SD clock 1/1
divider option, with a new SDHI_SD_CLK_CTL_DIV1 macro. This improves
readability and self-documents the purpose of the value at each use
site (setting/clearing the divider bits and comparing against
CLK_CTL_DIV_MASK).

No functional change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v24:
 * New patch
---
 drivers/mmc/host/renesas_sdhi.h      | 1 +
 drivers/mmc/host/renesas_sdhi_core.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index af56b4bfb1d4..a1b2761ceccc 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -24,6 +24,7 @@ struct renesas_sdhi_scc {
 #define SDHI_FLAG_NEED_CLKH_FALLBACK	BIT(0)
 #define SDHI_CLK_MASK_DEFAULT		0x80000080
 #define SDHI_MAX_DIVIDER_DEFAULT	512
+#define SDHI_SD_CLK_CTL_DIV1		0xff
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index d893a263e770..fbc0a8317b30 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -219,13 +219,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	/* 1/1 clock is option */
 	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1)) {
 		if (!(host->mmc->ios.timing == MMC_TIMING_MMC_HS400))
-			clk |= 0xff;
+			clk |= SDHI_SD_CLK_CTL_DIV1;
 		else
-			clk &= ~0xff;
+			clk &= ~SDHI_SD_CLK_CTL_DIV1;
 	}
 
 	clock = clk & CLK_CTL_DIV_MASK;
-	if (clock != CLK_CTL_DIV_MASK)
+	if (clock != SDHI_SD_CLK_CTL_DIV1)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
-- 
2.43.0

