Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10423859F3;
	Mon, 11 May 2026 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530918; cv=fail; b=cGGbObelDPnnCqjy5HqEN43d+6K7W4Pslz9i7DHyBOGhUaFsTKhVeOLQ+fBvon1VZ5mH8mDx1hAk5d3gydtFHBomWOBbAYCcDXgePlX6gWpEbTtZw0tAMkAo9yDd7aJIa89xIY8yhWkJDDx1QC4mtHN4OjBiSDp1IN8eu+u+jB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530918; c=relaxed/simple;
	bh=pDZW/we+Cz0azmKqRgYbJuQIth/j4YaK5nUbgAxap1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jfYl/qluaX1Kp14jZ9M5ZGkpf8UQGC5NtGfrf4IfVxO5G1fh8+d5o1JgQRD6K7maxTsTAFr4VMDivGIoBWQ7zPEAeI1eIaDHX5GnyUGIvS4dAbCtvwb/ZQOq9616Qu9t7JRIU30MTrZtv5pqKS0REBq8rCSKbH8dk1MDZUMA174=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Tuccnd+L; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Tuccnd+L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D30AbR18KgL+oE24ibQeMflMx9mgFqwVUKzitCLpwxxibBXefJ4Qr8PnXs5oLEANdR+RQB7+iOgybILsHmsdhhUYAne6jtJKJeZ43v0DPsshp9q4m+MjjQdAeXgmVS9MIeJOlS2jtdfcGxRu7yNJvkM3XIXqF8qSV0GzmDlHS+LNmDDWc0o6mXzh0Ct58DE5SRuOY1/wgz/B6pAeblCp+ny0xhhYH2DJaBZOs9h+sWlUB2sMeGQJvmckhg02yCU/EHXB8CCM+s85k4KhWNvOLc0674WLG+Lk2S8zRyafQ6+L5VAY7DaLqOT58gnAfTBEJsuA1bIkRLQdZrD65GK6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8to4NlnHz2C6oABzI9wLgsZqgEBe5rKjuvGunXPp7Nw=;
 b=TMlwQ+8wFYNXdTWlZN4678gbkyUhTt2/i/CbPPc5cw7sB/M4PgylBpEpCIdMuD6108+fvhz7f5V39oo9Tsv13MC6gFLzhYevQ9I/S7XFjA/aJ5wYNK0UkhMay23vOogxRwxMD9//jxgv33wrFP5maCgC90NMP3FOnAqv5J53MTD9olIq7BbVGyqEtyabimR6KmHyajsxaAhgbOPFniBAEu++Afxz9uXW9mobwBry5JxgEa+KkvCowK3tS6mzGoc0kChoJUCjKUc/SpEq5KbR97++l/RRY5NFOVp1Ook+IJIKGVQ1zGpHQIT9q1CetYcUt8JzN4lu4/y6t0bFZ8XGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8to4NlnHz2C6oABzI9wLgsZqgEBe5rKjuvGunXPp7Nw=;
 b=Tuccnd+LTazSlTgYac4Ici2eOgCleCqaftSofXTitJ/1w53olO2sRt8p3cE7DZaSTLLT05+BJK5oB0U/elVRiqbJhv0rNE5OgsA9CboAj/ygV8xtDdvQLsI3pPwnN93q0AYJAivahfcKkdC+aHYYFpAO6jEiYhYGzo1pY9an/GpyvE/yys05JhgG5HUhZQPOxj9tdqOeMZCmHJ6qJGlH5rJX2z9eypsIKZhrqWxfwIZTywGZ+2CEOFrNK2Q5bb9wC0qfIZfKbBosETbG/yvDX6SkikeI2NTuMWQRV0vEXVucwnkd+V8wUcPiArCG2P5Sqi3bQaBx2XI62pBKYFVOEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB8296.namprd03.prod.outlook.com (2603:10b6:8:292::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:21:47 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:21:46 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 8/9] mmc: sdhci-cadence: add Cadence SD6HC support
