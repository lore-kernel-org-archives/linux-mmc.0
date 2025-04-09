Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542BD25A652;
	Wed,  9 Apr 2025 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185298; cv=fail; b=aiB4+BTtQO9cp251CS+BIvC6NBuwXgzO4e9sgSJ7AdCnwYMp2d8JtlHbP2G5GwMylueQGvs9ejPDXaAWq/HXzQAUosfkv131TTYZN2K/ehWCrPoAWqGJnQy8Yd67Yb0eRQkMF2M35JScT7TKCVTINzxHXSf/z7r4xnwBaKEZA24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185298; c=relaxed/simple;
	bh=UwLfrmWoiSOAOP6sEDEiRuZLaBpHCSWHVOQmOGz0yho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbQhuSufjesi1BX83KcHk3gy2zHWSRaBiV8JQKsZR6n5ItB0VP1NuohXIY56SD+EHtP14KsCCC5+7XhY/LTZrdK3CZK7aOXgLa+J4x/Op8djcBMTSqD1cwcDBwbj/1I9giqX3Kb1ZODufHIec/gsh7obCsqKLxPrjy1IXIcwMG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F4gdkJPR; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F4gdkJPR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PckfFTaWiJg11urlxgjLD5KOyGPB38XAxXouCKe89d9J2xzRIYij4JgbSalEGHBuxCoKT3t/KjmZLbM2jaHcGZ+PjfWUN5KrqqqOVyCnFu9/7a80dhAVNXu4BpoFifZOQ9eV6rlB0uh1G+PTwweZPOuNxQT4JZDPmj8ftHU9u7vJI/hZUxXuYama3W5TCCP6dmbUhfKpqHP/5gj+kr7zw50zCKQ0kAaKGLeui57nagRl5Y18cEg1g9Xx+n+PxSO8TTVgqVPfM4LaTMuq5FPK9kktO66R2ek9byk9Tmu/Rpl2P2iFSH2ArvPvMu58u/t2dIPi/l+Q5knNDApGM/Yrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJF2N3EwX4lmcFwRkDr8x53Wgzi8S2bYh7SpMaQ9xVo=;
 b=Sdn17cOP41BgnCO6iOimHO1JttGxRWwQSxMxF/8r067kxKqrFyjXt1B7Ra9E5yL8ZFMCs3s443mqqDVXtSSfK7ImnrWnztUz7fjd1kCYT8661643gw87007GPvq7oBbTX8vhwjMK01Kdu0vjFNVfoNCqLOcLKAgcYTNnB878cDf27zclu3PL0fo80uszvbwy4gxp2Jw0+0g4HTLRHRnvQ0N/mFKexGPRy2cFhHu1MsWd4zmTOF260NVlZyemYSIW48rE3PgV0LVkaWcETdbPSYK6VBawk4U8XhaeaKxGvy32TogxnFTPPKWh7/FmRR/uWCH6NZIa2LD3FCkbz4UDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJF2N3EwX4lmcFwRkDr8x53Wgzi8S2bYh7SpMaQ9xVo=;
 b=F4gdkJPRVCyu9dB+9aB1NoS6gfHfaUgd8ZChruVSk8DbZ5BvnVoNTCgw3zlnjQpC71KQ7w4r+1KNJlA3eymJr4ATjQkpyQZ+qJimQBB4Z1EeHU4Q2AoHY0lHk2K0zCoQglq4wTLLUb3hsAYd788hbx9mWGMq5NLjQJOZPgZKAT8c5HfBoqS2tR5ddqQRJVm3j609IJrBHqtwrfxN1yka3gTlfnqh7V/fu/bf7WdSczBZxY5kNp2wAVCDX2od7MOcJqXN1rEcjZ1on9v4gt6BcdDdt8M9zgmkne8q2pfE0Ff+u4QpPrOkyv+K1Ce1guG3ZVnT5g+HmDZeqZ/9BhK3/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 07:54:53 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 07:54:53 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mmc: sdhci-esdhc-imx: reset async FIFO before sending manual tuning command
