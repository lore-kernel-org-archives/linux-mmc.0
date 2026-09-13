Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54CB3644D1
	for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338950; cv=none; b=Iix7ZZIKSiYk4qq++13cj+8ajq74cKuRScxB5MIU7A5z6E6cZRKWkLXGzsjbh7DdQoFqa/aWA9B4iB7KRALdJoimuyC5VzvyRCkf9iRu3CSMSMa3H6+sQ0kLlyhj50pDjF+CIHi6eKNaPU5E7jhfCrG7PM8Y2OxLnhPAVqxeqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338950; c=relaxed/simple;
	bh=fk1sBYpSwMOddhw2TIfC9bxNmD1u6xITubSBHBjorro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCwcB3+dL2LeM0Ee1/F3/uINssyMZLEdIftkOD6o64HZ1KYDlT3zhh3X7X++nAgTY1LUaU2ctnAeyQXPEG8paFURdQJmCLqYZyTNK8p6Ie+2e50a/CnpCQ/DoNENAoMxQJI1gjuEhA23uGn//8fzZB0iypojkoBfGTP6bk6IVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTKAnEdM; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTKAnEdM"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb769ca17so18515331cf.2
        for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338947; x=1789943747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6tmc56vt785H8n8sw3psZCoq4rEVXID3penocU2E4Lk=;
        b=JTKAnEdM2zrVaiID1nNusOq6p+LmrdVnGlrsgUN/qjE4i9uKS+3bYtIr99bBtUUkya
         jqDjUpQLcrI6lnLTAuD0ponLFxjcZCzYlpNcSHylqXnI617SeUUuFRaB8lGqczQnWN8/
         OYHSNluTwvwVWhf0IACee0Fn0dtlnZ6eJs1cGW0CRe1VsjSEPcOkDVP1xeZJrctpksHT
         1zxaZyZs7hLSetGbeozhJjOIro793loMmVcWfk79Fz1dhGTdcof2vKfljQdeLJuAhm0g
         6Ok+oSZjfEBF/8YGw4fjUFYmZYrKvGklRzp2BOQ+TLJQ18a1LKe/ybA5ZDZ3cd9JG0ZH
         97xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338947; x=1789943747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6tmc56vt785H8n8sw3psZCoq4rEVXID3penocU2E4Lk=;
        b=kalW64ol9zYXWigRyg79qGYbQr2cCpONMJlTA7AdA6i+kaPvthVzL13iryN3uyHsw+
         cLwhl5ReC+ve9Oed7SNLtSXRlLRcltC1qfnEYk9K6xCxcSkvBunVZKR4UhGis8ZJF47o
         k5zSm2zveVfLGZdTzdrxpsXzAlUYdDp6uUx2yNlo26yUzypjpXrBo3w3GzsR56Yy/Dbm
         l+7V/TtbRxPGNkPDUkiqUapdn/YjxbShQNAWS/+cKDd349xPnnTgUwBsfJQgMf6v2Vg2
         4yM5cSjWn4mEOBBNcD/58BBn4PojfZDlB4n9+ibnAa1y1IsbI7Dv5klR/HCqXVgDEiCh
         5daQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLSAq6j0tyzsFdS91W/Pg8vgoGCswYcC6GlZ7aiaiRZnRkJC0PoiJdng1GTZcohrTOy5uUjQDbkKo=@vger.kernel.org
X-Gm-Message-State: AFuF++kzzIbE7nQHy5yFLxJvl0VpF3oTKsSejKZe+hRfoV6lpYg9D+FU
	LynMketexA/Ix+zA9KdSp1P3EA9awxFMRQ79he4kIPjWpOQkUxaUNNg=
X-Gm-Gg: AYBFou2MtRoBwTqXGvYfJzCWPVCJQYlqZJEqGl7U/Mqem+SfP7Bi4Lr7bLt83YPiHIt
	gX+Mf90Bkzx2F0NtvY4gT5Jtso6jaijg7sjmUbWn8Txnmpz0mRFYVJCKpz7aEmWmt3scn/mLZs0
	RvKLz4YwVF6K9xJIAURfisMX+rOu6P6dodJa7fnoRAKWIJZPOtWHqlFGUC9IgjjhJUE5vFx4D8G
	AiWe0mhwLdrNRvnb2xoOs5a7MuiuObe6Myzlh8KlOor5c8rciUmTdrTyz3jYKS0+us+VJhLGTy3
	FEAkvGl+kJb1Py+YUEixLtRVGNESefePa4jGYYx3amBxbJN9XhSpN0ffbikVarq4rLyBO5nTv+2
	3FjZ4Oiv7OjfUsKJEuD2wukzde8TZLtn4fwp9jbieQLO3d5IHrBaxOosaCifU3eWwVzSm3sCVUz
	rZHty1ktcn6uYgahWlRwEB5iMB8lTmZe9hcXM4uGtw11vtUCn3UcE0KfUC4J2wTFPP3JvAmYpFt
	lfrbfoDQyCUPUWNKBwDfuA2H33b5K47Osauv93eDYNMMtS2OZWr1HzD5UMtrn68CIspejdfCC7D
	XePKFo4tlmywj5xoo4b2VRmBfki3AS2zUw==
X-Received: by 2002:a05:622a:11c3:b0:530:eb9e:63d6 with SMTP id d75a77b69052e-5310d09817amr342871cf.49.1789338947507;
        Sun, 13 Sep 2026 15:35:47 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530d5e946a0sm71513481cf.25.2026.09.13.15.35.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 15:35:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] mmc: sdhci-of-aspeed: Remove children before releasing SDC resources
Date: Sun, 13 Sep 2026 18:35:38 -0400
Message-ID: <20260913223538.91579-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe failure and removal leave SDHCI child devices registered after the
parent clock and managed resources are released.

Unregister the OF children in reverse order before disabling the parent
clock on both paths. Use of_platform_device_destroy() because manual
child creation does not set the flag required by of_platform_depopulate().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: bb7b8ec62dfb ("mmc: sdhci-of-aspeed: Add support for the ASPEED SD controller")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Assisted-by: OpenAI:GPT-5.6
---
Validated with an ARM64 W=1 object build and strict checkpatch.
No hardware runtime, probe-failure injection or unbind testing was done.

 drivers/mmc/host/sdhci-of-aspeed.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index f5d973783c..d317626feb 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -560,12 +560,14 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
 		if (!cpdev) {
 			ret = -ENODEV;
-			goto err_clk;
+			goto err_children;
 		}
 	}
 
 	return 0;
 
+err_children:
+	device_for_each_child_reverse(&pdev->dev, NULL, of_platform_device_destroy);
 err_clk:
 	clk_disable_unprepare(sdc->clk);
 	return ret;
@@ -575,6 +577,7 @@ static void aspeed_sdc_remove(struct platform_device *pdev)
 {
 	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
 
+	device_for_each_child_reverse(&pdev->dev, NULL, of_platform_device_destroy);
 	clk_disable_unprepare(sdc->clk);
 }
 
-- 
2.50.1
