Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667F3546D8;
	Sat, 27 Jun 2026 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591345; cv=fail; b=HHunLHjvgdmifwJMb0IEuetqKl840h8JqTxwbbZm8KNdwTtC1A0rlynE19kLZYL3hqNADzHBZ8YaZY5d37g1NSOY+E77To5JqJN6/tjW4zxwo8z5kou1iJpzMHEUVKX3h/yWfSnPQmypKY8jejge/MTVmYNpYZvtIV0IP2UlBok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591345; c=relaxed/simple;
	bh=JdPXh5/uG4VE18E+hv8auL/lpFr2/y3ckfB/+UddWhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZT0pNaTxJQozCmoJoEnyaTDj8vTcukt6LuV82f36i6yNw0JMiU/P/Ayb5wPCPFldp43oR+sINtddk9y1nMQ8I6fpchlneeiZtMX7R9/bap+z4s9jw+5sEVYZO0xJSY7WJaJDS8aUaLjlupPmxi+8ZqPq305rl72ngbBRFM0WL6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=f6799bCj; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="f6799bCj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Diu7nG8VqEerwsCDoSfw+pt2BP6yvDhC1jWjEbkW8CokA8h2IsjoBUEPk7uUdmqxyEatj/yVPNtok1ZRXf2QQL4y6HAU96R7Zi5ptWSZ4MajARzjYFjeGIWhXdywG7DAtic18j0xaVk+Tbj2dKA4p4szvecG5QjadINNJU1Fg76510JqNQPslIJASiyAPWLKWXlFZ+34AP46MO4PxjrMM924OFyfSJUM01vh46C/hcBdfDa6e9kgc1O1u3U6B1mYKv4w0r/F8zozFQj3OFIlJPjRyaIPUkhRhU72Y6m3fN4IKr2rf63l4Zc68gFBMI3lFJS6kTgiFiZqHzpgcs+Juw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUSNtUMNhoMSDBGI6ygldoYy8fEVHwgPKREN7gR8MKE=;
 b=gtTfYewcUWcHJhcafySDRtwWtB0hW8S9p5EeBby4CLUmE4XKOpSiXGenybpMMgOKshTZeoAQLwvZRyqI7fUPDIw3twyvTMg83lBUcLQXlPeYgN5u5JL1sS6mxlp82xxFqC2Y9yROu+Qbvlyy3iaJgO9czG53QAnkfecBIDuKvKsRR26yqTwMt+/FvYDinrmUfJFeu24jv9uJIATZZIfVpz0kmG1zft5Lm1UbsmHsfHRiIwqqPRhsyxmbl95ekq+S/TBS3UYi9d2K9LMy6n4v4jhD7yRC52g/RMDIBd4v2o1s+0cWmoaisEJWV4D/51HCFDGba3zJFrlkKWz+R+gyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUSNtUMNhoMSDBGI6ygldoYy8fEVHwgPKREN7gR8MKE=;
 b=f6799bCjMQD8a7JO36BEClxXgd5koPYW8BucjRzIZ5M+1HvxgUGjGBmyLDYGXZ135BBgurO+TQP7I3hMdstyWJ99FXT1lmnRftG0a1IRC2w4pJ10U75qSYgzp97cshP0G5bzKtquZ8kKGvrdPPs4F6YgOsD7RsbFyDbNKCzssRHg74/XtZBG58ee7MO4GovQPmHKFPQsv3JJo3/Q25tMUA1XIEak7+awFWupb3FO5qI5whRpBXExXcNClp1nPGhLGAC0eEJObxt2gcHwydDbc+GP7wH176Q+bhpQxJAu2oklKA/77tGRJ9I93xfX4u9p+GY8cZ3w90UNeq5JCKhvFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 20:15:36 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 20:15:36 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] mmc: sdhci-cadence: add Cadence SD6HC support
