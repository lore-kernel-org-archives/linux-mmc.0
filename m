Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797302;
	b=Q+pSluzw0Otyea/Zfsjih5r7DMjTg/MePgTeobDSEQ2Jk+E9ZWslcw6m725EiisczqiU
	 Ix7nLe2HgWCGilwMA2aH8cSTrwHj+ivuYWzsMPlGBXvp7FczxoOCiaRsA4nFyEzSmpCCK
	 QHj85AijWXX9QcFZNWroVeQEHJjtlbzBtJGp2LxJiLJc/ReCt1roGsgkQyxClpjTjTArI
	 SD4x7pTerqSGOOcWCMt8prXqL6TfD1xeHi9guwUTjQK/aGlEjacbEOxJJtOwXStzAQXaD
	 OD//IIzbGbEfPwh2E/DJDi/YT8Hr5usZ47sQJKRSpa0kB6OB+zrKlw5n2tygG4aqlnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=08/+Tw1oVd8ocLS95JJDAmqhnR/TTdXdQcTFOlKFwGQ=;
	b=YPpZEU4JSNAa3MTYBe+o2ALLF/HxT/0j/gJY13ZHSwkL74+7YR52D4KgDQTPUVRsKmxb
	 38QEpJHvipRs4IzizrSnEDgYur4eKFXQJ3t/1/FAklJkPZBHAm0uy7YtX8HDy2hecLAw/
	 wLfLiN49R01amvgHE4vF/OGZR3cYTygaxKfMTJXWRFyh+OpqaetqdIeRkTLRC7xLkxGh1
	 pF6bOlJ6xzUU9wZMIY+nj3fuureR2ToYHjq3uyeEpxNiXP0eeylLEs7bCxZ0sV3AmNdoL
	 hp/F+XgRUzCt8B8e91RSUnrZMuNsvGMDLGgQeYiyJLg9rDREglub5p+OrYH3whTTQrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HZ/x4nYd";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC5606A31E
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 16:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9DC5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZ/x4nYd
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f03920c477so69516435ad.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 08:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795797301; x=1796402101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=08/+Tw1oVd8ocLS95JJDAmqhnR/TTdXdQcTFOlKFwGQ=;
        b=HZ/x4nYdEFjLN0H/Y+nuL/VXorbJWVqyhL3/AaIpw0FNAqNJtW1POFVnP2dIpfIPHd
         9RddiArK4HpszxhjFlFHVN5yeim3bWwcMl6xYbTU++uhfWqmaHBgcv1QbPUU+RLp/pz4
         QkCp5Cn8IStarn3NL14VP+a7hj5Z62BucX9IXG93eGN8fBQltS/m2ixPEDXM7SDEOZsX
         /QeW1fc2SFRNihMJYkjEzWvWXsp1nyIdkJcFHTlc2R0cl5A/hCHzrNx5jvYEJQqEagjp
         9KBFSk4v8oTLlRP5FIgdGzEDca7+1Tf4mgYkK77ejnJlklIYhvsPScUR4kctdeeP9n8q
         myOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795797301; x=1796402101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08/+Tw1oVd8ocLS95JJDAmqhnR/TTdXdQcTFOlKFwGQ=;
        b=WvIdVpJCYTF3peItW1LNZ/0KkYEb7Z1EOAy4TMsTg3ZTQcGFuQdOUrun4t5VJbmc/K
         qix8dugItiIcG6um+DqCuLUvsxgKPbzpO/hhrNbElRuRfUWVVa6xjYxgE/xVZz7aSgJJ
         npnLz85GLmd+x8mSGovhNA/AADnvIrdwGak6ZOxBtnunSzBBmuc0ASS/jazfDQFXeblj
         RRJ0BI2zzZGAz4RhKIk26ZTsTDZFPhwAaQQ9SauqxAqzD9oPv6qvDzb1pXCyVBhX3zIQ
         3/daXePVvqFr2SOIq+Ed/K4DiYDsPRAzdSvJjhFYe6O84X90Lwh3YlVpCg1ccho+G9J6
         hPzw==
X-Forwarded-Encrypted: i=1; AL+hErFeOcVxXVSO39wPAPWWI5WpY3XPMaXSZHPtoFkcP1oNZ98dZTJPY9qLi+szMp/nB8tXJ6WFpjjJeLA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6MLkX5MGJUl48tja8QlJZc3KA4NLR3y3jbllqy5Ij8Y40ukQ8
	IqPjbt6uIarsVetwxp3mF8eO4tFoV+trNQHlJvj1/o19jaUfLEMeAVCE
