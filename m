Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECCB3FC5AB;
	Mon, 29 Jun 2026 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724690; cv=fail; b=BeFB4A76wiyVNlphZs/leYRTEr13ednhPLuQgyZ40S6LxSKAI7DWl7KSgBr3Y2UKP9JYvttmYYa/YwBs/PXfGRurYJxsfAgZAsxkwiWSWdQ6I0rzO3VshCdDIEcSh6IH38E99/7ZOwmqHva9H8BoOSMbDVnZlcuZRYIl4AEcts4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724690; c=relaxed/simple;
	bh=zW5LZOeo+bRCAzz8tqAsFZAMg0zMmTs10IybBtp0eWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qtKOFWOj7pBFnv9W0igKNP2mNppq0VhZ35AcRcnBtbp8c1Rw/bF4PBT0+xUHu0OB19pUmFIr9M8tRQ6qY6ZJUMY8Z/SPFdrVaL0woP+wogd4jxLDiRyHDSIJGv+Y5JpWPniMgpeUSBTzfILy5BbHJtiXdSnV6YIYVgXwRImrpzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ePzVcp7V; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ePzVcp7V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiJ7SPfwi80g0dY7sSqSVzeTjR6N9zqQcWh69+8J1Cy7oPWVtNwZL/QSrNdWqt5ge7xoz6L8/YLkqe/MUnSdZaZBkPitz+/OZ6DEFtX0G6xEvy47l8g9SqEs/a6yEn0wE92r7mpU3XSz9VUMOLD7gTWkOZZJ5Yh9svoSHLAc1C0BCoArNByWJImpZibun7rtADUKLkwEQRLUlFM07drvatzaGZYT9DE6N/4ira8fCxR4Uz8XXyRI72dR2BDz7441/dNSX5vq2Y1P0iQAs+Vp55aNSaExqlymEh0cCcc2IwckRSHtXv60RNHfIHvQjEJO2tNKM828C9v1WSKEYdL8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWe5HUTaDJumk5/wExvT11eYksPmZGVvmKOXSwotnd8=;
 b=St4G5nMpmjix9cs+W7NMVy9wv26b2f7e0TKzqrE8ZHMWx3py69z4LliA1gMeOUdMax61HYVnit5X+jgRWAgXV9OmluDraBN+XQIWWfknYikWTagYw/DdHY020DOPAq5lzPNMkNnVm7yA41+sos82D+lckNVNgSidts1IsCMQ6fOOTF4vMQaL9/rc+cy3gwLsaA0QcdQnxKHpHQUi5uSPVylAGT+b599zsma6kVv32e6flZrYo1DdxmSR+ODHCkuqxWh6idD+jMMGEY0SivIagwTEsB76rblVyPEWNWYQbdROKFtwiIhxMK2Ej36QWQ3lvGg+iAl1lzwfmLiKCJdeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWe5HUTaDJumk5/wExvT11eYksPmZGVvmKOXSwotnd8=;
 b=ePzVcp7Vy6YEnGcwJXPukgfcu2Mx3T8VMAFHozxv6xmwpmpt5qWgPlFi3UyMr68s9e+HkEMuIZJH9nMAPhMg5aKzQcINYZl1fHWUKCX/hB17w5my8sNyH59saj5Kwq95qOfcztk74liqILW4+iEqjLukXRAA19TeVNepIbYJDBsjyUQwUoCf1AsZrn9ZmsAx9IUUZk/Y7RA96L9gjHsHw2BARWv20Cw7VAXZK3amTTzuC2ZtH+4CiMOKfnXHKlopVi0ES41qQuy2BgXYfO+BMbHPbVEKubJ1KZpGukGNBG2Vax/Irm4qe76KxxwUVvcoXGxV089exEI4GUVc4Ul+UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:18:04 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:18:04 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com,
	Frank.Li@nxp.com
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] mmc: sdhci-esdhc-imx: fix resume error handling
Date: Mon, 29 Jun 2026 17:19:54 +0800
Message-Id: <20260629091954.3227151-8-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::14) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c8c43b-e573-4ff0-3000-08ded5bf5333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iopCkgEq+kdBpWItmOruDM468vbUOtt4LyA/eytnV+AWNmeo+dn1vxK7B2PeLnvSIAZzP1RSIUTS5Nn/VNUrWqHXgO8C1YZnxBuJ3ExxDqCmisoM/qW0nasvFahlcQ48N6Pf+RwSG/5S4apzr10Ks3GO0bpQOQxCfxZasJYjeqEImEiQIdeeDQWTMM+sFGZ3Lb3D6PduXUpKLsXvZvyRPcyv9KEUTk/K/NDsi0NgTZarkhRJG9dQrATZCeox1h0JDkt4aRFqlhVFmEKnFpvjzXpCHHcryzKxKw41fSB9ZBedUimEzkKngbBuWdqeKSUsm0tFOMhoS8PJZrvzknJx+ATbaUwrqvbLaU3PALXbGPsRLVMfJMNRX816WS/2DimWVbEkTgRf3Fqw5BmS4EpPbMLgMVBGXrI70/X9m16v/tO7uZ9OvssdOK1GU10NuWg9NE04vknqw2rMyYxiaAQ7z6iqcgzwRBHAR68UPKjPKNqDLoBvL93T5wGmyN/pPKzwzeK/yz1xxAH8ZYE6yrB+HWYDO0pzrKvFipIHwV7XEfWNWuz709JbbP5I3UlhoWkUt1WrxLqEMnIT8pR/Tg+3SgRMQidxBYUU9NDW8QoKR9EOmTPEkCwP/ENDBz7PhFr/oRRpMbNf1rGBYgM8FVWe+yS6khWISB7lQA29FTz372Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ztKboEyhtgNE2/zRVFPWHebOotEJFf3H3P3vxa7Mj/maCXhSmgLJ4JsyX/JJ?=
 =?us-ascii?Q?dMdRxj94RGJHx0YsLBtU3S/cS67LO7cZYqswUF3qf1rUDF+EtDWicoqFGQ2q?=
 =?us-ascii?Q?m2AB24UD1NmvYGMvGJobmixZVzv8p07lUJG4XWfm4o62fvNtUteM9QtR1xS6?=
 =?us-ascii?Q?r0KOHYVWWiSaZr6UP1+QGJE6G4HRPpEJQ8c2N8onJ3OC9bqhUuijGy1+sLDF?=
 =?us-ascii?Q?xPXyX+x0kLOTRLi8m9NN4tHlWiRQNTRlq5872lKWt2PpwqtpJqTQ2uTs5Q0D?=
 =?us-ascii?Q?D/mDj3m0KVACws1IPIlb4pibTDz61GLgbWEaGIgjSHA1vVlC50abwlQGoQaS?=
 =?us-ascii?Q?tJ0PrADSxCpMh0JP7cr9HZSsOnsEcOp6FcuCXHR87HXN+jRzO4OoVSwYIMOv?=
 =?us-ascii?Q?FJzo8ONrnw0zpYPuu4JLBRx56s4Wte0Q/OoVOx9i4Z1vfr6Z/SGvinn2hIEa?=
 =?us-ascii?Q?FEBifvYc+ZFN1JOByTMUoZKRfQEvmx/EFSwufNbegNNYoeGq4xkFbGutZvtu?=
 =?us-ascii?Q?0CSXn+q5oub70lv+csqQsoc/UsrmDwxT1W1tUbOIGH62UTYYbVlwIITum9pr?=
 =?us-ascii?Q?N2QyMALCTr8UWtTlE/TGeO69QQoEnAdR18oqoNfm/tdsRgj4nA/tA/ypYnhf?=
 =?us-ascii?Q?Kfc61YXK0rCt6KBp7NhG99v+uowVywTH3nCR4NMkGmuoFSfceQQz9CviVKJz?=
 =?us-ascii?Q?kwtNx7ltBPKaVz8NTj4xtXu5jziMqreLHnKq5utYQVF7/wzJJ1R/EtXDXqDs?=
 =?us-ascii?Q?aXsyKSjJUuNIb+dQH027+O2661PoweJ4JixM3LLAnR49NcW2Q/31gWScpbtC?=
 =?us-ascii?Q?shQcMmXvz75/VB764IrUu6ZVmqAunU/Qrikq9NrXpi49wannDJ5OO9YvHUtp?=
 =?us-ascii?Q?aqO6BCY9KeXfIDVQlEyfp+rje/B03B8TDyAjrEiBPZ9iZDXpVwiBzP/vBye/?=
 =?us-ascii?Q?41viz32p3U8tNV5b36G0BTQIWtdllTH0dLytWLC5vvnj83XS96lPqPzssaAE?=
 =?us-ascii?Q?pgZoFvkrQyPJ4WpqBVQxlXIwBYOC0iPMDOIiqqXd1M/66WojPzJFGi+thdWz?=
 =?us-ascii?Q?rkclI1dPBSbUSUdBNO6yyGnUrZV5tOqL14eS2iKjTJhYIKW2EgaDyMt8Ld2J?=
 =?us-ascii?Q?Gy5LZi8+MjZXqipP9Yjhx5S1IkpcCGq8SX9a8Z3UHaX8OajhJIQTSzwa47mY?=
 =?us-ascii?Q?vsn9VqGbcxtA0ym5URz0632j+IVEbqL0j+4nvo/696q+qfkB0riynqbRHNnq?=
 =?us-ascii?Q?p//Dli+u9+oXxDQZzuBx8IcFyCs4aKSoO75rsTlCr7vU/Gj/aN5lSQDZpEhl?=
 =?us-ascii?Q?OT3xKS7lra7bzpvUMnvvRQUq8nkDjasKKEEofzICkOdsOfAy8DCKm+XYvxnh?=
 =?us-ascii?Q?UNyIrRvRLF7a6gUehodhWmojZzxvguunrJ++SUHlJDjrQHjmYTHX8O9txiOF?=
 =?us-ascii?Q?3YpAt9GqvoMVxYGcZWoVH73tM04a9wFjN8xn0LlZigfUX3tnnNlFSSd4HMOQ?=
 =?us-ascii?Q?kZkcnHv+KSBkjbbiW+IAlcCyjGs6CsJacth0OBo4We5QcksRZiGR2XaKH8uv?=
 =?us-ascii?Q?K7phZHhDPUkBr7zaj6U29UFHjxIpVuD9HLqnbFQ4GfsQMvauFvWjRSFM157b?=
 =?us-ascii?Q?AUZf8mpJxClWPD930u34hBkCZwGlmZK8GVLUc7FFMa0ExlAQgl0rJiE8xfEy?=
 =?us-ascii?Q?jq5oP/elgVQd8WXZA9s+NqFB4YGVVpK6pqTbjUFKbKgMKA/jxlKuxP51cfzZ?=
 =?us-ascii?Q?J884w+f2nQjZwq5a5Gf4213qeMCS7auXNC+O8DK8nG2z6ibRewKC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c8c43b-e573-4ff0-3000-08ded5bf5333
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:18:04.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUtv19G/NdNzJg9ANV2VCuSsXXyFzIIRBUB4DeZTaJHSwOcK+nNnSYItzwZi4QH5h20mYZKHE8vzW4ZImh4g13n7pnn9uHgQIepo4IZl5uioJXX/j8l2CmpNfc9NyvWW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986

From: Luke Wang <ziniu.wang_1@nxp.com>

Check pm_runtime_force_resume() return value in resume. If it fails
(clock enable failure), return immediately since accessing hardware
registers on an unclocked device would cause a kernel panic.

Remove the return value check for mmc_gpio_set_cd_wake(host->mmc, false)
since disable_irq_wake() called internally always returns 0.

Also return 0 explicitly on the success path instead of propagating
stale return values.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index abee3d7a07a3..4d6818c95809 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2125,12 +2125,12 @@ static int sdhci_esdhc_resume(struct device *dev)
 			dev_warn(dev, "Failed to restore pinctrl state\n");
 	}
 
-	pm_runtime_force_resume(dev);
-
-	ret = mmc_gpio_set_cd_wake(host->mmc, false);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
+	mmc_gpio_set_cd_wake(host->mmc, false);
+
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
@@ -2157,7 +2157,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 
 	pm_runtime_put_autosuspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_runtime_suspend(struct device *dev)
-- 
2.34.1

