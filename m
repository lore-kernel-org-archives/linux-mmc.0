Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9771DF66E;
	Fri,  2 Aug 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594206; cv=none; b=ISGAqTEJGFohlCpJ9bd4VjH1I2ypqqiDGShmlcKWMn54cjHGIVPnTm8EhyGzjOIt0aatrDlQnYdQ+htNIobJA3McuKsD/gPZJcisPNbyln8/3p7CuGF9JxRjm2yyCoGEGLPLbV/YWrTzMsAZ61lvejQ18dSQbdKX1Al6U//zzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594206; c=relaxed/simple;
	bh=8IQaeum+PtKG2xI+/EJeMr8rGL0SxOnmlRGYQwHfrxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tl5rAQ582xrANxhYa5FdG5ftHMH1C2Ck2+HVR8yoEVu4q4KoHuNONv8FI5cKOJ9rfy4PFqpvB/loLL1YZwS/ZRWd1W/MyLKYZXVTx6wVooIAK732LiZ56M6ih6lMWvW5a5q0r/hPxGSJP7ZUQA0sqOoQsMdNL+BXiOmNQAq5S2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoUp2M7b; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoUp2M7b"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db1d4dab7fso4788013b6e.1;
        Fri, 02 Aug 2024 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594204; x=1723199004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwAfvbcMkBC59Kx5FBEq2qrJR3ePxjXnVll4NWJrBBg=;
        b=QoUp2M7bqkfi8PG26FhUqX/PH3LDf0UqIF/lIUy3TUqFt4/egkXJd0dcaJQU3ITDCa
         VAlf7tz+F0HkAc1Ou0IVc6cYJW+v0BCyZhv7F2zj3j1P13mYNmGeU5GaJCPPJm2i4HVd
         jX7OGWOHLOId4+OKksDKHmZp//tmeiy3VxA0rpO0Sp6LjUTgwNnlFyBj0dQ7NOxli83p
         rmbnRo/JqUXLcsGKPCNlKApmQmKe0+XRCLWR8g8yql6tHDe2DDD4rR60p1PoHSSv4sNG
         GhzMmvbuPB3A+kuoDqFtootDMfehXydRBRebKkJAVbCiwtYMRXvH97k7BHUXCS+qKfvy
         gRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594204; x=1723199004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwAfvbcMkBC59Kx5FBEq2qrJR3ePxjXnVll4NWJrBBg=;
        b=fPvYaU0JniDQqoleR7mVUjC7pWaCm72fzytJIjH6cCPrk2Xt7ssk7xIyyblGyBGD55
         8DWgKXFfWO/ygJ1K+aJSW7TkDrcPJYXru4TBuKM9gjD2AsKmshc+TXQegny5mKMxvcjh
         sS19YouzxRNi1KB3A2xkyEG/dLnwuqs+xPlPbDpqOt7dxRA3oJVhTPOcEcgl0b+YyQMa
         F8D8hkVdqa5yRkixmGtN0GfgGxVfNb/nBqiwB3usFmzZR8lv07SUHAb79+tVmPc9lFu+
         vyAm/2zdAAW599rVRyq/9yXylWbbnL+MeDdYKA4JI9fPaAhw361vyfCLZmvBLaL9UinE
         dscg==
X-Forwarded-Encrypted: i=1; AJvYcCU0xPR/Y3/B8vw1D8u/TquZKwaA3nbgjCfHC9ROiY4D0cJDPmGy1Ws5RAUmMP76RD1nJJRmin7Fh/N21HMA3jfn29JCGY1hRzItzPha
X-Gm-Message-State: AOJu0YxsRdovD2hvSAeCWWGDB6C57Ql1C1e2uaiqK2HB6w7UPznQ+Omi
	Vtg3jrsWgF1GmijAnKvVnX/ZEzM0+S0FdW1cVG22g6QK16fgbFiz
X-Google-Smtp-Source: AGHT+IEJL8BcA+ffmx3sUifEl6mUmFfOJkgtm8txiSVykH2UsEYBTfQvOnSXhJZt7VytC2GaWcssRQ==
X-Received: by 2002:a05:6808:3013:b0:3da:b22d:a5ab with SMTP id 5614622812f47-3db5583ebb9mr2995554b6e.49.1722594203916;
        Fri, 02 Aug 2024 03:23:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:23:23 -0700 (PDT)
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
Subject: [PATCH V18 09/22] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Fri,  2 Aug 2024 18:22:16 +0800
Message-Id: <20240802102229.10204-10-victorshihgli@gmail.com>
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
index eb3ecfe05591..03b2eee9203c 100644
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
index f53f86d200ac..fc064a3030ca 100644
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

