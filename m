Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC31D0493;
	Fri,  6 Sep 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618149; cv=none; b=pY9fqWHXs9Pj+JNMHQjFrHTBBX75kUMhPwK4SNlUyTam12gGRnrSmcLyEH47a4aCHF+j2C2xk4yYUHIBNzArwZ/bHdXa+WYAUmNzl5Z8TuPdL3Vx9aJvFPtVRB3Iestw0wlbWdHoVEeEbLqHo3Fjj3Fw5oZ5d35kfK0eP60aqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618149; c=relaxed/simple;
	bh=wwTPC4r8iYAP8GeBuLmgFlyM4VpaIOspAq1+/oVWpDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IG2VIGLRoaXXZE2u6A/myoTPZleHkBoc6SPmKsKufQqJTbPytdUQMyRA85Yh/bf453VZZDrWQJxM8qi3ComTZhdgdV0EqlgVPGt3Z0YqH1gtQpbEJ/pnKk2uuUpDlNtA4+cS5qqW9EmdeNeLdXWPMdbMItdYofn9n5bQbaj8xC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTj69KTv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTj69KTv"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718da0821cbso300155b3a.0;
        Fri, 06 Sep 2024 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618147; x=1726222947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnvrWqmELtAkmW+kIijtP880LPZaPGwktrrUKOc9JZg=;
        b=DTj69KTvOTHM5njBQX1aC2Oyyusu/3yAAZhP0yu5ijtxK4hbGSE+TdZbXFkPpOzVJ8
         FV4ash3XEeCKyMcSfbYI++dp1K7ke7W6qMeyIEzM7h6uYyVdtUrIBlixopdw90oNQPyp
         xU5kRXDLqyrutXWH0111/TbTwM1d2smUmk/kN9UDenRLdv2rXqXU8je1dEjWgtf/W8W2
         trcwEhkEAcSh8XX/2mPumr02SdEI7V8oUT2W0LKtIAxHqNBAZLEqMBt7mIO+1xAczJNB
         nGKnuC4dwIUVsAgUVFgV2NCSEelO588FXdtTh8Sv6W/ac+bYZ1cI5l4g+2FPtpqZYkHb
         0KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618147; x=1726222947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnvrWqmELtAkmW+kIijtP880LPZaPGwktrrUKOc9JZg=;
        b=R7Hm+14Z6Ho7/i+h8WsZpXDRp+dIh0ZnYSSwH58zdz5zMxqZlhGAn0ollmqRhBWviS
         eP8Kx+WVZokzKOTvUNeF75FmlRNzFcEZWffH7iBjqnbB62sfkdnF0zisyX6RR1SbTS0/
         QSVIbFrTcA2oie3fqE7M7BgsgMyb3dF5S2DdhKtWL4kfVbBm7+Lg5IJqKPweXrsSPQLd
         p3AgtdCBoklZSixfojFaoyHlNLbNHjroz9pHphH/WeiAI6kcuqX4piiG5Oi1+/oyY7f2
         juynvMVTktm9KkaRzlk9sY5N6O1SXvh13nCSkV6GYZyLI4h1l+gA30P9hwA4EoKXZCN9
         eziw==
X-Forwarded-Encrypted: i=1; AJvYcCWFSqRLdESL0WxmveyWsapD6i9+oMaA2EWKaFd5aI5rUv5FtYyBzOdtVJK/9yrK7ggYtrMGqNFSFXcLuiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywOCmzXzIJr80YOSCUPYXyc9r7XkZ/OG6aWPDsaIbKC+nzCCKR
	P8vxX3rgSsj7J2Nu505OvXhjvSl1Pz1/mS1yrh/ODSIZeCCDZymI
X-Google-Smtp-Source: AGHT+IEdPGa7MXnofwi5N5OB0Uez2El5AJagiPCWZq6hIrr1h+e3kpHdz2FwRESJgbQQyN7hui5axw==
X-Received: by 2002:a05:6a00:99f:b0:718:a3c1:60f6 with SMTP id d2e1a72fcca58-718a3c165d1mr2804360b3a.18.1725618147382;
        Fri, 06 Sep 2024 03:22:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:5f74:48c1:9f66:fb02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717931fca8csm2072611b3a.139.2024.09.06.03.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:22:27 -0700 (PDT)
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
Subject: [PATCH V21 20/22] mmc: sdhci-pci: add UHS-II support framework
Date: Fri,  6 Sep 2024 18:20:47 +0800
Message-Id: <20240906102049.7059-21-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906102049.7059-1-victorshihgli@gmail.com>
References: <20240906102049.7059-1-victorshihgli@gmail.com>
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

