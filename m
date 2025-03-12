Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC8233701
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781853; cv=none; b=nuEU4z5xBk23K/o/sJwWdDGNi5ZzUfDavd6jE2ReMsyFS7Rjo7Ree4Kz2Vux2vsvVwVK/IviyYdgkX/Mc9IPtBdsr0aMC70mHSxTsW+BwBIzCseLh736eleodn4OT4K6jw222Lg1OltwYVpPz0ZNOIK9Tv0eQsQpr/IldaAJRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781853; c=relaxed/simple;
	bh=rdXkNKeXWew4xzAG4PBwkY6uv6kSEtbnc7+M+xTZvM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BImVGCXcawAyIz0kRitj2zGEV9ds0xb8oUXcYjaVFLptwNE5bwq2kNdThHPdKOO0ihUx5nSOtokPAtvGqzEqJz1BCvLuAMpwihydUXaFj1mvL3v+tH13Hzb+f59N6xFsMrXrIb16XKKZZ+vt/2jPsigVxuAhVEBC7T+9Zfmka/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLhzbbYI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLhzbbYI"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54298ec925bso8937144e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741781849; x=1742386649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++pmmtfiHftyIXzbe5IYh4I8mfHiSJ9y8MZc6wxAQdI=;
        b=sLhzbbYIK8Jc9gW52WOYfpfaQvCXkQ9NOebS41of+TlLpKOd5NBfBnfOpX1rZOzNFr
         mty0bYN8PG393RfAo/n0qukvRTDIPsD3kjudRUB9B7mP4E38iT0kvNNLjiRBOlf/j90F
         myw+YKrg9qQeZbfIZ4Zpp4Kb3WqozAewElCa+SmqsHOFHYCwgb+pVTUqW8cXuU2V2ZI/
         6hcrO9iXTadlk8B3MfZXc9i1Xg9qZqn2j5WUiybnrhFwSYrT8ted0c6svbpki6R46r5O
         VRM1qJkUvFeLVOP3nKl3zvmDWs7uZKYFRqkUNJ/Z7vva87ah09dIZjzgjWhFRmZU12yO
         5HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781849; x=1742386649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++pmmtfiHftyIXzbe5IYh4I8mfHiSJ9y8MZc6wxAQdI=;
        b=ZLdqpOb0xtubwq+ue1rnWUvLvaxVuauKoIFhHBsN74BDxXsuyJo4mCq2lSzKhm1+Lt
         82MjVpqP7vHTsUlPbcDzKGKLMzh2fL+xPLCOH80sjdLGFSAYAaECWbHZK+x/dU6xuMyX
         e+qdzPUn4e9QOPA+GA05JK4S8KOfNv3+cznKYl5FlaSsmsXrvH77vTI3e6Jy45UrJkLH
         kkasfO14WwlOD8UAuoQMKHFOpiFHSzi8P5nob266XkqjX/nms/FkAzwIoZROQxmGdpt2
         1awE+a3XixcqvydzOISg8dvbm41p4g8XcnNW6nKbUqOe7Yc5afan2aFPi+H2SotttV/5
         paaw==
X-Gm-Message-State: AOJu0Yxnfx4rlmYLsVjhzC2OjrP3teVVd/g4Cgpwr/HNkRBmRKPjr+Vk
	5wVeI8ZajrUpX788YwQCeSIvQsW9vdnxZzATEFbXbQzEmEskmSiUmeux+zegnCXgxuxQ7aUnul4
	6
X-Gm-Gg: ASbGnctTwlQLu9V6wKMmQqdOXo2CN8WpTlS1qk9D6wwKFdwlil6D4DDvH+nIrcMw7a2
	JDdlhbPJ8w3R4sZM0dV2fc17riN3yycmpdOkaPtL3yakjt6J+JefZSqIWAaAgJOnFArW737CZuC
	vnC7vODyqwjX/5Hn51GKm/276mxOenkp1NUBTnTv2QdpTe8h5pvy1cCP14Bw+1VebYkLkj4OQas
	2YEGkNgtgnrsFJa1zWLdJDuxI8YbSc+0JqCvDTwCyjf95tKl7AgdKMAcStvumcUnAHUpLp0R5p2
	FFW9wIUSG2HwLfey2zbvzGBsTJM4SJIW5iVEeaWmkMKeRwqurQIZdef8sLxOE739xYiMc+W8mXl
	hbRG+Jv1s/5IMDJn9yp8=
X-Google-Smtp-Source: AGHT+IGnwuT9UHbasvv/nBdAIly8F0nWcdTRH3MqDpJZ5s98EGwTiAiir5kSAZQLl8Y3LblOfs03WQ==
X-Received: by 2002:a05:6512:1255:b0:549:38d2:f630 with SMTP id 2adb3069b0e04-54990e66e97mr8347422e87.24.1741781849005;
        Wed, 12 Mar 2025 05:17:29 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae46261sm2102082e87.27.2025.03.12.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:17:27 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>,
	David Owens <daowens01@gmail.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Romain Naour <romain.naour@smile.fr>,
	Andrei Aldea <andrei@ti.com>,
	Judith Mendez <jm@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-omap: Disable MMC_CAP_AGGRESSIVE_PM for eMMC/SD
Date: Wed, 12 Mar 2025 13:17:12 +0100
Message-ID: <20250312121712.1168007-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have received reports about cards can become corrupt related to the
aggressive PM support. Let's make a partial revert of the change that
enabled the feature.

Reported-by: David Owens <daowens01@gmail.com>
Reported-by: Romain Naour <romain.naour@smile.fr>
Reported-by: Robert Nelson <robertcnelson@gmail.com>
Tested-by: Robert Nelson <robertcnelson@gmail.com>
Fixes: 3edf588e7fe0 ("mmc: sdhci-omap: Allow SDIO card power off and enable aggressive PM")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 54d795205fb4..26a9a8b5682a 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1339,8 +1339,8 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	/* R1B responses is required to properly manage HW busy detection. */
 	mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
-	/* Allow card power off and runtime PM for eMMC/SD card devices */
-	mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_AGGRESSIVE_PM;
+	/*  Enable SDIO card power off. */
+	mmc->caps |= MMC_CAP_POWER_OFF_CARD;
 
 	ret = sdhci_setup_host(host);
 	if (ret)
-- 
2.43.0

