Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01E1AD3F0;
	Thu, 20 Jun 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880372; cv=none; b=EABFM2QulhUTwcdBRNJgxGCY4Slq/N7SLQDVNpL5q3i+RG1wO41daf3rWPwKN0L2lWuSaZ5j86OUN94mn3/PMcpEsObf508WA2M1Y06AahcJpKzEkNRgyRlUCmcjYND08na+loHtIvvskGLJ99tQNYiCf3ZPaN2K2P/St22ctBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880372; c=relaxed/simple;
	bh=S9sJ2EpZ4lhKLN6lOhKjm3V6c5BDb3OqO1TMnwXZ4ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNn0KJto8hTIntV+aEKNBaDewQ0vNKhrpuulgr08OJisiKH85Ekwp6LvHsH4UHXblLrHgBAggfLxXP5BKvSW1CVeFRo4kv3XUt8wsVQf/Mp6wNKrZJAwpCpCAn+6Bx2lDxJa2F34RTSFEPjF62N8apjN4BJcorGbunkyPjj/Vio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUwRj1BP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUwRj1BP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9b364faddso6173855ad.3;
        Thu, 20 Jun 2024 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880371; x=1719485171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8swW2OiBWO8iEiTd4+ToO1rrxW7MWmDO62LW2ZZz5Nc=;
        b=XUwRj1BPL0n2CTjh93LH+VLeMBFwW/ucvYVUcfxbhQP4VKxJTf+iqF0HRsW2uA7dSU
         DFv2ykiU8f5oohwpl73eX0UXL8+sNUv2EH60Bt7WYKBB3TfmikOBN3gSBU5J8PyXPbGg
         GDWxTfpyTH89jbYvN9spoa0IaCMrR9o9s1qdMa0uD5BM1+VCdvbFjVSsiovH3K9qvp7j
         yBQOyUnECXrBlCFVCwtdRlevFPgqYMVI+MfRpwxrw0xYOOTWV9twg59Ew7DoMA6vELLk
         Us7LetuGKUNviOPHlUWa32FSdqX6b6SNFMq3ETB4Up14RYAMSiSnOoh8GPHY5QU3KdNa
         bKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880371; x=1719485171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8swW2OiBWO8iEiTd4+ToO1rrxW7MWmDO62LW2ZZz5Nc=;
        b=AfeLrcP4ngEMUaIRG36AERlBwgSH0XxqHswaRk6SQDtr02NVtbbgCWLrgYnH36jvnP
         FzljmPUm2oaO8SeCeIu60+TJix2V+7HtRVrTZeCeCtkcfk6I3+p+Na658aqjglynuRGV
         Bp/ILqGFkQG6UVo6XnUnd658ppSKOzW+wiZF8Yy6jQVRJuykshhep6K+nw7xaw6S1g5M
         onU5vPjA8FLvvKeaMCEjV8Yauaom2h1nIlOM0lAw6bsEUsbKKbi36CZoKa1TA/8lT7bE
         f9jv2C5ChqkxntN1mRgxoQmFT72q4xFxwFIw6M61b2nVMTCcMmuQHh421DbqS+8zXZq1
         7WRw==
X-Forwarded-Encrypted: i=1; AJvYcCUpNzL78+4P+GRlAR1ssD3gFgFh9zYr6C1AO9YN/evc72MsUww2GqpWGSzU3Fl2soxlFuyPATcxyf5tBU00T6au+GN0ovKz8aJ8EAt2
X-Gm-Message-State: AOJu0YyWAqrKdEc7O+0jb2pNrXkpLm+p2zJcgyhMfdXYo35n0GErcssb
	Cm4lCFJo5QCtZMBPzkQ8gldS1MQJgjqQjAuPmv54d03x2nEc9lon
X-Google-Smtp-Source: AGHT+IFNGNrAWi5GTxFdTBhjTM6vS8QwvN5xMvOgqOXwucuhFMMoHwC8NpG1XgEdXAUeNknuYlWQvw==
X-Received: by 2002:a17:902:e747:b0:1f9:8cd9:96cb with SMTP id d9443c01a7336-1f9aa45eb15mr60443425ad.43.1718880370718;
        Thu, 20 Jun 2024 03:46:10 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:46:10 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V17 20/22] mmc: sdhci-pci: add UHS-II support framework
Date: Thu, 20 Jun 2024 18:44:42 +0800
Message-Id: <20240620104444.5862-21-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
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
index 342bbc3ef577..7bd2f3c94e48 100644
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
index 23e6ba70144c..96b6fa831714 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -40,6 +40,7 @@
 #include "sdhci.h"
 #include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2164,7 +2165,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2172,6 +2176,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
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

