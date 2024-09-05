Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5019A2AE;
	Thu,  5 Sep 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531646; cv=none; b=gHEsu+Tn9Lh3slHX88PcVDn2n2BuQxBnYI+8gNY03/nw2CRa3sWpC2HYcjuqoHV+F8uouLhC84yMxWAKWJoEpml5a644ihBh3qb7233hAl1m5iKNSD1twYgPb7ly10e9d/oOYXjSVLznH9/V5J4zH/R10iAhVZOV2x4zkvWcBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531646; c=relaxed/simple;
	bh=guM1f/siCslHATM4oinaJJPdY2igGntUfF873uW1+ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3f5L2QRY/MLwIyaVeOz/6CqiuRRzUd3ziJ6V2hJuGIetkhyEmaFM/8/L4+smJK7uL1r8LgnxgkWXc/DWOvyzZj1bcNiRKfP9xSJKOoDNqmehfP8zMxF/apsZq45rWgbjecA034MteV9L9EBTYYrBklvm82/mgEDyw5BtlZRO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyg5AsFZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyg5AsFZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2055a3f80a4so4784005ad.2;
        Thu, 05 Sep 2024 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531644; x=1726136444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j1RKBUtNF04ic8Rg5kT45Wt+9uKp7eSOnxzixOp7AQ=;
        b=Yyg5AsFZsLfNqoJisEieaEbmH+/REQDLwbeNE0wqRC7li4zQoe04zDdBN105YUeCN/
         Y16thPyr0xNlobvVMgRmbUj0OUR4j0s2uyvravclQ+I9r+bod9Zo8e1V+draBu6kVL1b
         oAzuBUQvxAF3xqMqxlOzk+8jhJZUnicSxQJrlxnFIZSYz2c4GziRfEiog6KsxnEfkars
         hADaCp0F733NuSCqPm08QyOg8djpGitO4y/cox+jNl/9bASJIf0/NNvJtmsfdKSvegJT
         CUs16rZWA98X3PTZiZQL/UWUPh4jYFN3BzxjlkEadxIdfD0N6HOZWf0z8Lb9y7RRwF1p
         OJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531644; x=1726136444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j1RKBUtNF04ic8Rg5kT45Wt+9uKp7eSOnxzixOp7AQ=;
        b=U93CidlHbQ9taHb0UhCefVsJeRBQ7JmK0ilYN+INTPGENdcv37NfOb/m+t5Hhwfx7e
         IFKxm7dnr2nR2QD0TUknRf3BJlZVLdzopzqNggR2jytMvzJTIssv0aauBfS/n4uIggvb
         x8mt+IIeKgG95/4GD2WZVxZw5atgjSQ67ncGTeQoMnR+opRKdTa7fO6Uw/A8qjRMWal9
         6aRHOjH5OCSDZVc+9oFAnvDNIVeSHEbRWPv9IXibeS+bdHKF4HaF9OCBRrsfpRI8zQee
         fsXlFZC3eeX2heGbj1Gc6kZZlEFgzqe5ln37q1b+O7vQRAOe3Vq4pRabFwM5ctRGai7E
         ZiXg==
X-Forwarded-Encrypted: i=1; AJvYcCU7B07tX25BRvmdvGN3th1JxpqnlDzS4flymT99xN2ISoopXEYIOLY6WWPOGPPEeJ+8Kcoes6p9Hlf1hV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+WstOD/ChgKEW3vb8KsqAf4UENY8zO6OVyEof2NbRk8LO6oM
	s31Djc2ZOHRB4pf2C9hNiy85NwLisyEYRF4lDWTFGZ6VLJ8AblLh
X-Google-Smtp-Source: AGHT+IH34ZR0CZZPuXE+4aQ5BkpvidJHLvwGeaC9h6HkLipEop9GtnQ6ynNPfKBmNSAUQttRtyap/g==
X-Received: by 2002:a17:902:ce91:b0:206:8acd:ef7d with SMTP id d9443c01a7336-2068add356fmr110742635ad.52.1725531644247;
        Thu, 05 Sep 2024 03:20:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:20:43 -0700 (PDT)
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
Subject: [PATCH V20 09/22] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Thu,  5 Sep 2024 18:19:47 +0800
Message-Id: <20240905102000.5020-10-victorshihgli@gmail.com>
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

This patch adds sdhci-uhs2.c as a module for UHS-II support.
This is a skeleton for further development in this patch series.

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V9:
 - Modify the commit message.

Updates in V8:
 - Modify MODULE_LICENSE from "GPL v2" to "GPL".

Updates in V6:
 - Merage V5 of patch[7] and patch[9] in to V6 of patch[8].

---

 drivers/mmc/host/Kconfig      |  9 +++++++
 drivers/mmc/host/Makefile     |  1 +
 drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7199cb0bd0b9..f636af8a98df 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -98,6 +98,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 	  This is the case for the Nintendo Wii SDHCI.
 
+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 3ccffebbe59b..5147467ec825 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
+obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
new file mode 100644
index 000000000000..608f8ad5aaed
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
+ *  Interface driver
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *  Copyright (C) 2020 Genesys Logic, Inc.
+ *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
+ *  Copyright (C) 2020 Linaro Limited
+ *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <linux/module.h>
+
+#include "sdhci.h"
+#include "sdhci-uhs2.h"
+
+#define DRIVER_NAME "sdhci_uhs2"
+#define DBG(f, x...) \
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static int __init sdhci_uhs2_mod_init(void)
+{
+	return 0;
+}
+module_init(sdhci_uhs2_mod_init);
+
+static void __exit sdhci_uhs2_mod_exit(void)
+{
+}
+module_exit(sdhci_uhs2_mod_exit);
+
+MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
+MODULE_DESCRIPTION("MMC UHS-II Support");
+MODULE_LICENSE("GPL");
-- 
2.25.1

