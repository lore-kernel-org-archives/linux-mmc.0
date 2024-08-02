Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF881DE870;
	Fri,  2 Aug 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594263; cv=none; b=OQXGbcqWerd2lbjtIyq8i9Jn2Hn7B4LEcWaFP+jhvmtWQwrk4FZdN/X67ZK2sx21/1uJBUxZbfKs2nOi3LOA0kp8YaYRLXYzSenjWjiKkWzc0EemyaK27zlEb/dOyW514zgrIJLD6Ep/X7n7w3754k4OGjN/Y810sVACHvxxW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594263; c=relaxed/simple;
	bh=BBmOh+J8wbHqD+qTLuiKwDbsSR+vTtMdFhdWAtR9fo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m9WO3zKVOerh8OdOhC3IH5aqPKCDtWUnpgGH5nSV8hvdwYbpAIpMuY/YcErI5AEUJK2BCRfaVYCgItl/QOJBCvtkwWdWT3INJi1oi0cOEUbJPFqgVSa4rFLrBg3Dvqb+X6ISAytIqrmgUh+BLy1l6VTHvqghiVZT5M+pyfL7Chk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4P0+2SD; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4P0+2SD"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db13410adfso4474029b6e.2;
        Fri, 02 Aug 2024 03:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594261; x=1723199061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gNUl99+/cfPbFiFnZDy+WpX8DaXSfS4SfGET1lkYO8=;
        b=a4P0+2SDU6tYTFbMuowyd2y5oT++lIGDkRrOK+zvwGEUC4St1o/SOXAqYj99pE5GDQ
         /S7cro6e2cJH7NaBiQFHaPyiwc75m9x4UmKg97mFgbZJ/wn/Nhw2AO6RXHOOak/XQHFr
         yh4BNlaTRNFdYq/2B0lA2Lp9vGVcJi19D04X2vBLzH4r7LoB8HKPBhvFNDrX0+2/Jh6i
         SKI0eO8lNfKcDg5BwIhGO8hhgqC38NWtoiYWdonxRT2MoRPO5iy4ZVJDI1eBI7CF28tg
         JT58+0apsyhIFTAVCTiq/IeXbOgyRfooxhxuPGpOQDCpgAzJFfMLADywMYkg/9uxf4BM
         h+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594261; x=1723199061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gNUl99+/cfPbFiFnZDy+WpX8DaXSfS4SfGET1lkYO8=;
        b=KO+Q3fT1CZFzyJYKeacoO+cGn/MxrMCdMeWf2G24BRKIdBiNqgOGBPIs/y8gqH18sw
         ylVSrxYOn4dO6jTPMkfgGlOtg+rTO8DlO78z91QwlIepvBNSYMbHJtW1fnPSwUuBfDdK
         ILKOdEnG+ChbpQwvZwkCgCHNpEIgZ44H/WdTbC5aU6hOuGtU+t5326RgWv86bTx8Z8R5
         +EiUfbbFVyNFNSEauLfrkw9iPzXtASx3hAQjUqJb5qD10EqfQncDjBX9/8uooboPxpG2
         Icju+yn4SUhvSHIXEG5P85TeCm56I9+DWpZt60gi1T0DIclvDh5LroJLpwbUE+R6IiRs
         s1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOgxgp3zneE+PzuFrFbUGjedIZV6ZEMAk7vrHBO5g+2mqicxkLn35NGu2bXbzapAN91cCQgtZqT6dXCBeFK1I/Tm3tG3WSlMMCws16
X-Gm-Message-State: AOJu0Ywy52xV9feRGufhZXXLCyuvIK7uHLJbwBf00Il4VZ9cC78Si4ty
	5FzcQkI0TMzzUBFfJI6buJNMN7mGTnD4xWIO1vtNXa50jii2C0ZD
X-Google-Smtp-Source: AGHT+IHMeaxqRaedGESgMORhk2TSHrehACDz81lC3oknfScKruQb6DnE747TtPlWI+VKXYMSD9eeNA==
X-Received: by 2002:a05:6808:1385:b0:3d9:36ba:2bb with SMTP id 5614622812f47-3db55818fe6mr4253250b6e.29.1722594260712;
        Fri, 02 Aug 2024 03:24:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:24:20 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V18 20/22] mmc: sdhci-pci: add UHS-II support framework
Date: Fri,  2 Aug 2024 18:22:27 +0800
Message-Id: <20240802102229.10204-21-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802102229.10204-1-victorshihgli@gmail.com>
References: <20240802102229.10204-1-victorshihgli@gmail.com>
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
index 03b2eee9203c..0e33ea3b00a7 100644
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

