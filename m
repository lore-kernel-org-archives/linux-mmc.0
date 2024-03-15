Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCB59B72
	for <linux-mmc@vger.kernel.org>; Fri, 15 Mar 2024 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710546294; cv=none; b=EHIUCRdSf9ruGVToZnUevrrfdfGpHXNhJD/Wb49YhHSfCuU2a5CZ0GwkUJ8V1fCqxxRJGk/BHGYd3+3Ea0OSIFQZwXQykE+hrnrBsEkWvP0tQAlMJs8XPtwS3evZI+vsJ61ER3xGK9NL5YzSiEW4JJNKauLtslttPYT1YZzjCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710546294; c=relaxed/simple;
	bh=MmM47lInEbxUE+Xs0ZvIBvo1dAR3CChJVvovySqI22A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czSNqdEkk8TLrrVdMNNM65AaAukuUYzym+4j1dx+SVBGcShmSLDUG/V5IFFhEPgmdpmy+yuzcB7iway7c0Gv/WBxJWmknfcyO/GTUU9YrD7/PsDE3vism9QbpwVlLgu18am9HWRwLicdC32xPBzL6JAJV2SBErQTzoi0qjz8FDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=QNZZoOmg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="QNZZoOmg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41400332550so12271225e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 Mar 2024 16:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1710546288; x=1711151088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVmxbXF18KhLtCJxujdzruV9hT1pxQUGaGhkgdeENs8=;
        b=QNZZoOmgrapgf1HRw7TXhzcO9xw3ByQWqR51q+soT6BqR4G1Xpx0qOtk8y/owJcRQs
         XaMpD3+mz4XRA3UW7fcMlIuLeYjz3joNaC93xMuFAsuL8AYu4zWT35LKWsCDmWPsoJYj
         oK/wvSjJKerVgge6oLFHcVNL9UbqN55w1s5r+FuFb50tZdJAUMhDYeEg6MTXFAMkNQTR
         NsDFkhODAmRH8G5Km1dnzU0eHxEhQjHqxZFe7wctLzzWzcJtpY7tCYIUDgxNi7LYd9Ag
         FwGoRiCdDpyXnfB+ZVx6kmes3SLfr2Mx6K6mOr1LYHPegv54pyTymiWaHqTeRqyg32Yq
         hp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710546288; x=1711151088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVmxbXF18KhLtCJxujdzruV9hT1pxQUGaGhkgdeENs8=;
        b=mfbXDr7dCk6gyDv+IF0paUPzdfW3i4Qh4jLuf1ruRUQ37FgHOLa8c27l/eZyGeiew+
         mITbRYt1YAKeaeYq5tI5M0gI4kcmRLQsUQjJTLmf3PupqfREFXpuAqKe/xJhwjPWBiKW
         58gfDt/f/VH8qId6xWi4pez21tlPOeyO6FBYughw+biSwl6KqYxct9TVpG2m9vPSAAsa
         nJpb8KO9lzvUiLjFzDUKCwFwGVakcj6DBi2X+WRfKWqd7csojtveV1AGBNBjGGHhzFFi
         kQVlP9kB5eJkx6fRYpwPUkyYncxn9a7m2dYxDTm5rxlRkSiJKAiUyS5eCgHSQShFASQV
         FpcA==
X-Forwarded-Encrypted: i=1; AJvYcCVxXXZldhHEK3ECmYsYzehHOJXeCT/IdbemvUnZx/e8NqspLyRrSBvoRdyq7yr5LCdXTjIUNhqa+/2+YZpZWCqil+VVvoi7xntd
X-Gm-Message-State: AOJu0YxaP1j6xkGBLyrSJ1VUaW5YKtlL+sli3ssmfaqt+YS0khoriqQJ
	7WNxBMpQgfHJmRLhvNU4fJQrIH807Fq/bY54KQeBtWl2gW1l/VeAJGiOhB2drD4=
X-Google-Smtp-Source: AGHT+IGkUKbH9dcDV0TFp+qGZCLNv8sEMp/V5fl/wA3PdB+ddlfhzVfSdudzvyJlDhc2N493tjsIOw==
X-Received: by 2002:a05:600c:458f:b0:412:e59e:da2c with SMTP id r15-20020a05600c458f00b00412e59eda2cmr412790wmo.37.1710546287986;
        Fri, 15 Mar 2024 16:44:47 -0700 (PDT)
Received: from P-NTS-Evian.home (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr. [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
        by smtp.gmail.com with ESMTPSA id by1-20020a056000098100b0033e18421618sm556093wrb.17.2024.03.15.16.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 16:44:47 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: linux-omap@vger.kernel.org
Cc: vigneshr@ti.com,
	adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	tony@atomide.com,
	Romain Naour <romain.naour@skf.com>
Subject: [PATCH] mmc: sdhci-omap: re-tuning is needed after a pm transition to support emmc HS200 mode
Date: Sat, 16 Mar 2024 00:44:44 +0100
Message-ID: <20240315234444.816978-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Romain Naour <romain.naour@skf.com>

"PM runtime functions" has been added in sdhci-omap driver in 5.16
f433e8aac6b9 ("mmc: sdhci-omap: Implement PM runtime functions") along
with "card power off and enable aggressive PM" 3edf588e7fe0
("mmc: sdhci-omap: Allow SDIO card power off and enable aggressive PM").

Since then, the sdhci-omap driver doesn't work using mmc-hs200 mode
due to the tuning values being lost during a pm transition.
See the report on the linux-omap mailing list [1].

As for the sdhci_am654 driver, request a new tuning sequence before
suspend (sdhci_omap_runtime_suspend()), othwerwise the device will
thigger cache flush errors:

  mmc1: cache flush error -110 (ETIMEDOUT)
  mmc1: error -110 doing aggressive suspend

followed by I/O errors produced by fdisk -l /dev/mmcblk1boot1:

  I/O error, dev mmcblk1boot0, sector 64384 op 0x0:(READ) flags 0x80700 phys_seg 1
  prio class 2
  I/O error, dev mmcblk1boot1, sector 64384 op 0x0:(READ) flags 0x80700 phys_seg 1
  prio class 2
  I/O error, dev mmcblk1boot1, sector 64384 op 0x0:(READ) flags 0x0 phys_seg 1
  prio class 2
  Buffer I/O error on dev mmcblk1boot1, logical block 8048, async page read
  I/O error, dev mmcblk1boot0, sector 64384 op 0x0:(READ) flags 0x0 phys_seg 1
  prio class 2
  Buffer I/O error on dev mmcblk1boot0, logical block 8048, async page read

Don't re-tune if auto retuning is supported in HW (when SDHCI_TUNING_MODE_3
is available).

[1] https://lore.kernel.org/all/2e5f1997-564c-44e4-b357-6343e0dae7ab@smile.fr

Fixes: f433e8aac6b9 ("mmc: sdhci-omap: Implement PM runtime functions")
Signed-off-by: Romain Naour <romain.naour@skf.com>
---
 drivers/mmc/host/sdhci-omap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index e78faef67d7a..94076b095571 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1439,6 +1439,9 @@ static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	if (omap_host->con != -EINVAL)
 		sdhci_runtime_suspend_host(host);
 
-- 
2.43.2

