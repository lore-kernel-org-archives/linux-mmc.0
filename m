Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE283FD96E;
	Fri, 24 Jul 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904633; cv=fail; b=dysC7vFNeCATTC13GaxKjHBKPkJUBnyytDVOWDiIDpMyskxkPSlBfaPd7/PgEUxsIq3UL1pWib7zTbI2+MhkQMa5n5Jcqok9+K+72cQ6GuYOMKhiIpZO9tEQ2GF6AAc7Yz3QakevfxqFqaln7/dRasVI6At4ks0aHLFdPUmiA3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904633; c=relaxed/simple;
	bh=MITb270l9zRzD5fsmPYhmOHBvOKPk1fcA5kBcWpGHeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDREqEJ7keJzkXGxMXdqTUeoKcVsP3A6YeGikjiE/9OCqvYR4kEY3WxmX1dgvnGzI22Buw6hGL5P+nlFFGGKjuNxiAm+s+Q7+LbswHUOyis5nXgn+8Zae8Y8PIx+t3vhHZvkK4EcEPZ0YwcQVv/1BpOwLpvVeeJd/oHQat4CpRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=rEb9LnZm; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="rEb9LnZm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydQcFCPVe5C765URaV9fH2E4JOYng8c8N6nWshgCqxbhrWrJ1KDXCBVG68Q4c+EP5r1WD/bRCx6CcGqBbdtOH/D2vxv/ppVDvSy0xUysJg9+umYt9ij+HCrZUkpblBOfnwOwXvyH4emQ6IyAsfepy0Z445Ds26f+5rHsFs0ya0js8h0MxWEQ8t2vW13L/ZSSmhzusqOOHsCw6/RXrlmpmw9n9C2pqxrSRuj0T5j0Z6sNFOz7ZY/OYBYeSpS7ime0UmGOvHKBiLtrhRNdUnwCn04+VNXWzobuyir2zZ8JBtVPiPCxdyAk+DAy3eI67kk5ssWUzKtEWeuniohhiWivNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QCP7qnlStcKyvJn5dI2wzITUQ5/ExV7fh7FDic8DlA=;
 b=vddbzk7FAPWogcPxyRxBhUrlJzL3OoSuQ/wGK9eoZ6dVtFL2HrePmMHISdOhCJGedU65LsCzDhUpvYqYoELblPQtPf8DW2vmIk93o6/E6VnqsSX6smCYjvY1UCkFBuAVZvELq1rivcg9VDjpgB2qkZWS7ih3WZCPt9FTDd9c45qeejyoxjnEhbLFYh+x20+Cc4JzY1Re5JpvnefCA016zKLAmP0RLf9Swvf7G6Z1mbI1zRzjySal95ufqCAo/HOJh+Wj7xWEngWRMFFR/Y8nFCOHD8bima10Z6+BMFwxy/eeyyNFI/kB6TeEHZLYg4dXVDhS+umBRgjecLi7Q5WzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QCP7qnlStcKyvJn5dI2wzITUQ5/ExV7fh7FDic8DlA=;
 b=rEb9LnZmnkbgUYffBm6ZYgCJTsLmNIFRdPcWsQtYYJ18cEB+VC/BDSIP21e6ISPEzb+8ultjr2OqhWwrZk9Zs0nB+NCWQOEfPVY7ndrsXmZeM1Ogfu1Cyz85Z0OrmpoC4SlpKQCN2oB8OuHpUw4ijU54jB8yjDT0xTAcV8S4BqFqrDg+GKWcAbLcGS0msu6YW4Hr/roME742j7YozpzOEUaIKrhn9AMGB73wSXWW7LCgB9Dz/ikz5f0HVhaViprMWYhMw92PsXD2N1d1cENl6iEo1F5lLUth/Ci7pijgjzKxdAqNJcccO4xtwYte191acemqK0IDg78pi/F8G0pesA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7904.namprd03.prod.outlook.com (2603:10b6:806:42a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 14:50:24 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:50:24 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] mmc: sdhci-cadence: add Cadence SD6HC support
