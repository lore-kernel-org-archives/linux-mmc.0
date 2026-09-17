Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECE4AA1E1
	for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643627; cv=none; b=e9wqlOVsBOaXSwIOcYAtRczDFHryKZHkAOnouDlCMc3rH52uypyz/r6J18gAb7KGyECZ4ziHjPaGZHrqq0h9qoA9hlEWsb6KioCzadyqfWaSh+gTzGjbxFJLPDhvtBV6RlbzhS+L5idVFeeUnAH4INoJFmW02g9qogseJCHhsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643627; c=relaxed/simple;
	bh=FPRRsaLOotLLGU2qlqoDfHiPkXVpRDaTl35pAxkM6mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lyo/qSPoj4i294Erp/mAT88VvKJv3HKUjxpblLni/0i4G+nhcZmOoT6Xj6hkqMLKEWPp/pQS21Piuoy1k2WeLZJSKIRsnUfbDnL6D5WlxOcCEWosV6GmFLHPE1YVWEyz5GZhsw67e9Ablh1+6KOXJY66Nf1ocC5ee8Q9cMQWLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odPfWtlx; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odPfWtlx"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8b402f4e3so663482e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643621; x=1790248421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1BcjxxUUz9REzI1Cz/zHV7EuDapF8kpq7QNpQA5pel8=;
        b=odPfWtlxZd9XnKySyT3gVVZnv06c0MWBDu8Ho0r9qdRgBR1qY3O4Yrvih27VVbIfCI
         9mzyvT2kmc/udK7CASKRQ+wEQzm9j/1XKZI9auhqdtzJwEDR7g6HMZNXmvW7BIAP548W
         yIJzQVW7RrBpsV2mB8oCqSfd4QVPOYhtzZbSxb1bFP9GMcHiNeKSnUG3m/QqPdO0x3ut
         xiabW2Xk4Z1MJdabZrOGxU6mzwdSTnQTPkowm+Kc1JPF/JwHE7U0eXQt/zLkmwLkPd+f
         RuLtdWzfMHm+6HUzNXC84Pqbx08j48+ACa8Sewsa8lNvm7VuhGHc470C8ekgtz6y3cqI
         RbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643621; x=1790248421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BcjxxUUz9REzI1Cz/zHV7EuDapF8kpq7QNpQA5pel8=;
        b=uz0+uSUmkmYDwjyBXjASpBNTcWR230nvXV1F0YeEufPPJVfr/2F7oaNW7nUzGMsTLL
         d01QvdlnhGU3upa8N8j6JdBtmJrXTGF0ozEsXTixLrhXz9RLHb5PMYJnQcpIia8vXySn
         8yhfRjZdzOh/Qz7p6SSPpPkwrg58RmjfMYnON2P2P8s44NGhGl143n938uDRiz5sGkxD
         jZvZCdPJjOG91wxR5XNMMxOuzu6WBUSyq2o9+afGrA9cbP9c86rfFnAEexFEfce7L+7c
         ZYPuBFQmuVeBVqJYgjBs8ElmjVsi/8hdUdS5OPTtK58m19A4dArvKcxjRQhyEAYu8GCk
         tFGA==
X-Forwarded-Encrypted: i=1; AKwUvBwJa4QYC4Rt4xSlVMhFuz4bnC7yIgDsDF5CfB73EbN7EPbTwxsTp1CgPBqlgyqjGqZRvZMl8XD2ez8=@vger.kernel.org
X-Gm-Message-State: AFuF++lIwDrjLio2gdDarUaPW7U0PVrOzKJyEnVc47ztvzvZB8jepylp
	J2QR5L/3KneofbCRy9kubAkWH97rFHoy3A8gHTu9iRRjAsxEswYnFNom
X-Gm-Gg: AYBFou1uEDYutsLPJQRUUs6x3JQ5M31Xs3kRjETRErXxOVSzOrS1XD1BezzB/Tw0fwC
	fgwIplAG+GNgiZt4c6sidATiJX/paGqxSIZnBr1j7Q2qiX8Mzckm8wN3DuDbg3F9RGxVim6fLlX
	WmI6Mm0i3TlZmzHEgqKAc+CWz0wR8FOrnN/6gt96eQLiS7glJuN8NpcL8C7s3GcZ68X+oPsqXci
	f+1t/wfLCfHfNmbXGJpXXL7zEwUrQQW1xkVT6cROcphhr6qjSMZjIARPQmuMLoeSloRH4bDAZve
	BxTj7LoiuwpJtecEIprUTTtSduwTgQsBbwJLwZWsCqnEGFJg6nNGYLqjvfV8mEXoE6/on9+iHwU
	nGFdB1keYrDbjWolwKOhzwNmDeLUj96kYUc/kpWt2rayiqu7Jmzv8jhT+UUh1472TnSXmFMU/tb
	L7ETpLvcJc3MRAz/RU0jI8aLJYE2hV4RczkbLj9xf/QfcP0oLU39Ef2p7s7xF6T9YwLtEbNi+9M
	H8sj6E4F6u3jPc6Q6AGDpr358MMB2SauHmkXBBng/XN0pZiVdUTdHcOFVGk7Z4bAacQkw9yrnU7
X-Received: by 2002:a05:6512:31c2:b0:5b8:bc5e:d10f with SMTP id 2adb3069b0e04-5b8bc5ed2dfmr596727e87.57.1789643620561;
        Thu, 17 Sep 2026 04:13:40 -0700 (PDT)
Received: from localhost.localdomain ([176.40.225.86])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57c3b81sm1702367e87.20.2026.09.17.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:13:40 -0700 (PDT)
From: Alper Ak <alperyasinak1@gmail.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Alper Ak <alperyasinak1@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci: Replace deprecated PCI functions
Date: Thu, 17 Sep 2026 14:13:35 +0300
Message-ID: <20260917111336.1102829-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated.
Replace them with pcim_iomap_region(), which requests and maps a single
BAR and returns the mapping directly.

pcim_iomap_region() returns an IOMEM_ERR_PTR() on failure, so check the
result with IS_ERR() and propagate the error with ERR_CAST().

Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index b121d896a804..a9000f3bd419 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -2170,14 +2170,12 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 
 	host->irq = pdev->irq;
 
-	ret = pcim_iomap_regions(pdev, BIT(bar), mmc_hostname(host->mmc));
-	if (ret) {
+	host->ioaddr = pcim_iomap_region(pdev, bar, mmc_hostname(host->mmc));
+	if (IS_ERR(host->ioaddr)) {
 		dev_err(&pdev->dev, "cannot request region\n");
-		return ERR_PTR(ret);
+		return ERR_CAST(host->ioaddr);
 	}
 
-	host->ioaddr = pcim_iomap_table(pdev)[bar];
-
 	if (chip->fixes && chip->fixes->probe_slot) {
 		ret = chip->fixes->probe_slot(slot);
 		if (ret)
-- 
2.43.0

