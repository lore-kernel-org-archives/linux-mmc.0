Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCE2C08A1;
	Thu, 11 Dec 2025 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765439696; cv=fail; b=lLUOO8ZDGnT7dVNhy7iXNJk2CAZn8afpt4ytMGCTmiicklttTZtcbSjWG6ax62x5KxPg+UXv81awbjjhXSJLXsOT4nuyyaHnS8frmCM86MR2jgaKp9RXjlUH25z2byzmC8dt32tX2FQZM8Re0tNvSE9zxnE9M4d/Ybd58pWj65I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765439696; c=relaxed/simple;
	bh=gD5ud7jxAutKvUDY2YJ0PkhjC/krbHZHAL2tMc3pMpU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MkqtmCi24HQmYOnhsDleAOWiKw4ZvjD0gtOjCVkFw3f2VeRWETMjZY42QB/Ftnkolw9LvDRbZSEwrWs9LeHmZn8dlIOOJn4CzMz4pozTA9j5jvEEP2O2l1DQlvQl6ShFCXw8527Wvj8l4gBc2Kt0lGFimPb21ciCXELaAmM83IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O59iniXW; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O59iniXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkw8Nij0SLEq8MOpvxDu5jry8merJalxhRaRamfkeUNxKLZ0qUDzFr3J0N/2wqVQ6Z6URAOiTnRSi7wk37pfJmqxyuaPCDbfDfhnDUcYKvKCQR0z2X8eCtSwsrNOJUOEkHABvfwccD0kkzcfolJ+QXSPQIzn+5+o10upCRC2RfB//p85bi/NiY8FBBDPJVsr3RC1uOsFd7CM9vEU0hcWbpCvLF2rqy9ouUHo7uQqVzRQN4bEab2U3HQr/bsA0JSHc/jSUYpbVR5WWj8ARtLTyda1NSy8UZvn5cX2rVasuuWc5nBOPRamsmaH+8iiYZiHgwPEY4ryLJ2T8pwGKceG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jiku9WzPU7rK3XOvHSLOOuKvy/lFgCYL6dToqZRT+D8=;
 b=iDXETbDEPgcPtQX8YcF2xn+A6hcPNApwn/OT98JhuxvF5TZZeYsWueC8XKfaHLOu8aTkLUR1D0d4NK/X8EFsuD/g25DgHKlZ2MF7isA1agbps/BTHkiFtOjYyWvnRh4rkYmBYbbIFX8uG+qogGoDaB3U0BsiPNvRUOe2X57cQmUA2AH+k3Wy6G6zS+7lwDke1jeeSLJat3UMmap2cIRlGpdjb8eWegjdbFycNuFajXlee8C7T9KcX/xU0kPlY1FJW2H+HLrXnhkEcmph7scSzOQ623P1gLUJZ8Kw6FDkFGmnVVCzYpSzq/HcLb/OBjHTpHbxipAgeVff7ovyXa8hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jiku9WzPU7rK3XOvHSLOOuKvy/lFgCYL6dToqZRT+D8=;
 b=O59iniXWRz5PdUspCdh28bTlIY8gbdFGREuCD3YqeCFSbEJ1I6jenXhH1+xLj9E/Y6Z0opujgj8TLksYUUSTh8tFLi8rCDhbtl8VefG5hJA04EMqpW+t2Q35NVfdiMl0zcWUwzoJaI4gPFTfnyNDQ0vurmNIAtMXVeKUZquNL01QTTVYpJeNo61YM9bKW6NAy9zPe7UIVel8PbWvZ/oLhD494nTFd2y5q+NIgRm1Z5xqvpzVUqXPDeCtaw6WeD4URLzRB6MW0tWdixTKnUg/q7Cht2NUK8p4I3OydGfS7Mp/sUlS03jO3t/r+qltyp6JikdR/GoN2f2c9IdMPtmuAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 07:54:50 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 07:54:49 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	haibo.chen@nxp.com,
	ulf.hansson@linaro.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mmc: sdhci-esdhc-imx: wait for data transfer completion before reset
