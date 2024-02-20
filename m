Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEFA154BE2
	for <linux-mmc@vger.kernel.org>; Tue, 20 Feb 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469929; cv=none; b=Al2e9YOmt4dhpCLCcRc0tJ+Lr248ZPI/3GolTSr12R+v2u9ngtGL3wlhIOhzLu5Qh0MI2ZybL+mN15q5ehI9lHTAmpjjhLQV+Wvj9YV+Yphm/EQ1c48UqjI1exXTJmW8PcnS377SNi1XR4e6uM7AylX/EYPc/UNJomm9KZDp8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469929; c=relaxed/simple;
	bh=2KMavfot7dn/jSlYRp4vCD7QcIkkOuyAV9KqDkyaykQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UsAcGGhE9jsBTx8n2+PJkiyZY5dDPo/chvAbUtquAetEqrgeb1/ydz72DFYE/A1QlxdhIyPFKEngvotcPxuifKGt/lEq4z5Mbzo+rT6lom+eXUn1HNQHQaaz2OPJTC/eKiFWIlXnbp7+x77eiCK/F4fTrEQ4gpI8O1b03vC1PX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gdzK+hfx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdzK+hfx"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e82664d53so360401466b.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Feb 2024 14:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708469926; x=1709074726; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUcIEfTpYZcXd0dHJfdR5ASrz4snMW6xTMGC+3CDi/Q=;
        b=gdzK+hfxp3w//WJXkZf0jhXFjBXCszr82lsBlru4jGHjsZixGxF/FMG39fjEoQlR6p
         JbcZ70CSIK1KcZKxcp6kTnh6LMmENu8Hq5a0smyGD01m1qiNs3MT1QkXiTmqBIR8vhv0
         PajGMh8NmCv/TDVCjLxi7eOxeFnXqt7SWRXzwphZ9QOz2/5/hqFMU20XQ1kO3+TIGuQc
         Gt8zK0K4MT1UyvvPqnB7lREYMs8yBjJnt56ckAQUjB/AFvk8dCMZllJ2pncaaSUdohlZ
         tAhQFZiRzGVRkpz08R/Y4TJfAIUjY9CmRA0T8ZBXwNtrDH17/ZBYAiQJrgWYwqxuDHxv
         271A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469926; x=1709074726;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUcIEfTpYZcXd0dHJfdR5ASrz4snMW6xTMGC+3CDi/Q=;
        b=rmgvF7pUtMEeN/YQ1fqJbOVfItB0Bt4tZVyjp3s/BfCQhXI/EkmLrzzysHjjfuGgeB
         bID+3xZ19HwoUghGwTI9UwReaBvk+Ey+WKsdeAAQgoIjBZUZZaV1uiXxmSr4IXlx8PqN
         7B/kvQt4c+S4IVQdS+F1YaX6Kij4IVK46vt3n8W1/N/jX7zySfnY2g1/6WpGhsLuiUYb
         p/qvf1TSrPILgLdI8ahi02Bigd1b/5sUGRQFADM9bJqSW58/HlyhjtlPrhJR7RKHd+ZW
         ZA1PNt96jdv1EzuyHUSc9R27k4H89F6Ec9N0ly94dhzXpqPIh1gz30IXaMUe7ilInZt4
         b1yQ==
X-Gm-Message-State: AOJu0YzO4pzezS1YhC6N85ZiYjQvIMxVsQ7Uv5UCZnM2hjXPFwok+ny2
	tfitju3gHYjaWK48ekI5F2KoiKxHWgPEA0E03ve1UU/rZyRev8gEQ5WouQA3HBU=
X-Google-Smtp-Source: AGHT+IF2fSCulCys+V0r+zufqoHv/4IUYP8LW9DrBLQfm3rB+JxNdqLqcpFaKpM80DQhAG7gS+CJaA==
X-Received: by 2002:a17:906:e2cb:b0:a3f:175b:ea91 with SMTP id gr11-20020a170906e2cb00b00a3f175bea91mr1274492ejb.13.1708469925781;
        Tue, 20 Feb 2024 14:58:45 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id tb5-20020a1709078b8500b00a3d599f47c2sm4417614ejc.18.2024.02.20.14.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:58:45 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 23:58:45 +0100
Subject: [PATCH] mmc: sh_mmcif: sg_miter does not need to be atomic
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-fix-sh-mmcif-v1-1-b9d08a787c1f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKQu1WUC/x2MQQqAIBAAvxJ7bkHFkPpKdChdcw9aKEQg/j3pO
 AwzFQplpgLLUCHTw4Wv1EGOA9iwp5OQXWdQQmmhlEDPL5aAMVr2qGcrHRlhp8NAT+5M3f+7dWv
 tA64RybheAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

All the sglist iterations happen in the *threaded* interrupt handler
and that context is not atomic, so don't request an atomic
sglist miter. Using an atomic miter results in "BUG: scheduling while
atomic" splats.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 27b57277d9ba ("mmc: sh_mmcif: Use sg_miter for PIO")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Geert, it'd be great if you could test this!
---
 drivers/mmc/host/sh_mmcif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1ef6e153e5a3..669555b5e8fa 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -607,7 +607,7 @@ static void sh_mmcif_single_read(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		       SG_MITER_TO_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_READ;
 
@@ -662,7 +662,7 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		       SG_MITER_TO_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 
@@ -710,7 +710,7 @@ static void sh_mmcif_single_write(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+		       SG_MITER_FROM_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_WRITE;
 
@@ -765,7 +765,7 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+		       SG_MITER_FROM_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 

---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20240220-fix-sh-mmcif-49c1de70c5b7

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

