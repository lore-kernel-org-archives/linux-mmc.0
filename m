Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827771F94D
	for <linux-mmc@vger.kernel.org>; Tue, 26 Mar 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471714; cv=none; b=p+TXy+SuzZam6Lvx+lHC35aUemczG8joF/sGOxJwEaAIxjy3mEQaEOD8SphZ2gwrgznD64E+s3Dq/TnJC3Zrh2tLRNSXvvB/A9zkfVGVCVhttsiUuAhjIKJl05afnzM9NnnrBbtMlMbHw1fUARSiRuK9YCyqnvoYQXI1qfaIzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471714; c=relaxed/simple;
	bh=UCmlrZz5wIpqDNxx5pcqKcqwMTpJe2YHlubTTGszCI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCh85HdqifSTqJ/eKAef8FqyIpRVAeYEQhYyVKnQc00RN/BNp55hT/EgTbidqtKgIZ6FkZNpPxyCf2xo2WLYgtMoPJ3u0LqUuzkX4fNgHlT7gVUvwErB+beydVu4wAd9CnkHffcUg6utfYvrkynUFSJd8vw9EwLgtikaXhwteM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NgAbQoFx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NgAbQoFx"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41400a9844aso38854795e9.0
        for <linux-mmc@vger.kernel.org>; Tue, 26 Mar 2024 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711471710; x=1712076510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUX0Fe8KaQL1u5v0D+HurQZKsoXBEzxwHFFOyTDa+54=;
        b=NgAbQoFxb03SX/9WndFalmq1spl8kPkm8Co80Kl/iEiAXQgu9eyXYsR16IuF79Mu2l
         vVsKzvybRhPPI1UU3TRcCt0OL9LCb88a2HBI7MVAorKO1CwM4V+su/svPPPPBYeQOJU1
         3W49J3Yw29mAlnwrgIf8CZIfSFnecK/wEuIgg4mrfpUIVJfx9+tfqHKwCU6pgGHkgCIP
         MExXknojh+gorKZBes63BoF+eVHoc46fecgxFU2kzpkXWFVQlC0XggMLXOwcq3lJGbyo
         xt81qwfWHd0xPsAztrUHj9mWSHgrfrPe3s52kF+7pKtPGmodTEYiH4UwzBP49SutumUI
         U/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711471710; x=1712076510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUX0Fe8KaQL1u5v0D+HurQZKsoXBEzxwHFFOyTDa+54=;
        b=AObxIV1dPOQJYtpv/AVNrtfK9IImwjYgg0Buhks2DYsgguRJDS6/H5HJA0z9TcvcR0
         bsjh0x2Fnqh1Fdvab3hASw1LAnhrbZJioaZwGY40ht5c8a/BwK9zG+QiLLiLR0jzacW6
         DhA1sXZ4PFRG44yzdfRl5pK/cha6EH6aeROzJq4bC/o1sQVcFVTHhC1ieiCLZJ+NJXEI
         NPIQSVok5je3uK7GXD4CZ1pYwOCnkVj9WM7FgDCG1PmBtVbAZQkqNfffjinBxbPe2Z8t
         Q5UMDjNQUvJAx+OTiR/inAK914BYsjNktWJ13+B7bKu8Pc9X9ss5THyroePogUeOrJtC
         KQKg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ga9ejaG5JrYqAxrEy/+2xoZl5nVifef7bgdPsXjdgFcBUIPamEdSlhSwp0Kr2WmrwqlcIquKEZ7FkK+syc9rvEjKcquWb3lM
X-Gm-Message-State: AOJu0YxCsqUX7vYHCQDjYasVmJ510ts6xWbvPONCTLC/I3iPsikUSEGZ
	nrIKaNdObMG/aSzBMHFZuerOiGvFra+AkA/vEQV29/1CHVPbik42b9w34zIe/cAWeKXSCAZHbdw
	lFHwhpaRD
X-Google-Smtp-Source: AGHT+IGSD6SX1h+XJYSDCQWy+wNksm/8PaF5+BJG0gN4k4HXxpQXN5S50Qe4XQBW+X7oG57o0CzNiQ==
X-Received: by 2002:a05:600c:4e14:b0:414:925c:a860 with SMTP id b20-20020a05600c4e1400b00414925ca860mr353338wmq.11.1711471709882;
        Tue, 26 Mar 2024 09:48:29 -0700 (PDT)
Received: from yamato.baylibre (alyon-651-1-22-137.w82-122.abo.wanadoo.fr. [82.122.123.137])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c4e8a00b00412e5f32591sm12135535wmq.28.2024.03.26.09.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:48:29 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH] MAINTAINERS: update Angelo Dureghello e-mail address
Date: Tue, 26 Mar 2024 17:47:33 +0100
Message-ID: <20240326164733.15271-1-adureghello@baylibre.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update my e-mail address to adureghello@baylibre.com.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..c3e365b9d759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8512,7 +8512,7 @@ F:	Documentation/devicetree/bindings/crypto/fsl,sec-v4.0*
 F:	drivers/crypto/caam/
 
 FREESCALE COLDFIRE M5441X MMC DRIVER
-M:	Angelo Dureghello <angelo.dureghello@timesys.com>
+M:	Angelo Dureghello <adureghello@baylibre.com>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-mcf.c
-- 
2.43.1

