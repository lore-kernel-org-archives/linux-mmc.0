Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64E18E03E;
	Thu, 29 Aug 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926587; cv=none; b=OFelLJbBSNyyFViylyzfGnSLTkOcruxIe312WNCdD1pQcQEuB1qC/30K/c7QrnRC9hnP1ji+qglFq1oNSUosSs85JjhA2/kM8+m/7nklTeFLtGFD9y/ALij3R++9VBy/5RUh4Qrc+Kz4W7yLIUPagEgUM5toNNxCPXjBUFAyZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926587; c=relaxed/simple;
	bh=guM1f/siCslHATM4oinaJJPdY2igGntUfF873uW1+ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQ0toagu3Jo0T+N6MJhyCj15TTWckila0wH5KAhOhbBp/axS/50tW28Xky9qGYN267x1oEAl8dbABOh3F3SCrKH8e/6rlxDUgHahmK6CQNeHEL9XJNvETswZCEmXUgoGorSmpeB/OCahiYB7RINSAWpLBGpX9QP3AdnIIK4SRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQGsMav/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQGsMav/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so344104b3a.0;
        Thu, 29 Aug 2024 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926585; x=1725531385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j1RKBUtNF04ic8Rg5kT45Wt+9uKp7eSOnxzixOp7AQ=;
        b=kQGsMav/4U5xGtepGhzD3Oo+wdLQpYF/PwW+0HRP42tBKessxa25cXC7pZryddqdY4
         Dr2ic1DYGcfiqHtzQyPDYyogRGzpu9CdImBXrjtfHTsweh8Kr6nQg+l+2ikoLqt7hZKS
         Tq7b6j+4wiPBupToA2va1/eqqtNlnJKr+dZAYMy5LrjX78i7B70Hh14nFuLlvZ6aZfnr
         aBQSSpY0RYljJX+O3tAvTqd6ITYqDi9vIt6JYU+wSxfFnzqi5SG3ca/Y5gGv6WCR2GJJ
         XY33p88MO/5h+CABlNimdRKei7JX/s6QbhZY3Ldl8dLhkpz/Ia4FEVvpbPoJFie8CUK2
         r8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926585; x=1725531385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j1RKBUtNF04ic8Rg5kT45Wt+9uKp7eSOnxzixOp7AQ=;
        b=WNGuBPKTgiFtOJVvp9nnvm9yWSBQGfzWixkttqZK8ONQiXOzNu6yHsAgC3TLtjpecR
         WpxAk+1NxCXw6q/iQ98oQT5UW5bcLkVROpsldzUGatxPEDZQsg1wQkeXB4y7fJ7pSjjC
         25JbZCsy558BD9xh0NlmOhnEmHhjviUNxhwuig055QaxBZNI4lXuaJNUMYWgJnwSboaQ
         pmbiC4RgLp619URgBEyuMlmYopZJPndh99f27RVQLkNwBBbt5AbB6b5rDItTcrdESn6j
         QBdj+2gOypTq7obiiMtwRb2Cz7mNzA1yrcK2bB5d3RKNrxHq8fxBd2JcrWmRIXa+a+49
         HMag==
X-Forwarded-Encrypted: i=1; AJvYcCXtjNmJQWJk/jX1aVh/q8UmAUK0tYwPg2yJ0kPdn1wkTb/GC3yvaEp+Ui0nC7yCHe807MUXWzSFezJuN+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4D3qfW1HPD1s+V8BrbBflznvqvO+MyPbzEkvJRVo1/sNi27U
	FQj0MjAkqC6rYgmO24OW5uABUN4o4Z8SDWce6fFVlActIKV26Kci
X-Google-Smtp-Source: AGHT+IEUkMHdAycjE8Cnj+pkOdUQkApNte9XNFLy405bkgbzjij0GLOZPLldX3O0UeeUbdwB/7HJlQ==
X-Received: by 2002:a05:6a21:1394:b0:1c4:2132:e205 with SMTP id adf61e73a8af0-1cce1125ca3mr1820513637.48.1724926585496;
        Thu, 29 Aug 2024 03:16:25 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:16:25 -0700 (PDT)
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
Subject: [PATCH V19 09/22] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Thu, 29 Aug 2024 18:15:26 +0800
Message-Id: <20240829101539.5058-10-victorshihgli@gmail.com>
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

