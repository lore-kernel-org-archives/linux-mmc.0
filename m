Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FA3D8901;
	Fri,  3 Jul 2026 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075205; cv=fail; b=j3nH2xaiQT5qGrvTKMR2qKVNLbsStH4bsJ1eGREvsXGdcMo76bsrY0jpUFIL0pyB0UFhxbE81IS9dORJLSmDhPqEtK9Tvae9KLHKWvUBZGlpKaGOTSyPn1r1fPIIfDd3K0XATTTYGvF8Ck6VzBholHTdinzZmHGtG7b41Ty42Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075205; c=relaxed/simple;
	bh=81kbJyEjyLH4alSZ6pbco56NtNwczgFdYZHVspQZ7PU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2CpLLHg8BEZM5jcl7lHM568SQCSRZYBhlEB2hPxIZGxjB4bcNJ7EMxviNG2CoPCbYN03wLVL0EeMg+9lyiNePWFAWDRU3IJdUdliGj+4a0mrBN6j1so808hm3j2HOY4DX0k6sdgndObpuof1OCpPqUzJ+MNcrajqIadK2X56u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eyomzV/G; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eyomzV/G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZJcRW1AJq1C7PczTwVQY69UBV82lQ4ARYvcfQaEvYbDooJRE21naR48oKkp49e1IbUC3/LdDILuIuN4akGWmqii8o6+1wTgyeZ/LeG4XBxIJjzpn6UATbU2gTm3LP+p354d6eAmQqzFrDf0VtKsJzKYDF0X0qw0yYWxa0vQo5YLQufFv0wpk3G5SfBqnkfc1Mqc9v5hLpMmcYhZkuWqp1XTfG1S8eTD0GC2TXZcTW34yl7ADmYO0rJqZqWlk1THsOSSTuIzy1AMS541SgbI7NMke/3iay7sZ+Vv7vHUYoSUgykauCTdD4hlnUem4Wy8Rrw68OrCugvefFTkcAG7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7QhbatFUNj9cVTT/EY0fMfHJlRhHyhEonrtYgpfw/c=;
 b=ag+Z4IR6nTuBJvhEbeYQObalWTvovamqdgfKj55NAcJWO3E2TWChyr3iO7oJL4Vei1mkBhrH+/G/gTcse0e8aQQpCpDMM0ZhivcbXvcIhsv/4vXS49HzR9L2jHb3hu7PeGiR3bu9B5v4SXe1K+xfAf7y8QRp6DV5CZHvtrxnRstOSqCs9F9oDceyfT/uoHoQjQFD2WVjmaSOD/4hNBHHKQfcINvUCuHHLzrGvwSigtczPO0Ht3v2WhpP+Q+HHcOBSljhNsweTM8nNmmZ9Gk1TU5VGlGBd0PW1k+IwLjFB34Ij5WzVb6M7QZFxlrPjqd8JQqhmTzFI+a1vuMrJ6G3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7QhbatFUNj9cVTT/EY0fMfHJlRhHyhEonrtYgpfw/c=;
 b=eyomzV/GkggqXcgQQI7h6s/57ojOhbJxUuGWaRbsyzMPjDT1XpcZXyJpNcra1Dt9cZUOa3n6xjxk8zHpR7VYea6k2iQXEFMN/TDxgaZgwZ9B3Zetk5/lu4Br5JVsIqV94u8tvBmv9MbKrpVJI9XcLReXVfye5gHS6W1Fw3PcvbiV3R+rjIuTrVjO+lcx4QKPITaTNXnbFmVZa+wTa6hkz76d5yEL5mzjM4QXUUwZlQUiPYG3sTHIDRHKMSVBTenunbNXMDG30S9SMrTFNc7UpWzhKLz3ZiBIZz84yxXDXJJFM6DPcFKHMVN6dhW7gXus/QzUvmAQNcGcvF4r7m8BNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by AM9PR04MB8667.eurprd04.prod.outlook.com (2603:10a6:20b:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:40:00 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 10:40:00 +0000
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
Subject: [PATCH v4 4/7] mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled interrupt
Date: Fri,  3 Jul 2026 18:42:05 +0800
Message-Id: <20260703104208.3426374-5-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::13) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|AM9PR04MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b055bc1-cff3-4694-b7b1-08ded8ef6f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	3zZOkrEohuPOWT0Ce04yiqrdU2z1edlzTmMV0T+VIvV3Nt9EXO3u8nIqbcFW2ycbftRNMYfA9UqnPWJ0hAvFAbcgFHTMK5oKXTVstGgIbO3pzh22pAP+274j486R/riwAZIKQS/4Wdp/8rXfGnjlVIpMjsP3w1Ar1nA9mqgV0tI1auC30V6rEJ7jMko9iXj+g4rojT0N42a/aGK4PJ2HobMMzU7+aosryhTqeRztBfAeU+aVIAE9g2VgP9mASOna6/rosMdlmoBpmHNFu3HVUL6ypgI5jUR0YxfydBhCjt2hyHgW21CUG4zYQcfdM2a5iMf+zBj/ggVkYjE3Gs3lG23lViaqJsxIqiVRYkyxnFoudT5SYgboRiG/Ns0wo7wzy98dLVRt7+0q9qoaEvzbivi6T12hebgVRWOZMsT793mFrhYPD8ubQ8FMyIk0e3UX1tkdPApfTgAgasKX+pQ9qB+IEzwzCKCFKjtq3zz65ml+MruMRqanQH6y1NPhxoDXmuSojBVnSADpT/6OH9/P/XY5Y5C2ChgqyHoc9LJAalaqVXfGk42Z0kTi0b4lLzzbldIFbAsuK/YkUahQMA+PK/OMykVsND0IxL6mFZ50oLBwHOA5yVjEO8Hak/CE+eH1RuieDnQ7yReFoadz0/3sGQkng0rqdcaj4pF5zOYtzXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q5Og2/8SxAwcKUpGpV3Pqw4Bhxu6QE/wpg8zGfsp0jMFat16vYIAYydlWYqc?=
 =?us-ascii?Q?6NVpH81Rb0Zn/IbP1dEOtjLg8nn7C+gfYEckKuko3DqatrcQadJ9xDO35wWV?=
 =?us-ascii?Q?KZ6h12zDkfJO6+HGrcKCI1l3t75k1hlZ3fRMy3CNkVhC1IKnzx5iY1SYMeUh?=
 =?us-ascii?Q?1i/SG1FQr/QQ+Nu2RVUskQ7paRUNqtMVQlxuarPm0+7hGfleNq7lf94avAN7?=
 =?us-ascii?Q?jTFFRo9cnpvVauLW43ePst0AdnGN3HY8vla9HWAv5SZ8ie/dqZzzSiU06btz?=
 =?us-ascii?Q?3SqEotUQ36uua19/frbrUCIvrF+Z13eH2i3dNh3km5ACnYNryJ1U/XqRHgYg?=
 =?us-ascii?Q?KWxyGVAK/IJ119vdaLKoqKfhNCQQ/N9Yqms7tv3Re6Bn9+lxr5yEW4HKViKN?=
 =?us-ascii?Q?I4KwcgAWexv33tM1P2ZRQbzJIpLqgLmlTaA9lBJ3W7xk3YsU/+3lBwmlE41h?=
 =?us-ascii?Q?xJ4uGY+B5WY/vfatQ2qX2A+prfw9ocw/kxoVon+1fWblXqh5RVvnJNAuCy1D?=
 =?us-ascii?Q?t85SoJeCSct3a5yDPJKW0a1oxY3zzGrLMkfL30PSdGwxK7BJTvQ7bNNQclXu?=
 =?us-ascii?Q?kP4IFcWtL6ITXIFHL5i63USMOjJLsht4HKGUQhwZrnNS/3ixhHrC3PjZ2970?=
 =?us-ascii?Q?OuzVlYbjSwGDBXH5bVazPnJShkrUyYct+4qFHZjnDp1d0WitXkWrwqVOyxmS?=
 =?us-ascii?Q?PdbVbwLONk7vzB4aWt/CR7BnwOWvH8Z5baa1439cwUb7rE2H9ZdSDjy345cy?=
 =?us-ascii?Q?OrjoVrJtmk+8DL7nQDWSQkhCDsagZKIYdN+ulV959Red8N+Ip/Ad96l4Z88d?=
 =?us-ascii?Q?ZWK2DOFrE9TopEKuz0JWG9KXTfCa1cvGrBcmycQbZFaDhc8sEYuwNO69WDQ6?=
 =?us-ascii?Q?KYnUHi/kakMsxp2/I7VexGdZYwlKzU9GOOiP7S1VIfUgmI5L0f23uQkVj6F2?=
 =?us-ascii?Q?VDaKRHUcyD4HvwvT6e5DzU34vRLriepijbTwOAGeE7d86+n6zub+mz7hJNbH?=
 =?us-ascii?Q?eZFH2qfBV3+eFxjlaycAPNv1XnrvV6fHQWvaacLBd/t622C4dnSQweiBagKX?=
 =?us-ascii?Q?kU2ERIZ/oZrHfx8YAdzbSGDTgE9upQIaq7kYlEzEaKtmLDNIY2ZKPWnrZiBw?=
 =?us-ascii?Q?C0rbAsakxP5PojTSyMBdR3CqhqTdjZBPnLN6v8ZR+YThABp2hSat2K6wmFIF?=
 =?us-ascii?Q?AQ/PjnpOMQmYeriZyR4k1dxXYjl9t+cG8KxEMw/mSj1Dj3T70vaB19eSOyyF?=
 =?us-ascii?Q?a54QIOpurumE5juys3njEI+HBgCawPWUL8XGm0WDBScthNeXRCXeJvHAlhky?=
 =?us-ascii?Q?usYQaA9WANNGISzEiV7OWu4sdHdfAzlyy8TbH+3FpLzLRQd5nbKj+cVhBIoX?=
 =?us-ascii?Q?GRpnZgXNqW0a7PXU0p3kf3d4+dQtjTie5+386mNWGOrT8mZKVMAtGNX6MwfN?=
 =?us-ascii?Q?Eho4t8D4QzZA9n9cEnHXFKHp6vcfRpFzvt5QCF7dMQshvim+ZKOUhS83AIdr?=
 =?us-ascii?Q?OtbgYbew0ODqS2ePggpyrtewm7rxtUTb9p0EiB9YGE2gZI1dh0liV7JIcQN9?=
 =?us-ascii?Q?QjGv+P8PU1I3vk81d9CezG+nnKxH7wrjzFbk16h0GggDXo6F2s0GRlU9g/ee?=
 =?us-ascii?Q?KJbSVyqjbYy1zmo8z3KPivGsK8e4FzakRljRoj7VbtedLLwiClZlQ/MUWfQE?=
 =?us-ascii?Q?zVIVbua1dlymRL61lWOS5e6jB4pYxygwWRVaQIpTcO4JUS3y1nTBgVF4b7xq?=
 =?us-ascii?Q?VImYogu4lK+4Ej4Otr890j9kCR26z7tY9BqdMh9wyOL3TdcNL975jOcLW67d?=
