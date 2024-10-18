Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C9206962;
	Fri, 18 Oct 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248888; cv=none; b=fIT7kYBcHn1xTfoAp8Gz8agm+DYmzEJG1gkv9pv8UCpCzFnTab6ApeDPYOSNHvgjI8A2c1TjQ449tz2zl/zpfgBUNW+yGCcDZhxaNFoReqrfRTAXr5UYob65atRuaicMlt0Axrhp4VvbXi63XgHRD+0rwYvl4LW9EfzOGMcVtXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248888; c=relaxed/simple;
	bh=kx+4OyfPkgdDsZx2EqLrYQ2HGDcBIftS9eZE7hBiy/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGlZrZNRLdho4Bn3+VAuh+1AaKLbGePkJDkKIwjOmIgqZSBI3RbqyHMV4uafYs994ZrRM4n2J0HU/ItgWZKC+PLpqXoudh5BdErA8dll1Q0MUBmT7KEqPGehAB/7iU1IKX7dD/FUJ/79/L6gnvW9T8pzfM4fTy3ejT9Cg1/90bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeW6WGhD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeW6WGhD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c805a0753so16794815ad.0;
        Fri, 18 Oct 2024 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248886; x=1729853686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEAeEioysszMV4Bk2sIJDxmaz1U5aF7RkBrmONafTZ8=;
        b=EeW6WGhDpqk82cuXsYYdWHi4hIP2IvKkWNzGeSVMCLeZI4erwmNqJZ7q7Hd8eJyQQE
         DGdFI1qcdBlli46rXkRkb98Oqqye1YyXzl+j7yBtsV7YH+6ohfWMBIMUNiX8NwbvdIQP
         M5QlcdNiPJAukktJZALZpNv2tuxpg9KFfprVgOoUgKHXDKTzut3haDfmo/wAKszwXhS9
         g5EOECirfu/RNYAyEo9Sq/MAadTKC9Lnx86EtR9UFN3WCRTCFSZ+xjDQtudbSXC9mltX
         DGSoVPj0fLKrfWBtYzoMHDiCSQJKd0hh85+/8rOJ9u3gFx0SI0r4IsqI0r3ZKtXqhvX1
         o6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248886; x=1729853686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEAeEioysszMV4Bk2sIJDxmaz1U5aF7RkBrmONafTZ8=;
        b=g+GDL7BbJLvDNHIAjHn0IHDL0mcorESGaeSkDtFFKnM2TmVIlVohzg0D2j8bJ9ssUy
         Ec2SjHIvrQ08J2ixkiCxVqto4XDVgTWDGh2ujw15VxR+0jPJTWmAPlP5CyFBxwDrVpqJ
         t4FS5eK4C42tDDc9XYM4FZ+EolGrkM6qbMJU6Bq18wSOW+ul11EQskExlkAdx1Sys6gj
         RSCY11sahJaFMImjYOdG7e2TK7vCr1eRIQvahIq4kmvN1CjLlDTn0U5QSMDxayEy1f35
         zKbO3YzJ8f7a5n0+DhRPMztDYWPDuLvuj0hJZmZmp0F55M+ME+cLZkXLQFpmB9nuK1WS
         Dtlw==
X-Forwarded-Encrypted: i=1; AJvYcCWn95SDmXt2i1BH067RihjrpzRXTV/zJXmXZWsfl1aar6XgN6MvYCcjnBt/dMZz4ELSdnzoM0RLqOpbMaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzInY2AAhIa1leCuaKao+xX7Nm1oN759wp5VzuuC7C7jAxwdXkk
	P1DnLETGfUKlCBruQFeO9NiwU9OzEq5xh+KwA8iZAZAp5RTXKNh6
X-Google-Smtp-Source: AGHT+IFotUVUQtMDO8R7mVjD7kkaM+4IzA45gO52edlUiYEQWeiLtjGsy1XnBqZ4pfzqFm07jRItuQ==
X-Received: by 2002:a17:903:2307:b0:20c:94f6:3e03 with SMTP id d9443c01a7336-20e5a8fb2e9mr26100835ad.47.1729248886046;
        Fri, 18 Oct 2024 03:54:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47a:11ee:3789:3bcf:d64f:bc9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fa20esm10237455ad.234.2024.10.18.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:54:45 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V23 14/16] mmc: sdhci-pci: add UHS-II support framework
Date: Fri, 18 Oct 2024 18:53:31 +0800
Message-Id: <20241018105333.4569-15-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018105333.4569-1-victorshihgli@gmail.com>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This patch prepares for adding UHS-II support at a specific UHS-II
capable sdhci-pci controller, GL9755 for now.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V8:
 - Add config select MMC_SDHCI_UHS2 in Kconfig.

---

 drivers/mmc/host/Kconfig          |  1 +
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 45df8ddb8918..fec470225584 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -111,6 +111,7 @@ config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
+	select MMC_SDHCI_UHS2
 	select IOSF_MBI if X86
 	select MMC_SDHCI_IO_ACCESSORS
 	help
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index ed45ed0bdafd..2b300bc4a701 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -40,6 +40,7 @@
 #include "sdhci.h"
 #include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2181,7 +2182,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2189,6 +2193,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	sdhci_free_host(slot->host);
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
+{
+	return sdhci_uhs2_add_host(slot->host);
+}
+
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
+{
+	sdhci_uhs2_remove_host(slot->host, dead);
+}
+
 static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
 	pm_suspend_ignore_children(dev, 1);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 153704f812ed..e807c039a8b1 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -145,6 +145,7 @@ struct sdhci_pci_fixes {
 	int			(*probe_slot) (struct sdhci_pci_slot *);
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
 
 #ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
@@ -189,6 +190,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
-- 
2.25.1