X-Gm-Gg: AZFdTZcEQZa5Yrw0xTrJ6t0ULizhNArb9XyLWCaBTzlwRMsVUKRcelaONIfFY9EEhGo
	zn2Nbg6hzxoeQDP3KkYd0i4ijf9qkxrop8Wo/9PDazVYLOUS5+FP21VzPr+NkrqChaXBXHlcnDM
	aklaCLwokigdVeYhplQJ/hrlD2Kh5cgkjfcxi+LdzeaILzpL2LQWKwWikkYRJ8fPYRaVzZSJgO0
	AlYbLKS2x4lM5WKnPHY9gOanbLl9J5BKJ2gupABUjCaH7oAPNAMSLY+SpIV7O9WTVeMYIXcmjuD
	LMAeNfOwqrtDnAuR/LIP+4o6LVFJz72yfK3W7XDOF4vaiogkb0Va3Skew0D0gNLmEqGiguj8dl1
	hPndm7zS7CRUaEaXTPXSrzWhLpu/0uSUVteryvzmimCuPITuRLO9fih6PxqKz5q9NRpGDOd1WuO
	43UF7JRz868Vl6qvxAAi6nH7FAcPQv4wiPEjRiH7OsaD5A/nDqRX0oWsp7MzWSU89sc9czk3Euc
	Je7pva7GmtI6i2Wur1r277B16LabHNvoKOHghGhf4O/gFxu4nuTu6own+3IAvXebFehLO4oDj0B
	zqy5CYfaSsqUa0sJTrRsYlhZzk0JhXFNszAmDsNVRIWyrS224o2WFaGvMytegHpXQH/3+XarJab
	XVohVqa0ZEwBk8ErkzsWluRbmUL4YFRG5wjgS8Hr9K39rps745vR0j+vAiC3rfg==
X-Received: by 2002:a17:902:e80b:b0:2ed:2b2f:8632 with SMTP id d9443c01a7336-2f03f11e582mr276703145ad.22.1795797301078;
        Fri, 27 Nov 2026 08:35:01 -0800 (PST)
Received: from localhost.localdomain (bb121-7-41-33.singnet.com.sg. [121.7.41.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f070a12491sm100482945ad.8.2026.11.27.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:35:00 -0800 (PST)
From: Suyuan Wang <shyckless@gmail.com>
To: ulfh@kernel.org,
	adrian.hunter@intel.com
Cc: konrad.dybcio@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-msm: Disable clocks when runtime resume fails
Date: Sat, 28 Nov 2026 00:34:47 +0800
Message-ID: <20261127163447.238-1-shyckless@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suyuan Wang <stevewong@hust.edu.cn>

sdhci_msm_runtime_resume() enables the bulk clocks first. If restoring
the SDR DLL config or resuming the ICE fails after the clocks have been
enabled, the callback returns the error without undoing the clock
enable. On the ICE error path the OPP performance vote also stays in
place.

The PM core then keeps the device in the suspended state, so
sdhci_msm_runtime_suspend() does not run and nothing drops the vote or
disables the clocks.

On both error paths, disable the clocks first and only then drop the
performance vote with dev_pm_opp_set_opp(dev, NULL), so the clocks are
never left running after the vote is gone. On the DLL error path the
vote has not been taken again yet; the OPP core returns early in that
case, so dropping it there is harmless.

Found with a static analysis tool and checked by hand.

Fixes: 21f1e2d457ce ("mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically")
Fixes: c93767cf64eb ("mmc: sdhci-msm: add Inline Crypto Engine support")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested on arm64 (W=1, sparse). I don't have the hardware.

sdhci_msm_runtime_suspend() also drops the vote before disabling the
clocks. I left it alone to keep this fix small, and can send a separate
patch for it if you want.

Changes in v2:
- Disable the clocks before dropping the OPP vote, and drop it with
  dev_pm_opp_set_opp(dev, NULL). dev_pm_opp_set_rate(dev, 0) does not
  touch the clock, and calling it first left the clock running without
  the vote (Konrad)
- Link to v1: https://lore.kernel.org/r/20261124-sdhci-msm-v1-1-75c70ed6569f@gmail.com
---
 drivers/mmc/host/sdhci-msm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 32b1bcba4..967843a30 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2978,20 +2978,27 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	if (msm_host->restore_dll_config && msm_host->clk_rate) {
 		ret = sdhci_msm_restore_sdr_dll_config(host);
 		if (ret)
-			return ret;
+			goto err_disable_clks;
 	}
 
 	dev_pm_opp_set_rate(dev, msm_host->clk_rate);
 
 	ret = sdhci_msm_ice_resume(msm_host);
 	if (ret)
-		return ret;
+		goto err_disable_clks;
 
 	spin_lock_irqsave(&host->lock, flags);
 	host->runtime_suspended = false;
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	return ret;
+
+err_disable_clks:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
+				   msm_host->bulk_clks);
+	/* Only drop the performance vote once the clocks are off. */
+	dev_pm_opp_set_opp(dev, NULL);
+	return ret;
 }
 
 static int sdhci_msm_restore(struct device *dev)
-- 
2.43.0