Date: Fri, 24 Jul 2026 07:50:06 -0700
Message-Id: <20260724145009.7456-7-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7650ba-5a84-48c9-f10b-08dee992e48a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|3023799007|55112099003;
X-Microsoft-Antispam-Message-Info:
	RZ7rWPBprYtJCUTuH1o63JgFuikoJgtMSBiaNd6tp12vNdswJcj1GrOUNd1KvtlAAS35NrKXg1zIkSjTXMt5mhFQswHUOOSczqcigay48WAU1sHq4URuEqoexVp7cqv9kCet/cpEONRGGM4cXTNRDAoMYvBh4V4GSrJO949Q2PaDjRNVEYZI/JElv79j6FCsQykp3KyI+5arnDwq9UuK+LPiFqrqyqgzakzXYF+9BYDbojM5M3dh2eEwzTQCEk9YlZZpcEnyVjWW71UY7VwH1tpTgw5LHhYYvv7DjxQPRFKPms2KheGuth+U4gnby2pT7Zb1OTCBzH/Ga3dHNJ96KfOO8b5BSEUDbNgzl/QIxh7bsNs/vHOJ39XyPXEm75oj6oj3WMdfev5cTAUTviMD5ccot4X0E+dTX9Yn5wRq//6UHaAxjlJVBG7uJbseGzHtIq/zUfyN0Cs4aXeqIH4aItCrNKC78I2SENsvesggDIQ3uQealLfNoHAJKuw3GmAr4iDiWgaGTkCXrWXETxD694MVzXkFJRpAtMLV4aZnsKGPfDJ+6afT+r7fDiLOo7ndtPG6bPH3h8rFYONcZZJh/VtLzX14BssxYkNfPgr9WetNj8UptTirYdJbikjnr6ZuQoEBU7bom3Y2XxZx1wUpNgpsHOE5uvHZvQcxBqzOpgA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQQf+lqF6F3jwr19V4DukIFFAcv/bSKQtgcWbamcINiOa559GjCc2nZ0DmSl?=
 =?us-ascii?Q?oCmdi0fw3iVdgATd6Rh+rpvpKT4H+sY6R5zMNbbBCpC0gvHogsVMgdc81qux?=
 =?us-ascii?Q?jpCJlCwE77DjaSZZJA+rCzGHwXClaZYqAp2KlxkJrShWnHWQg25Rl8TY7J2s?=
 =?us-ascii?Q?kAweHihf9WeIkiaTj5tx/FVrCkiv42SlthfQp1qfjEEDs+JTmGoi8wb8JIya?=
 =?us-ascii?Q?9HZAl9t/ymrCO9czJfe/PJsm2KzjxsJdmCKVZafxenaJ69ndYc+twih5elOA?=
 =?us-ascii?Q?3H+wCyd8kCPlwCMfLchu4gjyIbIizvTiWmqHWpKOYOIfEK3QC29t1re8lLIG?=
 =?us-ascii?Q?jc23NVVuSAfBa/HIllaTCydq6dIr/qbPrQWKGir3e9HJz91Hqjbo8CZs64QU?=
 =?us-ascii?Q?oRKmIgTpjIA82vEghsmF71q1blhNZLu2EM2DcFUFPy2J1u/1JNNVGbcwmfIj?=
 =?us-ascii?Q?ukQVrftkd5KtEutl/ODOfr40BSZwl31P93NPI+uXHRQeHqsf+LNPytZzKccy?=
 =?us-ascii?Q?9cJRcfDAAmoqL7qCdztXcBT77qk8Kiegx8BQubPawMUn1p2jFeg+3QUI6910?=
 =?us-ascii?Q?A/DFHAdW7eMDVv+7PSg9GLtXiFrDT8tyrPP+9QCWF+9+7SsfW9G/1WSvHa+u?=
 =?us-ascii?Q?5h1a7BgdcTV+FA+ra98WEJywQBE9ShKsn1sywyzVDNVKfHB0qUCq9DwN2+XV?=
 =?us-ascii?Q?lF2iJw++Vnj8v1CvcvO+xKEmfJiNxBXAkty/cjIXizAMSzGn6RI//XPjjf2J?=
 =?us-ascii?Q?LyP+NJkak2M79OKdNeK2SAkRajTco/W+Vc1iCf+4urljQIIQNHXTQVhQD39C?=
 =?us-ascii?Q?Zb6iS9xnz5bSgE0V6L7Pu98zoUqXosf5qemzuim6AmXUlcX//KuB6Zu4kdav?=
 =?us-ascii?Q?LKNNP5xmmq+hU1L+298Jga231pBmnv2gVIWxx+6b/YwTC9lklsq9M96tt9lC?=
 =?us-ascii?Q?K1U+sjreHu8OkvgIoFFOXQdkXSefWQAlzAwoJ6/h1F0hcEfMGjnxAu87Ccgi?=
 =?us-ascii?Q?BtuRtaSZfsaB5h6sTsxOiwnl185FpBBTeeYBHMDQF7qjw1JFG538pD6Rn6Nj?=
 =?us-ascii?Q?npvK4aKsx3qxiuWvT5CPLAfsc8Jhvrdb6F7DxNea7WfZbn8D7upL2X3E6gxc?=
 =?us-ascii?Q?pscw4xgx99ZdqmE0NxrecquxMmLa3INZ7pYjEQaGFmIItuNv05siZkRBmO2l?=
 =?us-ascii?Q?i/byuaB09ipIerSH4WFkFBJsYpqbvofOIqRSPgYc/vx2/aTgeEdbyugs6I1j?=
 =?us-ascii?Q?2nt9bSknUwKQbEvAKJYrTsKeDB7tw+BNAPhJ5rbjxPU/gtf0VHtrUE+Uee8N?=
 =?us-ascii?Q?fpRDK5KN3R5SD2TE9Empphf7+lI93wLcI28/u4DeH8iDjo8GzHwdpQ/78m6E?=
 =?us-ascii?Q?f4y08KIiOrMEZrbtPJeiQS2bFLMjerZtzlTKwpJvATraj7Fjxi0QiJOrVYU+?=
 =?us-ascii?Q?hITbDM2e+OWkgokDnbbq1J5GZvDKwKhBzHDeEfFb6Lm//oPMJm1Q17AYJe6R?=
 =?us-ascii?Q?+lv/bRhUENy/Ys8SzG/0WoACPcY07/C+bUgpieg4lHiaE6AlgKVqo9UZmqmE?=
 =?us-ascii?Q?ZtAChNch49HN+CUpPrPMz4lh5epPrI/uaFXiY1gnHR4gkfSpXAu97BOnM0eq?=
 =?us-ascii?Q?hWwXYCsI+3JBWT03CP6odJ4Ft577KX2Eqq8k6F3CEsBmZNSXVzpoAv/R77nU?=
 =?us-ascii?Q?C6mTy3gzTxVSQ04/I+5G63zYfJ5Y9vkKMsDXPFaJo+tnQ8UHqiUPLzXrywsO?=
 =?us-ascii?Q?LhhH5cIpzuvgnd1cijmPryKV4juB2YY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7650ba-5a84-48c9-f10b-08dee992e48a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:50:24.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztEu0MTe5p1drVDjae/VQ3bDL0BvcrXvzelO095hu4m7vvGw0kmiXLxUv48Wc+OP1mgrvqKjTjxvoCMhkPtKe8L50r59HFSEsx2+iRxAYas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7904