Date: Thu, 11 Dec 2025 15:56:03 +0800
Message-Id: <20251211075603.533033-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::19) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c2dbaa-4996-4c13-37f4-08de388a8f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bsPI6LGYU+d/g2mC2mAScj/vCFVdgrKRHvAPyb1uBnENtIwLfPIe8W0AaIDh?=
 =?us-ascii?Q?DZiTX+KlG05p4XXxKn0yeL+pVeS2oN1AL2hUTzHbSHPIf4nQX8bw0puZRtgF?=
 =?us-ascii?Q?ZxzH/DgUmHr9y2PVe7yBLaBOl2YEbynzdody6XavI8C+ZS/KleZ2CJ1vwNhS?=
 =?us-ascii?Q?dpiSe/30sK+uFAbcIkhuDGHM2Fo+PXc2fPjHuScVqsxn3DKjgo3NlC9r4fZg?=
 =?us-ascii?Q?n4KWrJ8LrLez2ukxvSlrU2HnRfdFkuJCWlhPxjXpoG7gDC2N6k/MMAhRxM9/?=
 =?us-ascii?Q?FuMkgPQMw0zvRS/h13a/KH/Ydx9FvgEaM2z6NoYzH66HXYQ9BEBGf9fiaza0?=
 =?us-ascii?Q?vbWXs5LlwRyIyXZ0WWUSb8iJ8MHFvs7gG4Sknyj0sqRm+c+gzmQ6AGAJ0CRP?=
 =?us-ascii?Q?T3QvMXckg4w43qLsOKtMtVw3IsXFjMDNc/wt5IJNIAIMDxyHfo+S2slilUZ0?=
 =?us-ascii?Q?cnnuDzpETn+DeEorTtnhjSkIy8HYLwOvERmL1lnGwojGmKtu56q94h4RLHY+?=
 =?us-ascii?Q?E7TBVeEqQjOlRBbewSkh9Sa3S0QWPlcEwPfVgjLL875RyG+wOZH/vG+L7vpe?=
 =?us-ascii?Q?NtQd08Y8OwcWajjqsD66e1oHiQZjzdH3h07qrDx7kUdaC7EQpZJq29+Mys9H?=
 =?us-ascii?Q?nshsqjAUoanL/ey6BgFjWqBHFEBYRRSo4eFJib5k8oOMpMJW4WU/7/7hmLZx?=
 =?us-ascii?Q?a0p4Ifg/2VBq4TOk+oWl922YamoMd8PWfuzyXtmG/nsQEZLc0K2zzROMaZiw?=
 =?us-ascii?Q?YJXA98G6/lrBBBwX/W/lRSDe85L748anq6OdFZ1AUspSt/qQJnwy5rfbQ+xh?=
 =?us-ascii?Q?L7VluPbXmUh6MOl1YCw7dbGTYqD7CjkxhfxSP5OMctF6lGkp7JweKEgpM57o?=
 =?us-ascii?Q?5eO0CEkOy2Vwgu683XPnP77rD8Y64vaJ1DWBxTN5iHs1n2nHjIa9PhTv7qPN?=
 =?us-ascii?Q?y49U/7oeshUXbDsLGy6y3MXMRIuSI7szOQe+rjwz+V4SQUUYMyUoX8zU7FpO?=
 =?us-ascii?Q?nZYm0diLmXy1fBg6tfH+LNne9amunZjNCLvd5EmXPSU6VJ7/S1s7UyzO5QnD?=
 =?us-ascii?Q?TRCdkjGb4JPMKWWvRlguvTHRi6ThF4EqA6KACAqKZ//7fe9FkErEW+SN+AGM?=
 =?us-ascii?Q?jNzrAYvTsvsJ0dtJBx1iK/dQ8tBH+7JVfXrQKk247PtgUEGyfPwz0NLrGquI?=
 =?us-ascii?Q?xTEZXuyqyAKfawrALOBi2GGyDGhMTqddnUnaPPbcSTMYq1Ntdo8Rqv1lBtqz?=
 =?us-ascii?Q?M8eTkvqWXV4CH5vRDp6AD5v8HSOzdJGqVHj2Cag0UPFSQsSIORt9au+Uzvbk?=
 =?us-ascii?Q?3kIAcH7SVPZ2yYeZ0ivDFNpNlkJdsuXC+9zOVXB1eNIedbUDfyJEPtY9d3hG?=
 =?us-ascii?Q?I9MhL68fQXghNIDeED+6e4wHAl86nI4dClJH0Lbk+x2355D+sfyeg7nESC9x?=
 =?us-ascii?Q?KkrSqXIWvVthZbjSRGPe/3lOrRvvROgr7TGR+Skry6CWYmfHnRPF73spmwaN?=
 =?us-ascii?Q?TQnIIbFRjFPcfiGw42nzQv3q4pnCMr68sxkl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOyo7FiFL75y/hBfjWRiud5YnqenjCq4xcaqOmV4Mb3lOSjAtZqec3rdWjNG?=
 =?us-ascii?Q?qbW/N+5U+SXvcUA8HGp0ZFPhypzPQ7Lydl99Ay9gK2Z5ItbOVVkguokNU4xQ?=
 =?us-ascii?Q?D6qTHIIsIT9gu9BnLyTKwzsjVGzCTg0DG0hnPp9lrAltgPFFi8QsejTIaSw0?=
 =?us-ascii?Q?izwaUcUawubzHBbFZLx40JXNgKPfRBxN7q6Q6fRvZkZ9Sime9KQOkYQUwkOG?=
 =?us-ascii?Q?X0p881q/MG5s6v/boRbdDWKNQRaJBwi/B6W6XrN4dQ8ixeBqtlJDI177l6nG?=
 =?us-ascii?Q?l+Dw2MMzeWF76HMR1MMWUFSre2waFH2jTPcZKnQZld9valGnUDTgSyvbzhqW?=
 =?us-ascii?Q?xQ+ePF9+6vqe6uLZuzQCs1+SdhDJ2t4adn9KeR5f52i20WY1WlEk7eiJujMA?=
 =?us-ascii?Q?KLkVC22Quywi+CLdH8OlYPdaUhFGf6pFgqgqWlZCeRXOihBTdayjf30/hS4P?=
 =?us-ascii?Q?NZnsBieS//p5M/7YifyiPV1XQze01OrxeWe/mTHlP0XX2vaT2RHExeuamm12?=
 =?us-ascii?Q?3xCxY13obzh8rEljqG1d5FMrswgfut877uk/Rop/mxnvWEbhKhPihXdv8odr?=
 =?us-ascii?Q?bBtFcb5pp6eelRRb1qgBRTy1N0Zvd2KTnD6kmdFlYfZKbRutXeXOPzoLTyT8?=
 =?us-ascii?Q?WwPolaDO2fHs3+cgxpAJgClz7mUmqnJvgC13J1iChRod5G03aGAG0RIMvOH0?=
 =?us-ascii?Q?D7D+qHtLx7vsyRItMnl5NT0LN2u3IT0nTA8R+lEQVSmuQD0RuSPTcSznCTyr?=
 =?us-ascii?Q?AYhA2t0fViJT5ZAGINfRoOns9q8fKRRxQyWbC2SrxyWP6wvcPsX2MVcHnqr8?=
 =?us-ascii?Q?crIOFV5f7su2sswJy+k5sRzOihvMgHcfAcCUODiVEnXa+ZhV1Dwlrz4/Enpo?=
 =?us-ascii?Q?1z6RnLYU3x/h93Feq1qYzk3/rhs1Bo8xuBKFmQ9wQcoTkLCmpF71UeoKfi1w?=
 =?us-ascii?Q?2h5PVtj2PZeKoBVlOVK8AKHDhwyIqX3uYpyqMolxFM6Tnf1hy6UJoWFONO1K?=
 =?us-ascii?Q?UrJU2iyqRHV6kFKtwnFYixVeHse1hG4cGXSn8ktD4SB/qMTxDTQEy7GIuDNq?=
 =?us-ascii?Q?+b6e3L5NEAh4G4MzM4Cv6u5qSXJt503+nHutxEejE8vlA7S8UfLCQ4MEw9ae?=
 =?us-ascii?Q?StPhAfd5TW7tCHSZE5YCQU2MSFXxu1jz10rWX6GH+Tsj4Okq6Vyqs5kWHcQZ?=
 =?us-ascii?Q?qBlM8a4lfEbUUnoXe54eseTS8rEJjSuXwXZRpWgJHmjnYr0jnJ2OQzSETLzr?=
 =?us-ascii?Q?h/1ZyXzcMz9sSYf+YWpvD1TveUy17RTUTsVsnxQKOaCWKA/CEDCdvi1e0NtF?=
 =?us-ascii?Q?fBILPmuOIvJLR+YXyaSNpH9cUVlbgpgxUTDdAdiDTXKlkjk/91jgExYc8Cui?=
 =?us-ascii?Q?7qbAzz7pYLODj5gjxOeLDNheIUyVGXeEJ4ImLs3p8Ng+FudUAPgqz4CRPndy?=
 =?us-ascii?Q?PVQ3iCNiUomFnWkeZiLaZ1zhXPHRK/MzOfh5Rot22HfPECkFGqgrkYOmNioZ?=
 =?us-ascii?Q?H447YMB903eBP6x1pRBBdVT8Dip8D35g/TQFaRbWzejeI2VAHW2wpr5lFJOZ?=
 =?us-ascii?Q?VXTuR1mXtZdwFRemPdtYEZ/mvDC1cXJN/6dDxaID?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c2dbaa-4996-4c13-37f4-08de388a8f39
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 07:54:49.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTpwL++JwlBna6834ihAMWhyvBP8q1G9i1TFOG1w782NrL1O95zDKX3CeWHUFWVwcWlXxI/Pajkj2+8AnoUXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

