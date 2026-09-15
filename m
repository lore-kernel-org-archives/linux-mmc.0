Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49A421224
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489198; cv=none; b=qPAKz9lR8tD0zGtTsY4+J9R7LY7LAI1Wke4Hz20n6EkALeLTJYopNkiJc3fWNtKivM7wM3JEwQrpIIvitfAt9DDJIUkgqNhyo9giDRAieJ2ubbkhx8pc7YIaQa/MAtlWM+wMtuRUhFktSsm2aZDETwm2SDljKreJzm7nAwYiyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489198; c=relaxed/simple;
	bh=MdD/9MYz7M1wCbFAHiD7DEgcogkOmiRDU7stj2S7jz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYvrfcWsEM1Rpe81aKm+OmFrc8gGAbzHXebSsUK1K0jSA9BNhhCHnmAqiyRR2qsxmODe7igjhnJ0q2IFwI4Dx9PjgT67NqXQFmXMd+MLbo0JCyXL6ROTGtHNKrWmjEQKRxyWR/wDm5s9kbu0Fhp8Ce2bC6SnS3Sc7OPk1BZQmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EluP/tf2; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EluP/tf2"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f20513so405909b3a.0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789489196; x=1790093996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+yVuHLs29GzY4fkqZIEiSlSvIN7JcAqD7l0flOonVQ=;
        b=EluP/tf2hPRnIdpQMBMje/7WuKoGH9VF2LNmKp0WooFSfBLZBmTvJqsj3+wPnnZlHk
         jF+St8/AFemJ1to3hDfWlg3twq3GhD8SIpQrVBXm8/eIOW8JXm8krkQY3lnmizex7DgP
         1S5zGP5EI8YZIytShlTPyfec/CP3H655XxMOfpMh+PLtV8mxdMj5IbN71GpFbjZeFZlc
         Bn4XOrFYQ+whdIrJh/Azgvf7EkQ1g2SSTbQXgZJypRRcR1/nOvJKxQ4M3Xng7hlpuac/
         AOvukcELhNOsFWxMboDS2l8SxH3wOT03ostTVPRMehyJHarhgqvhmjx+Qx0gq6j57N0/
         DjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789489196; x=1790093996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+yVuHLs29GzY4fkqZIEiSlSvIN7JcAqD7l0flOonVQ=;
        b=eUpUd0SwygsKXIdku1nA6EaFXqH2E7rIqCGydInbNoxdvr/Fh5jz6RlPgHDYDLv30L
         mITbdBFI/WxHgUA253TecKWihM6n/1lfjLXnno7g2r7g9xbpzKB4HHT9HpC7yZXgCXl0
         /fhLP/2x2wAC4xPKhvWBmqStRED7tEFUDNv6UBwraetBEXQ8G58b6Go/jy1gzK1jsrGy
         pe6DTm7WQKgt3eHmfnuwVWO8D8CiNtXzI7u++J3lIVN+3XsQ+W+HHCjtXfCS+b1upV0A
         5nA306+bjjl0v3atTozWjPfAVBeWO8wGPGPsnPGDlDD+BIPSXe18D2hnXsS5qkV2jfeO
         8TuQ==
X-Forwarded-Encrypted: i=1; AKwUvBypeurOwYPO1kXDo4yj+Z+JY4FZerBrHq0qhgzuK5w5ASHNUFkbIqYuHm7ZhuLxd6z9M8hdHOgUDt8=@vger.kernel.org
X-Gm-Message-State: AFuF++mVfskcCYNlxWsgc6mIEZdmhe4Vyoo0/Hdl/UqURNrze2YOCJ7H
	O9nbCPmDTTRyamZEafuK63Ob5YwYJgZnwv8ZiYWj4a3Q+AshxJlwARLn
X-Gm-Gg: AYBFou3fuB4jcvd43Lz+lBLrqdzBGE5W0i2OaD/2XSb64y4XldNSnHcLp6pMbAcwQFY
	zx41gruUQISbdCIpaw4+7Q+My/9xhLYaOtGklXW5gv/lLeWt2H45SvhL3+Ryy2P52biUnwI3kHn
	kMT+NzHglX17Ctu/PnGTPvuLKXtmK4YyuVYO8ApLn3AUyK1fn+mTSiZjdmLcuKjVWwd50CjeqpC
	St4S4V9tEwsaIlK8aAWDbEY4PcF/ddd7XnyijfXpYikPBxqtomSWzoeXVys1X3tSgPB7IgeF8pR
	881+qHXZxdnTL5+JdHHSTOlM+9VMgUCggaIkOmqprxVEnAIDR0Myq0WFJcGSMkjHbS2k2+FBVXW
	PxiCQnSVF/TTFft2tT/drijZRoz6/CSJmI0sPRRFyp3+VdlWBtGRUTzuJORtC0p7dSMUiU2Qbn1
	Zvowp3p/1Xsx7q8029LDRpUiFnpx5ASBxHM7NYtR8l4HZALsaK7yJ0JQ==
X-Received: by 2002:a05:6a00:1da1:b0:871:13f7:9c41 with SMTP id d2e1a72fcca58-8717efc888amr3300275b3a.14.1789489195671;
        Tue, 15 Sep 2026 09:19:55 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29dc09d4sm6446021b3a.47.2026.09.15.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:19:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-sprd: disable runtime PM on remove
Date: Wed, 16 Sep 2026 00:19:47 +0800
Message-ID: <20260915161947.2479111-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sdhci_sprd_probe() enables runtime PM, while sdhci_sprd_remove() does
not perform the corresponding runtime PM cleanup.

The probe failure path disables runtime PM before disabling the clocks,
but the normal remove path directly disables clocks that are also
managed by the runtime PM callbacks. If the device is runtime
suspended, those clocks may already be disabled.

Resume the device before removal, disable runtime PM and drop the
temporary runtime PM reference before disabling the clocks.

This issue was found by manual code inspection.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 3584a2b314a9..0c8f389fe584 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -890,6 +890,10 @@ static void sdhci_sprd_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
 	sdhci_remove_host(host, 0);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
-- 
2.43.0

