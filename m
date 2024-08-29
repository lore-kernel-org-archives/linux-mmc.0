Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E8198E75;
	Thu, 29 Aug 2024 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926634; cv=none; b=Qb6d6axvULjdfmE5SGeubiJXNIGfJxuCoHoEJ0gRJEGQ9B12tafKj4GlSkSBIk2xl7RSVPhgp64pp8bENToRZTCvGClEJLbv43XWLP2qdnPE53Lr2Z03c7He8YodVYnP4DZw+QxJIcxkGAeSJrPJopOucSYVuifLgrc0VZ6/OHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926634; c=relaxed/simple;
	bh=wwTPC4r8iYAP8GeBuLmgFlyM4VpaIOspAq1+/oVWpDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdLwxTxzTYWUuSSTFwI7BCntyM+rRSBVPIy6CLofiRAy7ISSxuz2+xqurYces1UVQ7HYVbjGYUAE5J6SFpcReyqNlv/W3hoOojtipuMDW+M68/vX/3iAYbHeqZ/pKFDbbsMiXRoeHc+DwUGsXA1zvnqRajdg9B57spa5AwOptc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc56dzxv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc56dzxv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714302e7285so403452b3a.2;
        Thu, 29 Aug 2024 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926632; x=1725531432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnvrWqmELtAkmW+kIijtP880LPZaPGwktrrUKOc9JZg=;
        b=Kc56dzxvOx02PXDTAEDPs8cabNJOgfLPa+0aR2I5HGQQBDf184b8oQqxAKhlraIQiL
         Jh9HUV0lw7aDd8rqAQqrToR8oVF+8yPgHUd0u4YLnJmo7hIY34U+YcDRblhmzLv5qswK
         Ev2xGqMNU3PzMrZABZwhSTC5tkXoRcMqMc8U0UxCqwp4rIu5STzd0buMhqgoWjiPEGJD
         SD5nCGlQA5u9ensA+6TkfaXwT72OIod+ISqzhg9BwIkmS6wuJT+juoIhNextu/KN2FLP
         D/gx3H4U6RaTfYbnN8MSAbyinXeJVNqnOw6CdtJikPlzgNuoLDzmfRrmTHpUvou9vt8v
         qjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926632; x=1725531432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnvrWqmELtAkmW+kIijtP880LPZaPGwktrrUKOc9JZg=;
        b=pu5AhToamG+w568WXYatchPkeR9kuKibSBIqlrAn1Fa9YjhX7DQi9RiJhQwLgd2x9L
         14SPC75XeBWE24yO4fqXYKUR7RP0pNLDvMjkCQyrhlubTX85liQuq4Sa9dExDDfF/m2W
         ePcVihKcDITj0ZB6pPfqqhc+ZoAYUkTMAAuLHTKmSCNREF4uq4LllS36eYhQlSCJhyyO
         PeLvg68X8fvmR3nxfhmzBBI65RfU6750htZw7zmx/s343MQoHIShhSb671Ne4AWC4xK+
         rmrov1B3QAvrcTbfsu8Hm4d4YfdOvoOlxb+R54vy5DmmeXv15We189rL6m/ouGvZzcHc
         ckXg==
X-Forwarded-Encrypted: i=1; AJvYcCUrwC+mqNANVjQ7ZFwfJ6j4UusqsktzQ4doMqrnIPCjNqbsjSo/mdAzhM0VTtZUU/rJlG8rG0BtoX+WMSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3BrNObv0JsT3YPl2O74PVAKVr6wc2Z/W1oQUyCBMGsGna1RJs
	r1N8iLaDTpLtapDBT9EabynZoy14gKnsxU8Ypqdfm/oN7Rw3wjgp
X-Google-Smtp-Source: AGHT+IE+F7lLnKIjhGbxQrd4qEvBZj6ijxNlR8SVZXSx71rB7295D6J6jbEabc6pE/exPogec+st+A==
X-Received: by 2002:a05:6a20:9f09:b0:1ca:2789:c3ad with SMTP id adf61e73a8af0-1cce1003843mr2217886637.4.1724926632328;
        Thu, 29 Aug 2024 03:17:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:17:12 -0700 (PDT)
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
Subject: [PATCH V19 20/22] mmc: sdhci-pci: add UHS-II support framework
Date: Thu, 29 Aug 2024 18:15:37 +0800
Message-Id: <20240829101539.5058-21-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829101539.5058-1-victorshihgli@gmail.com>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
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
index f636af8a98df..70d37a8c3613 100644
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