The Cadence SD6HC is a sixth-generation SD/SDIO/eMMC host controller
with an integrated combo-PHY. PHY timing depends on the active speed
mode, the SD clock period, and board-level IO-cell and DLL delay-
element characteristics.

SD6HC provides separate card-interface (CIU) and bus-interface (BIU)
clocks, and asserts eMMC hardware reset through an internal controller
register rather than an external RST_n line. The "cdns,sd6hc" compatible
string identifies this IP in device tree.

Split the existing driver into sdhci-cadence-core.c and
sdhci-cadence-phy-v6.c, and add sdhci-cadence.h for shared private
state.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 MAINTAINERS                                   |   7 +
 drivers/mmc/host/Makefile                     |   1 +
 .../{sdhci-cadence.c => sdhci-cadence-core.c} | 122 ++-
 drivers/mmc/host/sdhci-cadence-phy-v6.c       | 929 ++++++++++++++++++
 drivers/mmc/host/sdhci-cadence.h              | 111 +++
 5 files changed, 1130 insertions(+), 40 deletions(-)
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence-core.c} (86%)
 create mode 100644 drivers/mmc/host/sdhci-cadence-phy-v6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a0996faa091..58267c681780 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24407,6 +24407,13 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-brcmstb*
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) CADENCE DRIVER
+M:	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
+L:	linux-mmc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
+F:	drivers/mmc/host/sdhci-cadence*
+
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-mmc@vger.kernel.org
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index ee412e6b84d6..799ce7ad43d5 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
 
 obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
+sdhci-cadence-y				+= sdhci-cadence-core.o sdhci-cadence-phy-v6.o
 obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
 obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
 obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence-core.c
similarity index 86%
rename from drivers/mmc/host/sdhci-cadence.c
rename to drivers/mmc/host/sdhci-cadence-core.c
index 1fb23051a047..18846acc0b11 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence-core.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2016 Socionext Inc.
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ * Copyright (C) 2026 Altera Corporation
  */
 
 #include <linux/bitfield.h>
@@ -14,10 +15,10 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
-#include "sdhci-pltfm.h"
+#include "sdhci-cadence.h"
 
 /* HRS - Host Register Set (specific to Cadence) */
-#define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
+/* HRS04 (PHY access) bitfields (SD4HC) */
 #define   SDHCI_CDNS_HRS04_ACK			BIT(26)
 #define   SDHCI_CDNS_HRS04_RD			BIT(25)
 #define   SDHCI_CDNS_HRS04_WR			BIT(24)
@@ -71,13 +72,6 @@
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
@@ -88,16 +82,6 @@ struct sdhci_cdns4_phy {
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
@@ -203,13 +187,6 @@ static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
 	return 0;
 }
 
-static void *sdhci_cdns_priv(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	return sdhci_pltfm_priv(pltfm_host);
-}
-
 static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
 {
 	/*
@@ -245,6 +222,9 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	u32 tmp;
 	int i, ret;
 
+	if (host->version >= SDHCI_SPEC_420)
+		return sdhci_cdns6_set_tune_val(host, val);
+
 	if (WARN_ON(!FIELD_FIT(SDHCI_CDNS_HRS06_TUNE, val)))
 		return -EINVAL;
 
@@ -325,8 +305,10 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	 * The delay is set by probe, based on the DT properties.
 	 */
 	if (host->timing != MMC_TIMING_MMC_HS200 &&
-	    host->timing != MMC_TIMING_UHS_SDR104)
+	    host->timing != MMC_TIMING_UHS_SDR104) {
+		dev_dbg(mmc_dev(host->mmc), "Tuning skipped (timing: %d)\n", host->timing);
 		return 0;
+	}
 
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
 		if (sdhci_cdns_set_tune_val(host, i) ||
@@ -350,6 +332,10 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	if (ret)
 		return ret;
 
+	/* Block gap tuning is only required for SD4HC, not for SD6HC */
+	if (host->version >= SDHCI_SPEC_420)
+		return 0;
+
 	return sdhci_cdns_tune_blkgap(host->mmc);
 }
 
@@ -385,6 +371,10 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 	/* For SD, fall back to the default handler */
 	if (mode == SDHCI_CDNS_HRS06_MODE_SD)
 		sdhci_set_uhs_signaling(host, timing);
+
+	/* For host controller V6, set SDHCI and PHY registers for UHS signaling */
+	if (host->version >= SDHCI_SPEC_420)
+		sdhci_cdns6_set_uhs_signaling(host, timing);
 }
 
 /* Elba control register bits [6:3] are byte-lane enables */
