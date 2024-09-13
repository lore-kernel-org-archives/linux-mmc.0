Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C01DA2E7;
	Fri, 13 Sep 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223365; cv=none; b=QNiy06B11Ng99A3RA9tFW2HSjvSsV9IaUK2D6SO0cANCVaPJ6khWWmmxUlx65ChoUXsnVDUaFq/nvh2gWwtpVd/M+HVrNGc0r3L9WY70Mg8xdG0AVL67bhCtVKzCQleUXd7FUxzMW0SDK7766dVVn1ww3eM7XWKx0tv0gBEYzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223365; c=relaxed/simple;
	bh=cPTPqssbzIZVfDNGZdIYNAFD7BVSVTBiliWw762LKXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUrDvy7Ivs3DO3N/HGEcJ6Mj3wmZKQWsi+GDjTVAlfRe69T6BNZ4X4d90KQ+qKIkPymQZYI4xyKGcAZOylEhMs3V9NqsZH6lQNAvS81OqJaRNyJQM4l3iiqP6H0MqIOnJaXTSoiD7ui/FFPfidsjcx5UWJbNqfDUh9/gmnOHeMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn5NsaBd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn5NsaBd"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so2241316b3a.1;
        Fri, 13 Sep 2024 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223363; x=1726828163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB/r5QcrC2W23fyVv+wkCCFI69L0021XWlE3anCdksM=;
        b=Dn5NsaBdJzVtcgKIRigOEu4qt38waDvgFrvPN4PDoAZQ/pe7f82GZTbus8zdejzWlk
         8kG7MMaDPC2XGQLFSOQZzPI57kdSzydlVxDRUEGwm518XHC5GCp1edkJqxzFAEazMGJa
         nnvQKfRVtH8hFI7XzYwQ4ByQj7Vt9CrMREloJDlguhkNoH0x51yyK5CFhaVm4oU0e1OP
         mDqPUuxJ77fw6QCju3pb1W8oCSu4sgqKAnIkocwDnmmG6l05eAVdV//4I6XoDAPIRVbS
         xx5oDTZOCx+vGrcBdAZjKe0joxBiGn518R7cC3HxiV8rxaAxW9zqKzTWEb0vfMeH+fS9
         WySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223363; x=1726828163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZB/r5QcrC2W23fyVv+wkCCFI69L0021XWlE3anCdksM=;
        b=hrXQ6f5e1sJ85ieKfP66MbZmwy4yUXiRLH/FQ29HhcTmN0w/y/Y50XY5SjEA0/NiFv
         lQFqY2ovtZ4p+bIZRg3jR9DXO8WcudJxo3iM2YPpIoa/y3IaR4aLFSflkGYc9k2oZs+F
         tHoS76rQpikx+ngxZa3LvrRFi0Glo52JES5K3nF3P2qCQ/MjMeTJi1cttmKRJhl6XAGU
         l4boPfsWNO9l6PlS7PhqmVbYN6ioZ9oE96J9+E1GDMUGf0G90rbQorJohUQayc5XoTwN
         fbwqayYro8hz2Hi+6hKmWguPMxJ0PkF7/gpiOROEY+Wn2Hhd20LirrlUCWZh0G/irYYq
         3Ycw==
X-Forwarded-Encrypted: i=1; AJvYcCXVvSAiVMX8IV3R0DomfN2Ui67M1vpCagzqazu8av+0PM2n+CcACxgsdRZ4UYLcNpzOl9NFuRGDidGEOdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFRKTgPHKuTwh96u522iuS3TRsIyL/YkKWYDrfXMtCXE9nWWv
	gEJx+kMK4VRDvM1jyNeYeRb17UXkGLfyXb/BbTDcm6IQPy1e/Vjo2Yhfi47W
X-Google-Smtp-Source: AGHT+IHTAbI+3Vu6byLJC1cBH8090LasgimQD5C2vIVWAY/r2a7dr5+mINI5eTsyKhCEFJFp6B7ISg==
X-Received: by 2002:a05:6a20:c799:b0:1cf:38cf:dfb6 with SMTP id adf61e73a8af0-1cf756c3ea6mr9423792637.20.1726223362578;
        Fri, 13 Sep 2024 03:29:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:29:22 -0700 (PDT)
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
Subject: [PATCH V22 09/22] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Fri, 13 Sep 2024 18:28:23 +0800
Message-Id: <20240913102836.6144-10-victorshihgli@gmail.com>
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

This patch adds sdhci-uhs2.c as a module for UHS-II support.
This is a skeleton for further development in this patch series.

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V22:
 - Remove defined but not used code.

Updates in V9:
 - Modify the commit message.

Updates in V8:
 - Modify MODULE_LICENSE from "GPL v2" to "GPL".

Updates in V6:
 - Merage V5 of patch[7] and patch[9] in to V6 of patch[8].

---

 drivers/mmc/host/Kconfig      |  9 ++++++++
 drivers/mmc/host/Makefile     |  1 +
 drivers/mmc/host/sdhci-uhs2.c | 41 +++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
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
index 000000000000..9ec1d6abb47c
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -0,0 +1,41 @@
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