Date: Sat, 27 Jun 2026 13:14:53 -0700
Message-ID: <20260627201457.12318-9-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a05ba12-94b8-4bab-6927-08ded488d94f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|3023799007|11063799006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	fSOCXGa4M5LNJatQlF2dPkKSrT96kOVzLD749CLHTqEG3I6sd0OAdBrCy4+dMvcU6FMGisAwFdjoR3xZSO6dlRmruz823L3q1oFKjO0TvIcKF+t4zEN3G7RI/nvLMRk3n5o/4MvgHCWb6o4ofvIQs6qDZrwlScrlxkQ+z5Mtg22aMULqQZap+zArWKcFNkRJwZydV6yTojM56JE2DD2QOZizxfqeRVb+aJ2HQ904kSP3gp8re0yBd4wXK0eWbPeZvIiz7lji1MuBXRdt1MF8jIYTi1fm9M72OtOyE3ECZWRHnmg2AMAljkMNVjLmeOwmQoBzqOx1vQQ4StDogMQKOyih/BLCbRuAUOLMwhWT9ICidTv3d4NDJgdx9ugmegGJLWwf657Q4fs+Ncry61OQKQK+0Ki0Zyb/lm8/pTgtc4kn+hqFsf+mO+pc24WHiIQbEKIKkDWvit2QcQ/6cdiU9V3aU65t1XL9K0UU+ojtG4yDPaFhool9h/WafoFfzE/STgMYCcXRA8M1D2mI5U3g4fltJv/pUZE7jG7OC2VmuIr1UTNY6skMj2oI6isr0HabpcW6Ts6VVz5jFKFRirzi9nyEmJ+8Ab8d5NOj1Xz3SvsLii9sq9m++9NHhkCquDNGaJuSG55iNWiPPWzZDstgKCaeKhlA8vg3Wd5ZvR+SwS0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(3023799007)(11063799006)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g0t3GUsrXmS1ixirEiZa3KNHQ3KCTblLAYV44ft5IrHpR1ZlrWZxIzAFMZzO?=
 =?us-ascii?Q?TY1ITg0/Ci4sOmbJ0Lt+N+u+077oxtzy/Fr7cMPIczuMfBOKUJOdYScVdI1P?=
 =?us-ascii?Q?pnyu89EQ1T5rAav3HwmJmp6zDcBIGvg92rIHT0BznSTFkpoway0Ix9wrgH3P?=
 =?us-ascii?Q?i324JfqQav+Gtab5S784XgBk0luv8bWPEvi9K8sISNFz1xleFizIvAyGCWcW?=
 =?us-ascii?Q?Q1FiasSrzeBY5oHe9x+Wxsw2Ub4JdbFhhO5zJXJp8Uqx8jkv5HbEDGLwp+yx?=
 =?us-ascii?Q?voaYiJjXU4cXdbKJGva9xPjOGFRGuV1rss7WvtLmc+zPRHYUL3Nkk5DKnw9/?=
 =?us-ascii?Q?v4Ms+C0bduH+UZ0yGDKNp1ZshoE5zGzfP8sOqThd2bDkN5XEK0vsDFDbdj0T?=
 =?us-ascii?Q?Giz88SY5GFD6/QoBzRWz80mBOojwZ9mY+r+6jOIdhs1TP1Eaxga6nT6eOhS6?=
 =?us-ascii?Q?eFYqOaszyv8cfs/PL9kkF/mUwuhJ0Qg5ERmqca2WsrRwdvR8n3uZjJVd/3hN?=
 =?us-ascii?Q?Qo2PO04wBRGLbuhpnFUxpW8vZfGphkp/ojPDWNPIXrCD9tyynOhfNCWUxFW7?=
 =?us-ascii?Q?2U0XN43bgN/btmz5+PpXOLcBSAP8bky4HkJAToRGXuPtJaeeSEnj5LJQHW3c?=
 =?us-ascii?Q?17kyOCYuFNPH8o6PN0zhXF4d7MdV07P2rrncu/zTgZOhd6jXaRUM3PXycEMJ?=
 =?us-ascii?Q?aPTGwBSxPA3k4KzHSFYd30RjT0rKldA8w6nU+u6VV2tGtlTPB+zngOR45zrt?=
 =?us-ascii?Q?PqXs4rIcxoda11NUMV0yI9fkFIF6rNg8v4UafcFqaE26V38q0tsxFSDQwsYI?=
 =?us-ascii?Q?p9g+VMlj9+bKspvMGvad71MqtKdjhdAuj8Yp9eGDY6tLYNOvp5Qec4tX7Q5Q?=
 =?us-ascii?Q?XuETewpt35T3l1W/V0NRmuzWCE/zamhoaKXNaV69ge1wIYfKs8SXVhrY5VYy?=
 =?us-ascii?Q?ZE1CjZmHA8uQvm6x5ml/mpqpL42btIA96X5MkWqgt1MlANiuYIcdeBVpkM4R?=
 =?us-ascii?Q?4lVYelrPjXChdwrI7Ue+HQQsDy65MwpxwlivY8zYlAonfgLDkspzo+EPQ4tH?=
 =?us-ascii?Q?+A0KFIArdQUiigm2x536nay7ff8a893RotSHpCtwVXsdEYkOXBE06mJ3f0za?=
 =?us-ascii?Q?nDvJN/wU5J4/h6Z4apjbi0wyIrFYqxti9zy1L5aroSio3DlGuFgXBBdYVCno?=
 =?us-ascii?Q?8eNWrheM1QU8CATyA965Nddesog3yadLu+eylNuePKfVxtEg/HFzuK4LUmC3?=
 =?us-ascii?Q?/9uLTPyvJsYZTJzoyQXszZMsvx5hnHevJnYbEwrhtCmxalxH6spiUBbFhQQh?=
 =?us-ascii?Q?ngASJeL9YeOQBuID7+Z+F1Z0xrdamR+pidSJpW0oxZ6Z7UOsheJbU2NfIxH9?=
 =?us-ascii?Q?qGgekaH9VMwoJt7EivUjh8vHZQZFSDQmCR/exV46+HpRWFq0vyiMrYM95Z+R?=
 =?us-ascii?Q?P4c478DVB9bsASx25EAQ8nzfA1tnvQm24Rjwj7sjDq+yhhbKADb3X4VOYzph?=
 =?us-ascii?Q?rScduRuB6dxE8Uuv050NtLt0b9d3xhroKMxXAWWS9KI76Tc+J0oxFhUjrnoo?=
 =?us-ascii?Q?YHc3xu1MdIF26p97dLov6ViJfDAp5dGcH8lMZCmWyOqZotOW10Jv+9i0i4v8?=
 =?us-ascii?Q?QVpDORFey/+tkU9kKEw/MkqcECtDM+2xYqpfWhcWneAnu2AUnCiUMtnUnp9g?=
 =?us-ascii?Q?7VE7qowH7s1Gh8SWHG3PU/kO+UEgtMCAgX7qHmM2vc9iEM5kb6DE57r2XRFp?=
 =?us-ascii?Q?wCELEB+NfLRkHKqj1hjZQRELYsaTrfQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a05ba12-94b8-4bab-6927-08ded488d94f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 20:15:36.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mK6qX4ZIXcxi3iIC0a4nVlgLSXnz6UibZVxIDyVK3no9G9VWTJg78+XWmxDeCwCW2FFTJJl6RvciVVmhQ/QjiKgMz/MIZHKBTByjJLu+a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837