@@ -481,6 +471,16 @@ static const struct sdhci_ops sdhci_cdns4_ops = {
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
@@ -508,6 +508,12 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
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
@@ -526,6 +532,10 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 	if (mode == SDHCI_CDNS_HRS06_MODE_MMC_HS400ES && !ios->enhanced_strobe)
 		sdhci_cdns_set_emmc_mode(priv,
 					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
+
+	/* SD6HC PHY timing depends on enhanced-strobe; recompute register values */
+	if (host->version >= SDHCI_SPEC_420)
+		sdhci_cdns6_set_uhs_signaling(host, MMC_TIMING_MMC_HS400);
 }
 
 static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
@@ -569,6 +579,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
+	struct clk *biu_clk;
 	int ret;
 	struct device *dev = &pdev->dev;
 	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
@@ -577,6 +588,13 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	/* SD6HC requires a second clock, "biu", for the bus interface unit. */
+	if (of_device_is_compatible(dev->of_node, "cdns,sd6hc")) {
+		biu_clk = devm_clk_get_enabled(dev, "biu");
+		if (IS_ERR(biu_clk))
+			return dev_err_probe(dev, PTR_ERR(biu_clk), "failed to enable biu clock\n");
+	}
+
 	data = of_device_get_match_data(dev);
 	if (!data)
 		return dev_err_probe(dev, -EINVAL, "missing platform driver data\n");
@@ -601,30 +619,46 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
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
-	if (ret)
-		return ret;
+	/*
+	 * For SD4HC, read capabilities with fixed version override and set up
+	 * the optional eMMC card RST_n reset control.
+	 * For SD6HC, sdhci_add_host() will automatically read capabilities
+	 * and version from the host controller registers.
+	 */
+	if (of_device_is_compatible(dev->of_node, "cdns,sd4hc")) {
+		__sdhci_read_caps(host, &version, NULL, NULL);
+		ret = sdhci_cdns4_phy_probe(pdev, priv);
+		if (ret)
+			return ret;
 
-	if (host->mmc->caps & MMC_CAP_HW_RESET) {
-		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
-		if (IS_ERR(priv->rst_hw))
-			return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
-					    "reset controller error\n");
-		if (priv->rst_hw)
-			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
+		if (host->mmc->caps & MMC_CAP_HW_RESET) {
+			priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
+			if (IS_ERR(priv->rst_hw))
+				return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
+						    "reset controller error\n");
+			if (priv->rst_hw)
+				host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
+		}
+	} else {
+		ret = sdhci_cdns6_phy_probe(pdev, priv);
+		if (ret)
+			return ret;
 	}
 
 	return sdhci_add_host(host);
 }
 
+/*
+ * Only the CIU clock is gated on suspend. The SD6HC "biu" clock is not
+ * toggled here as it may be a shared bus clock; a dedicated biu clock
+ * would need explicit PM gating added here.
+ */
 static int sdhci_cdns_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -636,7 +670,11 @@ static int sdhci_cdns_resume(struct device *dev)
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
 
