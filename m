Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770F364032
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696211; cv=none; b=ILmSApEWAL5hKc/PDUgOVSe/XomSyml3J673jnfYM2gpqWYTjbQgNPoVz54VLmAJ7qTljbFnJu5F2oqF/LoE8w00sC0VqKP4hioyqMNLTFZbMrDwAo1iGMl+KXUTLybvOtKr/zBS3hFvKZK+GPn12wP23lJizkKpAM2mb21/JQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696211; c=relaxed/simple;
	bh=qx4z8Ob8SnELEodjvWmMWyv1xv4wlLOYDgg4+waEj+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9uLHjP+JXnmYlj29/jCOnIeUt0nOsCFVW8AwYIPDamnYlxMPbaKFQHB48aRMywFN+Yp/eWeKDEZSOGSabQd+T0NU3WXO594LAWx3yfpuWPjBXqY0SPIL6OpaB3MhGYLEffcnmT7qQveV2aQVZcfJmfYVWc5u7x5gwhk7hsgQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn4JvhYW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn4JvhYW"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7982c3b7dfcso47595187b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696209; x=1774301009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e79VH+YX5m54FYYzBazND4kInl10p/kEBJg77AgNJYU=;
        b=nn4JvhYWRHh7HRYuVmFuvGF12yRtpBTOHZM3qvow1yNf/b50mJxqr8lnWJ9PzbaWWZ
         GcK4q/PV3vVxWDFbmYWwZG9fx9WtJFtFCpzifQ1kO4YCOqD7bgo6bFFqT40iGKyExuM7
         JfqWbFkSkZAnHJssiUDMPT6Iani5HfchbNQk/MIf/Mw+UaOZU7t3ULJvs1t3ADwWQqme
         REhwxIH8Egltr9icGfKrEtBYeOSxkKLtxYrnUw5T8CQAtbeLrgnTgmzepR1F/NAD2coy
         ah1jnfHzReDy4st4rWK+JMFtPYlaB1YsOg3CLqvuAtODKjJzMSdZYH/4TvOlnuriE6mo
         JHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696209; x=1774301009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e79VH+YX5m54FYYzBazND4kInl10p/kEBJg77AgNJYU=;
        b=MESep1EgtQzDZ7g0bZ8jgoR9A7dXS/S08qWKq3iXGuzzNHnc/ml4W9l5Fz/iaaQb1v
         lwVx4Zd4SkVAlB27Sec5rPGRVOJk0BpR60fERRUTvZm/Ho87kb4fesP/PQAf05jramyX
         9rb012O7tLC3qcHOnchvxbIOQvSjNQhu5+ZQYf81ul3osBlpxBL+wRdYJpNt8jtLTUaj
         V6/KJ3BS3W/0CLrRyg5E444dE4jhqzZ/K/r/W6E/UsQJmznHcHVWEo30HVqNbE8k7o4g
         z5j3beW38hVfOGBq7Z4MlmcIBYbLXXPRH0i4JcmlvBZuwHPL+xej7nvxRFkrK8Ja8dz1
         x/gw==
X-Gm-Message-State: AOJu0YykqzAMjob0eMvR2IGVBbjT2LArunZ06oEX5JMouwzdd6QOEIFN
	/ZTHMIZWvpfGEYKdMLh0KR/SJudLIbbR0LWYBIO057X4tB2Vsh8AbEFHIhPL2Jvy
X-Gm-Gg: ATEYQzyfzin9LXIkf2aQgcsZYQ1MCukMJaSkoTz8GSr4gZsLIASN70zyaJ2FKUF9y/y
	ROCLr2eqqq6TvAVSufCLZUKV/POF/Vel8jzyMs47Uj/GGVWuGdMU1BGcgEbI2OamUUsSpzAzL9/
	lfbGIvJaWwBSz4tpVJzcd/QuEeccF5ZN7ewmvjgT3zhvzGAopH/h0haYrOSUf4fPvkxyTe5mW11
	8l+Z0WniLoUkhrhJigZlijSrQzbnVcaTa12jA/ndjjJSPkXKp7hk6XlTy6LZXJVgs/DV7Pf9Brr
	VB+l7NvB2Xz7LaHOd0FddUYjl4/LZIyHhoHXBevq+FFXysRHjNM4FMe48TRRN0lD6xwLri7QQa+
	NY55/vi2IL/lWNTSXCi8r1DUw9cl4C52Gak0kgcvznQMgva7+Fg7j+PMo1o0ec682mcSLngFDNJ
	J7vYv/4qIMgr0T/qyiWR+jkxhD62sPMqJBeZ1YbAoNiZgQOOL4Ww==
X-Received: by 2002:a05:690c:c4f1:b0:79a:610a:2d76 with SMTP id 00721157ae682-79a610a33f6mr14075587b3.40.1773696208835;
        Mon, 16 Mar 2026 14:23:28 -0700 (PDT)
Received: from Starblazer007.localdomain ([12.206.154.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a5e1ae50asm8180437b3.2.2026.03.16.14.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:23:28 -0700 (PDT)
From: Nelson Johnson <nzjfr547@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	Nelson Johnson <nzjfr547@gmail.com>
Subject: [PATCH 2/3] mmc: sdhci-pci: force polling card detect for Braswell SD on Lenovo N22
Date: Mon, 16 Mar 2026 16:23:24 -0500
Message-ID: <20260316212325.4207-3-nzjfr547@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316212325.4207-1-nzjfr547@gmail.com>
References: <20260316212325.4207-1-nzjfr547@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo N22 uses the Braswell SD controller at PCI ID 8086:2296, but its firmware exposes a broken card-detect path. On modern kernels the slot repeatedly fails to come up because the normal GPIO card-detect path never becomes usable on this machine.

Force the Lenovo N22 to skip the firmware GPIO card-detect path for the Braswell SD slot and use polling instead. This keeps the quirk tightly scoped to the affected DMI match while leaving the default behavior unchanged on other Braswell systems.

With the polling fallback in place, the PCI SDHCI path can detect card insertion reliably again on the Lenovo N22.

Fixes: 6cf4156c0988 ("mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD controllers")
Signed-off-by: Nelson Johnson <nzjfr547@gmail.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 4b3c61609..05ab17e72 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1134,8 +1134,17 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	if (runtime_pm_ok)
 		slot->host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM |
 					 MMC_CAP_CD_WAKE;
-	slot->cd_idx = 0;
-	slot->cd_override_level = true;
+	if (!runtime_pm_ok) {
+		/*
+		 * Lenovo N22 Braswell card-detect bypass: ignore the broken
+		 * firmware GPIO path and poll the slot instead.
+		 */
+		slot->cd_idx = -1;
+		slot->host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+	} else {
+		slot->cd_idx = 0;
+		slot->cd_override_level = true;
+	}
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXTM_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
-- 
2.47.3

