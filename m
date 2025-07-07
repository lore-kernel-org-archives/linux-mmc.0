Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F3262FFE;
	Mon,  7 Jul 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914615; cv=none; b=f9AWSichdmYJMJ/G8gr/1A66ps4CCiwTJvsfVgjDx+P5A2fZ4/WMNORKBcs7yRk/PKeWNcPzDNXdRZh2MHQragsBvguT9l5jAICvmbi3IS0I/RyIifYnWcDYgXOjsuRCixzQWsFj8qhpiIzJvGmT3ZLGiwp6ND1qTsRTUBtGcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914615; c=relaxed/simple;
	bh=9ZxsGfMNuIDd8PUZJl180e6uYMTAtfiL4MXB7zLYGfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcwO/x5fzqnGgMk85gz+i3VrOFBKDTiy58p0jvKkLFC0r4LP8YC9lw03QYhYFEM5FbdIpl/UGbNLGX09P4g9iJ/MvXeVPfJPOWQoIZVek1iAdfDo/UARc9eyao2w76BA/Aocyy3argrqI8WTTQZlkBOFhnhG/JevuSstAMkM/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdJuKRG7; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdJuKRG7"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40a6692b75cso2511344b6e.1;
        Mon, 07 Jul 2025 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914612; x=1752519412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K6ayYvKDTLhKWG6B6PhMbZPiXC1I4Lt8zkiYPs7tjWQ=;
        b=hdJuKRG7feEnfbyfqLiNNJO6afcGq0+v7Rq001Iods3tZncRid9p93sdsGJXh0kOHS
         WL3WmUIg10SJE55lEp2ZtnSMFUbGM0oSNySSm/ERoitPR5vKnxj3FGV333qX8X8CMINs
         FTnA68OxP/H1RvfFG21jVaEx1pyEhhLiwjUTiQmFm5Khb76qs42sO4ll0Mml0ea3q3Cd
         3BYr8cFyd2tzE6Zf7DeQqYU9/cVtjG9sit3dZXErlwftsta+n1IGj7RgJ+jF7k7rtLdG
         FiILZTlomN6meCpVmitRTO4vQvkb1xPm2Q3xrMV19c2it8E8NPmXnMScRFT+eJ5H+h4P
         HQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914612; x=1752519412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6ayYvKDTLhKWG6B6PhMbZPiXC1I4Lt8zkiYPs7tjWQ=;
        b=w9+xUCGhA2dCtn3lPNFUegWT/ApTqO7q/Gc9jEey4z5MvjfARdHnwUORfh/aZKStzW
         R5EACD8nLOSCdXu0NUW45SghOa3IBDUEoDE4vhuzbK49wCcCVvvd25o/g8g/1edYvkpA
         MsdnRK0KePUcQp1jG0HU3hqMeRYmVRTi4tYiDvEgUB1di6VQxvUno2KlSxpZznaiQEeM
         4bUi/9yhCr86fCAe+XPn0gKR0cz2ty91L/gaDi/k/rhhH9TOVHBJTHxDRZdEMqCBcqIn
         DT7ruQkfJdX8mdcwIL/decbX45QdYRtzp7PA7hdRdjObjQsnHLH2/9UdIaq7ZPGmFpfZ
         HrMA==
X-Forwarded-Encrypted: i=1; AJvYcCW3UQNvBZj4lqGcokYqWpi4EDiSI9Pp6KAuKp62J+pY9mRppKrXQ5aqmPxIbz/ELwiQEu1QxN0uW0RRKI0=@vger.kernel.org, AJvYcCWyAOpuFFmdKBIBgqZ2SEK5oBniWEhzLHYb/e+vECQNVC5m1BGNHr0RJ9eposoQa/E56Hze19OpfNEb@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVJvRESe8VnmowygvxOrcr2QjAUDASLZANCgJDJsB66L1eD9q
	kKcDHskBPYrBjyM3dsrCBKCn6QHesJH9/9oNuFkGM4nW3GpkTdR65yhS
X-Gm-Gg: ASbGnct7scSQal9Xi6H1vFEgSBeyWJeLSZk3GXplLrAETYiPDQureZKSOHDvANvxx+4
	Q9XQHuBSN4by7krjFea3bSuMABN0u15ZNZ1TJq9rrna4vQScpe2Si+zjuxFSmCXfsZCoO2/jsGv
	MrUO8vtUBBCTbwhXh9DVy/2PrKNk+QobBcongtO3akx8Q5pSPlCa+Q1ij4um4ERByXV481Mu7Qg
	60VxDI2iuNiRL6RS+Hb6VXonOmYmAtRCpeh4OOb4TtJ2z+52GmGr40wQq5WDcD0yDF5S6JTJeBb
	rnXupASj2jvPf5c/oYHG7R5xeOFpm+xbeVZA1qxI4UQR/gJKjdxHny3VuRP2DrM=
X-Google-Smtp-Source: AGHT+IG9Bu90q0WTjtWxz7HDuJ2Rzyfv/8PajDWomE8All5ggz2bpklWeqOUkIt8krxiv5gByH/Xcw==
X-Received: by 2002:a05:6808:1a0e:b0:406:71fd:b610 with SMTP id 5614622812f47-40d073ed6d3mr8063252b6e.33.1751914612548;
        Mon, 07 Jul 2025 11:56:52 -0700 (PDT)
Received: from s-machine2.. ([2806:2f0:5501:d07c:d8b:9d6d:a96d:6f71])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40d02ab27c3sm1400851b6e.32.2025.07.07.11.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:56:52 -0700 (PDT)
From: Sergio Perez Gonzalez <sperezglz@gmail.com>
To: zhoubinbin@loongson.cn,
	ulf.hansson@linaro.org
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: loongson2: prevent integer overflow in ret variable
Date: Mon,  7 Jul 2025 12:55:41 -0600
Message-ID: <20250707185545.46275-1-sperezglz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In loongson2_mmc_dll_mode_init(), `ret` variable is declared
as u32 but it is expected to hold an int value.

Fixes: d0f8e961deae ("mc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver")
Reported-by: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1644958

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
---
 drivers/mmc/host/loongson2-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
index 515ccf834f0a..ba6bb8fd5535 100644
--- a/drivers/mmc/host/loongson2-mmc.c
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -485,7 +485,8 @@ static irqreturn_t loongson2_mmc_irq(int irq, void *devid)
 
 static void loongson2_mmc_dll_mode_init(struct loongson2_mmc_host *host)
 {
-	u32 val, pad_delay, delay, ret;
+	u32 val, pad_delay, delay;
+	int ret;
 
 	regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_SEL,
 			   LOONGSON2_MMC_SEL_DATA, LOONGSON2_MMC_SEL_DATA);
-- 
2.43.0

