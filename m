Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6519992B;
	Thu,  5 Sep 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531694; cv=none; b=Nf1H+iAqN6/PWSUPHvGoh8UNeVd45cCsuRdND1EpoyCmhlYkXZP3GhUZov1kueVxIjiNmqoIP5AudJyqJHmMq6Zz+E0AyOm/GpwCj8kg2PaGT2LWbdjogGJFzd/6FB2/wR1crUTGfuYWAB7YLT8ZFbP159UCDxDf6y03w4KdAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531694; c=relaxed/simple;
	bh=wwTPC4r8iYAP8GeBuLmgFlyM4VpaIOspAq1+/oVWpDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijb/eHfZI/OdvPUB+0uKARWvGssnGqRwE1ApD0Feu7hXCWQJrPjDYMwBu+bmDPL1Llp6bmpHUQLIAwXpxtdMPXqjefeSir1qK4b/eYxYcmorUsnk6pCiX0fpz98zNbo1mZpT+Js/czKHBzpt2abotfdVUNprGrdyG3IDChhp0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTAaq+G2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTAaq+G2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2059112f0a7so5702135ad.3;
        Thu, 05 Sep 2024 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531692; x=1726136492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnvrWqmELtAkmW+kIijtP880LPZaPGwktrrUKOc9JZg=;
        b=HTAaq+G2eRDL9YBSJxAefyoeYxf8BFmLbjp6KRNq4nWeyaRUa9ehwi/C1sI5RMhWeV
         fEN8eFLDuP+zg/O70vtfUaQF6A9c7JwD5yWFHokO+YtHksdR2n5A183nkbo8XRuFon+7
         IgtvIQe4xpMv9C4Hrpm95dBi6s0jTV7geNfJ+tzE/UoBB7OdPK2t8MFSTOErIzrSH2R9
         ivezqwOgt/qitRTTIAt5/EENIFEeDwsQ1Su6Y23EKYos8Icu8KBiLvkgcoazqVjTlPLf
         zZVe5ic9pf/U0CxamDkHTuKhSE8pvBewwQ4n6qK67t+1hmNekk45RhnCpoB3XpSs0uT8
         1CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531692; x=1726136492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnvrWqmELtAkmW+kIijtP880LPZaPGwktrrUKOc9JZg=;
        b=qjS6EwZkBN98qHxJOpaFeZB+GJzk5UlkhSUyYQadXUtX7QthpPJtvnalrxUEUQwujG
         pIYg9stY56Gii3x3tiIjGNRIl5NXJSH8BCJtpnapD20yRVmEnBK5B/8n4OYpJNrLTH+c
         /YdPonQG6nSyyIYCSFx/2C/tJbfZt+uFw40IRex8TZjqxn7W9KZlIlvAx5IMiFVyG0tJ
         1ImaX+BsYuoTuljf8NGHcawyW7W1aQJPeBGEZuKLuwOjtvopB38P43jy2p2jr8X8kPVD
         7q+jvUr3wbYykkGFCHUBCmesFttav+v12DdGn31lxsea3HAUwnQu2vQRQ8DbX+C0zPHl
         ybow==
X-Forwarded-Encrypted: i=1; AJvYcCVME0h4ObC0KTxStXKOeAj6+E4PDxOaDz5BuRk8B3B8GTHGvKqJFkzM/Evck8Wf1S3vrEj6avM+wGSRkrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsq60g1JDgOe2P+Jq5yhUHGhn6mbaRBSB9dYHJSVWLUmo3yHHW
	9bWC7o+xVOcX02/KXkXmvncXYo4El/7zi9O8Q8SBGCK2kQZKMvba
X-Google-Smtp-Source: AGHT+IFOU5mj6aM8bL9We+Gv+fexfeRZb+zTNTe6oTz5GGtIKkxS/LRB3ROsHHUoC3S6Ebuuo0LCRg==
X-Received: by 2002:a17:902:7c94:b0:1fd:7097:af58 with SMTP id d9443c01a7336-2050c215b2amr182634285ad.11.1725531692566;
        Thu, 05 Sep 2024 03:21:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:21:32 -0700 (PDT)
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
Subject: [PATCH V20 20/22] mmc: sdhci-pci: add UHS-II support framework
Date: Thu,  5 Sep 2024 18:19:58 +0800
Message-Id: <20240905102000.5020-21-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905102000.5020-1-victorshihgli@gmail.com>
References: <20240905102000.5020-1-victorshihgli@gmail.com>
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

