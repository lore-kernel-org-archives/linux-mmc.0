Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937D28D8F1
	for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769659176; cv=none; b=bMPMfKCFI/zELAyBlKqlnuBexBt2PJC1OiXE2I68eKluHWGFIrcBpirSSMRX0mkHBamKcDxjFB+h20HZ1k1oWGzoeIfWbpvs28WypzhCa9DR5zdbsbfwZet+thFhI0xW9eHtahubqqRTUEtNsqVxrveh014/TWkuHKbji3Ex9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769659176; c=relaxed/simple;
	bh=5bdmB25tVaWd8+gOnwukbZvqaaCU2a5c3UopFBfj1QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDhAM2/DFj+F1naPFwy6Dq/+qolVAFpBThhfl2Rd4h0momFizH9+DYJgr4hBxb5Oq9rIlYOFYfrS7frfLZJBbrOZ6sPXMqADQ6czEK5DVHOVOlMyeyrpkJxpQi+VrlQLsB0vogsPy+RTLaaF7yYzkDz8iJbiVwPvjJVSzshPRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnKZIjZA; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnKZIjZA"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124afd03fd1so802206c88.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Jan 2026 19:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769659174; x=1770263974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRHz22JTQQqshfZxaDzpPbMH6KcD18UIYRklaLC1nf8=;
        b=fnKZIjZA5FENaIAhpXjIWysEtmJtzm18einXRr8mKZSm/ivkuTS5eOALK0Tv3QwNNq
         5LCVOfTZ55l6+TlnXCMPiJx16k57W66HGUtX7oBxbOuxVH1Mbp3XjCvwkHb8m7pDEJ3m
         QX38jyHmVvkvVxveOpIjl7JdTLFWTPWF1G+QWyqUb5kIehKYUgxfdPlMX3dCZxOqZsE8
         L51D29opG/xFluR9/NsosZYziERZ+hQghXfCgdSsLDTiSphBIBGLirG7i/PrsKYoXa4n
         5oidgAjSk268WpqwlJ2YPCRAO2X9LowLMJuXHZB2JnpnKn2wbEoxA2VE+M5zIHye70V0
         Xg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769659174; x=1770263974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRHz22JTQQqshfZxaDzpPbMH6KcD18UIYRklaLC1nf8=;
        b=Dr312d8axrX3WT4qet+/cg686echS5QbEArkO317DJu076JhE0f7Q3hXNX5Oxi1B5k
         C13UhZ4To4jyJ8fxgawlbSBR6E5yCgLI/av5rVC8br0h12rWXdaxCrj2CfF8zWmwQQ7D
         YMsIV8dFvp6y1JuWhu4JVacjkoAh5oBazQiv5wh1034+OTTC0C0EgJ4oHcyl7v+NAIIf
         Y9qKNNtsUzPNryP4uyUxPcXaHYnMUIPqEgcdKu68VJPJZr70VqVJObDHdeqMPqSM8ZYO
         2ITNB+33oUz7HqYhvMnZgLIUSq1BLLlHZBQUihx3rGsSfcvqW127DBWxhZIjLB1+3xvA
         H1pg==
X-Gm-Message-State: AOJu0YxXq0gVixVzvsdTHAURsijvc2F+YDNv0VQWm7hBYIu3MQucN2Uh
	bIP+zZRw72GxHfBtTmJh+hMZyLqu8bZjo8HZlaEk3T6KSWpZERK4BJ+lwsSeThxV
X-Gm-Gg: AZuq6aLuZXhZ0KZr6N6UXcSS9NjQKi5atemyPumfwcXtzI2vb1k4Nb/eDEPsiVgtqyK
	8m2S9ngt8NbFn1hho7DTiVtXITeR8WXHIH4FR4nq2w6CLM0VXsn/irr1Od3l+wONdoxG7usEs7a
	jNFX2QpW18eYlNqoCNdm5SkHDxmoJbzPyhtYUvFFRcBQk2eW11oyxpkxmqe3wF12E3uMJ5MrqDI
	P9f9ZHQFHXWRFJ4J7pBeulUz3rYiyjyBV1bt0I+ZPqgvm9+rizdcGj6yhEkUJ40vm15HVBKNF00
	E4oy7taYRIzpjeGJ6V/gPaYisPFntyQG8yI74YdiYz4GscQGfGPVwTvipAD3IURpd/kgHGu1MuD
	V9uHou/rjvIDhMq97g1nu9sUmpndD7LBm1teVU70tCG18N947nE1o/dvDvTZSWeQYFx70S/E/LI
	n5wHkct5oWCFvVwstSdx9ClpBzw9XiQog=
X-Received: by 2002:a05:7022:f85:b0:119:e56b:91f2 with SMTP id a92af1059eb24-124a00d087fmr4660148c88.35.1769659174376;
        Wed, 28 Jan 2026 19:59:34 -0800 (PST)
Received: from valhalla.localdomain ([201.75.187.231])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d6b663sm4882289c88.1.2026.01.28.19.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 19:59:33 -0800 (PST)
From: Andre Korol <andre.korol.dev@gmail.com>
To: ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andre Korol <andre.korol.dev@gmail.com>
Subject: [PATCH] mmc: loongson2-mmc: drop redundant memset after dma_alloc_coherent()
Date: Thu, 29 Jan 2026 00:59:17 -0300
Message-ID: <20260129035917.48080-1-andre.korol.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_alloc_coherent() returns zeroed memory, so the memset() immediately
after allocation is redundant.

Signed-off-by: Andre Korol <andre.korol.dev@gmail.com>
---
 drivers/mmc/host/loongson2-mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
index da3daab5f3d6..026cbd80f114 100644
--- a/drivers/mmc/host/loongson2-mmc.c
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -846,7 +846,6 @@ static int ls2k2000_mmc_set_internal_dma(struct loongson2_mmc_host *host,
 	if (!host->sg_cpu)
 		return -ENOMEM;
 
-	memset(host->sg_cpu, 0, PAGE_SIZE);
 	return 0;
 }
 
-- 
2.51.0

