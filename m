Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC7193089;
	Fri, 25 Oct 2024 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836073; cv=none; b=sL7wW+IwZmb+s0Zv5AZhSIL5j9RIWlu7BWHZdYD/paVjqOuZGJnZWFghlb0svTgECIT7GbxWxX+RiTjU4RxO/bVr/PBG8TRpOfa83clU1BURTpnJJ0RT3SvJ3UkJ6L9YK8EFV0iCw20Ejfp38FVRX9nRd+8jR+QYMbVQwg3C4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836073; c=relaxed/simple;
	bh=y01LWBiGrWPkZdH+79GJS8rq6857OtjcXuEavrtOW90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTh3grSzTuKyAP76li2rVt/LFVjfVgq0zm/O4ywgalPlwAixtvTioAdOe856DBREyDdpIQ2QIWVQAXU70IpzLVTPmdWTt6F25NHUl4ZdJzYjHlCkmVuJPOT4GlvOgfaQu7sD5PyLWijunDnoeXpB7yAQjhhVyl5zTt63AohqQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkWN2l5r; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkWN2l5r"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e983487a1so1235209b3a.2;
        Thu, 24 Oct 2024 23:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729836071; x=1730440871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4qOkIV0mJ9rxtHsHJLKJtD4R7WAh6avEGQBU2zikwI=;
        b=dkWN2l5ryVCX/MA16z7ldJveIxYCBf/fTE+7fe62/NEubbb63isgoXXorHGV/lM4pZ
         y5vZv04aB54jqJ/Zrd/G1z8qYYAULAd87M2aNkxShg510pI9VDRLq6db1/8O2yi0kW+e
         6Iw9sK1yTXoseKckmFbMgjdZaWNzO0beIZcNfwvbNpS38QEeEZu/vd9GrzAIWbhXwZEw
         57smyQ6y6hnJOUjeca85JVci7sNze/NTcfWLGRbj3UALgdJ1qm7oa7tnfyQlAzRoCOdo
         Wsx17c1xEOAaSSKrhzHVY7PTQugMbz8wMiBFEe//S294HrgxlAgTu06xDa+DdFg33KL1
         V/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836071; x=1730440871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4qOkIV0mJ9rxtHsHJLKJtD4R7WAh6avEGQBU2zikwI=;
        b=rpm3DcyBqAToS7TtV2JAnulp1kAuEkez3yTuLDRQ9r6qHmTjC168Ty7y4faMNGSl4C
         uA0AODc3JGkuMO7RjwCnMwOPeq0QmFfc+JxSuQ+nfFkecVGohQ6dX0uBOi5PP42ZwDrk
         k3e/BZOXsiaChcG+gkPzsgpq/BtCNgiRHrk+Adr3DPoYLtvy7WuS30Kj+qa0NgcCgboH
         ylLNQxouQukNGSyzqiE2pBFXSbH3Cq8ohybmUY4RIIW6Oqv3xPaSEt9e0PvXhDWKhKgY
         GSgb8ueiB3mz/EpbofFTNKa5mx54rIcnbyeVa5+UAPEOG4ejkyNLTiXf5pJaXdt5ne0x
         vn9w==
X-Forwarded-Encrypted: i=1; AJvYcCXKIS3QehZ5wJzkFYw6a7wq52piIYZkemUJCasKpI4RqXozrmso+p3tRmQh6J7xc+e+p4hqj7w0CCm1@vger.kernel.org, AJvYcCXN1VXT/TT+BtZwGbOmomi6fFFJZMV9dd/KNV9UqVlXZ0gvuKQ1aljdop0X7SG+UAkAMBrM/V2cED3t+XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxljvEZZblaWPzYmSl8JRxO2hEQ7YpPOEHqkheq/7oacry9ntuA
	wfOYg0wGBlEyY8ZzFiTODUMlyr/qUonn8UZ+zwQ0wwaG234fTzTOV7qBOg==
X-Google-Smtp-Source: AGHT+IFRcHAfxvWd+XZHDWWpwAvsFqFoJ51P/0+g7ndz2fpY9o/k0SOLM2nN5pCOoyJ7km5GKwwiTQ==
X-Received: by 2002:a05:6a00:14c9:b0:71e:3b8:666b with SMTP id d2e1a72fcca58-72030a8069amr10476773b3a.15.1729836070978;
        Thu, 24 Oct 2024 23:01:10 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c024sm363557b3a.192.2024.10.24.23.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:01:10 -0700 (PDT)
From: Ben Chuang <benchuanggli@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	victor.shih@genesyslogic.com.tw
Cc: greg.tu@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Lucas.Lai@genesyslogic.com.tw,
	benchuanggli@gmail.com,
	victorshihgli@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express process
Date: Fri, 25 Oct 2024 14:00:17 +0800
Message-ID: <20241025060017.1663697-2-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025060017.1663697-1-benchuanggli@gmail.com>
References: <20241025060017.1663697-1-benchuanggli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

When starting the SD Express process, the low power negotiation mode will
be disabled, so we need to re-enable it after switching back to SD mode.

Fixes: 0e92aec2efa0 ("mmc: sdhci-pci-gli: Add support SD Express card for GL9767")
Signed-off-by: Ben Chuang <benchuanggli@gmail.com>
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 22a927ce2c88..68ce4920e01e 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1068,6 +1068,9 @@ static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
 	}
 
+	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
+	value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
 	gl9767_vhs_read(pdev);
 
 	return 0;
-- 
2.47.0

