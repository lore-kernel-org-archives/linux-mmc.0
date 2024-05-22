Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012C84D0A;
	Wed, 22 May 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376197; cv=none; b=cOdSfWm0x8eBF6Nl+j7VWZmpYIVOhIgutYdqJ0WeSER4wfFR9bSqUUFYOgyLZdCCI72mg4w0eBmDJmTpca0cZJjwE4O4Lx0oleClzxpYDASn+/oXRfm0x46qU/+LkUPyuL2RtK1aXa13DOLxb2N86vZJTL29QlvrWiz8nopgQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376197; c=relaxed/simple;
	bh=vENF9HCmcpJXEqgwxvddYUAdwYA+NrUfNCsZT+T4wFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBEEdEehRZR8NUke1HKLTuR6Ee4LEF2zUQjWeIqaZ251ELPu+GR2rkUJYZV2SdhhPO/aTbBJSX6aJ4qqivJJULXj94UP7ziKr8CaEyKzXJqB54/LPR1cwJ1eKfp9domYH33GWa0O0kte6zUB/2Pk57Y8HiCyJ+XBl51nxWxzpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J54+6YIy; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J54+6YIy"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36cc8dbe09aso22872205ab.2;
        Wed, 22 May 2024 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376195; x=1716980995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4ulBUi6egoC57FE+2wADM8HkpJFXf6Ty5HbDsYr4Os=;
        b=J54+6YIyIvVh3eBlf9vgh66dINCHMM8pppcP8sE8YIcagTBV0feVj7Z58Aareq110b
         rk0uWddQncIOF8uew/eCNamGWfwbO8qAB10tT1DwKga8YqYqSlkZTa63fUJ/bAV16xdp
         2+vUWsewKIUZ6ddQdWQlUwjQ/4wag4Wuj8hpNJ0dB8NWQcTRdzin3WZ9mMJYmeMInBll
         0NeOa5wGckfnLIzpFIQ2mbh2RrbPMLehvHa414GRIV88ju+0O5d0xTVDzqxpU0LAoCc1
         vvGjv5BpfJumZUihcXgP7CHlNVmbeBMInUF/wMNNLOW+j/7rFX5R9Ig2qgRaViGsJ7Cm
         NG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376195; x=1716980995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4ulBUi6egoC57FE+2wADM8HkpJFXf6Ty5HbDsYr4Os=;
        b=FqC/oDXSV95cFWBLkocxE3r1xNyMChtji8b/UG9d6D25xm3Q+TkzvcuzHdsq1pY7fW
         3dtV9JSOUFsLlC4XKlpd4UMYW6bxGaaiDBI3HbVO6ojsDjPstnzM/5wZwhB/BQ0vmGnw
         JjlnpLuE8yww+Qk1m1gcyI5XYVVrljQAKnSEIg1VnIHei/K/PWXMb7avgRWrj79lQuFn
         EJF4aV1vT3HkXBcNzSoteL4oAC2razQNDibqyy4rEoT6mSxhrYDZmRm2jl5bY26Cd4Io
         AV47V0jt9dSyiSKZN+9rcL2bV7CXPRJ5SSwoAJ3WSmdmLez33eE9rSJXRSApnhMCooqK
         TSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc42K0CaIJ+U95bytwuY1+qdkhr7xGbPjSlxLKuoh4iPgd08CeTlzT8S2ca3C9D+Rf4ESdNCxIGwDKnKNv8bB+EKu5/Usl+EvGEiBz
X-Gm-Message-State: AOJu0YxJkXnwvcQNGGsO1AWqyaLUOTjdbHIz+viDKeKZnW0juo7qFFSw
	L6NIHK8jT3nKHUCdfyV24XFQjJyZ91Z8hrZ0XJRB/hu50HlS4XC3
X-Google-Smtp-Source: AGHT+IE+Y0TAHuoXeZ0m0OvbMIBJXjolqZox3OGtfJs+zhDRElZJq2ioXB6T+zbKwFoArH3Z2rPD1g==
X-Received: by 2002:a05:6e02:20eb:b0:36b:46b:1338 with SMTP id e9e14a558f8ab-371f9dda871mr19732825ab.9.1716376194794;
        Wed, 22 May 2024 04:09:54 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:09:54 -0700 (PDT)
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
Subject: [PATCH V16 10/23] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Wed, 22 May 2024 19:08:56 +0800
Message-Id: <20240522110909.10060-11-victorshihgli@gmail.com>
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
index bb0d4fb0892a..342bbc3ef577 100644
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

