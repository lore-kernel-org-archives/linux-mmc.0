Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C681CB128;
	Fri,  6 Sep 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618098; cv=none; b=ZC43OJVemfiuSLApDMUs35FWqkiiAuTgvfC97y+nRQrdW3pQ6Ej9vLe3u5/Gk4aSRaWosGAu1R/sDrlKKzgAoq8u/ftmXybdL+cgdjtUuSyybUvsynUZV9LEYoXGsC0yaq2zyqKi/uA2y1n2SZ+dnT8+FEflJqykEWR5ISLp1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618098; c=relaxed/simple;
	bh=guM1f/siCslHATM4oinaJJPdY2igGntUfF873uW1+ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O4dou1j3Wo22BSdezTeBVrQt7MgirUWhCn2n1fadSo4AbjT3t/WpEMNQMCiybDCtjkvZlWreO7Sb+fH/ZuDisU9jRfHJnqozTGQG00EMtiAaucLzqHgVDxh0nXNda35Z10gYB63yU9qmXsKNfEQJ1ZOh26fayCDJcpLBl+p7KkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEXjki0v; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEXjki0v"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e19b16568cso943468eaf.3;
        Fri, 06 Sep 2024 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618096; x=1726222896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j1RKBUtNF04ic8Rg5kT45Wt+9uKp7eSOnxzixOp7AQ=;
        b=NEXjki0vfYlKcWMrsRqs8K0l3l6cZdVAP2UgWbXSc8VbeMnB4vRAWSDrQUr1W+o2JE
         frFFgsn5dcaPZfnjaVhDdWZ3pGFLEChev4hAyHjqG0uDAjYJ2rQKCsjMxTB/3ICyggWF
         RAoPQnZYCRQxpY3E4v5ey4bfTu90uuflU0uCaJyqIoaiNzcpVX8Gl1D5soqkhDwnp0KB
         rhOryZG2Tv3nJdiRqWR8y8ItmbfrDxvjbsSpEaCqt6S2pldG1vYhCsmdP7gLIZC9QILe
         +f4hHiWnT9PFF3O++GbmM3SDJ9wCmJpiLeQ6ba1aW9+touuItwzHlhTcB+WTped7LwxB
         0XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618096; x=1726222896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j1RKBUtNF04ic8Rg5kT45Wt+9uKp7eSOnxzixOp7AQ=;
        b=pkmRmbrqilL2EvVnTdJTAdpN9yCiAMTaiYReyFOY8e+x44blekDQiChkF2ePdMzKFl
         Dp6hqgxxM55OTN5GYjdKzxzxa2wvIiDDs6vSKZBreAjEuI2fDGQZKOYZ05SwjdrACkkM
         09rMlqgMKup/0nZqcayLxjX3RFN5ibHjs9P4bnRCdU6o1Dyvsh4J1OPmYIKVuA1151Cs
         CP94SO8KE0RC73SXx9vdL61YGcU8/5yhh7uzajbgkvYm575lfOVzJJA7p8spH0Q+RPz3
         4+dG5ZuEE1OecPSgtc9CeCe+gGsyU5PhHnHFQCUT55QJnQQe9HjRugj/p2FivsoO/s0x
         3aFA==
X-Forwarded-Encrypted: i=1; AJvYcCVw3tLQBP7iwR+YKiEwRRZFqGrgk32O044kLzyDEBcmKNacmZ/u8+dH4RWZMJJnRlk53maUzQikUX3gD4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhZcRpc++EGPcqI/JB8bQaeupiJx0D07KPqgcfOJwtu7NK5l5
	1yUmfQtWdWHBS8OEur8EESJNbhE4HwzTAxZa7LLu1U4scFx0Bqb3
X-Google-Smtp-Source: AGHT+IElT4CUYscHjccxTgiaIzIxyDVAHxdXJnfdPJuUFCfFNEqmnh+GOTQWFmU+UaKJZ8GA9gwRDQ==
X-Received: by 2002:a05:6870:af47:b0:27b:5abb:7def with SMTP id 586e51a60fabf-27b82e11008mr2299901fac.20.1725618095843;
        Fri, 06 Sep 2024 03:21:35 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:5f74:48c1:9f66:fb02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717931fca8csm2072611b3a.139.2024.09.06.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:21:35 -0700 (PDT)
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
Subject: [PATCH V21 09/22] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Fri,  6 Sep 2024 18:20:36 +0800
Message-Id: <20240906102049.7059-10-victorshihgli@gmail.com>
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