Date: Mon, 11 May 2026 13:21:30 -0700
Message-Id: <20260511202132.5597-9-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9aaa1a-722a-424d-e0a7-08deaf9aecee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|3023799003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	clk/ilpMlt/DPmmLwNYN9iU+EdlWA6b0VCVX2hDevvxKa0fXcEv220UsmyPsrj8OG2IaoNPOafkhScMsBDAUHnsmIX8agZK00trX3hIOr6hUbt0VtoKf7evgkBv59+C7dx5lS2tlCKy/LOd3BbGRbsB77taK0vDsLa/hLvIr4602ZfEthVVLArSjy+FjGMguZzDQGQml3GV9IYR4yiA+OR5GZF0/LVuVVO50YFXoqo16l2sYRR/7ZoEQDf68CUCK1iALGyqttwkvgjF3xFwwPf6Sr2n+bt9Smw5ah3K8u+SlM0Flgt2BIBLHpp1oCAaBmlc+IkSygmJjFs3oYfaSXfXFJx9z455WrOKW72LKb7enJnN6h0PVOrr4IACo8ymgnk4e6Y4lXhqogh5HNo4nQJ2xBJi6Vj4XIsEF6ywsjJ3B8TBmDzYZksyUjUaWWxEUDeXDZ3H9kzdMy3rSNfEBKsiJTPBpsrQiC06P/PrFj+xeTxz9Esm82v7miYmKD5pNFndFt2kY54KEJH/pYLS9RIeOBArU7PGR4FEzJLbPZ0vciZVg2K4P91QzmCwU+PJnVC83uOVH+xJFJnc5s158/G6ASgpxSYLleTO3XGVCNmPv91uHyIfVY2ItLdr/DX1xM28bFfdg5rcxIjbnvx+1hJTV6LE8u6Ei7zmqTZ77SpJwpoqwbfXtLxLwadW9qA8Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(3023799003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLkiHHYXOqV1M/zu/1RsYSHE0ECgyycCBQeIFGh7a1Z2932723G6LUpTBg2Z?=
 =?us-ascii?Q?D4mjiHEyakInNibX11jKpdqTqnmP52H9FS11PMtfcUFgpbbfFCwCKopBeaeH?=
 =?us-ascii?Q?fAxAZzQ2HCK3G+rILDpprPOT6OSqmQJW08QGaO1xOewUg1b0KxMsWW26fGGf?=
 =?us-ascii?Q?Jau2CBW1uZIt2sBstbo9fAyWkbIzLITpe/rmHMyjsVJvwEZnXyyidJkxyTE+?=
 =?us-ascii?Q?Tcl/k7Z0JCQWSloa06Z8jTypAS1DtOpo9iNxPz3pWqH8hdi/wXNn+V2pGwWY?=
 =?us-ascii?Q?xBNW/74QPbhb38s08JFAjX2/+jrjZiBh5mOxSaw6FSRpVd21FWHHwO8XN0Rg?=
 =?us-ascii?Q?NFz3P97QG0IGqv9qR3hJy6AdDvDUZKQeCj48VaR9I+SXoT1n3N46ROhkGEgn?=
 =?us-ascii?Q?m+U6hC1Kcaz2E+1mcXhwcPf6NuJ+GC6Xu4jU2KTZmNszfNV7ppercORtJq9X?=
 =?us-ascii?Q?GIMNBFoIMFBRiUUUFrbNvf9wWl8TIpHZcUwcOmSxS7Qn3u+Im9VXwJXqqUvD?=
 =?us-ascii?Q?YvuClMWmfB/hWURCspfy2m6qWwSZdLNM4gSo+ysUrD9tI+AlT+yZElNPh2HX?=
 =?us-ascii?Q?m1k1LpIJeq+2Ooro6w2vFqyot3SDx+ynWBfP4dNxxKpgM1K2CIfMoTCbhRKh?=
 =?us-ascii?Q?bIJSMMhSOeY9+EONR1LZGjT/WFDMRbpj5znUkxbQSBVnRK8FaM1SoWSWQKCv?=
 =?us-ascii?Q?mTkSCuIqoAyNIQKbErktfG59NooMLnWLzuRDqBiBmMGKj81XEQk7Bg1BPh1F?=
 =?us-ascii?Q?OoUq5HSZMVMCXFIjqwE8x0EcWY0HG9dIL0DW94s4t6Pc7sz3q7DfNhHU8W6B?=
 =?us-ascii?Q?Ds94fN68ATWLScP0sdEgWyQItrNCfUgJOCb7ZrXwzqbTB+TmJ+v56CSnC8us?=
 =?us-ascii?Q?VxLbRGG7GGlwSNgbqOKJWc3OTPCr0t4Kb0b524MNhdqdmfMU/0OwQmn56aHF?=
 =?us-ascii?Q?rw08V7wZ9hnJPgcDnLVZtgrpPTuKnku03FkSPpruwHNllWBQBJX49yAt6a5z?=
 =?us-ascii?Q?9byL13DxV7Skke+Cwjrl5afoyYFwPMBYpjA9pbE0LntfIxYMD14HMApAfRXM?=
 =?us-ascii?Q?KmmvX4ERzavW3TviiP1Q+XFkW1IvFTpept4+rMXenRyQGr9rNnpt7D3cEGk6?=
 =?us-ascii?Q?ARZ8Qhn9oyHLUU6VLSnDcQLWC/aoDVx3o0Jd1o2i0EGWbfbye+dhxaQjQrCg?=
 =?us-ascii?Q?iydm9Nv1HrRCwp3xvb1pobrjl2Q5VFW01yV1/d4YAeoQnBT7hrbVSsrmZdTF?=
 =?us-ascii?Q?OWG3UUL7I2BOC/Rcz2IHlq7D2eb51nh/NArDn6Q9KCUrcYP5l52OgvKOTsnM?=
 =?us-ascii?Q?+oHJUJuryosmBc/nFxIqSrc+aMHJPOV7tjjGs624vjJByYqvMOoMVLkjWN7c?=
 =?us-ascii?Q?naMCaolFnh+U0voy0Gait2+TB7jb55c08O2JXyTXuF7dyATJx92WIuDS0yl/?=
 =?us-ascii?Q?y9GUjFiTS6Q7jkRwrZuMSOv/OHbxxKNBRVO0CVa4wdkozwUd9UKy/V3iXaHY?=
 =?us-ascii?Q?J4e0Pq0X1dyUsRK2MjbQU1HGBrUkPuu5jMu8hxTj0VZ63zmHqG9O+Y/uGmgA?=
 =?us-ascii?Q?Txm6NlqVpFT61Ysgr8ZZAsfmsrbG5LhIK8MDAVSg0J0YK42G5SyEqmejCGzO?=
 =?us-ascii?Q?oW20Un7oMJT4jF0bYnfBd6MXgRg3OhGbj3PqKv1RHMvzU7z9A5swSANSWQiw?=
 =?us-ascii?Q?GXCujv5FfA8HZHLSxE1nm587ehRMixGr9b/yT0w+JsY/IMe4xyXl/ZfJrXDo?=
 =?us-ascii?Q?vQtfvMOa8eyPtFdj1XF8Fkr/yv/eE7o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9aaa1a-722a-424d-e0a7-08deaf9aecee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:46.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6X5Hi65XZipJHLrJA++qG/o5Afksq1EB8RI8lyAJBsdf0qPBr/1TsVzG1rVR/reXg3bRbAl9bGXYZYHmZP3t5F6IWZpxuoOQGcMlORTP4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8296

The Cadence SD6HC is the sixth-generation SD Host Controller used in
Agilex5 SoCs. Its PHY differs substantially from the SD4HC: it
requires per-speed-mode IO cell timing parameters and a DLL-based
delay line to achieve correct signal margins across all speed grades
from Default Speed to HS400.

Support is implemented in a new sdhci-cadence6.c alongside the
existing v4 code, now in sdhci-cadence4.c. Shared structures and the
v6 function interface are declared in a new sdhci-cadence.h header.
The common driver paths select between v4 and v6 PHY operations based
on the SDHCI specification version reported by the controller.

The new compatible string "cdns,sd6hc" identifies SD6HC hardware in
device tree.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 MAINTAINERS                                   |    7 +
 drivers/mmc/host/Makefile                     |    3 +-
 drivers/mmc/host/sdhci-cadence.h              |  113 ++
 .../{sdhci-cadence.c => sdhci-cadence4.c}     |   92 +-
 drivers/mmc/host/sdhci-cadence6.c             | 1051 +++++++++++++++++
 5 files changed, 1228 insertions(+), 38 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-cadence.h
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence4.c} (91%)
 create mode 100644 drivers/mmc/host/sdhci-cadence6.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 27fefd92744c..4856450bfd36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23863,6 +23863,13 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-brcmstb*
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) CADENCE DRIVER
+M:	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+F:	drivers/mmc/host/sdhci-cadence*
+
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-mmc@vger.kernel.org
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index ee412e6b84d6..f3b2f43e751e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -80,7 +80,8 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
 
 obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
-obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
+sdhci-cadence-y				+= sdhci-cadence4.o sdhci-cadence6.o
+obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)	+= sdhci-esdhc-mcf.o
 obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
 obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
diff --git a/drivers/mmc/host/sdhci-cadence.h b/drivers/mmc/host/sdhci-cadence.h
new file mode 100644
index 000000000000..05b8d8f16543
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 Altera Corporation
+ *   Author: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
+ *
+ * Cadence SD/SDIO/eMMC Host Controller driver - common header
+ * Shared definitions and structures for the Cadence SDHCI driver.
+ * Contains private data and declarations for SD6HC-specific functions
+ * called by the main driver in sdhci-cadence4.c.
+ */
+
+#ifndef _MMC_HOST_SDHCI_CADENCE_H
+#define _MMC_HOST_SDHCI_CADENCE_H
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/mmc/host.h>
+
+#include "sdhci-pltfm.h"
+
+/* HRS - Host Register Set (specific to Cadence) */
+#define SDHCI_CDNS_HRS04		0x10		/* PHY access: address port */
+#define SDHCI_CDNS_HRS05		0x14		/* PHY access: data port */
+
+/*
+ * The tuned val register is 6 bit-wide, but not the whole of the range is
+ * available.  The range 0-42 seems to be available (then 43 wraps around to 0)
+ * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
+ */
+#define SDHCI_CDNS_MAX_TUNING_LOOP	40
+
+/**
+ * struct sdhci_cdns_priv - Cadence SDHCI private controller data
+ * @hrs_addr: Base address of Cadence Host Register Set (HRS) registers.
+ * @ctl_addr: Base address for write control registers.
+ *            Used only for "amd,pensando-elba-sd4hc" compatible controllers
+ *            to enable byte-lane writes.
+ * @wrlock: Spinlock for protecting register writes (Elba only).
+ * @enhanced_strobe: Flag indicating if Enhanced Strobe (HS400ES) is enabled.
+ * @priv_writel: Optional SoC-specific write function for register access.
+ *               Used for Elba to ensure correct byte-lane enable.
+ * @rst_hw: Hardware reset control for the controller.
+ * @phy: Opaque pointer to variant-specific PHY data.
+ *       For SD4HC: points to struct sdhci_cdns4_phy.
+ *       For SD6HC: points to struct sdhci_cdns6_phy.
+ */
+struct sdhci_cdns_priv {
+	void __iomem *hrs_addr;
+	void __iomem *ctl_addr; /* write control */
+	spinlock_t wrlock; /* write lock */
+	bool enhanced_strobe;
+	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val,
+			    void __iomem *reg);
+	struct reset_control *rst_hw;
+	void *phy;
+};
+
+/*
+ * sdhci_cdns_get_priv - Helper to retrieve Cadence private data from sdhci_host
+ * @host: Pointer to struct sdhci_host.
+ *
+ * Return: Pointer to struct sdhci_cdns_priv.
+ */
+static inline void *sdhci_cdns_get_priv(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return sdhci_pltfm_priv(pltfm_host);
+}
+
+/**
+ * sdhci_cdns6_set_uhs_signaling - Program PHY registers for a specific timing mode.
+ * @host: Pointer to struct sdhci_host.
+ * @timing: MMC timing mode (MMC_TIMING_*).
+ */
+void sdhci_cdns6_set_uhs_signaling(struct sdhci_host *host, unsigned int timing);
+
+/**
+ * sdhci_cdns6_set_tune_val - Set the PHY tuning value.
+ * @host: Pointer to struct sdhci_host.
+ * @val: Tuning value to program.
+ *
+ * Return: 0 on success, -ETIMEDOUT if PHY initialization times out.
+ */
+int sdhci_cdns6_set_tune_val(struct sdhci_host *host, unsigned int val);
+
+/**
+ * sdhci_cdns6_phy_probe - Probe and initialize Cadence SD6HC PHY parameters
+ * @pdev: Platform device pointer
+ * @priv: Pointer to Cadence private data structure
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int sdhci_cdns6_phy_probe(struct platform_device *pdev,
+			  struct sdhci_cdns_priv *priv);
+/**
+ * sdhci_cdns6_hw_reset - Perform hardware reset of the Cadence SDHCI controller.
+ * @host: Pointer to struct sdhci_host.
+ */
+void sdhci_cdns6_hw_reset(struct sdhci_host *host);
+
+/**
+ * sdhci_cdns6_phy_init - Initialize the SD6HC PHY with current settings.
+ * @priv: Pointer to Cadence private data structure.
+ *
+ * Return: 0 on success, -ETIMEDOUT if PHY initialization times out.
+ */
+int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv);
+
+#endif /* _MMC_HOST_SDHCI_CADENCE_H */
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence4.c
similarity index 91%
rename from drivers/mmc/host/sdhci-cadence.c
rename to drivers/mmc/host/sdhci-cadence4.c
index fe3f7c5109fc..283d22328248 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence4.c
@@ -2,22 +2,17 @@
 /*
  * Copyright (C) 2016 Socionext Inc.
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ * Copyright (C) 2026 Altera Corporation
  */
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
-#include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/mmc.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/reset.h>
 
