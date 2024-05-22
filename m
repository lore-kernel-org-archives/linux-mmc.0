Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8E85959;
	Wed, 22 May 2024 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376238; cv=none; b=coKlOOZb4F8exGUquCen/kayFv9I1aoPYWMi7yAYRjJU7qmEGgFAPPsANbLQzBwUQHdjf2NFUBOF1GKp1lm5dSKWPZci4Sz64yDXNVaeaQ5C/6DDYyimK0mm/ikUMLPsjcVV4QA4zfztvqSVNCDMujq6AoOTbVZIfHhszfOVTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376238; c=relaxed/simple;
	bh=cvlHF+xMs1qsEOuNf3mwOC8mdfVM7AymMc1BF9fSZhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kK9RaVCyrroTIDDJd5NFHGwRWuB9IpMH3ORY1WIN+phEQvtiuLuZHrje+EgqjuYcDbTO4dxyCAh/nA2rNcdauY6Ji2Nm5tWIcP3MNCMem+8PvcUAXW5qjS3EcN1a0gpomla0fVbbhudEPrDaOUdv6OGFmvz7AqyGVqe4gPFEqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOc9rZIp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOc9rZIp"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f43ee95078so2452245b3a.1;
        Wed, 22 May 2024 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376236; x=1716981036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0cmjeO4AWJjXgxtd/DzrwOW0GDT9l0zaX03UCUQBXo=;
        b=aOc9rZIpwHX9KFtMuoKiKOget4SfEBLeZ/qxHUrBGbLFa7VriV5Rdlxrlbtw2vmkIP
         2mFKoIYh1o84pyndQVhnJov2K+azvOZailmASt3xhve2+OiMbnYzETAoiIvky2eVhByS
         dYtrtNKV5FeL+Cc94S4Cp6RYUG3Ua5b7qC4vWbGlfSQxG0OcfxOQpjsB2NinoacoH23+
         1cEOIOIa8QUL2grr5lEYf6ZSTxsoIfudYpmLGxzEQOUqSsvU8e+yTWIngKANbiD5x+QR
         3pJz6zn9pXahK4/dIeY7O7yhxBxkYt95D7iP4Uu4LC0irjFm8xGn0zWXrTB8oagAkHgv
         26Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376236; x=1716981036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0cmjeO4AWJjXgxtd/DzrwOW0GDT9l0zaX03UCUQBXo=;
        b=Cc6pA9VE5979bHbM/K8bdrUW/KWSeB+rwZLMfcZiMNv7b357RbklSGAmzo9VZ3eqt7
         woHNXduLdLiTmur5+l5pUYzBgxY+nHwqoraMaWTOiUNm5nI+yyQNfPH65/dxUSpys3wD
         pOd1J977ekuZGJzZiJZptGGmY4EN6QX97DO/ioGkVTeqRyjsdeVggKTEw5ru4MFp0S2C
         PggBqxVVOOi/FVnmHXvQQ6t1+fBKCfRgr11CwgcwnzwAsNgK56YcPyIgw30MLDV+1Fjl
         i5Yh0bLfT4mACmrdjfIgr2HgxyR4CIKDJ3m9tBDXMj4UBDNNsvfperrStqwML1AbSNZj
         1qgg==
X-Forwarded-Encrypted: i=1; AJvYcCVR263MZ06gXebvhnvjjEKbjW0/wou4tgJDdc6orvg5NtC8CLHbTOLrpjjLbt85PhFSiPKsKRvxPD543JLmmuzcRoO+Ha+TzfKq7mAU
X-Gm-Message-State: AOJu0YyUmK1bZRoSh+sfxHbj10avlaGv+udqLu/7rCKc2MOxXPZIvO0y
	D7WBPrx6LPaBflLoAn5AFq/wybRVdTYjWp3Svq2zshjhnglLymqB
X-Google-Smtp-Source: AGHT+IEhcrjQ8jC7jjgrcEeeYF+XUZ7zdFT2iARO9Tu73AJS2MFiGASJClg+Ts7YI7nFKWAtYPzx0w==
X-Received: by 2002:a05:6a00:a92:b0:6ed:21b2:cb17 with SMTP id d2e1a72fcca58-6f6d6089dccmr1690796b3a.4.1716376236322;
        Wed, 22 May 2024 04:10:36 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:10:36 -0700 (PDT)
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
Subject: [PATCH V16 21/23] mmc: sdhci-pci: add UHS-II support framework
Date: Wed, 22 May 2024 19:09:07 +0800
Message-Id: <20240522110909.10060-22-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522110909.10060-1-victorshihgli@gmail.com>
References: <20240522110909.10060-1-victorshihgli@gmail.com>
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
index 025b31aa712c..9c87898a1b03 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -40,6 +40,7 @@
 #include "sdhci.h"
 #include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2161,7 +2162,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2169,6 +2173,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
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