X-MS-Exchange-AntiSpam-MessageData-1: xmeEzTXmkxYo7g==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b055bc1-cff3-4694-b7b1-08ded8ef6f14
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:40:00.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ze4hQTB5dBm1TxXcQVOeghtRj+nlXW81G2Fu0/t/aG4jW9QrjZz/H3dY2f/+8EZ6/v8VrrDi9BZWiWQL1tSVwPMVtYziqhtG4R9drbj9SA/Zo/eYa5mQbIrnvOorGG5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8667

From: Luke Wang <ziniu.wang_1@nxp.com>

When using WIFI out-of-band wakeup, an "irq xxx: nobody cared" warning
occurs. This happens because the usdhc interrupt is not disabled during
system suspend when device_may_wakeup() returns false.

The sequence of events leading to this issue:
1. System enters suspend without disabling usdhc interrupt
(because device_may_wakeup() returns false for usdhc device)
2. WIFI out-of-band wakeup triggers system resume via GPIO interrupt
3. WIFI sends a Card interrupt before usdhc has fully resumed
4. usdhc is still in runtime suspend state and cannot handle the
interrupt properly
5. The unhandled interrupt triggers "nobody cared" warning

Fix this by unconditionally disabling the usdhc interrupt during suspend
and re-enabling it during resume, regardless of the wakeup capability.
This ensures no interrupts are processed during the suspend/resume
transition.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 3b1e63425a19..ade99dabdb5f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2075,9 +2075,10 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
 		sdhc_esdhc_tuning_save(host);
 
+	/* The irqs of imx are not shared. It is safe to disable */
+	disable_irq(host->irq);
+
 	if (device_may_wakeup(dev)) {
-		/* The irqs of imx are not shared. It is safe to disable */
-		disable_irq(host->irq);
 		ret = sdhci_enable_irq_wakeups(host);
 		if (!ret)
 			dev_warn(dev, "Failed to enable irq wakeup\n");
@@ -2128,10 +2129,10 @@ static int sdhci_esdhc_resume(struct device *dev)
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
-	if (host->irq_wake_enabled) {
+	if (host->irq_wake_enabled)
 		sdhci_disable_irq_wakeups(host);
-		enable_irq(host->irq);
-	}
+
+	enable_irq(host->irq);
 
 	/*
 	 * restore the saved tuning delay value for the device which keep
-- 
2.34.1

