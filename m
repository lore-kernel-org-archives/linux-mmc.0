Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02A37F73A
	for <linux-mmc@vger.kernel.org>; Fri,  9 Oct 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535585; cv=none; b=mkTpfoLL8vrQQyBIfIsyeJygwb/3BCPsquEQM5J/F8Ky70U9DcBEx2deSgTDVbZmiOlQL3CJGhk1oaVjYYmPMN45O9ycf+eKFvKya70KORidKDxCZaF/n16RP5ZwJQmeqo+jKT6AFIW3jkOg0Ka2LB6LAUdAXnnav3XuMY2KGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535585; c=relaxed/simple;
	bh=be5N0rKg83/hK2SYnT0Q3evk5ahtdilBXSVdYE9Uaf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6BuaH2VUUKW8BVkJYri7+awJ30Xynv+JA/jZU4K9HhyWC6Pi8iiPfTjLuU3xbhevOKT3bj1Ptq1sa7Kkwo0/+7HLJB9RPlW8HffurOtKmQSbMB4cnvT0VpIJchttT6X9Prv37BFCFZ4s6uCaW5ziqtr2LUzRivKPZMKG3acUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8o36bzF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8o36bzF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e49fbf92aaso24923075ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2026 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791535584; x=1792140384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z8r8TJA9PDai5V/l9Od9FfNtWGMltnJ5ojxP28WzN7A=;
        b=J8o36bzF4JqgKB3252Sv9Ea7NxnwzmGzgxsPuSyfeeOaq19Mp8uEP5/Zynk6q84iR8
         6K9KdrIqqOMi9DP/VNZFKkAUD+4R2+V4ZM+GpXDJkIMfB1DhDchjlOYb13mhsSiPJDqf
         WBeKFRhRVheS3k0xtP9/Y1u8bh6StegJh7TzlmzZ+L5QQQhyPvfAwGb9KI1tGKMjSER9
         gyXa+Wd1W44uFiMRCf0jWn8VMJfFml+rfraMeTxLBxLUjh14/kmAilDEhL3C/vohv7N1
         CLptc54871b1q4j1WXBLjydLyDtwCMoRETSPOxGir5JH4WAYYNaMiKsah5ERMvQ7WCGq
         //xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791535584; x=1792140384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8r8TJA9PDai5V/l9Od9FfNtWGMltnJ5ojxP28WzN7A=;
        b=KgILlOIFU74xbQkDGC5Fbauf8ZgYMOQQhxrrvWls8Unn0bjVOu8YZxC12K3R2JUHfh
         bSCVWjuXoQOn1tRo34lUm0JMMExdP0d7AElUwS4hEMOVsxU3z8i5Jep1eJ9cGHHgk4qr
         mDWaa/27AKcoXRDogN9qaE+AzDxHivxSJxNSZzgXKCIYde/SBADEEV8TjA1YganN0bDN
         1341M597f1z283gqQAydHYlUz2u2O8Z7BW59JzJ7sNPKkfkwJ3+nKjNOH3Ew52ydVA1F
         E2/84NaKGD8HCzUSRXDFXRQ0ufsOroaFCNy77Wmbwc3IEl/ASDQZrchGzdiWigZABiyv
         k/bA==
X-Forwarded-Encrypted: i=1; AKwUvBxPO8qePixPTJsYekScvTBDbDb4SC98U6OzJ86AYCnciPuIN9OUj4RC/fbVxneolda0lqPIFcy+bWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDTFlREz8csEWD4eOi/jmBOJ2Db2tSD/9WMUpA81XZytPCLfXm
	Jn1e13q/8KHeqwpuYmovX7QJikTei8mt8DeGBXHbFeJesr/wkmN+E1FZ
X-Gm-Gg: AYBFou0cmWgmexHgjW19/fUd2Wk25nqtZYORomrw2niHNp3ixjBQh3tUGWttaJKc6Ty
	GBJzpON38eVwS3El3Mfa5Pu+vrhwJ3rKry6bqkv2ZXeqQyD4Mvz+tW9UXuHIQ39MjnNH6y/WhHO
	9SdkQy5JpibooMC7Lwj8P3xcvife+mtvEjl5toTRcF5Uzk5yXXFnKHvsbUNMXaTf2rEzYkTjd+q
	gNvNBv4aLld6fwwcapBQheyGfKFhRROhbcOFcKUYQYAGN+VVeNJ4LCEKxdTe2tvhMlaTFcOcNAu
	ptTNWUa/2QHVOQfxUicvl7fa9eAEprb3qImSz65YyCnypIJaE59b4Nnvneo3O3mm2An8VRrY+YT
	3jL34yqLb1eXF89vwM4UZnt/bG6KOCxFT8Mlq/+3zm7ezz0YQfY2Qn/Ug1RqG+0eS8GEgDDvkN+
	SWpHsew4aOJWCXqNhwiX4aDZoRQRRx6O29haV6i4QNXiN/igY3iiwIBqBHaVps0Oh9zIeoSe+Yh
	se41lQ=
X-Received: by 2002:a17:902:d2c5:b0:2e5:a355:56e4 with SMTP id d9443c01a7336-2e8428a1d5cmr10798905ad.11.1791535583941;
        Fri, 09 Oct 2026 01:46:23 -0700 (PDT)
Received: from arch.localdomain ([161.33.202.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8419fe0a2sm5489815ad.6.2026.10.09.01.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:46:23 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: downgrade HS200/HS400 clock-reduce message to dev_dbg
Date: Fri,  9 Oct 2026 16:46:03 +0800
Message-ID: <20261009084604.385664-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dwcmshc_rk3568_set_clock() refuses to lower the bus clock below 52 MHz
when the eMMC is in HS200/HS400 mode, since those modes require a
minimum 52 MHz bus clock.  This is expected behaviour, but it is
currently reported at dev_err level and therefore fires on every boot
and on every suspend/resume cycle, cluttering the kernel log.

Demote the message to dev_dbg so it stays out of the default log while
remaining available via dynamic debug.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index c688f3eaf468..b4fb1c1e6d99 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -790,7 +790,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 	if (clock <= 52000000) {
 		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
 		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
-			dev_err(mmc_dev(host->mmc),
+			dev_dbg(mmc_dev(host->mmc),
 				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
 			goto enable_clk;
 		}
-- 
2.56.0

