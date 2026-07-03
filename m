Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E723C10A3;
	Fri,  3 Jul 2026 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075231; cv=fail; b=B6Dr1t+j3kb+pHvg2iKsra/i59jjDjPWO9rSphnSi++2Ry7tKitY2ayrAOX5oNSjwlec3PQgEVUM7XslQzbWH1tcbL7a7kf5mBCVcvULKiejaF63jMxK+rsPRNlMHqasdW0+jRJ+NvUqiohyxjcqnj+Q+ruVrE1XgM8UCmDww0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075231; c=relaxed/simple;
	bh=uiX7fs/+LfDexm4dJ2fnAcDDmkwyqzp3U2ilDQ+m9hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g83WAu1TF+l/DjeMFbfR9PdQOfqiphNPrQ4HaiWhkvpxnAzUGdZP+CXYz72CtZ7qLabxJifNKbxMYneSxlwiPJGsjPRoBT/wfDF3garTzDiBIb8+bXMXpQH0/Bt9JAkFvhodbdfym+i1/4CuBPfj+Nn71UfnVdiNrptIb+awSMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BDEffEx9; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BDEffEx9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYXCbayFbSm5Mfrgwol+/5HQ/2hXdZ60M6Ohh7G4+9+nQz2CHO0wsWnLOiRig0sqNc9s2mjfxuBeLQ6JTahkD/oYJtfbeUX8UK9E9+KcNS7aQw2SNdKs6urN9yUiFbVSB3uimHUQwW6nMuUoJEOgjoUBi6rzQ3MrZnvpqa6i+BIpHlP1ydQtWtFPHZbV+AZtssUfQJqYagMs4YgUVwqEMvbqab4Fc7EVhgUq1wmtsUhRhO1dWHDoX2PJUFXJG/LeWZECMNkFSMVa40m2U2ExLRKoWoD782GRaIFWo+Rp+93092jUfLWASBboCMyWi58qhXgwTXxEiUXk6eFuNemv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfgF3xD5GVlkdOY/TTkYJBJzZmMlxHd4RVdHxZ6kKUw=;
 b=ToRIBNnXWSliSWNm9s515YMOu/8mqjWamRAw3N/j0GLG9l+4F+jf0xe6fcczcLRXaj+dnwnZxV3p7gC5zZTaBqyHCHdONIJdln58uCffO+Q3+lM6idKv/Mjx24IJxShADuRWzxlOq9NkhIZD6kVOINafL+I7xjat8ffvKbptqJ8bb3OCwFjeBQelLm0h1Cs7X2YDPPjXQ+bYIe/EaZpyUZpQEujhSz+uqgYCaNh1PBTDqe7OuLdIgX7xcvBwdVHPqFCgW0OGqLS28UX1O883+DCj9rNnoXRFLhrPCA8q9aL6tjLybBa0QU/lhOhhMQBPnuYKW0kF0Rl94VrdhDFQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfgF3xD5GVlkdOY/TTkYJBJzZmMlxHd4RVdHxZ6kKUw=;
 b=BDEffEx9UydCsUc4rd6x3S0QSYPXiVoPiX9VTCaWbmZZAhU9wFVl2tdrpy9wF7dVfwJ2GJBhMZr2n7UXFcpUPtp5yh0dFDx2W0weSIC8l+fs3IoKOsmEqWP3d+Ut3uUoBGTlQOtaT/RUo0WNNbMDi5QgLj8i9qMxLI0mqOiFLEaPGQBSQutzwgHE/x3OWluQRm33t+abbiQ6w2fGE5Nv7N6VrS+nYtDwJPJY2kTlI7Hk1fJF1rvjkjaq58Wx8cZ1xoSEGwew657YgI839sEza/C5l1HFBgjGuNf9D8/iA0aTKNJLEOlH/CPNqPecedDNS2/DODD0yK1VERSp2CRDMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by AM9PR04MB8667.eurprd04.prod.outlook.com (2603:10a6:20b:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:40:27 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 10:40:26 +0000
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
Subject: [PATCH v4 7/7] mmc: sdhci-esdhc-imx: fix resume error handling
Date: Fri,  3 Jul 2026 18:42:08 +0800
Message-Id: <20260703104208.3426374-8-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0284.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::13) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|AM9PR04MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: b18239d5-8ba8-4939-80dd-08ded8ef7eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fRJvOGeYD3UBZlJi3o9GR8Empzs42dBdO4dv+5t3n39/Dz9v7wpDff+nSe8+1PghPBlKQgXWK1oGCFNJibTuS4o736+aXpSuk6ZsBV1QcDyxazTSk7++A9+hhuynOMmTAKuKqx+Ho9H8GW1FCc2HlHWTk91PZZpFJOlHsIOs7XAds/C3eAlKqru103cnFDJLHAAofuQ/GQ/6oVoM66BOU10slCFZILRaUvydVWmvHzgkm56xrvMGs3BrFL0I7cjOYmb8+Jvn9J4bBA5xSHqXMQwKnM0XS9SUqfWg9IEArvaCByVoAqVEU6HO/nHgKyUC92yHj9u+Y0y6siAhr6TqtlzkyR8njREY6i/j/WgsqgQmIO3BlrxfL84hT9a8xcQtv46Wu0aqlNwI2V1warxR4PL76Uz0LSHzX/rSM7Zn6BJnAVxLNHGP2agVUTNC11KZtBOQESZcVCnJsqic68zZVcF1bPf6TajxCWtOWXYdfzthTga+P2SsEBTtnmRhC8aZ8E0sNzolUqBfwjiY6ZxHoH9qodHnsWTDDPKQUIBgh74ni05nFYfblt9knboOMt16l6BUSByGC47drdM8xPKIKG4er6nbITlWRqbPx4yW37Pl80/n8ZLvXz0VN3osUSpdgWJBQX4may1g2ROD28aTYzCyWtZraGUr15G6zd+jHIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAf2sGwt3aBb4DBwaZfCWcfsl3ZeqgSUz7d2pjT7bvJGuJwN8Wv64aCUBxSM?=
 =?us-ascii?Q?xgmwcVTZnXF7Wpd8+J0kNiMQ91UC/EBwHcvN0bSOPOmWWpVl3tQoUgbhfUFc?=
 =?us-ascii?Q?ZAR5Sp853TG3KiyHSPxJHYrjwovDfLiYIXFbwyTUrlEgzOJvoNYuJLO4E/y7?=
 =?us-ascii?Q?oSzTZqO/r3zZpn4ECQe7h61JaOpfu7LLM5dWU1vTlO0pZ3tE0LPEkaJ3WcVc?=
 =?us-ascii?Q?n7MKsuoe+C0zxaVhVpMCgglyOPqmO5++gUV53dHVD2JfefHrgfdhzZKNhSQD?=
 =?us-ascii?Q?cchXfbdWYGOkgfgO7jdmyx4LVSgB5RXaUOviI8a3ZsGx0obx9Otw1YVoxXqT?=
 =?us-ascii?Q?nAXZoIIyoKGWVbdCXZlBlrQ4t3OrinxawCRUK3+TqwomaxCVNAjZkcreFTcc?=
 =?us-ascii?Q?dgilPNEClUfSJQLj1aNnUW3FgcwAlIqhw5Fx0SnPf5/4f5mrlvYOeqIqQFP0?=
 =?us-ascii?Q?WD0vi0qymebx0Mi9cfof02J5PUAPzKa0nlxdL8dHjJRUMoRO9a31AJsNXBuE?=
 =?us-ascii?Q?FnsilBVPyeEhSCznoykwowkxta3ydDOCAz9lLRJqXziuNxnna9bIxZyAhNhb?=
 =?us-ascii?Q?ghhP0wn7sSkXkgWfsZrSzdHf5l9WdV0UHeuLfO7C2RvH665yRQmeOmnVhKag?=
 =?us-ascii?Q?EVVfyDea86uZiFaNxB7HbEMpnxlpOzYWr+SFJ2OvAgfLzgfZCe0feQdou36P?=
 =?us-ascii?Q?F3mzlnfpVUcOZcqBurZUYu/9iIbfizjzywQ4fk5yGECv3FvL61Ro/32PQH/C?=
 =?us-ascii?Q?wfAp388Vp9zInajUClwPEi8jfoxlYOfgyJuv+abBRyQ4jpdmmtnPcqkMaU+N?=
 =?us-ascii?Q?hYXPWV1BlH1Qz8HnTTQXACfkZSQ8EtFbJhW67K9FfgA9OHFEfaY33aIvlth8?=
 =?us-ascii?Q?qHFINYAOAKJPvGIoR2EhzURJ1W0hajXIA7T+R2ppFqThYR8xPmFYWXRrxzNw?=
 =?us-ascii?Q?enI3H8dxPiMXyNZYlXiPwgLQ+nou29kE7O+QYM/w0UXmXH2x4wrFQ8xC9JMo?=
 =?us-ascii?Q?DucauF9JzTTxWAoyJlkc5Xucg6JWj6qteF2jJv6e/woLiLnOSAbyMYVzU92T?=
 =?us-ascii?Q?jb//ggQz6gmFE3gxd0jTLQzdI0jUmxmYU0ukvKOu2/zXXcrCztufHjyI0iVI?=
 =?us-ascii?Q?vDLQsp2YpN3wM09NNPtYLGVZ8Axg3eJIh9KRTrpjjOYIEjoXTUvHludkA9cQ?=
 =?us-ascii?Q?GDosrgh8vpD9PwfPHt2LG0D+S5qvWD/OjjVLDS/qKZnFIy4ogWj8/unctZSj?=
 =?us-ascii?Q?pYuGftnioZGc3BE9lEQynjyc3z3joQyVokIrC9r/hIPoCTYHtdE1wSvYwTsH?=
 =?us-ascii?Q?loorrwfDB0QDcRJUcACFR2a0i8ghoUuvpBFeT8nTZKeNDeTSxM1nU3ynI2HQ?=
 =?us-ascii?Q?cbHCf0N9gJQhOblT0VuSdJVz/AzcPJzmGjMsDVUJRGDGPAL4KHVjoZGKw/Eu?=
 =?us-ascii?Q?t+UgDVXAa4J0JBrPFf6BYatduAIei25FlcaVUrNTMpyyRfFckEPmRr1YLQ/9?=
 =?us-ascii?Q?CzS1q3BjL5Cet5r9VU/dnjUB1M3zNMEJKElFuwEae9PJaLyODKZZ271k8of2?=
 =?us-ascii?Q?dwHncFgFdeqv8E8W6lUYdbuefuLlDsrOFG8kPkWXcMMvYPx8sPLJBr1kq9kx?=
 =?us-ascii?Q?70xjDDVtLnupsh7abMNEFbNB6GX0L0tRlCrna4oE1uNTkjWoX7RianbcwME5?=
 =?us-ascii?Q?Guapt+1v1/CPPLs2yuqlVMelDQ6kQlIOa9wO4GywN3X8i3C3E0hujbBoOwHv?=
 =?us-ascii?Q?Pp/zXBb9VGszlb1yP/N0D5333tvqfbhRB4devNWrFO2/WGFYt/0xOHKeQRMZ?=
