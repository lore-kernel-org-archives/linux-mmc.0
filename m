Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04362038DF;
	Fri, 18 Oct 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248838; cv=none; b=G9QoMDLIN7XQIshsAPX3kBI52z04EUvwpoT+gdttuH7OnrLz8aEpLjkxoBTIKl1CAOPB6NF/CLPYowZkzmnNqMyWi5MWkFntAqmnaUcz4sM0kiBW7bnw2y0/KxocUxGK3sG13vYpIOut3jtW+QTiXD2XmkSQ3h76KiQAeIxrSnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248838; c=relaxed/simple;
	bh=BwlaZItjOFI0S0BMaprRVSJVkucKk6rCBi3r2JVKQsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qlnqKDhd3obgJBkyQWqkDClBBGDc+njMIJv6QPF8ioOao+CMlgjf6f176O2eLLQfo9YqkSyvhubWxOYsIA/07h0BhWSgKZtmuBfwkIMmokYcchhkcZbJ0vq9GN2oU3LWvbdCAHd4Tv29atJbymjUlkEqmrxBmqkN9QvA243heJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ7rwBYT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ7rwBYT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdda5cfb6so19674875ad.3;
        Fri, 18 Oct 2024 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248836; x=1729853636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQmQrgyNCodGsShz8Y8raLHteS/hxhDy8ogZA9Qt0jw=;
        b=hQ7rwBYTVaousbg1BTAQjEOH6oxbw0nbXHSgc7i9FuA+hDw62GGL21nM1bnICOOmhc
         MOgkhtV98XDelmXXo//rT/oP4+aX0P6KJCPlSvc1BpgCijkwp++vcKkUDATj3pe6GH5a
         WwEqnodGhhNv3qgEd5kUk/EQpUlIWtHbk82RGZSf/J4AGE4xBeaaBZX5nRWAT5Pfzdhm
         H4igWR3jp2VlXfiUmFtJ59jQy8vtGwZprWImrZTEIq06SSwdKKhC26RtycoVGdWq83Rm
         FmwBhPOG0RalFAPDkE3aTypQw7GctShhksLYwcu1EzQLR1S4fL7yC1mDYnyPZ4HHT6TQ
         cKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248836; x=1729853636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQmQrgyNCodGsShz8Y8raLHteS/hxhDy8ogZA9Qt0jw=;
        b=YFT8VNbXMraSYhEp8fFNpVn7gyF1N7GgUxcljsnxVYRrwpgU9BD9/lQxYsmWl1D3Vz
         gNbfu0vcherMaQxNlNA3t0NgOFjF1gq29fsezccg90pw8SBglrA3euJuI054B5zNi08S
         CtsNooJm5wGtRIdO9ei4i7vHKEPAHbdR534sFi9DAkdR4GX9bV6OD2W1At6zYARAI6yD
         tmPpteaHu1lFPbhHUMj577cJRyW0sZ1mlSdKkDFbL9iVzRt6zUJerULOEPOvYGPZw8Ye
         2FAd0z1ke+nuVQCdYTSX5yvgCwFL7MdDo9RrYv+BebvePCD/XYAlsQ1Tf2DCoCLMd1KF
         SRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrKA2peIApU892x9aNYC99lsiNsKafLSHBD2SaKrfkbjghjbDLHT67ydlhfjbCJkIfvuQrR67G2EMTh6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8M2M9gm3uZ+VSKU2WeEKUhbiEuF1PeyDMsDB8dWOwrpN54Sad
	Ca7CFmXXSIBzvGF0e6kHvdnNT83a9uj3m7NAs0ZWZfpmMMQvsNY+UZUIQA==
X-Google-Smtp-Source: AGHT+IHhf7t8DbD3XLuf+75IAUKYiofwBuzdKdmc03Pw2z9hf9gb80JFfjeTm6OjYdDdzRHUdlBpvQ==
X-Received: by 2002:a17:902:e807:b0:20c:5e86:9b53 with SMTP id d9443c01a7336-20e5a79f738mr23510345ad.3.1729248836073;
        Fri, 18 Oct 2024 03:53:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47a:11ee:3789:3bcf:d64f:bc9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fa20esm10237455ad.234.2024.10.18.03.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:53:55 -0700 (PDT)
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
Subject: [PATCH V23 03/16] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Fri, 18 Oct 2024 18:53:20 +0800
Message-Id: <20241018105333.4569-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018105333.4569-1-victorshihgli@gmail.com>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
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
index 0ba5a9f769fb..45df8ddb8918 100644
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