From: Luke Wang <ziniu.wang_1@nxp.com>

On IMX7ULP platforms, certain SD cards (e.g. Kingston Canvas Go! Plus)
cause system hangs and reboots during manual tuning. These cards exhibit
large gaps (~16us) between tuning command response and data transmission.
When cmd CRC errors occur during tuning, the code assumes data errors even
tuning data hasn't been fully received and then reset host data circuit.

Per IMX7ULP reference manual, reset operations (RESET_DATA/ALL) need to
make sure no active data transfers. Previously, resetting while data was
in-flight would clear data circuit, including ADMA/SDMA address, causing
data to be transmitted to incorrect memory address. This patch adds
polling for data transfer completion before executing resets.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Reviewed-by: Bough Chen <haibo.chen@nxp.com>
---
v3: add define for timeout value
v2: amend commit message
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673b0f..97461e20425d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -216,6 +216,8 @@
 #define ESDHC_FLAG_DUMMY_PAD		BIT(19)
 
 #define ESDHC_AUTO_TUNING_WINDOW	3
+/* 100ms timeout for data inhibit */
+#define ESDHC_DATA_INHIBIT_WAIT_US	100000
 
 enum wp_types {
 	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
@@ -1453,6 +1455,22 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
+	u32 present_state;
+	int ret;
+
+	/*
+	 * For data or full reset, ensure any active data transfer completes
+	 * before resetting to avoid system hang.
+	 */
+	if (mask & (SDHCI_RESET_DATA | SDHCI_RESET_ALL)) {
+		ret = readl_poll_timeout_atomic(host->ioaddr + ESDHC_PRSSTAT, present_state,
+						!(present_state & SDHCI_DATA_INHIBIT), 2,
+						ESDHC_DATA_INHIBIT_WAIT_US);
+		if (ret == -ETIMEDOUT)
+			dev_warn(mmc_dev(host->mmc),
+				 "timeout waiting for data transfer completion\n");
+	}
+
 	sdhci_and_cqhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-- 
2.34.1