X-MS-Exchange-AntiSpam-MessageData-1: Wjydu1Df9G/QKg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18239d5-8ba8-4939-80dd-08ded8ef7eb6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:40:26.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oc3rMOkANyz4U+MZYAZ+1el69zK4C+lg+TfOoo5b+j61dii+C5JsaOXTC8VAeI++Zk2et1zz6Iio6gQ8xleSuo0zKF5GjjiU3ZQRtp6bK+VQF8V4u/UKw9SPmJmXAnKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8667

From: Luke Wang <ziniu.wang_1@nxp.com>

Check pm_runtime_force_resume() return value in resume. If it fails
(clock enable failure), return immediately since accessing hardware
registers on an unclocked device would cause a kernel panic.

The early return intentionally skips enable_irq() and
sdhci_disable_irq_wakeups() because the IRQ handler reads
SDHCI_INT_STATUS, which would also fault without clocks. The PM runtime
usage counter leak only affects this already-broken device instance and
is an acceptable tradeoff to preserve system stability.

Remove the return value check for mmc_gpio_set_cd_wake(host->mmc, false)
since disable_irq_wake() called internally always returns 0.

Also return 0 explicitly on the success path instead of propagating
stale return values.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6920f0425508..586a1debf098 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2124,12 +2124,12 @@ static int sdhci_esdhc_resume(struct device *dev)
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
 
@@ -2156,7 +2156,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 
 	pm_runtime_put_autosuspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_runtime_suspend(struct device *dev)
-- 
2.34.1

