Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D881D86C2;
	Fri, 13 Sep 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223413; cv=none; b=tDFAsI+Bn0UYm6JgQs427SNBSj/UixkfCFJTa5uKwqP6Fwl0Qe3lOXlTYlccyVGIA3hLRpc+p61gt7oNJfO4gH+Lx12lt814wSIyJ0ROk370pqNBxbG7bigTItnM0THT4buVUk2sD/n0frVNZD62S6F9D8NNinF2+nj9J9gK74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223413; c=relaxed/simple;
	bh=wwTPC4r8iYAP8GeBuLmgFlyM4VpaIOspAq1+/oVWpDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nggj7TpAq99wVT0kpzjuEmRGVScevbH2hAKpR/Rh0pC33S9ZAvA2UR9IQvwJvd7bRnb566ui8tqv+W8FIoODQDwpRHnijY5lS/SE2SLfCkSGEkS2GCMDCg6Lp700wVWFUtFVXZluIDxXVYBdYXPIroLFQ/ChwEooKnqkCO1D3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPWGELuw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPWGELuw"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718d6ad6050so682990b3a.0;
        Fri, 13 Sep 2024 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223411; x=1726828211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnvrWqmELtAkmW+kIijtP880LPZaPGwktrrUKOc9JZg=;
        b=iPWGELuwob5X/rL3aR4y7ptBhriDhH3Rz/stCqF453AecSWu8E/M8TyXycwF/6VrYU
         p/HjYuARkOjPGTNhZZ9/QnW3JS3fycqXh6t1Ygd4JPsUk3OTYDG0rzeqPViIUYYikR/O
         w96imaMUnFtzWtvWuioihoF1FWKQmiWvEOMGMyZuQE1H8Kf3T6rwGZBhsJ3CZBCzmfW7
         zZAKHcUyjkFg54EgoXq8lkb7iptwblFzLY4WsqruVehiVM61q9ly0ATTEj1hLQFQDMau
         9Nw8ukWlP4zcXcSFYovQSUA12LHbGP3fAEV5gMEsLnuOQ7IIHulIjS6/fV68wRQdLDVW
         jcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223411; x=1726828211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnvrWqmELtAkmW+kIijtP880LPZaPGwktrrUKOc9JZg=;
        b=HtTdhxblHgGyGqPxjjbly9SsBveT9tnxKxif2Zk4ZQ9lX/k17qWseQeVW3EUYsG88j
         0V1UdEWyCVTNLqXSn2vefoOvitx6VuXRy3KJgvMuQYN++XafFMc0QqkRTdwONga8ZRGq
         7EQDzse6+caO0VOYF8/Du/NS+aXrUsfp0TrCsIznM9W/Yo/yC51Jlq8rabDGHWMaWMYT
         gRz/okSKnKykfyl5390Cc6kScF3pYj3ZcyydwaU8zJ0svy27t2o6LEv+pHK8vLM9cGiY
         yaandrV8fNoPwrlv4IuYbAtAkR2Q/h7uYwvc/MYffMJzamIC8RP/VNjsVquD5Dj3IpRI
         i5+A==
X-Forwarded-Encrypted: i=1; AJvYcCXpLI5AEYYG0l+XZFPojgFwTfB1E24ZlohAi9O2p2keALUDUrSse7LVBQqd/C2VnIB0HiRrqgOFZc03T8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDqIb7dOe9A1UmeCMZamgC0+H2OgKdBiKzbveTEABQhX3zddUc
	GuW0frKLkQXWIfEAB6mMK4LvVqktmBQjJfSWMjnZTzUxDGAI7Suf
X-Google-Smtp-Source: AGHT+IGmgJsfFJulM10qMogYrsmYdj+K11pYgtG+Xqr8c3+FezyFF/+xQe1uiAJ+UvhILiSNxJBA7Q==
X-Received: by 2002:a05:6a20:d807:b0:1cf:1b7d:8481 with SMTP id adf61e73a8af0-1d112e8bfc4mr3472603637.32.1726223411218;
        Fri, 13 Sep 2024 03:30:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:30:10 -0700 (PDT)
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
Subject: [PATCH V22 20/22] mmc: sdhci-pci: add UHS-II support framework
Date: Fri, 13 Sep 2024 18:28:34 +0800
Message-Id: <20240913102836.6144-21-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
References: <20240913102836.6144-1-victorshihgli@gmail.com>
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

