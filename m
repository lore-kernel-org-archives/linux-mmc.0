Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF73876C7;
	Mon,  2 Mar 2026 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438365; cv=fail; b=qP2AWCgPKSxS17MlTBgzLcn6Xx1qUCzvO5sua1MSS2Jn8bE63OMocVaRMjigcT3Wj4udDb5i3WfNXzMyySC4ts/bZ9Kxe6LqOqn/5Y/rLu5atGEwisTCx0mZi2xawU8vW5ZhZ6tHp49RA8wxNfDGWSmU2w6QSI487n58OkTtuzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438365; c=relaxed/simple;
	bh=NEgY61dHf3JKTkn0dxkOW0IOlEmtlsWHjwjqvcWEknw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pv3l0j3c+9O5ArQ3C9eToKrxwa9WkRB+v34IvwcvC7cDn60n7UyIvdPyKLGaAxM09w5z5r83wqyM1x0CyGFD7T7KGkH47rRrPeOQ/30xayafFyOZpCSnMjTlScvrP/IEJRHZaping3jX7NZB/e3ZHDklXGhYCFLYesM/d98ll/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HFh61Vw7; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HFh61Vw7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeJaeNG0pgapdAadl7FbXcF3+mp9Zwmo0m4cdJmcc+65O5tXdf2esUxg+yY7w+h6/eoCSqCx+gDDBHJrIRjeFwcF0hjS7LN1e5n2ZT2Pkls++nGszFBRMUGm10Vrq6uq63QjMnEpudZDYti34SIlNZVcSQ5/VDX9oahHdrg1uptyxlx9GuEerEkk79glNW19oPXK33tVgK2wBvZrDzPx9Ly/C+iOJB348yGb3xOB96nCr67kTaQJLwBIwmhWJH20Oiy4OLf825sVhpN47oFN54l75y7X44goV9KdNXfn3NB6L06HQk0qE7b/lOJszmw8FOZCJyy6XSyQBKuzdacpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxssZMkmXS3vJdqAGIKB/CW3qxzTsWMPWdWI/4IHTeo=;
 b=A+nMlFTzbSRPm7h6oBNOejm+5fLni12JUnrRrohpNDwHIQ124wgakZmSHdsc1/IA3sks4a9125wUzgg/YqD8aRjCKhTnhgZg3Oq7C8/pkTjyRNYxGI6+VYNJg6sxcIU5LqrLDtC1JTe9kgrL0NXth4/BJNl3pK2w98/TlNFLSzX9LLTgSFB9yD3kba9Lcja5qyqZ/oPk868+JIkqVHSA+uhCYuUkSmaK0vJ6+mBooYoszGjHu7oOeGXmRnDucsuY1zW8xPRGCXm6kxDD3D2st1AstcGwkTPMbl0mGSGKT1BdGdXx9hYV7VCxTFKxwBf0NRxDkcrxPC+i8RpNeHX+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxssZMkmXS3vJdqAGIKB/CW3qxzTsWMPWdWI/4IHTeo=;
 b=HFh61Vw78KW81fM2Pq37NtQG3U5ByeIc9BSB6jfx+pH4nmeDuY0NQhKucFTy0OzHATn8Ewf6imTRVSWMOb1pd1gp0JNobZsBBZe9trAdoPnlEjY6ELUGxg/EjwIOZrixYfVGEAksaEHrolt7XJYDxRvYDaLOqNe5kZ1MtKXJySXP9Rwp/OIx01tLmGfrJCEydbu7L4vbPlr9HZb+a+sgtKDiMPqjTz/Bfw134DhdKQ6/nIeTmlmZf5aVC+iy7zdDBWYDKskrbb6bh675FRczy0GKPJ0SY0Emj0FaLAG8vou62lPiv+NNfQEYGP/mm0TSYDN7LqxkkyggxtooK3uVDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA1PR04MB11010.eurprd04.prod.outlook.com (2603:10a6:102:490::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 07:59:18 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:59:18 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
Date: Mon,  2 Mar 2026 16:00:55 +0800
Message-Id: <20260302080057.974102-3-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
References: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0034.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::10) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PA1PR04MB11010:EE_
X-MS-Office365-Filtering-Correlation-Id: ab56c282-3959-49d3-c49b-08de78319af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	X6qipZIEDhU+s4x4a8d4DfIUGc4TWdlWniPr8bdAv2k5rDbeIlnpl9iJlQjq6Igjf5wrm/8+BaWvHTK5PrcqE4qyXlK59f+jJtbgTibDOEgnyZZsWWPAicpzlpeHvg0WTaTNVaUtooGdcpx5bqWmz1o7YD85QVHXUQXwN6bj8Z3iio263PG9sw+giOjyaDEu+cnBe4y5I7j5k+XxwlXXK8WTaNvnbmCJ3foLKbGC83FetnSB7a9fgitKd3OJddO69kXYyfnu7eJtCNdLOmX4LI6xUiznPmh6Azh8E15PxJ/8/GDPgS4FnfUqsh54vpv73gSKAKs/pOaqbOkDiMGjrDyoCbyRIgH/phIaRl9LRsOnvNVGnyhAZfCfXgqVFvVVXyMr6iVZEkeuLFgUe6YLqbnloJ3WrnPaiIghAS4f2yH6YpBGio/RMyqc3uy3UGPWceR3l6x+oL5HhPAUgCwcB0J9+MZuFp2RpCxXDAh/WTwGb3irqdzEuvE/WCFkARwjQZ55O+r/s2xDmN5yZMSwmkQ64sJRQ6zPr+dHgGRf1DTBaE2+FiESetFc6H6HbyNTIJiULvertxS0ycW1VQJA7s0UdIIt6y6qQe+HtF4tRj+Y2cmTfRT/pMx/2xDb1RSIHZmIVjjBnH6eduJtCz8AIsFcsviefma8kcWpAfhnEOsXvWsOIg8JuBbpIQbHcnMTW5CSZy6hsaU3muwb5HPo210wM+sdY7EM7YF6Cgp4NGg1h1MgqNlb3N33D4JfLMT/lJ6oHK7fdb9QbUVedeUqpE6pR6gXZ4Le7h42hsO81Os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ETqyMqTzaWpnk46A8eaerBv1m+snYPF9wD9wxC5KG9HiEiZrLE+BhsRVCU1?=
 =?us-ascii?Q?ceKqlDsiwXtxCvrjDFWzkgMmQfl9zuZBouxPBLFH2nw+POOAZKVKRODRYPXY?=
 =?us-ascii?Q?Ohd4kxWs2srLLNyyOqmgYuPKgjQFvQSpMsrFpAFQJ/mnzvj14aQ+PbV45WGd?=
 =?us-ascii?Q?8u28SGYnzSGrrMDBcDPqXHyOrb8LKgChY+k1D1pRAY+Xd5ujI2Atg10fU/EH?=
 =?us-ascii?Q?jmWnOqhRg6LydwiQwufoLmZVk84ngGjKUMLeoy4gY0laPPmcfLW4P4kUpB45?=
 =?us-ascii?Q?1+hpKhhFguew0opEx+q3gjEzb2CgyvDtwYOCtQ517F0QWIK5KtnsI9AIs7tj?=
 =?us-ascii?Q?1cIkHtODnQG6m8ElGF3+j4cNv1d23AdeN2rtTXvdvhk5Y3xOXt75JX9GO+qB?=
 =?us-ascii?Q?2kWlAJpgmX5oqk6dULq0fVfo1xn240ZWC6vyvjJfAmDx1bvjg6bu5oruDbBw?=
 =?us-ascii?Q?OhC774WCNa4M6IqP4IF+b2BvVQsWNdbM+Rsjtn9ECuz11wq7t/tnaW9GaxRW?=
 =?us-ascii?Q?3Ps8WAiZxBEILXjPgvk+PS3kI2UuUMv+0OvY+MTt4/Y1nGpvGvIJJ6g5fsbh?=
 =?us-ascii?Q?Pt3tZvn3WJzqD9dR9o9TtVOTevUgF729VsNPZgmnyGQ+jxf34HofS8Vw3nmz?=
 =?us-ascii?Q?coCwBy8SGrWBO5l3K2Zsj8hwqFNqs7DNxnTCnRfVy584O6nJJEQX4Mn8aZcK?=
 =?us-ascii?Q?wLaN+nxr1AGtwq/N66WE32SuG9sFdzyqJHqmsGQwf6Ar408zrielIQZL7tqw?=
 =?us-ascii?Q?0mRl5mKK3QYL6FQp/h6KrlmW12V0mTc6TeZR92Bm1iIekdNdJMfITo2MCvZl?=
 =?us-ascii?Q?W/IxTq68F69m7K2tGUKfUlma1uzQe+NV1SalcAaPg12Jc8MiZxLCw7dU/67Y?=
 =?us-ascii?Q?ARDhcvZOfBJzYWdmkUuvy2movX3U1qtA2fz7cftk1VlBRdxTNbdXc0+RIjTF?=
 =?us-ascii?Q?7vl8rG0pTxdHT29uZXYNtcahRiiyPTjr3ba5NKIQ2r4zw4UwqfZ6WOZ1f6UI?=
 =?us-ascii?Q?THcAC4rpX3rT0wORouMunDsfFO6njAXBm+NszWMt6JE4ki3ep8IRkv4K0IQv?=
 =?us-ascii?Q?9lrWA9oo1XI2rfgi7HGoXx+8ojIQSwSaM1esJwmFN9TeMmPBS0KFGBG//WOY?=
 =?us-ascii?Q?6xLe6IoHIgghvQBhnd3pk3H2Efx1zTCcx2YwVPdsh3NGohIViqzR2TiWFrnh?=
 =?us-ascii?Q?xV87XpFawgOroknjxmOZeBRxLFj1BYgHFNXjDl+QVgjUvrM206H9tiSQQv9q?=
 =?us-ascii?Q?y9frzfhO0hLisQByloVAq/+kbixIERrLlKlNzFhIlLmWpEt/kgRjI8UWKuvy?=
 =?us-ascii?Q?vIpDroTH/HOcRKJE15tboFZ5n0rTc5FUbjNuJ8dUuqW4nUXOrJf18OAtsYpY?=
 =?us-ascii?Q?zY8jyy2/+LbpPwTuNMaz06FzAXXpgqHnNWFKagR5G2RrADY6qzOBGAgQT1Q/?=
 =?us-ascii?Q?Y9WkPMCq8qPbZFbH2GsRUagfnfGp1IxJoVZcSo91x6h1s0sV98OUlEHJ18ZA?=
 =?us-ascii?Q?aHGfwEhcgYaPlFtBshQdCM8EfMWAPciLJGBBwrLm+S1PahA6dizf08t5Eluv?=
 =?us-ascii?Q?gpE2b2sSG9LZYU9j4n8nVx4XkLEhUVgqYT8qYeN4en7hUsXTB1QZdpj2Um/O?=
 =?us-ascii?Q?V9vNPIBjHMb1CWERPyQRmPXE0ioqNpSNkY/DCp62ia+uytWhxOw28NoU8Bsm?=
 =?us-ascii?Q?ZIfL103zNkoHXLGiY0hATonoXNvur4bZvhFd26Rr99SfDNs6fPwrrCJ4bCZ+?=
 =?us-ascii?Q?EB4N+Gjx4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab56c282-3959-49d3-c49b-08de78319af4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:59:18.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPSq/v2Igf/MGSqjg9YZ537/zfeRDtxN9+85qBAv3xGyIlvct2khvwYL73bKdOrqKIk70kBN00xcIXrgLpj6Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11010

From: Luke Wang <ziniu.wang_1@nxp.com>

Add sdhci_get_property() call to parse common SDHCI DT properties,
including "bus-width = <1>" which sets SDHCI_QUIRK_FORCE_1_BIT_DATA
quirk for 1-bit data bus width configuration.

Remove the duplicate "no-1-8-v" property parsing since
sdhci_get_property() already handles it.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 97461e20425d..b607d4ffc562 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1813,8 +1813,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
 				&boarddata->strobe_dll_delay_target);
-	if (of_property_read_bool(np, "no-1-8-v"))
-		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
@@ -1833,6 +1831,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	sdhci_get_property(pdev);
+
 	/* HS400/HS400ES require 8 bit bus */
 	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
 		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
-- 
2.34.1

