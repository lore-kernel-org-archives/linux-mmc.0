Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793791638;
	b=qv5fUlh9fG0D2NS/ekzX6dEhUxWeK/5EnzQe1N+SAZWf8uqUyZcS25SBsM17DUdtfj8E
	 qXXR9SW8QW6Qji7xPfyP3SzxvtX8IM/rCH2gbnA5TQBOfqX4VQ4p7ACCsHCkX2f6DmmGs
	 CsFGU1Xxeo3mAsphyrjj60jKeyCgqrT994vzHwAH7IE2dUAOXMNvUKKnqcnuGvZ+NRVdu
	 7M8oZdgDXlZyknBBrvmbtIZWOaH8nSggz0lE8YHjWJnF9RDF5Phs/IwaDHwhN/pWGBF8J
	 jEoGsY0BEawMd6vspXKj75z9/sIBg3ZRb59tzkCjFxpAK9rmHOc26Qm3tBihAfz3gew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791638;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZovylRKUFyiyHrd/t/3o20JsLIV7zntoLWxrPHl2MqY=;
	b=UZdtk4bEFQzI+W1fgZXtL8CGhrFndVfW2+8aurU9SI3n5RqvB92lPdtuHqUkKV3hWZNz
	 18D/EKIMEYFXNCyInvdmWpXObr0RTyOQtKTVkZxvo/t7czz4lIVuokA0PRrprFJKuoWXt
	 Zgyju/6XlziMjd+REYIssXt1if7lAuPo1V8dt4JnlDzY16V6dk5AvIRTlPpcKmcT8+UaW
	 2H/kBiIEQV8JFA9dHD+DxJxIddQqfhK/tHMNqIpDKlpSu7zCnvX0IyFWJtL2gfNA5/yaS
	 1341jIPouVhRdCxC51Udm7oz1weW/3k037rdtJ/lNnyQJbb+ifKrcrMdsIsu/FcsFLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.125
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2125.outbound.protection.partner.outlook.cn [139.219.17.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C2606A33A;
	Wed,  4 Nov 2026 11:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D26C2606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwlPL0Io0DI53q5FxrfXIK/OxK642g34CEEEivqUd6gEOeT0RWhCh+PVShWMaQzM15ldtsRvmZZCFuK1a7OHpm1yRhJeH5ZIDYd9GVlBJU7aQgaz1DZIp3w8Ww/hPBjetW8Ho2mlVinHpKqXnd8yV/clNNEfsLcJO6ZYHKyoo2tcsJe9eE0gv7HKdNIxHzrcL+1puaDerSDnYKumAcfrlrLihjVGDkQd4PjNsWQfctayALp196EgeQXeGdPMTx31x+N6BdOAjkclzbC57+I/IBl65Thr3yVVYPWo9DT1DrIkZp9KzcRd0Gr1CiahNOljxoXiZC1wL3Z8Vaoj93rk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZovylRKUFyiyHrd/t/3o20JsLIV7zntoLWxrPHl2MqY=;
 b=gfXZ94LPT9HB3l7aTczmmi6Xc4DYi4a6bGp1RwMbbh6ZEcEfRs94FFdXcC/qJnY0RJhx9dPTSv5xnosY92mg84roTzxLA/oWeBnjTVzhqnul3bMJqStleZcAzV9En27D1rx6RCiYpZkcabDlgai//y0mfDNOI+HCVODZeX76PtNV/HI4tOiAJVjXPG2fUXpxSNrB9AlOPv9HwELLnukosEVbEKn2rgQ8DPZq+V2r0gZz9mfVoFd68Fg5mF5CmaxRV1TyIIDu2prDFwAyrKthYErfgChlvt6K13SNLJ/7u5l5TSxQlAE8Ly29ZWORwv3V/NJlgeEJrBGNPi+RD7YH2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1218.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 11:27:05 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0592.009; Wed, 4 Nov 2026 11:27:05 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 1/2] mmc: cqhci: Add support for setting command idle time in nanoseconds
Date: Wed,  4 Nov 2026 03:26:56 -0800
Message-Id: <20261104112657.110536-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104112657.110536-1-changhuang.liang@starfivetech.com>
References: <20261104112657.110536-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::19) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1218:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b034e6-3393-4b7f-2c9b-08df3a668dcb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|52116014|1800799024|6133799003|10067099003|18002099003|22082099003|38350700014|56012099006|261026121527099003|261022075727099003|261022105027099003|261102130727099003|261026140227099003|261028144727099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	jIxZfQfdp/F7V+QDFqnl0SCYkRHs77+3NJmvB8orSDX4M0VGwjSPMWuRDuPF1yuoqC+qSMJxp15I5+/A8Jt9Fs9AVAw8o24Mea5o71rPiOMoIepYrjEtZxAqErFZjle6GwMl/sRoY7i0P+bhOMnWLLnoMyCQ092zipyt0hG5XRCt6+J9LOX7vVm6EGlpEXuhuBeNuTLDQPFto7+HzVyakQOGZObL0RjVV6R4jyD45Yi/PjoRzRpBmwCl1jOe7Ic3dfRNIp4oXGSU4ctBNg8IYitP1tqa+ewEk930j7YMHWR/oitMORMG0F2tYLWghcMfdUMPLWDhs+ZliWhQ2k2gjXtXXTQAqblNnFp9cI6p/HGj5xvy25AepwA16SpmsWIlbFr6qEU/+UduoG94SLLN8qI5WOTnFM0eB0a4u2+BBhekDwZYriog6ut2KionyQdz7RN7V2Xji1n8YZ/aUUgkQRr1Nj137bgquXbuP6H79QX1vkFDjRJGrNFANau2HjzKyhW791iWxAsGlu/TNaPWeI8DGOY+JAML/wqWmFzVwbIpU54b2V573hV8z/MDi8W1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(38350700014)(56012099006)(261026121527099003)(261022075727099003)(261022105027099003)(261102130727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C4mrk2XV+bfFfDD/SX+G5RKa2xFKNiFu78DmuRcZ6NOk/JD/tyKpMJBGdl86?=
 =?us-ascii?Q?7FlhCNzTuR12XIuAG9GwE8+vvv1Z66z9ThegShXXHlwby9W82/JNjKfzTcE/?=
 =?us-ascii?Q?1dM3rryVtoLk+eX45qBea0187Fss4IF8fd8jdiRFdjicfLxzp5+khdhbzICn?=
 =?us-ascii?Q?tlA6RNCd1AQBD3venSFCxG0HxZSllw6qUuODQ0IUgXfkNdFIBX3P7JwRCnNf?=
 =?us-ascii?Q?NMo0eTwjLtAk9BKa77V4nWOFTdpVKTvjuCLWJUcyvFJrXKkS6y3CsYXDdnoA?=
 =?us-ascii?Q?bDtsx4mH66qb3m3zSd/eqp+QxeVlgz+v3J0q20ErvF27/M/GPfUwTB9ShWKD?=
 =?us-ascii?Q?k2NMrF/jHW0AnJq5381JqCe836CyzxlY7y2+NbITiVfbC1kBGhFJZZATyfiP?=
 =?us-ascii?Q?m0h6+4zdQSBHiqt9/3lBc+cnrDhscsE0grGzMtKxxOfUMOkI1AnZcvrdxhcQ?=
 =?us-ascii?Q?BTH/L1x1uYjEPIT3tEFQfj7P5FIcSo1+DiCLLtjGJweI8MHXBW4jyful8MPi?=
 =?us-ascii?Q?JjKdhHGAGmuBuJ9jhN6k4WOBmj5ULXJ/uHIXpCDXB6M6zcs9mdnELTvLaOep?=
 =?us-ascii?Q?2qC4hIu78tQJbr3k3UKZHu0QhIXTUpciTlq2L6nbNUvaqSu/fNl/DRp7f4GW?=
 =?us-ascii?Q?UyGx1v8IaRPYyCyKoQd1uXN1zuoVlxcw6zPjyIMGvpRrWSn1QhquC5mJXIdo?=
 =?us-ascii?Q?8R6M2pw5tlFUz/I1e9cWFFJvewVwUkWfkEgNsBjVLOEep+EB4Yk0OW5ZakYb?=
 =?us-ascii?Q?c7k8sNKMj/gXKC8uTo7W8i7rTOgKSHx3xUKBHtJyPSPTlk2mYqf6DlGt+7r8?=
 =?us-ascii?Q?1kDd5bbpVJi98CSTjzwChQFC6n17HxTQ6UX7yPAT7x3k+zHRO25pDKwzbibA?=
 =?us-ascii?Q?i+pm500cu7V8pYE013t2gSRBHxtkE0f1dG38TajHIdBuR/PhD7nVy6Tne4mH?=
 =?us-ascii?Q?xHxnLD1wpM/KL2W7n+omliLMSepHlJ06QYc+6EVTCDo0Zw+8eLWZfzSu8h2U?=
 =?us-ascii?Q?u44/sLl0/bCTJLI7BCteycYjAFkxW5HCgP76TmQ6uYgL3mA65COJtxYGAh4g?=
 =?us-ascii?Q?rnY3+PJhhfX254tQ+x3Dm6mb1fFedfoUzmhxCCQQdKZ0teFeEaZuuWFYaBi1?=
 =?us-ascii?Q?faRuh9pUcCdTMG95ms9MaURZS+252Y91/c3XbKl7GtqKaryIe7YQSE31WpzM?=
 =?us-ascii?Q?UGGfruD9FxipbNuA9ftKljSCK+ySds9tSV9eNFM9syFlKDAxXOhbpPcID9KJ?=
 =?us-ascii?Q?yRZQTCO1As80dX14jhgfG6vYEHaEpGoHRINvO5JcuN/nF67qoKcPnkB+RdRu?=
 =?us-ascii?Q?SNEPaNE2tRo7K2ZD6eBgb2FG0xgzrb9+GLvA6CWEfN1W0U/vHU89YtQ5iDyH?=
 =?us-ascii?Q?kf5fJnd/pIklHpyUOOUKCujIu+d/aesAaRNWUQ0ks5EJ5106BFFfJqyDy3jf?=
 =?us-ascii?Q?7lQFJVOlI8lMan05qGL8bw6qiUQ0wvW6NKZ9NTxD7+WnhkOymTSeQDBQuovb?=
 =?us-ascii?Q?9jKiX2VOIlxvvzQEK/6JOnIh38QIUuIvH54y0Rmgo5BaSpWqUeCyVRIutJaH?=
 =?us-ascii?Q?eU3V2k/wVJqCyHR1cvGyTcki42djfcycXCPBXIid88lSIOHaUNEHLo7U849A?=
 =?us-ascii?Q?G5X+g0fvQqjOXv3MGQDj1W1f3Bv2RCFiG6xgpF3Q6fuPWM0zEPNOj0ETnIeR?=
 =?us-ascii?Q?lIilVxK4kdKXWYE8DsjGqfGhGCvaLE+tA0w3drmLijWwAVnq67wn1d2yNeeH?=
 =?us-ascii?Q?5YbUy1NabXP8GU4cn4YQy/740yG3uL7Q+TnRS+9DyA0CrXwrbedg?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b034e6-3393-4b7f-2c9b-08df3a668dcb
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:27:05.1303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8gPxhA1yM4Ee3Hst1bzw+Z7NwCDv9296BomN3oPTgmpir7L8nLOUFEDQMa8EPjmOPI6rskEQl+59IdOyNwTilWkCyWIlWHzarsf2vMf3pa87tBh+TwfQlBAcSmJWHCA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1218

Add a helper that derives the internal timer clock frequency (ITCF) of
the CQE from the ITCFMUL and ITCFVAL fields of the CQHCI capabilities
register, and export cqhci_set_cmd_idle_time() to let host drivers
program the Send Status Command Idle Timer (CIT) in CQHCI_SSC1 using a
value in nanoseconds.

The CIT defines how long the bus has to be idle, in internal timer clock
cycles, before the CQE issues CMD13 to poll the Queue Status Register.
Its reset value is controller specific and can be far from optimal, so
host drivers may need to tune it for their platform. Doing the
conversion in the core avoids every host driver re-implementing the
ITCFMUL/ITCFVAL decoding.

The requested time is rounded up to whole clock cycles so that the
programmed idle time is never shorter than requested. The helper returns
-EOPNOTSUPP when the controller does not report a usable ITCF and
-ERANGE when the result does not fit the 16-bit CIT field, so callers
can report the failure instead of silently running with the reset
default.

Record the cit value in cqhci_set_cmd_idle_time(), and if cit is non-zero,
program it into the register on every call to __cqhci_enable().

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mmc/host/cqhci-core.c | 64 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h      |  8 +++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index a466cd88b043..bfa5d8b79145 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -12,6 +12,7 @@
 #include <linux/scatterlist.h>
 #include <linux/platform_device.h>
 #include <linux/ktime.h>
+#include <linux/units.h>
 
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
@@ -279,6 +280,14 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 	cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
 		     CQHCI_TDLBAU);
 