-#include "sdhci-pltfm.h"
+#include "sdhci-cadence.h"
 
 /* HRS - Host Register Set (specific to Cadence) */
-#define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
+/* HRS04 (PHY access) bitfields (SD4HC) */
 #define   SDHCI_CDNS_HRS04_ACK			BIT(26)
 #define   SDHCI_CDNS_HRS04_RD			BIT(25)
 #define   SDHCI_CDNS_HRS04_WR			BIT(24)
@@ -71,13 +66,6 @@
 #define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
 #define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
 
-/*
- * The tuned val register is 6 bit-wide, but not the whole of the range is
- * available.  The range 0-42 seems to be available (then 43 wraps around to 0)
- * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
- */
-#define SDHCI_CDNS_MAX_TUNING_LOOP	40
-
 struct sdhci_cdns4_phy_param {
 	u8 addr;
 	u8 data;
@@ -88,16 +76,6 @@ struct sdhci_cdns4_phy {
 	struct sdhci_cdns4_phy_param phy_params[];
 };
 
-struct sdhci_cdns_priv {
-	void __iomem *hrs_addr;
-	void __iomem *ctl_addr;	/* write control */
-	spinlock_t wrlock;	/* write lock */
-	bool enhanced_strobe;
-	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
-	struct reset_control *rst_hw;
-	struct sdhci_cdns4_phy *phy;
-};
-
 struct sdhci_cdns4_phy_cfg {
 	const char *property;
 	u8 addr;
@@ -206,13 +184,6 @@ static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
 	return 0;
 }
 
-static void *sdhci_cdns_get_priv(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	return sdhci_pltfm_priv(pltfm_host);
-}
-
 static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
 {
 	/*
@@ -248,6 +219,9 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	u32 tmp;
 	int i, ret;
 
+	if (host->version >= SDHCI_SPEC_420)
+		return sdhci_cdns6_set_tune_val(host, val);
+
 	if (WARN_ON(!FIELD_FIT(SDHCI_CDNS_HRS06_TUNE, val)))
 		return -EINVAL;
 
@@ -328,8 +302,11 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	 * The delay is set by probe, based on the DT properties.
 	 */
 	if (host->timing != MMC_TIMING_MMC_HS200 &&
-	    host->timing != MMC_TIMING_UHS_SDR104)
+	    host->timing != MMC_TIMING_UHS_SDR104) {
+		dev_dbg(mmc_dev(host->mmc), "Tuning skipped (timing: %d)\n",
+			host->timing);
 		return 0;
+	}
 
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
 		if (sdhci_cdns_set_tune_val(host, i) ||
@@ -353,6 +330,10 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	if (ret)
 		return ret;
 
+	/* Block gap tuning is only required for SD4HC, not for SD6HC */
+	if (host->version >= SDHCI_SPEC_420)
+		return 0;
+
 	return sdhci_cdns_tune_blkgap(host->mmc);
 }
 
@@ -388,6 +369,10 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 	/* For SD, fall back to the default handler */
 	if (mode == SDHCI_CDNS_HRS06_MODE_SD)
 		sdhci_set_uhs_signaling(host, timing);
+
+	/* For host controller V6, set SDHCI and PHY registers for UHS signaling */
+	if (host->version >= SDHCI_SPEC_420)
+		sdhci_cdns6_set_uhs_signaling(host, timing);
 }
 
 /* Elba control register bits [6:3] are byte-lane enables */
@@ -484,6 +469,16 @@ static const struct sdhci_ops sdhci_cdns4_ops = {
 	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
 };
 
+static const struct sdhci_ops sdhci_cdns6_ops = {
+	.set_clock = sdhci_set_clock,
+	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.platform_execute_tuning = sdhci_cdns_execute_tuning,
+	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
+	.hw_reset = sdhci_cdns6_hw_reset,
+};
+
 static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
 	.pltfm_data = {
 		.ops = &sdhci_cdns4_ops,
@@ -511,6 +506,12 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
 	},
 };
 
+static const struct sdhci_cdns_drv_data sdhci_cdns6_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns6_ops,
+	},
+};
+
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 					     struct mmc_ios *ios)
 {
@@ -607,15 +608,24 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 			return ret;
 	}
 	sdhci_enable_v4_mode(host);
-	__sdhci_read_caps(host, &version, NULL, NULL);
-
 	sdhci_get_of_property(pdev);
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		return ret;
 
-	ret = sdhci_cdns4_phy_probe(pdev, priv);
+	/*
+	 * For SD4HC, read capabilities with fixed version override.
+	 * For SD6HC, sdhci_add_host() will automatically read capabilities
+	 * and version from the host controller registers.
+	 */
+	if (of_device_is_compatible(dev->of_node, "cdns,sd4hc")) {
+		__sdhci_read_caps(host, &version, NULL, NULL);
+		ret = sdhci_cdns4_phy_probe(pdev, priv);
+	} else {
+		ret = sdhci_cdns6_phy_probe(pdev, priv);
+	}
+
 	if (ret)
 		return ret;
 
@@ -642,7 +652,11 @@ static int sdhci_cdns_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_cdns4_phy_init(priv);
+	if (host->version >= SDHCI_SPEC_420)
+		ret = sdhci_cdns6_phy_init(priv);
+	else
+		ret = sdhci_cdns4_phy_init(priv);
+
 	if (ret)
 		goto disable_clk;
 
@@ -677,6 +691,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
 		.compatible = "cdns,sd4hc",
 		.data = &sdhci_cdns4_drv_data,
 	},
