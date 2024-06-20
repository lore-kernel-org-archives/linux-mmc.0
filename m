Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3C1AB8EF;
	Thu, 20 Jun 2024 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880330; cv=none; b=MqqsFxZPY+ypEx/yaAFDzHTKwTOowAXx/rIXOiFuWM1yLO8ZZvleG4/b26OWltFvBvT1dpvqTqucTS1XlfmmgB/9FGRH4bqWk1VonUOwmRL+hlQliVVSWCqJ0NbfABLXTrBrKKEVo8PfkMGBS2hVA6s/nt9vLhnPMuVwC24KHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880330; c=relaxed/simple;
	bh=vENF9HCmcpJXEqgwxvddYUAdwYA+NrUfNCsZT+T4wFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLN/QO4LwAqM99N5JS6lWNztmUJwNTgaWpH2h5O3XXtPD6Zbe6SISYWWwVtadw/myBpciyZ75rwmv3BElZY8wYtYX1s0Pkxkuut4RzM0Y/e7Ksy/VhMgunvq9+qX3CcsLrOQFX+AMlzPuxv5HjIjhQZFQE1+LZ5f3t9y3yUm7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9XJG8mn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9XJG8mn"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f700e4cb92so6600215ad.2;
        Thu, 20 Jun 2024 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880328; x=1719485128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4ulBUi6egoC57FE+2wADM8HkpJFXf6Ty5HbDsYr4Os=;
        b=c9XJG8mnnnp61HQ4shSHsX1Zct9cHpL3m+HIxnF+hZV/iL+nBsQ4SBA+9TscsjoScg
         UT7QPwdeUetowiBjHIXvFQycqNKaK3Fs3HCOevARTa1DejDYAYy6VVyY8NYr1/OYnR2o
         b4jIQin7DmKm/l0RZGUkZ+YjRhnogVPEIop2d/YunX9pwlFdf4GYpXTpXiPm2WaOuNdd
         yL4545KS1A74ZoAQpfCawhbwI6qYqo4hfzejjGVpC09ThSqM+3nZ0zG4VfkeAkLElCvj
         pLqhxdZgfAHQ8CpvbE7UedMYASIF55zGoqgCsZfIx4fEja/UlPgx7zGFrESVMmIdAq5k
         L/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880328; x=1719485128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4ulBUi6egoC57FE+2wADM8HkpJFXf6Ty5HbDsYr4Os=;
        b=Wu3DP9k+2nq9RtVAPJ1n6tyF10/A3HNyMLMLcW/XsIgqmDvepPu+kTb//JtEkfXHHf
         FNfkd7GCKAfl0uzEbg9nEcpFFYckaukXnk5sx7qxtT2tpHrVDl+3F0D+vTsP+X+0zNpu
         mc2X2zNE2Miwrhun1S3XdqIn6rzhRnfh98gTbp45oyBHAN288S3Kra/0ntlVEaTIaFaj
         vGgxIUyEpWzj6Z74tCiikkoFdvy0ZefQvPV4dVjoqBfF/Lh/bKrwzvXxR5/MoEJ1+VEZ
         3plyg+GNFjRZaLOiJ4CbVbpK5pMsIMzaaV5zllO9uJOr9+SX9tZbqU+ZdX1QgLBuWV+h
         8gBg==
X-Forwarded-Encrypted: i=1; AJvYcCUDq/K00JFhcBT5kvptHLmJKwZXDvT5Wo8FZbOWFsMICTzFNkf79WhedITuqVrGEyRFzIsX/hGae2IzMiRdTZjnt1IEgbvtnVkVy9eQ
X-Gm-Message-State: AOJu0YxMspL2jtibdrMQ1XbJD8BV5OG3gfLrt/cnqlsI+ZPhgkh58RBp
	IzBbILo2dS3FwV0bWAgeSReygV1P4G47UgrCp7TI759JA+domC44
X-Google-Smtp-Source: AGHT+IG0wHb92/vTJKf4jxx0pPlSVdWZdY9bC0g+ZvgLjS3txM5IC1pn7zQYiy4Eblmx+BGFfnywTg==
X-Received: by 2002:a17:902:64c8:b0:1f9:c8cc:9e18 with SMTP id d9443c01a7336-1f9c8cca229mr15425795ad.27.1718880328090;
        Thu, 20 Jun 2024 03:45:28 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:45:27 -0700 (PDT)
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
Subject: [PATCH V17 09/22] mmc: sdhci: add UHS-II module and add a kernel configuration
Date: Thu, 20 Jun 2024 18:44:31 +0800
Message-Id: <20240620104444.5862-10-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
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