+	if (cq_host->cit) {
+		u32 ssc1 = cqhci_readl(cq_host, CQHCI_SSC1);
+
+		ssc1 &= ~CQHCI_SSC1_CIT_MASK;
+		ssc1 |= FIELD_PREP(CQHCI_SSC1_CIT_MASK, cq_host->cit);
+		cqhci_writel(cq_host, ssc1, CQHCI_SSC1);
+	}
+
 	cqhci_writel(cq_host, cq_host->rca, CQHCI_SSC2);
 
 	cqhci_set_irqs(cq_host, 0);
@@ -1163,6 +1172,59 @@ struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(cqhci_pltfm_init);
 
+static u64 cqhci_itcfmul_to_hz(u32 itcfmul)
+{
+	/* CQHCI_CAP.ITCFMUL: 0 = 1 kHz, 1 = 10 kHz, ..., 4 = 10 MHz, others reserved */
+	if (itcfmul > 4)
+		return 0;
+
+	return HZ_PER_KHZ * int_pow(10, itcfmul);
+}
+
+static void cqhci_itcf_init(struct cqhci_host *cq_host)
+{
+	u32 cap = cqhci_readl(cq_host, CQHCI_CAP);
+	u64 itcf;
+
+	itcf = cqhci_itcfmul_to_hz(CQHCI_ITCFMUL(cap)) * CQHCI_ITCFVAL(cap);
+	if (!itcf || itcf > U32_MAX) {
+		pr_debug("%s: cqhci: internal timer clock frequency not available (CAP 0x%08x)\n",
+			 mmc_hostname(cq_host->mmc), cap);
+		return;
+	}
+
+	cq_host->itcf_hz = itcf;
+}
+
+/**
+ * cqhci_set_cmd_idle_time - program the Send Status Command Idle Timer (CIT)
+ * @cq_host: CQHCI host
+ * @ns: idle time in nanoseconds
+ *
+ * Set the number of internal timer clock cycles the CQE waits on an idle bus
+ * before issuing CMD13 to poll the Queue Status Register. The cycle count is
+ * rounded up so that the resulting idle time is never shorter than @ns.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the controller does not report its
+ * internal timer clock frequency, or -ERANGE if @ns does not fit the CIT field.
+ */
+int cqhci_set_cmd_idle_time(struct cqhci_host *cq_host, u32 ns)
+{
+	u64 cit;
+
+	if (!cq_host->itcf_hz)
+		return -EOPNOTSUPP;
+
+	cit = DIV_ROUND_UP_ULL((u64)cq_host->itcf_hz * ns, NSEC_PER_SEC);
+	if (!cit || cit > FIELD_MAX(CQHCI_SSC1_CIT_MASK))
+		return -ERANGE;
+
+	cq_host->cit = cit;
+
+	return 0;
+}
+EXPORT_SYMBOL(cqhci_set_cmd_idle_time);
+
 static unsigned int cqhci_ver_major(struct cqhci_host *cq_host)
 {
 	return CQHCI_VER_MAJOR(cqhci_readl(cq_host, CQHCI_VER));
@@ -1207,6 +1269,8 @@ int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc,
 		goto out_err;
 	}
 