+	{
+		.compatible = "cdns,sd6hc",
+		.data = &sdhci_cdns6_drv_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
diff --git a/drivers/mmc/host/sdhci-cadence6.c b/drivers/mmc/host/sdhci-cadence6.c
new file mode 100644
index 000000000000..34d3570a0bbb
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence6.c
@@ -0,0 +1,1051 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PHY and host controller support for Cadence SD6HC SDHCI
+ *
+ * This file provides comprehensive support for Cadence's sixth-generation
+ * SDHCI controller (SD6HC), handling both low-level PHY operations and
+ * high-level host controller programming. The implementation includes PHY
+ * initialization and timing calculations, DLL (Delay-Locked Loop)
+ * management and configuration, host controller register programming for
+ * IO delay compensation and signal timing optimization.
+ *
+ * Copyright (C) 2026 Altera Corporation
+ *   Author: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
+ */
+
+#include "sdhci-cadence.h"
+
+/* IO Delay Information */
+#define SDHCI_CDNS_HRS07		0x1c
+#define   SDHCI_CDNS_HRS07_RW_COMPENSATE	GENMASK(20, 16)
+#define   SDHCI_CDNS_HRS07_IDELAY_VAL		GENMASK(4, 0)
+
+/* PHY Control and Status */
+#define SDHCI_CDNS_HRS09		0x24
+#define   SDHCI_CDNS_HRS09_RDDATA_EN		BIT(16)
+#define   SDHCI_CDNS_HRS09_RDCMD_EN		BIT(15)
+#define   SDHCI_CDNS_HRS09_EXTENDED_WR_MODE	BIT(3)
+#define   SDHCI_CDNS_HRS09_EXTENDED_RD_MODE	BIT(2)
+#define   SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE	BIT(1)
+#define   SDHCI_CDNS_HRS09_PHY_SW_RESET		BIT(0)
+
+/* SDCLK start point adjustment */
+#define SDHCI_CDNS_HRS10		0x28
+#define   SDHCI_CDNS_HRS10_HCSDCLKADJ		GENMASK(19, 16)
+
+/* eMMC Control */
+#define SDHCI_CDNS_HRS11		0x2c
+#define   SDHCI_CDNS_HRS11_EMMC_RST		BIT(0) /* eMMC reset */
+
+/* CMD/DAT output delay */
+#define SDHCI_CDNS_HRS16		0x40
+#define   SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY	GENMASK(31, 28)
+#define   SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY	GENMASK(27, 24)
+#define   SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY	GENMASK(23, 20)
+#define   SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY	GENMASK(19, 16)
+#define   SDHCI_CDNS_HRS16_WRDATA1_DLY		GENMASK(15, 12)
+#define   SDHCI_CDNS_HRS16_WRDATA0_DLY		GENMASK(11, 8)
+#define   SDHCI_CDNS_HRS16_WRCMD1_DLY		GENMASK(7, 4)
+#define   SDHCI_CDNS_HRS16_WRCMD0_DLY		GENMASK(3, 0)
+
+/* PHY Special Function Registers */
+/* DQ timing */
+#define SDHCI_CDNS6_PHY_DQ_TIMING_REG			0x2000
+#define   SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON		BIT(31)
+#define   SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END			GENMASK(29, 27)
+#define   SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START		GENMASK(26, 24)
+#define   SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END		GENMASK(2, 0)
+
+/* DQS timing */
+#define SDHCI_CDNS6_PHY_DQS_TIMING_REG			0x2004
+#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS		BIT(22)
+#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS		BIT(21)
+#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS		BIT(20)
+#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD		BIT(19)
+
+/* Gate and loopback control */
+#define SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG		0x2008
+#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SYNC_METHOD		BIT(31)
+#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SW_HALF_CYCLE_SHIFT	BIT(28)
+#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL		GENMASK(24, 19)
+#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_UNDERRUN_SUPPRESS	BIT(18)
+#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON	BIT(6)
+
+/* Master DLL logic */
+#define SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_REG		0x200c
+#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_BYPASS_MODE		BIT(23)
+#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_PHASE_DETECT_SEL	GENMASK(22, 20)
+#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_LOCK_NUM		GENMASK(18, 16)
+#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_START_POINT	GENMASK(7, 0)
+
+/* Slave DLL logic */
+#define SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_REG		0x2010
+#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_CMD_DELAY	GENMASK(31, 24)
+#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WRDQS_DELAY	GENMASK(23, 16)
+#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WR_DELAY		GENMASK(15, 8)
+#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY		GENMASK(7, 0)
+
+/* Global control settings */
+#define SDHCI_CDNS6_PHY_CTRL_REG			0x2080
+#define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING			GENMASK(9, 4)
+
+/* Default PHY settings */
+#define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY	2500
+#define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT	24
+#define SDHCI_CDNS6_PHY_DEFAULT_RD_DEL_SEL	52
+#define SDHCI_CDNS6_PHY_DEFAULT_DLL_START	4
+
+/* Scale tuning tap (0..39) to 8-bit PHY DLL delay field (0..255) */
+#define SDHCI_CDNS6_PHY_DLL_FIELD_SIZE		256
+
+struct sdhci_cdns6_phy {
+	/*
+	 * Mode-specific timing constraints (in picoseconds)
+	 * These define valid output/input windows per SD/eMMC spec
+	 */
+	u32 t_cmd_output_min;
+	u32 t_cmd_output_max;
+	u32 t_dat_output_min;
+	u32 t_dat_output_max;
+	u32 t_cmd_input_min;
+	u32 t_cmd_input_max;
+	u32 t_dat_input_min;
+	u32 t_dat_input_max;
+
+	/*
+	 * PHY delay configuration (in picoseconds)
+	 * Derived from clock period and board-level IO cell delays
+	 */
+	u32 phy_sdclk_delay;
+	u32 phy_cmd_o_delay;
+	u32 phy_dat_o_delay;
+	u32 iocell_input_delay;
+	u32 iocell_output_delay;
+	u32 delay_element_org;	/* Original delay element from DT */
+	u32 delay_element;	/* Current delay element (may be doubled) */
+
+	/* PHY_DLL_SLAVE_CTRL register fields */
+	u32 cp_read_dqs_cmd_delay;
+	u32 cp_read_dqs_delay;
+	u32 cp_clk_wr_delay;
+	u32 cp_clk_wrdqs_delay;
+
+	/* PHY_DLL_MASTER_CTRL register fields */
+	u32 cp_dll_bypass_mode;
+	u32 cp_dll_start_point;
+
+	/* PHY_GATE_LPBK_CTRL register fields */
+	u32 cp_gate_cfg_always_on;
+	u32 cp_sync_method;
+	u32 cp_rd_del_sel;
+	u32 cp_sw_half_cycle_shift;
+	u32 cp_underrun_suppress;
+
+	/* PHY_DQ_TIMING register fields */
+	u32 cp_io_mask_always_on;
+	u32 cp_io_mask_end;
+	u32 cp_io_mask_start;
+	u32 cp_data_select_oe_end;
+
+	/* PHY_DQS_TIMING register fields */
+	u32 cp_use_ext_lpbk_dqs;
+	u32 cp_use_lpbk_dqs;
+	u8 cp_use_phony_dqs;
+	u8 cp_use_phony_dqs_cmd;
+
+	/* HRS09 register fields - PHY control and Status */
+	u8 sdhc_extended_rd_mode;
+	u8 sdhc_extended_wr_mode;
+	u32 sdhc_rdcmd_en;
+	u32 sdhc_rddata_en;
+
+	/* HRS10 register - SDCLK start point adjustment */
+	u32 sdhc_hcsdclkadj;
+
+	/* HRS07 register - IO delay Information */
+	u32 sdhc_idelay_val;
+	u32 sdhc_rw_compensate;
+
+	/* HRS16 register fields - CMD/DAT output delay control */
+	u32 sdhc_wrcmd0_dly;
+	u32 sdhc_wrcmd0_sdclk_dly;
+	u32 sdhc_wrcmd1_dly;
+	u32 sdhc_wrcmd1_sdclk_dly;
+	u32 sdhc_wrdata0_dly;
+	u32 sdhc_wrdata0_sdclk_dly;
+	u32 sdhc_wrdata1_dly;
+	u32 sdhc_wrdata1_sdclk_dly;
+
+	/*
+	 * DLL calculation intermediate values
+	 * Used during PHY timing calculations
+	 */
+	u32 t_sdmclk_calc;	/* Calculated SDMCLK period for DLL */
+	u32 dll_max_value;	/* Max DLL delay value (127/255/256) */
+
+	/* Tuning value for HS200/HS400 modes */
+	u32 hs200_tune_val;
+
+	/* Clock periods (in picoseconds) */
+	u32 t_sdmclk;		/* Master clock period */
+	u32 t_sdclk;		/* SD card clock period */
+
+	/* Current operating state */
+	bool strobe_cmd;	/* Enhanced strobe for CMD line */
+	unsigned int mode;	/* Current MMC_TIMING_* mode */
+};
+
+/**
+ * init_ds() - Initialize PHY timing for Default Speed mode (up to 25 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_ds(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 5000;
+	phy->t_cmd_output_max = t_sdclk - 5000;
+	phy->t_dat_output_min = 5000;
+	phy->t_dat_output_max = t_sdclk - 5000;
+	phy->t_cmd_input_min = t_sdclk / 2 + 14000;
+	phy->t_cmd_input_max = t_sdclk + t_sdclk / 2;
+	phy->t_dat_input_min = t_sdclk / 2 + 14000;
+	phy->t_dat_input_max = t_sdclk + t_sdclk / 2;
+}
+
+/**
+ * init_hs() - Initialize PHY timing for High Speed mode (up to 50 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_hs(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 2000;
+	phy->t_cmd_output_max = t_sdclk - 6000;
+	phy->t_dat_output_min = 2000;
+	phy->t_dat_output_max = t_sdclk - 6000;
+	phy->t_cmd_input_min = 14000;
+	phy->t_cmd_input_max = t_sdclk + 2500;
+	phy->t_dat_input_min = 14000;
+	phy->t_dat_input_max = t_sdclk + 2500;
+}
+
+/**
+ * init_uhs_sdr12() - Initialize PHY timing for UHS SDR12 mode (up to 25 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_sdr12(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 3000;
+	phy->t_cmd_input_min = 14000;
+	phy->t_cmd_input_max = t_sdclk + 1500;
+	phy->t_dat_input_min = 14000;
+	phy->t_dat_input_max = t_sdclk + 1500;
+}
+
+/**
+ * init_uhs_sdr25() - Initialize PHY timing for UHS SDR25 mode (up to 50 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_sdr25(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 3000;
+	phy->t_cmd_input_min = 14000;
+	phy->t_cmd_input_max = t_sdclk + 1500;
+	phy->t_dat_input_min = 14000;
+	phy->t_dat_input_max = t_sdclk + 1500;
+}
+
+/**
+ * init_uhs_sdr50() - Initialize PHY timing for UHS SDR50 mode (up to 100 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_sdr50(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 3000;
+	phy->t_cmd_input_min = 7500;
+	phy->t_cmd_input_max = t_sdclk + 1500;
+	phy->t_dat_input_min = 7500;
+	phy->t_dat_input_max = t_sdclk + 1500;
+}
+
+/**
+ * init_uhs_sdr104() - Initialize PHY timing for UHS SDR104 mode (up to 208 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_sdr104(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 1400;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 1400;
+	phy->t_cmd_input_min = 1000;
+	phy->t_cmd_input_max = t_sdclk + 1000;
+	phy->t_dat_input_min = 1000;
+	phy->t_dat_input_max = t_sdclk + 1000;
+}
+
+/**
+ * init_uhs_ddr50() - Initialize PHY timing for UHS DDR50 mode (up to 50 MHz DDR).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_ddr50(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 3000;
+	phy->t_cmd_input_min = 13700;
+	phy->t_cmd_input_max = t_sdclk + 1500;
+	phy->t_dat_input_min = 7000;
+	phy->t_dat_input_max = t_sdclk + 1500;
+}
+
+/**
+ * init_emmc_sdr() - Initialize PHY timing for eMMC legacy/SDR mode.
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_emmc_sdr(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 3000;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 3000;
+	phy->t_dat_output_max = t_sdclk - 3000;
+	phy->t_cmd_input_min = 13700;
+	phy->t_cmd_input_max = t_sdclk + 2500;
+	phy->t_dat_input_min = 13700;
+	phy->t_dat_input_max = t_sdclk + 2500;
+}
+
+/**
+ * init_emmc_ddr() - Initialize PHY timing for eMMC DDR52 mode.
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_emmc_ddr(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 3000;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 2500;
+	phy->t_dat_output_max = t_sdclk - 2500;
+	phy->t_cmd_input_min = 13700;
+	phy->t_cmd_input_max = t_sdclk + 2500;
+	phy->t_dat_input_min = 7000;
+	phy->t_dat_input_max = t_sdclk + 1500;
+}
+
+/**
+ * init_emmc_hs200() - Initialize PHY timing for eMMC HS200 mode (up to 200 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_emmc_hs200(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 1400;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 1400;
+	phy->t_cmd_input_min = 1000;
+	phy->t_cmd_input_max = t_sdclk + 1000;
+	phy->t_dat_input_min = 1000;
+	phy->t_dat_input_max = t_sdclk + 1000;
+}
+
+/**
+ * init_emmc_hs400() - Initialize PHY timing for eMMC HS400/HS400ES mode.
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_emmc_hs400(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 1400;
+	phy->t_dat_output_min = 400;
+	phy->t_dat_output_max = t_sdclk - 400;
+	phy->t_cmd_input_min = 1000;
+	phy->t_cmd_input_max = t_sdclk + 1000;
+	phy->t_dat_input_min = 1000;
+	phy->t_dat_input_max = t_sdclk + 1000;
+}
+
+/*
+ * init_timings - PHY timing initializers indexed by MMC_TIMING_* value.
+ *
+ * Each entry corresponds to a MMC_TIMING_* constant and sets the
+ * appropriate cmd/dat output and input timing windows in the PHY
+ * state struct. Must stay in sync with the MMC_TIMING_* definitions
+ * in include/linux/mmc/host.h.
+ */
+static void (*init_timings[])(struct sdhci_cdns6_phy *, u32) = {
+	&init_ds,
+	&init_emmc_sdr,
+	&init_hs,
+	&init_uhs_sdr12,
+	&init_uhs_sdr25,
+	&init_uhs_sdr50,
+	&init_uhs_sdr104,
+	&init_uhs_ddr50,
+	&init_emmc_ddr,
+	&init_emmc_hs200,
+	&init_emmc_hs400,
+};
+
+static unsigned int sdhci_cdns6_read_phy_reg(struct sdhci_cdns_priv *priv,
+					     const u32 address)
+{
+	writel(address, priv->hrs_addr + SDHCI_CDNS_HRS04);
+	return readl(priv->hrs_addr + SDHCI_CDNS_HRS05);
+}
+
+static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_priv *priv,
+				      const u32 address, const u32 value)
+{
+	writel(address, priv->hrs_addr + SDHCI_CDNS_HRS04);
+	writel(value, priv->hrs_addr + SDHCI_CDNS_HRS05);
+}
+
+static int sdhci_cdns6_phy_lock_dll(struct sdhci_cdns6_phy *phy)
+{
+	u32 delay_element = phy->delay_element_org;
+	u32 delay_elements_in_sdmclk;
+
+	delay_elements_in_sdmclk = DIV_ROUND_UP(phy->t_sdmclk, delay_element);
+	if (delay_elements_in_sdmclk > 256) {
+		delay_element *= 2;
+		delay_elements_in_sdmclk = DIV_ROUND_UP(phy->t_sdmclk,
+							delay_element);
+
+		if (delay_elements_in_sdmclk > 256)
+			return -EINVAL;
+
+		phy->dll_max_value = 127;
+	} else {
+		phy->dll_max_value = 255;
+	}
+
+	phy->t_sdmclk_calc = delay_element * delay_elements_in_sdmclk;
+	phy->delay_element = delay_element;
+	phy->cp_dll_bypass_mode = 0;
+
+	return 0;
+}
+
+static void sdhci_cdns6_phy_dll_bypass(struct sdhci_cdns6_phy *phy)
+{
+	phy->dll_max_value = 256;
+	phy->cp_dll_bypass_mode = 1;
+}
+
+static void sdhci_cdns6_phy_configure_dll(struct sdhci_cdns6_phy *phy)
+{
+	if (phy->sdhc_extended_wr_mode == 0) {
+		if (sdhci_cdns6_phy_lock_dll(phy) == 0)
+			return;
+	}
+	sdhci_cdns6_phy_dll_bypass(phy);
+}
+
+static void sdhci_cdns6_phy_calc_out(struct sdhci_cdns6_phy *phy,
+				     bool cmd_not_dat)
+{
+	u32 wr0_dly = 0, wr1_dly = 0, output_min, output_max, phy_o_delay,
+	    clk_wr_delay = 0, wr0_sdclk_dly = 0, wr1_sdclk_dly = 0;
+	bool ddr = (phy->mode == MMC_TIMING_UHS_DDR50) ||
+			(phy->mode == MMC_TIMING_MMC_DDR52) ||
+			(phy->mode == MMC_TIMING_MMC_HS400);
+	bool data_ddr = ddr && !cmd_not_dat;
+	int t;
+
+	if (cmd_not_dat) {
+		output_min = phy->t_cmd_output_min;
+		output_max = phy->t_cmd_output_max;
+		phy_o_delay = phy->phy_cmd_o_delay;
+	} else {
+		output_min = phy->t_dat_output_min;
+		output_max = phy->t_dat_output_max;
+		phy_o_delay = phy->phy_dat_o_delay;
+	}
+
+	if (data_ddr) {
+		wr0_sdclk_dly = 1;
+		wr1_sdclk_dly = 1;
+	}
+
+	t = phy_o_delay - phy->phy_sdclk_delay - output_min;
+	if (t < 0 && phy->sdhc_extended_wr_mode == 1) {
+		u32 n_half_cycle = DIV_ROUND_UP(-t * 2, phy->t_sdmclk);
+
+		wr0_dly = (n_half_cycle + 1) / 2;
+		if (data_ddr)
+			wr1_dly = (n_half_cycle + 1) / 2;
+		else
+			wr1_dly = (n_half_cycle + 1) % 2 + wr0_dly - 1;
+	}
+
+	if (phy->sdhc_extended_wr_mode == 0) {
+		u32 out_hold, out_setup, out_hold_margin;
+		u32 n;
+
+		if (!data_ddr)
+			wr0_dly = 1;
+
+		out_setup = output_max;
+		out_hold = output_min;
+		out_hold_margin = DIV_ROUND_UP(out_setup - out_hold, 4);
+		out_hold += out_hold_margin;
+
+		if (phy->cp_dll_bypass_mode == 0)
+			n = DIV_ROUND_UP(256 * out_hold, phy->t_sdmclk_calc);
+		else
+			n = DIV_ROUND_UP(out_hold, phy->delay_element) - 1;
+
+		if (n <= phy->dll_max_value)
+			clk_wr_delay = n;
+		else
+			clk_wr_delay = 255;
+	} else {
+		/*  sdhc_extended_wr_mode = 1 => PHY IO cell work in SDR mode */
+		clk_wr_delay = 0;
+	}
+
+	if (cmd_not_dat) {
+		phy->sdhc_wrcmd0_dly = wr0_dly;
+		phy->sdhc_wrcmd1_dly = wr1_dly;
+		phy->cp_clk_wrdqs_delay = clk_wr_delay;
+		phy->sdhc_wrcmd0_sdclk_dly = wr0_sdclk_dly;
+		phy->sdhc_wrcmd1_sdclk_dly = wr1_sdclk_dly;
+	} else {
+		phy->sdhc_wrdata0_dly = wr0_dly;
+		phy->sdhc_wrdata1_dly = wr1_dly;
+		phy->cp_clk_wr_delay = clk_wr_delay;
+		phy->sdhc_wrdata0_sdclk_dly = wr0_sdclk_dly;
+		phy->sdhc_wrdata1_sdclk_dly = wr1_sdclk_dly;
+	}
+}
+
+static void sdhci_cdns6_phy_calc_cmd_out(struct sdhci_cdns6_phy *phy)
+{
+	sdhci_cdns6_phy_calc_out(phy, true);
+}
+
+static void sdhci_cdns6_phy_calc_cmd_in(struct sdhci_cdns6_phy *phy)
+{
+	phy->cp_io_mask_end =
+		((phy->iocell_output_delay + phy->iocell_input_delay) * 2)
+		/ phy->t_sdmclk;
+
+	/* cp_io_mask_end is a 3-bit field, clamp to max value of 7 */
+	phy->cp_io_mask_end = min_t(u32, phy->cp_io_mask_end, 7);
+
+	if (phy->strobe_cmd && phy->cp_io_mask_end > 0)
+		phy->cp_io_mask_end--;
+
+	if (phy->strobe_cmd) {
+		phy->cp_use_phony_dqs_cmd = 0;
+		phy->cp_read_dqs_cmd_delay = 64;
+	} else {
+		phy->cp_use_phony_dqs_cmd = 1;
+		phy->cp_read_dqs_cmd_delay = 0;
+	}
+
+	if ((phy->mode == MMC_TIMING_MMC_HS400 && !phy->strobe_cmd) ||
+	    phy->mode == MMC_TIMING_MMC_HS200)
+		phy->cp_read_dqs_cmd_delay =
+			phy->hs200_tune_val;
+}
+
+static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
+{
+	u32 hcsdclkadj = 0;
+	bool strobe_dat = (phy->mode == MMC_TIMING_MMC_HS400);
+
+	if (strobe_dat) {
+		phy->cp_use_phony_dqs = 0;
+		phy->cp_read_dqs_delay = 64;
+	} else {
+		phy->cp_use_phony_dqs = 1;
+		phy->cp_read_dqs_delay = 0;
+	}
+
+	if (phy->mode == MMC_TIMING_MMC_HS200)
+		phy->cp_read_dqs_delay =
+			phy->hs200_tune_val;
+
+	if (strobe_dat) {
+		/* dqs loopback input via IO cell */
+		hcsdclkadj += phy->iocell_input_delay;
+		/* dfi_dqs_in: mem_dqs -> clean_dqs_mod; delay of hic_dll_dqs_nand2 */
+		hcsdclkadj += phy->delay_element / 2;
+		/* delay line */
+		hcsdclkadj += phy->t_sdclk / 2;
+		/* PHY FIFO write pointer */
+		hcsdclkadj += phy->t_sdclk / 2 + phy->delay_element;
+		/* 1st synchronizer */
+		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk)
+			* phy->t_sdmclk - hcsdclkadj;
+		/*
+		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata
+		 * + PHY rddata registered, + FIFO 1st ciu_en
+		 */
+		hcsdclkadj += 5 * phy->t_sdmclk;
+		/* FIFO 2nd ciu_en */
+		hcsdclkadj += phy->t_sdclk;
+
+		hcsdclkadj /= phy->t_sdclk;
+	} else {
+		u32 n;
+
+		/* rebar PHY delay */
+		hcsdclkadj += 2 * phy->t_sdmclk;
+		/* rebar output via IO cell */
+		hcsdclkadj += phy->iocell_output_delay;
+		/* dqs loopback input via IO cell */
+		hcsdclkadj += phy->iocell_input_delay;
+		/* dfi_dqs_in: mem_dqs -> clean_dqs_mod delay of hic_dll_dqs_nand2 */
+		hcsdclkadj += phy->delay_element / 2;
+		/* dll: one delay element between SIGI_0 and SIGO_0 */
+		hcsdclkadj += phy->delay_element;
+		/* dfi_dqs_in: mem_dqs_delayed -> clk_dqs delay of hic_dll_dqs_nand2 */
+		hcsdclkadj += phy->delay_element / 2;
+		/* deskew DLL: clk_dqs -> clk_dqN: one delay element */
+		hcsdclkadj += phy->delay_element;
+
+		if (phy->t_sdclk == phy->t_sdmclk)
+			n = (hcsdclkadj - 2 * phy->t_sdmclk) / phy->t_sdclk;
+		else
+			n = hcsdclkadj / phy->t_sdclk;
+
+		/* phase shift within one t_sdclk clock cycle caused by rebar - lbk dqs delay */
+		hcsdclkadj = hcsdclkadj % phy->t_sdclk;
+		/* PHY FIFO write pointer */
+		hcsdclkadj += phy->t_sdclk / 2;
+		/* 1st synchronizer */
+		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk)
+			* phy->t_sdmclk - hcsdclkadj;
+		/*
+		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata
+		 * + PHY rddata registered
+		 */
+		hcsdclkadj += 4 * phy->t_sdmclk;
+
+		if ((phy->t_sdclk / phy->t_sdmclk) > 1) {
+			u32 tmp1, tmp2;
+
+			tmp1 = hcsdclkadj;
+			tmp2 = (hcsdclkadj / phy->t_sdclk) * phy->t_sdclk
+				+ phy->t_sdclk - phy->t_sdmclk;
+			if (tmp1 == tmp2)
+				tmp2 += phy->t_sdclk;
+
+			/* FIFO aligns to clock cycle before ciu_en */
+			hcsdclkadj += tmp2 - tmp1;
+		}
+
+		/* FIFO 1st ciu_en */
+		hcsdclkadj += phy->t_sdmclk;
+		/* FIFO 2nd ciu_en */
+		hcsdclkadj += phy->t_sdclk;
+
+		hcsdclkadj /= phy->t_sdclk;
+
+		hcsdclkadj += n;
+
+		if ((phy->t_sdclk / phy->t_sdmclk) >= 2) {
+			if (phy->mode == MMC_TIMING_UHS_DDR50 ||
+			    phy->mode == MMC_TIMING_MMC_DDR52)
+				hcsdclkadj -= 2;
+			else
+				hcsdclkadj -= 1;
+		} else if ((phy->t_sdclk / phy->t_sdmclk) == 1) {
+			hcsdclkadj += 2;
+		}
+
+		if (phy->mode == MMC_TIMING_UHS_SDR104 || phy->mode == MMC_TIMING_MMC_HS200)
+			hcsdclkadj -= 1;
+	}
+
+	/* hcsdclkadj is a 4-bit field, clamp to max value of 15 */
+	if (hcsdclkadj > 15)
+		hcsdclkadj = 15;
+
+	phy->sdhc_hcsdclkadj = hcsdclkadj;
+}
+
+static void sdhci_cdns6_phy_calc_dat_out(struct sdhci_cdns6_phy *phy)
+{
+	sdhci_cdns6_phy_calc_out(phy, false);
+}
+
+static void sdhci_cdns6_phy_calc_io(struct sdhci_cdns6_phy *phy)
+{
+	u32 rw_compensate;
+
+	rw_compensate = ((phy->iocell_input_delay + phy->iocell_output_delay)
+		/ phy->t_sdmclk) + phy->sdhc_wrdata0_dly + 5 + 3;
+
+	phy->sdhc_idelay_val = (2 * phy->iocell_input_delay)
+		/ phy->t_sdmclk;
+
+	phy->cp_io_mask_start = 0;
+	if (phy->t_sdclk == phy->t_sdmclk && rw_compensate > 10)
+		phy->cp_io_mask_start = 2 * (rw_compensate - 10);
+
+	if (phy->mode == MMC_TIMING_UHS_SDR104)
+		phy->cp_io_mask_start++;
+
+	if (phy->t_sdclk == phy->t_sdmclk && phy->mode == MMC_TIMING_UHS_SDR50)
+		phy->cp_io_mask_start++;
+
+	phy->sdhc_rw_compensate = rw_compensate;
+}
+
+static void sdhci_cdns6_phy_calc_settings(struct sdhci_cdns6_phy *phy)
+{
+	sdhci_cdns6_phy_calc_cmd_out(phy);
+	sdhci_cdns6_phy_calc_cmd_in(phy);
+	sdhci_cdns6_phy_calc_dat_out(phy);
+	sdhci_cdns6_phy_calc_dat_in(phy);
+	sdhci_cdns6_phy_calc_io(phy);
+}
+
+static int sdhci_cdns6_dll_reset(struct sdhci_cdns_priv *priv, bool reset)
+{
+	u32 reg;
+	int ret = 0;
+
+	reg = readl(priv->hrs_addr + SDHCI_CDNS_HRS09);
+	if (reset)
+		reg &= ~SDHCI_CDNS_HRS09_PHY_SW_RESET;
+	else
+		reg |= SDHCI_CDNS_HRS09_PHY_SW_RESET;
+
+	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS09);
+
+	/* After reset, wait until HRS09.PHY_INIT_COMPLETE is set to 1 within 3000us*/
+	if (!reset) {
+		ret = readl_poll_timeout(priv->hrs_addr + SDHCI_CDNS_HRS09, reg,
+					 (reg & SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE),
+					 0, 3000);
+	}
+
+	return ret;
+}
+
+int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
+{
+	int ret;
+	u32 reg;
+	struct sdhci_cdns6_phy *phy = priv->phy;
+
+	sdhci_cdns6_dll_reset(priv, true);
+
+	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
+	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
+	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
+	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
+	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS,
+			phy->cp_use_ext_lpbk_dqs);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS,
+			phy->cp_use_lpbk_dqs);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS,
+			  phy->cp_use_phony_dqs);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD,
+			  phy->cp_use_phony_dqs_cmd);
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
+
+	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG);
+	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SYNC_METHOD;
+	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SW_HALF_CYCLE_SHIFT;
+	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL;
+	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_UNDERRUN_SUPPRESS;
+	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SYNC_METHOD,
+			phy->cp_sync_method);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SW_HALF_CYCLE_SHIFT,
+			phy->cp_sw_half_cycle_shift);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL,
+			phy->cp_rd_del_sel);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_UNDERRUN_SUPPRESS,
+			phy->cp_underrun_suppress);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON,
+			phy->cp_gate_cfg_always_on);
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG, reg);
+
+	reg = FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_BYPASS_MODE,
+			 phy->cp_dll_bypass_mode);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_PHASE_DETECT_SEL, 2);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_LOCK_NUM, 0);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_START_POINT,
+			phy->cp_dll_start_point);
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_REG, reg);
+
+	reg = FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_CMD_DELAY,
+			 phy->cp_read_dqs_cmd_delay);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WRDQS_DELAY,
+			  phy->cp_clk_wrdqs_delay);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WR_DELAY,
+			  phy->cp_clk_wr_delay);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY,
+			  phy->cp_read_dqs_delay);
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_REG, reg);
+
+	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
+	reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG, reg);
+
+	/*
+	 * Ensure all preceding PHY register writes complete and reach the
+	 * controller before releasing the PHY from reset. Without this,
+	 * SDR104 has been observed to fail intermittently on some boards.
+	 */
+	wmb();
+
+	ret = sdhci_cdns6_dll_reset(priv, false);
+	if (ret)
+		return ret;
+
+	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQ_TIMING_REG);
+	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON;
+	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END;
+	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START;
+	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON,
+			phy->cp_io_mask_always_on);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END,
+			  phy->cp_io_mask_end);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START,
+			  phy->cp_io_mask_start);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END,
+			phy->cp_data_select_oe_end);
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQ_TIMING_REG, reg);
+
+	/* Ensure DQ timing programming is visible before HRS09 follow-up writes */
+	wmb();
+
+	reg = readl(priv->hrs_addr + SDHCI_CDNS_HRS09);
+	if (phy->sdhc_extended_wr_mode)
+		reg |= SDHCI_CDNS_HRS09_EXTENDED_WR_MODE;
+	else
+		reg &= ~SDHCI_CDNS_HRS09_EXTENDED_WR_MODE;
+
+	if (phy->sdhc_extended_rd_mode)
+		reg |= SDHCI_CDNS_HRS09_EXTENDED_RD_MODE;
+	else
+		reg &= ~SDHCI_CDNS_HRS09_EXTENDED_RD_MODE;
+
+	if (phy->sdhc_rddata_en)
+		reg |= SDHCI_CDNS_HRS09_RDDATA_EN;
+	else
+		reg &= ~SDHCI_CDNS_HRS09_RDDATA_EN;
+
+	if (phy->sdhc_rdcmd_en)
+		reg |= SDHCI_CDNS_HRS09_RDCMD_EN;
+	else
+		reg &= ~SDHCI_CDNS_HRS09_RDCMD_EN;
+
+	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS09);
+
+	reg = FIELD_PREP(SDHCI_CDNS_HRS10_HCSDCLKADJ, phy->sdhc_hcsdclkadj);
+	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS10);
+
+	reg = FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY,
+			 phy->sdhc_wrdata1_sdclk_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY,
+			  phy->sdhc_wrdata0_sdclk_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY,
+			  phy->sdhc_wrcmd1_sdclk_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY,
+			  phy->sdhc_wrcmd0_sdclk_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_DLY,
+			  phy->sdhc_wrdata1_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_DLY,
+			  phy->sdhc_wrdata0_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_DLY,
+			  phy->sdhc_wrcmd1_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_DLY,
+			  phy->sdhc_wrcmd0_dly);
+	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS16);
+
+	reg = FIELD_PREP(SDHCI_CDNS_HRS07_RW_COMPENSATE,
+			 phy->sdhc_rw_compensate);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS07_IDELAY_VAL,
+			  phy->sdhc_idelay_val);
+	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS07);
+
+	/* Allow 5ms for clock and PHY signals to stabilize after configuration */
+	usleep_range(5000, 5500);
+
+	return 0;
+}
+
+int sdhci_cdns6_set_tune_val(struct sdhci_host *host,
+			     unsigned int val)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
+	struct sdhci_cdns6_phy *phy = priv->phy;
+	u32 tuneval;
+
+	/*
+	 * Scale tuning tap (val in [0, SDHCI_CDNS_MAX_TUNING_LOOP-1]) to the
+	 * 8-bit PHY DLL slave delay field [0, 255]. With MAX_TUNING_LOOP=40
+	 * and FIELD_SIZE=256, the result fits in 8 bits.
+	 */
+	tuneval = (val * SDHCI_CDNS6_PHY_DLL_FIELD_SIZE) /
+		  SDHCI_CDNS_MAX_TUNING_LOOP;
+
+	phy->hs200_tune_val = tuneval;
+	phy->cp_read_dqs_cmd_delay = tuneval;
+	phy->cp_read_dqs_delay = tuneval;
+
+	return sdhci_cdns6_phy_init(priv);
+}
+
+static int sdhci_cdns6_phy_update_timings(struct sdhci_host *host)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
+	struct sdhci_cdns6_phy *phy = priv->phy;
+	u32 t_sdmclk = phy->t_sdmclk;
+
+	/* Validate mode is within supported range */
+	if (phy->mode >= ARRAY_SIZE(init_timings))
+		return -EINVAL;
+
+	/* initialize input */
+	init_timings[phy->mode](phy, phy->t_sdclk);
+
+	phy->strobe_cmd = false;
+
+	if (priv->enhanced_strobe)
+		phy->strobe_cmd = true;
+
+	phy->phy_sdclk_delay = 2 * t_sdmclk;
+
+	/*
+	 * CMD and DAT output delays are currently identical, but kept separate
+	 * to allow independent tuning for specific modes (e.g., HS400) or
+	 * board-specific optimizations in the future.
+	 */
+	phy->phy_cmd_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
+	phy->phy_dat_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
+
+	if (phy->t_sdclk == phy->t_sdmclk) {
+		phy->sdhc_extended_wr_mode = 0;
+		phy->sdhc_extended_rd_mode = 0;
+	} else {
+		phy->sdhc_extended_wr_mode = 1;
+		phy->sdhc_extended_rd_mode = 1;
+	}
+
+	phy->cp_gate_cfg_always_on = 1;
+
+	sdhci_cdns6_phy_configure_dll(phy);
+
+	sdhci_cdns6_phy_calc_settings(phy);
+
+	return 0;
+}
+
+int sdhci_cdns6_phy_probe(struct platform_device *pdev,
+			  struct sdhci_cdns_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_cdns6_phy *phy;
+	unsigned long val;
+	int ret;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	val = clk_get_rate(pltfm_host->clk);
+	if (!val)
+		return dev_err_probe(dev, -EINVAL,
+				     "failed to get controller clock rate\n");
+
+	phy->t_sdmclk = DIV_ROUND_DOWN_ULL(1000000000000ULL, val);
+
+	ret = of_property_read_u32(dev->of_node, "cdns,iocell-input-delay",
+				   &phy->iocell_input_delay);
+	if (ret)
+		phy->iocell_input_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
+
+	ret = of_property_read_u32(dev->of_node, "cdns,iocell-output-delay",
+				   &phy->iocell_output_delay);
+	if (ret)
+		phy->iocell_output_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
+
+	ret = of_property_read_u32(dev->of_node, "cdns,delay-element",
+				   &phy->delay_element);
+	if (ret)
+		phy->delay_element = SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT;
+
+	phy->delay_element_org = phy->delay_element;
+
+	priv->phy = phy;
+
+	/* default settings */
+	phy->sdhc_rdcmd_en = 1;
+	phy->sdhc_rddata_en = 1;
+	phy->cp_use_ext_lpbk_dqs = 1;
+	phy->cp_use_lpbk_dqs = 1;
+	phy->cp_sync_method = 1;
+	phy->cp_rd_del_sel = SDHCI_CDNS6_PHY_DEFAULT_RD_DEL_SEL;
+	phy->cp_dll_start_point = SDHCI_CDNS6_PHY_DEFAULT_DLL_START;
+	phy->cp_data_select_oe_end = 1;
+	phy->cp_io_mask_always_on = 0;
+	phy->cp_underrun_suppress = 1;
+
+	return 0;
+}
+
+void sdhci_cdns6_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
+	struct sdhci_cdns6_phy *phy = priv->phy;
+
+	/* Clock may be 0 during initial ios setup; skip PHY update */
+	if (!host->mmc->ios.clock)
+		return;
+
+	phy->t_sdclk = DIV_ROUND_DOWN_ULL(1000000000000ULL,
+					  host->mmc->ios.clock);
+	phy->mode = timing;
+
+	if (sdhci_cdns6_phy_update_timings(host))
+		dev_warn(mmc_dev(host->mmc), "%s: update timings failed\n",
+			 __func__);
+
+	if (sdhci_cdns6_phy_init(priv))
+		dev_warn(mmc_dev(host->mmc), "%s: phy init failed\n",
+			 __func__);
+}
+
+void sdhci_cdns6_hw_reset(struct sdhci_host *host)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
+	void __iomem *reg;
+
+	reg = priv->hrs_addr + SDHCI_CDNS_HRS11;
+	writel(SDHCI_CDNS_HRS11_EMMC_RST, reg);
+	/* eMMC HW reset assertion: spec requires >= 1us, give margin */
+	usleep_range(10, 20);
+	writel(0, reg);
+	usleep_range(300, 1000);
+}
-- 
2.43.7