The Cadence SD6HC is the sixth-generation SD/SDIO/eMMC host controller
with an integrated hard combo-PHY. Unlike SD4HC, the SD6HC PHY requires
timing values derived from the current speed mode, clock period, and
board-level IO cell delays to achieve correct signal margins across all
speed grades from Default Speed to HS400.

SD6HC nodes require two named clocks, "ciu" for the controller and
"biu" for the bus interface unit. eMMC hardware reset is handled via an
internal controller register rather than an external reset line. The new
"cdns,sd6hc" compatible string identifies generic SD6HC hardware in
device tree.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 MAINTAINERS                                   |   7 +
 drivers/mmc/host/Makefile                     |   3 +-
 .../{sdhci-cadence.c => sdhci-cadence-core.c} | 126 ++-
 drivers/mmc/host/sdhci-cadence-phy-v6.c       | 965 ++++++++++++++++++
 drivers/mmc/host/sdhci-cadence.h              | 114 +++
 5 files changed, 1168 insertions(+), 47 deletions(-)
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence-core.c} (87%)
 create mode 100644 drivers/mmc/host/sdhci-cadence-phy-v6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a386..25c3eb17b3c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24104,6 +24104,13 @@ L:	linux-mmc@vger.kernel.org
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
index ee412e6b84d6..83ce3358d8d4 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -80,7 +80,8 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
 
 obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
-obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
+sdhci-cadence-y				+= sdhci-cadence-core.o sdhci-cadence-phy-v6.o
+obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)	+= sdhci-esdhc-mcf.o
 obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
 obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence-core.c
similarity index 87%
rename from drivers/mmc/host/sdhci-cadence.c
rename to drivers/mmc/host/sdhci-cadence-core.c
index ab5dfae12732..5b8a83c9a0aa 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence-core.c
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
@@ -572,6 +573,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
+	struct clk *biu_clk;
 	int ret;
 	struct device *dev = &pdev->dev;
 	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
@@ -580,6 +582,14 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	/* SD6HC requires a second clock, "biu", for the bus interface unit. */
+	if (of_device_is_compatible(dev->of_node, "cdns,sd6hc")) {
+		biu_clk = devm_clk_get_enabled(dev, "biu");
+		if (IS_ERR(biu_clk))
+			return dev_err_probe(dev, PTR_ERR(biu_clk),
+					     "failed to enable biu clock\n");
+	}
+
 	data = of_device_get_match_data(dev);
 	if (!data)
 		return dev_err_probe(dev, -EINVAL, "missing platform driver data\n");
@@ -604,30 +614,46 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
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
@@ -639,7 +665,11 @@ static int sdhci_cdns_resume(struct device *dev)
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
 
@@ -674,6 +704,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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
index 000000000000..f3d2a5d16630
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -0,0 +1,965 @@
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
+	phy->t_cmd_input_min = t_sdclk / 2 + 14000;
+	phy->t_cmd_input_max = t_sdclk + t_sdclk / 2;
+	phy->t_dat_input_min = t_sdclk / 2 + 14000;
+	phy->t_dat_input_max = t_sdclk + t_sdclk / 2;
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
+	phy->t_cmd_input_min = 14000;
+	phy->t_cmd_input_max = t_sdclk + 2500;
+	phy->t_dat_input_min = 14000;
+	phy->t_dat_input_max = t_sdclk + 2500;
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
+	phy->t_cmd_input_min = 14000;
+	phy->t_cmd_input_max = t_sdclk + 1500;
+	phy->t_dat_input_min = 14000;
+	phy->t_dat_input_max = t_sdclk + 1500;
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
+	phy->t_cmd_input_min = 14000;
+	phy->t_cmd_input_max = t_sdclk + 1500;
+	phy->t_dat_input_min = 14000;
+	phy->t_dat_input_max = t_sdclk + 1500;
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
+	phy->t_cmd_input_min = 7500;
+	phy->t_cmd_input_max = t_sdclk + 1500;
+	phy->t_dat_input_min = 7500;
+	phy->t_dat_input_max = t_sdclk + 1500;
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
+	phy->t_cmd_input_min = 1000;
+	phy->t_cmd_input_max = t_sdclk + 1000;
+	phy->t_dat_input_min = 1000;
+	phy->t_dat_input_max = t_sdclk + 1000;
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
+ * Each entry corresponds to a MMC_TIMING_* constant and sets the appropriate cmd/dat output
+ * and input timing windows in the PHY state struct.
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
+	ret = of_property_read_u32(dev->of_node, "cdns,delay-element", &phy->delay_element);
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
index 000000000000..82780c86e98d
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence.h
@@ -0,0 +1,114 @@
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
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
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
+	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val,
+			    void __iomem *reg);
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