Date: Wed,  9 Apr 2025 15:55:46 +0800
Message-Id: <20250409075550.3413032-3-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
References: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AM7PR04MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4045fe4c-6fb6-47b1-5ab0-08dd773bd012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7dB8LwHNsNVRg49f7eV63bSaU2HHi/UmwVVrcaWp+WGAxtFFZy4LQX7LXVJ?=
 =?us-ascii?Q?SKGwqvfz5lF37pgb3brn5Tn7PMfgzsmrnGpWpsyC36IUvBLp5L4AIAMcHQMH?=
 =?us-ascii?Q?XoeKRQFdygYK08SUWzRUqmNEgnCvRDgECDdmeJCuHxkXoqX2DTK9h2NKsgKT?=
 =?us-ascii?Q?RSITePs/d2ZFSD5ik1fKyN8NNu0r0GlLs4XqxKLFImqmHW5I4HbukcxSWz8V?=
 =?us-ascii?Q?Mz6Nj3wLXMzLj1SH80SSyI1N3cuf8A0ci4EzdLLuL8XqCL/EmbCHj5Md7Bk+?=
 =?us-ascii?Q?4bHXQa7pT4K+SQM+Wkfft3KAd9hEgLlGlZ18b71m32i8dojfyntyaOiPyCXW?=
 =?us-ascii?Q?ABwLxxnf9zaDurHTp90C5xjvsB0pyegn1wMH5vezb6z447vZieNJfzbCqLHX?=
 =?us-ascii?Q?ottPEdevak6r1g4Yrm3fkwHodULKtckmNJrghdHbFKzB8Aq739JXfrkHWqbY?=
 =?us-ascii?Q?LcjcLQ8utftAdO7tpgPC7u0M1oJVACzP3QYN8UNNPi9fvtsC2wl//YT8hIJh?=
 =?us-ascii?Q?nb2YfGHljOZATM0PxHTdJ705uf2CigRNhwEDUhXdgC6pnJ4Mba7j3K38+Auq?=
 =?us-ascii?Q?mspTJ34x8a+dA3QkRq97gKrip9OuxhNZjbThOd2th73DC2X3re3OF5Z18iFV?=
 =?us-ascii?Q?RZUgtw3ZWh7lSmEHjCrtHST6qLLpbFk+zQEa3H5LVSGwWx0h5jmPNUD+0FFR?=
 =?us-ascii?Q?cX+dWRroDyDktFUPD7jA++mZnCoV5qhHtk6e14G7QBZvJ/E7UPoDlqXoxJY3?=
 =?us-ascii?Q?fLqBiXsb0bcAc1/I9SGYfGOzJXnakhXs+lKrFjvq6YMOJVCxoBEpUv5mD7Cz?=
 =?us-ascii?Q?BrWGpFISBWk3etRP24c3igpiUQ2+ITEXwRmtjaKpPF5HbfI9ce/4DS9AzdPd?=
 =?us-ascii?Q?QOzThOigy+EyK4c5WUNd0TBsucgaJ7IFiLkMgkPxxlG5FquCTZMYoUyTz5Im?=
 =?us-ascii?Q?kBwkpx2yotJnQA6HTZzvAzMNkbvNUTyPvAw497j0bwBBm0cdzUOHcNJwjHi8?=
 =?us-ascii?Q?5xuAIUcsF/aTE1zQgN9keodqjQtBZfcEhn4ryzXgv+7VoNB4oddCYlRe2L7W?=
 =?us-ascii?Q?M4Kj/ZrMX/nohwTOOqIrf9sdsn23Y5Jm2B80GxBJeHvwjksthqq4d9WhdzpG?=
 =?us-ascii?Q?qheGymj7GHoQzR8RerB8feyuGlXWzcEiALwdibzOfCOs7YsTdDS6WDbiI+9n?=
 =?us-ascii?Q?ep2DzsUuRCnkHgmP0y5b0OiCM6pItP7RDhqrPp4431SLktJktKVulzXIaOyF?=
 =?us-ascii?Q?54Ugfl/ZpXUSwQmKiJTfq/nlpigKXQedLA8WfO6w+VSdQ15EQRJWVNFjIzp3?=
 =?us-ascii?Q?G0qn2iSRwAnZWZR9l5Yf5FIjNdHXsA8DH73g82R97Z1hohH6PosGxJjFVgM0?=
 =?us-ascii?Q?ZmvDUOVRykviQ6UlaVNnS7nCf0Ce3Vv2x9rOF6RM6jFwjcvMtxlJV6arGApG?=
 =?us-ascii?Q?Bw+rtPukRh+D3E8TvsAS05/fC/ENSZhq6ohduWjaXKItxfSuPtLHfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gBbXe3u+Cg1rNyWyiapnOYmjFMctSl1qbO2k7L/kiSxofUpls7v1yMBEZ9Zo?=
 =?us-ascii?Q?B4NWtrduWiyTdaZeZUGZ1gNE1VbADXWRF+mKp8l05MqVSUtpw5o9PocgVBpV?=
 =?us-ascii?Q?0RIpRLkHg9o9gHxYCg40OS12CuPjxcWwaN7mYWbAO91bYaQftDcTG8uYrUxx?=
 =?us-ascii?Q?87hiCzfk/YYsh9R+tZ9hah5gRZstY07qstpSthaj3Yuuz9n1AA8W6b9V3r6V?=
 =?us-ascii?Q?18mdIzqiQDNE++3XxHhArWTTCepL4XJE5XlAwbzf1y4kWoNr4Sm6ekddcL0r?=
 =?us-ascii?Q?Lo748g9gtPm1vMtk4+vzkeSANGa4AkoZopZDLxCoQaxXyPOhtWpm2CvzUv/a?=
 =?us-ascii?Q?xwxkVRcCTb7B+EtGD9LfJbFulu/4OqiIeTu7MOYQzrtRsai/VkhIG76Ru7N8?=
 =?us-ascii?Q?Fng0Lw3PXFJs2dOHoTinzz5Ou10PdXInyS2BIn94IY4Jg35BI7Ke/CpMA6DF?=
 =?us-ascii?Q?31zkmoOnHv7wVCS0Pk1AAPhsRPgXAySn2OFs2enfpMMrSdXfjyOm+fN08jUZ?=
 =?us-ascii?Q?xIt3XHmmZDUkKemV6092CkRrlIgJKuOgtF4RC2rwt1SynHxP695uw6bjYY/M?=
 =?us-ascii?Q?4vF2l8PWK4d3RfcI9BTpb6BHSwM8ETIsQBxZnTVZoIlRwDpORhmH+GZpVYJ5?=
 =?us-ascii?Q?4LLJR8O0IOPbdVRWwpzzydaz4SPWKz6zOA/VpkiSsv3YgRdVqnmuIoe21kPh?=
 =?us-ascii?Q?fxpfKRh84QqkYToGn7iaPAWu6la5W+n551/PFYxSqh3Fdc9XURubU5nQhO13?=
 =?us-ascii?Q?JOHphJrClLGJQeiqRQtwb+v8o+ZDps4LvQy347P68kwHF0dZ3SAs9dCLWoCI?=
 =?us-ascii?Q?OhoobecTtBqPlYGtvQ/FEcB9dcZdqtZc+wmREDk1BIA7Mc4rIL1h34CvkJ2T?=
 =?us-ascii?Q?VhGAocOpiCWZe5EKar69U5dyePizcWr/D3F4UWdEg5yAVK+QO9AGcUxhcH/o?=
 =?us-ascii?Q?vN4wGtA0Q2NVTCSSYV2bnbVFz4Ant4DX1je3N0wAZ5tcPXQnBHvV6sHdbGz+?=
 =?us-ascii?Q?DTNoHGe0sa844nuRvmM32x+qxH9q7NZTalZCxlMB3sChDPtsCf5vmJ9Ql3+n?=
 =?us-ascii?Q?o/zMfoj1xsej1SDOq7Z5v8054GWKiLfO4XnPVpTSvP+B1eI3g7yAMbuWsVEu?=
 =?us-ascii?Q?MLL8Lxzk+2Y8q1xF3vQpc2yXnnGj1Ln26Y2GZ3duY6foziLPa/JtSU+QtlZ3?=
 =?us-ascii?Q?HEjd1mAVcFq7uXkXiZveEoyi8rOmOiPBK/dcbdxKjzdT8u/Yb3F03lUTGMfc?=
 =?us-ascii?Q?ayDPU+Flq0kAYuFFQOdiPd8kMW4OA5eLg2YNDjd781mRc1xqHwTEezfJEo/S?=
 =?us-ascii?Q?bYT4kAVEWhVqXKSWHnTpTJJ0O2cdOOjMXmIV8AlyIHcA5GmFBPE8FZPONX2K?=
 =?us-ascii?Q?CpXdce3WjDN2EseD6aAv/9s0dq2C6WQCdAdgdLla9sUuR6O1lUX2+NdhAwJS?=
 =?us-ascii?Q?4sWL6Az19AFEjfTEFHbvuVgqX/gcVwxgWXf2dEHHqiWScxmYwlllkWXevNW2?=
 =?us-ascii?Q?55F+LHjH3XaDMggLyWN+lrzts3kO/qLhbLGHRWX7CFvzhU/f0OlOJFUtaaGw?=
 =?us-ascii?Q?wWBBP56YiebAiOmW+Ra5ZwwqXMqN6NhCKmjBZt0L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4045fe4c-6fb6-47b1-5ab0-08dd773bd012
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:54:53.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCw9yrIZMBLA6KBW3dXsJX7cAfh5uHXbCAzCF1gK2CmuAjeI/6NlrUPFGIoZjjdWFT+ZX58/5hdRb+svdfTkgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077