+	cqhci_itcf_init(cq_host);
+
 	spin_lock_init(&cq_host->lock);
 
 	init_completion(&cq_host->halt_comp);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 8fbbc48c3f85..e6840a8f4798 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -26,6 +26,8 @@
 #define CQHCI_CAP_CS			0x10000000 /* Crypto Support */
 #define CQHCI_CAP_ITCFMUL		GENMASK(15, 12)
 #define CQHCI_ITCFMUL(x)		FIELD_GET(CQHCI_CAP_ITCFMUL, (x))
+#define CQHCI_CAP_ITCFVAL		GENMASK(9, 0)
+#define CQHCI_ITCFVAL(x)		FIELD_GET(CQHCI_CAP_ITCFVAL, (x))
 
 /* configuration */
 #define CQHCI_CFG			0x08
@@ -234,6 +236,11 @@ struct cqhci_host {
 	int num_slots;
 	int qcnt;
 
+	/* Internal Timer Clock Frequency (Hz), 0 if not reported by CQHCI_CAP */
+	u32 itcf_hz;
+	/* Send Status Command Idle Timer in ITCF cycles, 0 keeps the default */
+	u16 cit;
+
 	u32 dcmd_slot;
 	u32 caps;
 #define CQHCI_TASK_DESC_SZ_128		0x1
@@ -318,6 +325,7 @@ struct platform_device;
 irqreturn_t cqhci_irq(struct mmc_host *mmc, int cmd_error, int data_error);
 int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
 struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
+int cqhci_set_cmd_idle_time(struct cqhci_host *cq_host, u32 ns);
 int cqhci_deactivate(struct mmc_host *mmc);
 void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64);
 static inline int cqhci_suspend(struct mmc_host *mmc)
-- 
2.25.1

