Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F323FADF6
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810316; cv=none; b=uiLSnK8vj24Z6oYyUcvZZlT00/YVnClQC7Ly0hmqFTwNLni4h8/+Toq/qtVKkwJQzaq5MgUEdWYMMPIss+tZwyOD1cz9uhfQz3IEgyZZALuTfWBx62Y/MoTPY3V2GnOzl6SErdkd8IdnQjCCd+GPwk+MFJDFyOaH6webHC6VgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810316; c=relaxed/simple;
	bh=0ajQB+hPab2vIWSNK6YjKmU3k2ZE+ruh1odyGqqOzg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUnO8pKcYsSOzzkIwCFhdvR02pGepG72yq1XHUslfw0MB4ocElHxJhLF3cSorPX3rBoaEyQWwdsEvzrFLsKqZKkNcrgWyJLDCBEuo7fcg25drVPPyVC9LFUz18faflVkCoHRrCBYEd55qlm/MLVH/Dfm9bMmUxqPWj/dkPpGMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVV4PXhL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVV4PXhL"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d02b4c3601so44917565ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 19:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785810310; x=1786415110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1OaiGLLoxTsUad13rL5qrpAU9a1lh1UZkttvZnhnlXg=;
        b=OVV4PXhLzZLP8OQoWeJOJafRZj1Q1/uqjr+H4cemRtroqQK1zzAhvSPJEgaMAm/Hn5
         e9pJzZdVt9YDYQojIAtzvRwQEotV0xX2lPqOFdknjKuJHsYgOL+Qtpo3tlSx2i2MGqTM
         hzqp/H8Qaw7iPkEnL9+3OdU5CwOstGRRcE+HAESnBFoJOzH5yArhIFA6XkAnoQSAVu94
         Mgv3sWDXCCVoXSoS935qKLyiCdINFAev03baH6hPwdPoMj0n9UmtCoCLfLalyqgJORkD
         WBpNFsXwS+xhupjFnO1GU826p2lWhZn+bUskAm3vzyAry3zcE6qupz0+07iAqmNdKLX6
         D3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785810310; x=1786415110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1OaiGLLoxTsUad13rL5qrpAU9a1lh1UZkttvZnhnlXg=;
        b=ilkReZf02wabHIkuX35/0doHXyM9E6lq+jHOZrPOx9/42bICyrbItD2wY5ldCcMkcu
         XyZ1ak8KAgZh4l12Kk+qgJrZYbWf3nezXIPr73iLHcoL2DgIMz6h2hos2rqyYayLRRBB
         4XMyNnAk5rDiNmohpqtIfcIl58A55eJKfQ6NDRj0i4NX8LEtYx3/nLMjUm2pbQTU7l3Y
         6HCJmDmrbhw6gnofdMCJexXAh1dqgf9/tBAORBq17eULcE+/TsTAV9rzW5582Lv5DBcu
         8vs9O2y8cfLi2UnTuzh7pnZYhChzlLX7EAJR++V7+oGWNzgPV+tsSdt4FAEtnBOBm+26
         Ndyg==
X-Forwarded-Encrypted: i=1; AHgh+RpZY8GKi0ulSSvngaJnGM7hCQczLpVpnVdaZz/2Q0u/8/1nCiLjKkZshbDbc5yaRJ0oX3J94LbhBxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWMjK2BJZBpzZYcpDt3Fj45nOS+QqsbRXqsqzL+XFxnA9snES
	0CIjRgl3Lf9ZApuXTbmtsrC7bASWErcigU25Iha8LuVcnXTQiqoWY727
X-Gm-Gg: AR+sD13pzDsp2SyXR9YiStzR3x0IH5SItEqrFsVSI1qpl8PBXgHGS4Q/pN1+sWpfFOB
	1BXv9WO8BxMLUBGTtWcnX3M2yWO/g6zsCutllMWo6wB7i2AOLzdp+p9LeXvEZ6jtBvA1azreiKr
	g+5S6boxmZgdQMmDjwwABXL8u1iksqLfBnT8FUz43LGZsmEjUteRs0stHZgUX6En6ls2bkY9Vq2
	RszCC9b6GX0VsUTVWl20lKYamwlRhr7twD1AvBMEFrR2Qxx5y32LuGWxdvYlQ2fjV4gYso961c1
	tfOkiE3vIZLM/jwSr0m7YE07BpuWgUo4J991FMLkcfrSzJ8IzxYwrbM5dLZGZgHoydwh9pPfViM
	c2Xmj3FUoXUnsnDb7QOQAYFjCUEFDPL1zWr/lM6r1By3kKjlW+lPEglUgpZ6BCYuf6Drpb2Huco
	C8WnM3q73dRdaBsLBq4xYn/FLmAeFMecDsPkeLlJiGW+CBUg3aJTFlaN4RBthKrcUiXXHQvmpe
X-Received: by 2002:a17:902:ea05:b0:2c9:d55d:2d3 with SMTP id d9443c01a7336-2d052244e67mr121387165ad.15.1785810309827;
        Mon, 03 Aug 2026 19:25:09 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b1216bdsm45230825ad.69.2026.08.03.19.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:25:08 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sekhar Nori <nsekhar@ti.com>,
	Ravikumar Kattekola <rk@ti.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit
Date: Tue,  4 Aug 2026 10:25:00 +0800
Message-ID: <20260804022500.3768116-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_hsmmc_prepare_data() converts the command busy timeout to nanoseconds
with:

	timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;

busy_timeout is an unsigned int (milliseconds) and timeout is a u64, but
NSEC_PER_MSEC is 1000000L.  On 32-bit builds the multiplication is
performed in 32-bit arithmetic and wraps for busy_timeout values above
~4294 ms, before the result is assigned to the u64.

The driver does not set mmc->max_busy_timeout, so the core does not cap the
busy timeout, and commands such as erase or SANITIZE (MMC_SANITIZE_TIMEOUT_MS
is 240000 ms) can pass a busy_timeout far larger than 4294 ms.  The wrapped,
much smaller ns value is then programmed via set_data_timeout(), so the data
timeout is set too short and the operation can time out prematurely.

Cast busy_timeout to u64 before the multiplication so the conversion is done
in 64-bit arithmetic.

Fixes: 8cc9a3e73de1 ("mmc: host: omap_hsmmc: use generic_cmd6_time to program timeout value for CMD6")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58c881f2725b..3356ac5a1fa0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1357,7 +1357,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 	if (req->data == NULL) {
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
 		if (req->cmd->flags & MMC_RSP_BUSY) {
-			timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;
+			timeout = (u64)req->cmd->busy_timeout * NSEC_PER_MSEC;
 
 			/*
 			 * Set an arbitrary 100ms data timeout for commands with
-- 
2.43.0