From: Haibo Chen <haibo.chen@nxp.com>

During manual tuning, residual data in the async FIFO from previous
commands may impact with the tuning process. To ensure a clean state:

1. Set the RST_FIFO bit (SYS_CTRL[22]) to reset the async FIFO.
2. Poll the bit until self-cleared, confirming reset completion.

This hardening ensures the tuning command starts with a clean FIFO state,
improving the reliability of the manual tuning procedure.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8c2f5ae949ae..8528aa6adf02 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,6 +31,7 @@
 #include "cqhci.h"
 
 #define ESDHC_SYS_CTRL_DTOCV_MASK	GENMASK(19, 16)
+#define ESDHC_SYS_CTRL_RST_FIFO		BIT(22)
 #define ESDHC_SYS_CTRL_IPP_RST_N	BIT(23)
 #define ESDHC_SYS_CTRL_RESET_TUNING	BIT(28)
 #define	ESDHC_CTRL_D3CD			0x08
@@ -1149,7 +1150,7 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 {
-	u32 reg;
+	u32 reg, sys_ctrl;
 	u8 sw_rst;
 	int ret;
 
@@ -1173,6 +1174,16 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	dev_dbg(mmc_dev(host->mmc),
 		"tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
 			val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS));
+
+	/* set RST_FIFO to reset the async FIFO, and wat it to self-clear */
+	sys_ctrl = readl(host->ioaddr + ESDHC_SYSTEM_CONTROL);
+	sys_ctrl |= ESDHC_SYS_CTRL_RST_FIFO;
+	writel(sys_ctrl, host->ioaddr + ESDHC_SYSTEM_CONTROL);
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_SYSTEM_CONTROL, sys_ctrl,
+				 !(sys_ctrl & ESDHC_SYS_CTRL_RST_FIFO), 10, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc),
+			 "warning! RST_FIFO not clear in 100us\n");
 }
 
 static void esdhc_post_tuning(struct sdhci_host *host)
-- 
2.34.1