@@ -671,6 +709,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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
diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
new file mode 100644
index 000000000000..2d7972948a45
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -0,0 +1,929 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PHY and host controller support for Cadence SD6HC SDHCI
+ *
+ * This file provides support for Cadence's sixth-generation SDHCI controller (SD6HC).
+ * Implements PHY initialization, DLL management, per-speed-mode timing calculations,
+ * and host controller register programming for the SD6HC integrated combo-PHY.
+ *
+ * Copyright (C) 2026 Altera Corporation
+ *   Author: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/iopoll.h>
+#include <linux/of.h>
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
+#define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY		2500
+#define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT		24
+#define SDHCI_CDNS6_PHY_DEFAULT_RD_DEL_SEL		52
+#define SDHCI_CDNS6_PHY_DEFAULT_DLL_START		4
+#define SDHCI_CDNS6_PHY_DEFAULT_PHASE_DETECT_SEL	2
+#define SDHCI_CDNS6_PHY_DEFAULT_DLL_LOCK_NUM		0
+#define SDHCI_CDNS6_PHY_DEFAULT_DATA_SELECT_OE_END	1
+
+/* Scale tuning tap (0..39) to 8-bit PHY DLL delay field (0..255) */
+#define SDHCI_CDNS6_PHY_DLL_FIELD_SIZE		256
+
+struct sdhci_cdns6_phy {
+	/*
+	 * Mode-specific timing constraints (in picoseconds)
+	 * These define valid output windows per SD/eMMC spec
+	 */
+	u32 t_cmd_output_min;
+	u32 t_cmd_output_max;
+	u32 t_dat_output_min;
+	u32 t_dat_output_max;
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
+	/* Configured delay element (ps); preserved across clock changes */
+	u32 delay_element_org;
+	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
+	u32 delay_element;
+
+	/* PHY_DLL_SLAVE_CTRL register fields */
+	u8 cp_read_dqs_cmd_delay;	/* bits [31:24] */
+	u8 cp_clk_wrdqs_delay;		/* bits [23:16] */
+	u8 cp_clk_wr_delay;		/* bits [15:8] */
+	u8 cp_read_dqs_delay;		/* bits [7:0] */
+
+	/* PHY_DLL_MASTER_CTRL register fields */
+	bool cp_dll_bypass_mode;	/* bit [23] */
+
+	/* PHY_DQ_TIMING register fields */
+	u8 cp_io_mask_end;		/* bits [29:27] */
+	u8 cp_io_mask_start;		/* bits [26:24] */
+
+	/* PHY_DQS_TIMING register fields */
+	bool cp_use_phony_dqs;		/* bit [20] */
+	bool cp_use_phony_dqs_cmd;	/* bit [19] */
+
+	/* HRS07 register - IO delay Information */
+	u8 sdhc_rw_compensate;		/* bits [20:16] */
+	u8 sdhc_idelay_val;		/* bits [4:0] */
+
+	/* HRS09 register - PHY control and Status */
+	bool sdhc_extended_wr_mode;	/* bit [3] */
+	bool sdhc_extended_rd_mode;	/* bit [2] */
+
+	/* HRS10 register - SDCLK start point adjustment */
+	u8 sdhc_hcsdclkadj;		/* bits [19:16] */
+
+	/* HRS16 register fields - CMD/DAT output delay control */
+	u8 sdhc_wrdata1_sdclk_dly;	/* bits [31:28] */
+	u8 sdhc_wrdata0_sdclk_dly;	/* bits [27:24] */
+	u8 sdhc_wrcmd1_sdclk_dly;	/* bits [23:20] */
+	u8 sdhc_wrcmd0_sdclk_dly;	/* bits [19:16] */
+	u8 sdhc_wrdata1_dly;		/* bits [15:12] */
+	u8 sdhc_wrdata0_dly;		/* bits [11:8] */
+	u8 sdhc_wrcmd1_dly;		/* bits [7:4] */
+	u8 sdhc_wrcmd0_dly;		/* bits [3:0] */
+
+	/* DLL calculation intermediate values, used during PHY timing calculations */
+	u32 t_sdmclk_calc;	/* DLL-quantized SDMCLK period */
+	u32 dll_max_value;	/* DLL delay field ceiling */
+
+	/* Tuning value for HS200/HS400 modes */
+	u8 hs200_tune_val;
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
+ * init_ds() - Initialize PHY timing for Default Speed mode (25 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_ds(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 5000;
+	phy->t_cmd_output_max = t_sdclk - 5000;
+	phy->t_dat_output_min = 5000;
+	phy->t_dat_output_max = t_sdclk - 5000;
+}
+
+/**
+ * init_hs() - Initialize PHY timing for High Speed mode (50 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_hs(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 2000;
+	phy->t_cmd_output_max = t_sdclk - 6000;
+	phy->t_dat_output_min = 2000;
+	phy->t_dat_output_max = t_sdclk - 6000;
+}
+
+/**
+ * init_uhs_sdr12() - Initialize PHY timing for UHS SDR12 mode (25 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_sdr12(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 3000;
+}
+
+/**
+ * init_uhs_sdr25() - Initialize PHY timing for UHS SDR25 mode (50 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_sdr25(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 3000;
+}
+
+/**
+ * init_uhs_sdr50() - Initialize PHY timing for UHS SDR50 mode (100 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_sdr50(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 3000;
+}
+
+/**
+ * init_uhs_sdr104() - Initialize PHY timing for UHS SDR104 mode (200 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_sdr104(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 1400;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 1400;
+}
+
+/**
+ * init_uhs_ddr50() - Initialize PHY timing for UHS DDR50 mode (50 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_uhs_ddr50(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 3000;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 3000;
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
+}
+
+/**
+ * init_emmc_hs200() - Initialize PHY timing for eMMC HS200 mode (200 MHz).
+ * @phy: Pointer to SD6HC PHY state.
+ * @t_sdclk: SD clock period in picoseconds.
+ */
+static void init_emmc_hs200(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
+{
+	phy->t_cmd_output_min = 800;
+	phy->t_cmd_output_max = t_sdclk - 1400;
+	phy->t_dat_output_min = 800;
+	phy->t_dat_output_max = t_sdclk - 1400;
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
+}
+
+/*
+ * init_timings - PHY timing initializers indexed by MMC_TIMING_* value.
+ *
+ * Each entry corresponds to a MMC_TIMING_* constant and sets the appropriate cmd/dat
+ * output timing windows in the PHY state struct.
+ */
+static void (* const init_timings[])(struct sdhci_cdns6_phy *, u32) = {
+	[MMC_TIMING_LEGACY]     = init_ds,
+	[MMC_TIMING_MMC_HS]     = init_emmc_sdr,
+	[MMC_TIMING_SD_HS]      = init_hs,
+	[MMC_TIMING_UHS_SDR12]  = init_uhs_sdr12,
+	[MMC_TIMING_UHS_SDR25]  = init_uhs_sdr25,
+	[MMC_TIMING_UHS_SDR50]  = init_uhs_sdr50,
+	[MMC_TIMING_UHS_SDR104] = init_uhs_sdr104,
+	[MMC_TIMING_UHS_DDR50]  = init_uhs_ddr50,
+	[MMC_TIMING_MMC_DDR52]  = init_emmc_ddr,
+	[MMC_TIMING_MMC_HS200]  = init_emmc_hs200,
+	[MMC_TIMING_MMC_HS400]  = init_emmc_hs400,
+};
+
+static unsigned int sdhci_cdns6_read_phy_reg(struct sdhci_cdns_priv *priv, const u32 address)
+{
+	writel(address, priv->hrs_addr + SDHCI_CDNS_HRS04);
+	return readl(priv->hrs_addr + SDHCI_CDNS_HRS05);
+}
+
+static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_priv *priv, const u32 address,
+				      const u32 value)
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
+		delay_elements_in_sdmclk = DIV_ROUND_UP(phy->t_sdmclk, delay_element);
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
+	phy->cp_dll_bypass_mode = false;
+
+	return 0;
+}
+
+static void sdhci_cdns6_phy_dll_bypass(struct sdhci_cdns6_phy *phy)
+{
+	phy->dll_max_value = 256;
+	phy->cp_dll_bypass_mode = true;
+}
+
+static void sdhci_cdns6_phy_configure_dll(struct sdhci_cdns6_phy *phy)
+{
+	if (!phy->sdhc_extended_wr_mode) {
+		if (sdhci_cdns6_phy_lock_dll(phy) == 0)
+			return;
+	}
+	sdhci_cdns6_phy_dll_bypass(phy);
+}
+
+static void sdhci_cdns6_phy_calc_out(struct sdhci_cdns6_phy *phy, bool cmd_not_dat)
+{
+	u32 wr0_dly = 0, wr1_dly = 0, output_min, output_max, phy_o_delay,
+	    clk_wr_delay = 0, wr0_sdclk_dly = 0, wr1_sdclk_dly = 0;
+	bool ddr = (phy->mode == MMC_TIMING_UHS_DDR50) || (phy->mode == MMC_TIMING_MMC_DDR52) ||
+		   (phy->mode == MMC_TIMING_MMC_HS400);
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
+	if (t < 0 && phy->sdhc_extended_wr_mode) {
+		u32 n_half_cycle = DIV_ROUND_UP(-t * 2, phy->t_sdmclk);
+
+		wr0_dly = (n_half_cycle + 1) / 2;
+		if (data_ddr)
+			wr1_dly = (n_half_cycle + 1) / 2;
+		else
+			wr1_dly = (n_half_cycle + 1) % 2 + wr0_dly - 1;
+	}
+
+	if (!phy->sdhc_extended_wr_mode) {
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
+		if (!phy->cp_dll_bypass_mode)
+			n = DIV_ROUND_UP(256 * out_hold, phy->t_sdmclk_calc);
+		else
+			n = DIV_ROUND_UP(out_hold, phy->delay_element) - 1;
+
+		if (n <= phy->dll_max_value)
+			clk_wr_delay = n;
+		else
+			clk_wr_delay = 255;
+	} else {
+		/* sdhc_extended_wr_mode set => PHY IO cell work in SDR mode */
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
+	phy->cp_io_mask_end = ((phy->iocell_output_delay + phy->iocell_input_delay) * 2) /
+				phy->t_sdmclk;
+
+	/* cp_io_mask_end is a 3-bit field, clamp to max value of 7 */
+	phy->cp_io_mask_end = min_t(u8, phy->cp_io_mask_end, 7);
+
+	if (phy->strobe_cmd && phy->cp_io_mask_end > 0)
+		phy->cp_io_mask_end--;
+
+	if (phy->strobe_cmd) {
+		phy->cp_use_phony_dqs_cmd = false;
+		phy->cp_read_dqs_cmd_delay = 64;
+	} else {
+		phy->cp_use_phony_dqs_cmd = true;
+		phy->cp_read_dqs_cmd_delay = 0;
+	}
+
+	if ((phy->mode == MMC_TIMING_MMC_HS400 && !phy->strobe_cmd) ||
+	    phy->mode == MMC_TIMING_MMC_HS200)
+		phy->cp_read_dqs_cmd_delay = phy->hs200_tune_val;
+}
+
+static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
+{
+	u32 hcsdclkadj = 0;
+	bool strobe_dat = (phy->mode == MMC_TIMING_MMC_HS400);
+
+	if (strobe_dat) {
+		phy->cp_use_phony_dqs = false;
+		phy->cp_read_dqs_delay = 64;
+	} else {
+		phy->cp_use_phony_dqs = true;
+		phy->cp_read_dqs_delay = 0;
+	}
+
+	if (phy->mode == MMC_TIMING_MMC_HS200)
+		phy->cp_read_dqs_delay = phy->hs200_tune_val;
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
+		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk) * phy->t_sdmclk - hcsdclkadj;
+		/*
+		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata
+		 * + PHY rddata registered, + FIFO 1st ciu_en
+		 */
+		hcsdclkadj += 5 * phy->t_sdmclk;
+		/* FIFO 2nd ciu_en */
+		hcsdclkadj += phy->t_sdclk;
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
+		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk) * phy->t_sdmclk - hcsdclkadj;
+		/*
+		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata + PHY rddata registered
+		 */
+		hcsdclkadj += 4 * phy->t_sdmclk;
+
+		if ((phy->t_sdclk / phy->t_sdmclk) > 1) {
+			u32 tmp1, tmp2;
+
+			tmp1 = hcsdclkadj;
+			tmp2 = (hcsdclkadj / phy->t_sdclk) * phy->t_sdclk + phy->t_sdclk -
+				phy->t_sdmclk;
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
+		hcsdclkadj /= phy->t_sdclk;
+		hcsdclkadj += n;
+
+		if ((phy->t_sdclk / phy->t_sdmclk) >= 2) {
+			if (phy->mode == MMC_TIMING_UHS_DDR50 || phy->mode == MMC_TIMING_MMC_DDR52)
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
+	rw_compensate = ((phy->iocell_input_delay + phy->iocell_output_delay) / phy->t_sdmclk) +
+			  phy->sdhc_wrdata0_dly + 5 + 3;
+
+	phy->sdhc_idelay_val = (2 * phy->iocell_input_delay) / phy->t_sdmclk;
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
+	/* cp_io_mask_start is a 3-bit field, clamp to max value of 7 */
+	phy->cp_io_mask_start = min_t(u8, phy->cp_io_mask_start, 7);
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
+	/* After releasing PHY from reset, wait until PHY_INIT_COMPLETE is set within 3000us */
+	if (!reset) {
+		ret = readl_poll_timeout(priv->hrs_addr + SDHCI_CDNS_HRS09, reg, (reg &
+					 SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE), 0, 3000);
+	}
+
+	return ret;
+}
+
+int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
+{
+	struct sdhci_cdns6_phy *phy = priv->phy;
+	u32 reg;
+	int ret;
+
+	sdhci_cdns6_dll_reset(priv, true);
+
+	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
+	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
+	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
+	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
+	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy->cp_use_phony_dqs);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, phy->cp_use_phony_dqs_cmd);
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
+
+	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG);
+	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL;
+	reg |= SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_UNDERRUN_SUPPRESS;
+	reg |= SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON;
+	reg |= SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SYNC_METHOD;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL,
+			  SDHCI_CDNS6_PHY_DEFAULT_RD_DEL_SEL);
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG, reg);
+
+	reg = FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_BYPASS_MODE, phy->cp_dll_bypass_mode);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_PHASE_DETECT_SEL,
+			  SDHCI_CDNS6_PHY_DEFAULT_PHASE_DETECT_SEL);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_LOCK_NUM,
+			  SDHCI_CDNS6_PHY_DEFAULT_DLL_LOCK_NUM);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_START_POINT,
+			  SDHCI_CDNS6_PHY_DEFAULT_DLL_START);
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_REG, reg);
+
+	reg = FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_CMD_DELAY,
+			 phy->cp_read_dqs_cmd_delay);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WRDQS_DELAY, phy->cp_clk_wrdqs_delay);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WR_DELAY, phy->cp_clk_wr_delay);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY, phy->cp_read_dqs_delay);
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_REG, reg);
+
+	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
+	reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
+	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG, reg);
+
+	/*
+	 * Ensure all preceding PHY register writes complete and reach the controller before
+	 * releasing the PHY from reset. Without this, SDR104 has been observed to fail
+	 * intermittently on some boards.
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
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END, phy->cp_io_mask_end);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START, phy->cp_io_mask_start);
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END,
+			  SDHCI_CDNS6_PHY_DEFAULT_DATA_SELECT_OE_END);
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
+	reg |= SDHCI_CDNS_HRS09_RDDATA_EN;
+	reg |= SDHCI_CDNS_HRS09_RDCMD_EN;
+	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS09);
+
+	reg = FIELD_PREP(SDHCI_CDNS_HRS10_HCSDCLKADJ, phy->sdhc_hcsdclkadj);
+	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS10);
+
+	reg = FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY, phy->sdhc_wrdata1_sdclk_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY, phy->sdhc_wrdata0_sdclk_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY, phy->sdhc_wrcmd1_sdclk_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY, phy->sdhc_wrcmd0_sdclk_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_DLY, phy->sdhc_wrdata1_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_DLY, phy->sdhc_wrdata0_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_DLY, phy->sdhc_wrcmd1_dly);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_DLY, phy->sdhc_wrcmd0_dly);
+	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS16);
+
+	reg = FIELD_PREP(SDHCI_CDNS_HRS07_RW_COMPENSATE, phy->sdhc_rw_compensate);
+	reg |= FIELD_PREP(SDHCI_CDNS_HRS07_IDELAY_VAL, phy->sdhc_idelay_val);
+	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS07);
+
+	/* Allow 5 to 5.5 ms for clock and PHY signals to stabilize after configuration */
+	usleep_range(5000, 5500);
+
+	return 0;
+}
+
+int sdhci_cdns6_set_tune_val(struct sdhci_host *host, unsigned int val)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct sdhci_cdns6_phy *phy = priv->phy;
+	u32 tuneval;
+
+	/*
+	 * Scale tuning tap (val in [0, SDHCI_CDNS_MAX_TUNING_LOOP-1]) to the
+	 * 8-bit PHY DLL slave delay field [0, 255]. With MAX_TUNING_LOOP=40
+	 * and FIELD_SIZE=256, the result fits in 8 bits.
+	 *
+	 * Updating the DLL slave delays also requires a PHY DLL reset cycle,
+	 * so reuse the full phy_init() sequence rather than a register poke.
+	 */
+	tuneval = (val * SDHCI_CDNS6_PHY_DLL_FIELD_SIZE) / SDHCI_CDNS_MAX_TUNING_LOOP;
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
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
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
+	 * CMD and DAT output delays are currently identical, but kept separate to allow
+	 * independent tuning for specific modes (e.g., HS400) or board-specific optimizations
+	 * in the future.
+	 */
+	phy->phy_cmd_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
+	phy->phy_dat_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
+
+	if (phy->t_sdclk == phy->t_sdmclk) {
+		phy->sdhc_extended_wr_mode = false;
+		phy->sdhc_extended_rd_mode = false;
+	} else {
+		phy->sdhc_extended_wr_mode = true;
+		phy->sdhc_extended_rd_mode = true;
+	}
+
+	sdhci_cdns6_phy_configure_dll(phy);
+	sdhci_cdns6_phy_calc_settings(phy);
+
+	return 0;
+}
+
+int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *priv)
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
+		return dev_err_probe(dev, -EINVAL, "failed to get controller clock rate\n");
+
+	phy->t_sdmclk = DIV_ROUND_DOWN_ULL(1000000000000ULL, val);
+
+	/*
+	 * Optional board-level PHY timing properties. When omitted, use the
+	 * Cadence-recommended defaults (2500 ps IO-cell delays, 24 ps DLL
+	 * delay element) that are valid for typical SoC packaging.
+	 */
+	ret = of_property_read_u32(dev->of_node, "cdns,iocell-input-delay-ps",
+				   &phy->iocell_input_delay);
+	if (ret)
+		phy->iocell_input_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
+
+	ret = of_property_read_u32(dev->of_node, "cdns,iocell-output-delay-ps",
+				   &phy->iocell_output_delay);
+	if (ret)
+		phy->iocell_output_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
+
+	ret = of_property_read_u32(dev->of_node, "cdns,delay-element-ps", &phy->delay_element);
+	if (ret)
+		phy->delay_element = SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT;
+
+	phy->delay_element_org = phy->delay_element;
+
+	priv->phy = phy;
+
+	return 0;
+}
+
+void sdhci_cdns6_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct sdhci_cdns6_phy *phy = priv->phy;
+	int ret;
+
+	/* Clock may be 0 during initial ios setup; skip PHY update */
+	if (!host->mmc->ios.clock)
+		return;
+
+	phy->t_sdclk = DIV_ROUND_DOWN_ULL(1000000000000ULL, host->mmc->ios.clock);
+	phy->mode = timing;
+
+	ret = sdhci_cdns6_phy_update_timings(host);
+	if (ret) {
+		dev_warn(mmc_dev(host->mmc), "%s: update timings failed: %d\n", __func__, ret);
+		return;
+	}
+
+	ret = sdhci_cdns6_phy_init(priv);
+	if (ret)
+		dev_warn(mmc_dev(host->mmc), "%s: phy init failed: %d\n", __func__, ret);
+}
+
+void sdhci_cdns6_hw_reset(struct sdhci_host *host)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	void __iomem *reg;
+
+	reg = priv->hrs_addr + SDHCI_CDNS_HRS11;
+	writel(SDHCI_CDNS_HRS11_EMMC_RST, reg);
+	/* eMMC HW reset assertion: spec requires >= 1us, give margin */
+	usleep_range(10, 20);
+	writel(0, reg);
+	/* For eMMC, minimum is 200us but give it 300us for good measure */
+	usleep_range(300, 1000);
+}
diff --git a/drivers/mmc/host/sdhci-cadence.h b/drivers/mmc/host/sdhci-cadence.h
new file mode 100644
index 000000000000..9affd9f4ede8
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 Altera Corporation
+ *   Author: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
+ *
+ * Cadence SD/SDIO/eMMC Host Controller driver - common header
+ * Shared definitions and structures for the Cadence SDHCI driver.
+ * Contains private data and declarations for SD6HC-specific functions
+ * called by the main driver in sdhci-cadence-core.c.
+ */
+
+#ifndef _MMC_HOST_SDHCI_CADENCE_H
+#define _MMC_HOST_SDHCI_CADENCE_H
+
+#include <linux/compiler.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "sdhci-pltfm.h"
+
+struct reset_control;
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
+ *            Used only for "amd,pensando-elba-sd4hc" compatible controllers to enable
+ *            byte-lane writes.
+ * @wrlock: Spinlock for protecting register writes (Elba only).
+ * @enhanced_strobe: Flag indicating if Enhanced Strobe (HS400ES) is enabled.
+ * @priv_writel: Optional SoC-specific write function for register access.
+ *               Used for Elba to ensure correct byte-lane enable.
+ * @rst_hw: Hardware reset control for the eMMC card RST_n pin (SD4HC only).
+ * @phy: Opaque pointer to variant-specific PHY data.
+ *       For SD4HC: points to struct sdhci_cdns4_phy.
+ *       For SD6HC: points to struct sdhci_cdns6_phy.
+ */
+struct sdhci_cdns_priv {
+	void __iomem *hrs_addr;
+	void __iomem *ctl_addr;	/* write control */
+	spinlock_t wrlock;	/* write lock */
+	bool enhanced_strobe;
+	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
+	struct reset_control *rst_hw;
+	void *phy;
+};
+
+/**
+ * sdhci_cdns_priv - Helper to retrieve Cadence private data from sdhci_host
+ * @host: Pointer to struct sdhci_host.
+ *
+ * Return: Pointer to struct sdhci_cdns_priv.
+ */
+static inline void *sdhci_cdns_priv(struct sdhci_host *host)
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
+int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *priv);
+
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
-- 
2.43.7

