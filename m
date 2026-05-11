Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA35386C3C;
	Mon, 11 May 2026 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530921; cv=fail; b=u6yQji1j2ato50isE8V0+5J3K+DdT1PcMZwdXGSCOV+syS6do5j47Oy1uVx+GrpSiAl1Gkgyx90hP8t5wfqFM/Lmy+HjKHEVtprtVW3X1Y+Je4wcCYt0JswO8b4n3t+ADuFPxEMUZRL+DSqwYcPohjef7tiKHDEHDL0mIq4ZuuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530921; c=relaxed/simple;
	bh=VYmPpmY/NIaKX+x6lPxgtXgW2eMdkHyjr/Xg7jpRvpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDeywP0ZwGfiQg6z5jAIq843sNV7asDAgddzqHJO2KYH/Gxp87Y5kPy8leA+r+jsUsaH4lHfBMw+ebGPhvDodVvZDVVfhJSpqF/iq9iHaH9RXZ1C9miWj6WWBAfUX6sBUCmRzV6nTuZLqaExVhyJ5ig0Z3bdlXyhBf4Nvqz1Vt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=VYb8tu9q; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="VYb8tu9q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEyQMCiQd/h53wo2ww7myqD71iw4tpmJwx9/U6FnxGs7Zc1lUgUNDthBYPsSRuAKkImdX368SoPUzV/3kvi7okM6EaVnT2sQPBDjiUmGvSUWkFG7DM0mdnj7YRHbrTN8Q4lxVQwdMGkasGK4bojGY207e3rvshiMRRNh6n/041FsoUbCNKwOlJ7i8qPxZOcqj+L5M52Gz2v6jq937okBcmOAheLUbw43fvsqgimKJmheLqd7euE7DfrA9dCCpX6/EjoEg/cSPfGNWSULLr9wTC06ShF7sF0ElNEugD1bME+SHX3w3VJ23+eyVmrpstR8EO2y7TrRMhDBNHY3bNX1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEKlFR1LqBEXSkUTYo5pva8GVJKJzwT+3kuSSh1PX8A=;
 b=bff3qihn+lrwglJ8IL7kkbXhBIxSsKVzON5orm2wKl9bEmgC5TjjtJkLHkIy8tmk10I3zXxq0uWbNuDMeEJHVK25ohkuupB1S2nblmtv6uY2mBFd09ty5nLqpv/lytNCwVWlcBHqNXWUasMig7aXl6EmCJv6TS6xn0OEBoIso50SAG6x9xhcBZehEZQ2sCyBsT7YlELxeZj1aKNwePPmbEVSQX/QPQOCIyR/XzAeH5tg6SR78KhcM35VLV0dlfmt3LFrnYqsn4XH0kXGkRNmmfD1up33Jx3xpJr9dMtEh9RqRBTfv4jbsRanfk6Zv2YDGT6qg1Q1tUNcnvRcZers0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEKlFR1LqBEXSkUTYo5pva8GVJKJzwT+3kuSSh1PX8A=;
 b=VYb8tu9qkVl8RqUkPQFFrScl8Gj5qisD6PsqsBgh9cLkcCnGdub3p2WRqph25n8adJb0UryfIm3yvU+aS7E2r1LF1DE0x8+pSqkVSN4oldKuA9jch57EpoMhKtzsBCK72rpspiF2Ka3KgrepetZX7E8VFlmn82JCX8c1tapidIl/vjosxmqf49Ct7tgEubWVRfBbLn9gITBvSPsEyo+gcSakV6Qshdp/xi/GwKURdahsGYoBuRO2rqLYEjWtqTslttgeVvWBmkYBz+XK5c4kyPLcQjay0Sq3JgI5lbIzAcmgAt3t6RPMwdlBkXcdzenL0erw/Dhy/L/aGJDl6EUKSw==
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
 20:21:47 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 9/9] mmc: sdhci-cadence: add Altera Agilex5 SD6HC support
Date: Mon, 11 May 2026 13:21:31 -0700
Message-Id: <20260511202132.5597-10-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 469ebcd0-4027-4750-94db-08deaf9aed69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	huoVWVrRZN8SzKJQN1fxnjmF/1XYbXe2jR6Y14VAXXn7VsjVbL1YO4VP/exk1119HaEzl4Wr0n4yQlFPBnCoSmQRMLMfEGqAcLf2Aj9pmQZPIlPBMw1AAs6nDK/THHfM7w1gSwnZUJnjKhDpAtKtrtXofFN0qZwHvm6V42yqDfSDs0Ug97hNtta2aytTKi/khvBkxEIYEbPEzgjNtN6swNfnoZWp19dLoVzbi1wobnY1V5dn1Gw6Ga+cqPJNgaXSrFvCfLibpMmFcgx11YiD7/ws9aDQU7MZz0KK250Sp35Bx4wGykbOj/ETpZoR0XKGtZ/RurFKRz3oeQb2gEJe7KsT+4qkDVK4KCw0GJov4lsQLRzstqGFvdLo3HVX7Mn10Arh8h/LKf2Hkk+Im02cdp2HgAtn8AlB27n6HpWJnQv9ViST+Wlx3Pu+e/UxjcEXaQ/juGw71MOHZEjb1UX/RUbUzp8DIWKTvKPDeWdWOSjDnyylhym7a69t5J/2uqutleEaT4pakCLt2TqRe+ocClRa3h8THsd1sr3Lt6z2COJtqHk/JyexPXMfl8eJXYdOHUuoLgXQOL+H0bTpnlFwRYp/1e4glYTlIVEA9T81Yl9lEnTBbgQU54P68jF0N1hLG7MTEd2443CpXTjGB8aBg+j1sNGsvAJQ1EJ9dKdPpqsvvSACHYTwEK1hGWvTvLEi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zEzfELtqic/rkF6AG3ZGWbFRL1y/TYNJBCT/8wfdYu7C8TcwvxOpNkVc3OJY?=
 =?us-ascii?Q?WdrLPoyACX1/dTEU8Us5jcFL4dDN6AnXFq1pJ28WUXDdOcDngKfpk+z75Ov0?=
 =?us-ascii?Q?8cBTycVtMuU31b3L/ruhypWCK5nWPs9GawH5jPYXQTIG0QQ3zORItIsnR1JQ?=
 =?us-ascii?Q?IRBZMpd1egAQyLiLAn7nkwMl+qmwVqUzdawPebn4SRQ8jy5ZW7rKPF6bkKga?=
 =?us-ascii?Q?Uc0nJI20e6HsxTwravvA6B5+8tftZeznkcnFJgxISxS8s+Uy3DuedWOS+8lQ?=
 =?us-ascii?Q?gGB+j1/3734ZeTA6uITcZErSLxq4bzimoUPFrycutmO6ZJH69WbdiCOUMtRk?=
 =?us-ascii?Q?lO+wg1/hr2GKj1wuvhfZZw/ZX3IRDK6zVkorjgtoqRKfT46ei+zBh0x3sZUp?=
 =?us-ascii?Q?fuNMgujRlNm25330+aIr46lVydd98K+pCMrQVOwOwOdoE2lVIJTWc2JCfV2r?=
 =?us-ascii?Q?FNt6rxmdKpvsVVixFkegjVXmimXnJMdL5SxsTmEQOkXQiS0jWD7QV3b7bLm0?=
 =?us-ascii?Q?DpHLOfbgmi1AgCSxBCLbyZSs3e3wXXoOjWXkw+o4P5ElykbZD9+NkdbhLRrY?=
 =?us-ascii?Q?1tfONYcCN6h157fRxAf5cN0SfMQGIfjNJesaeNuAb3Tm2xfUNXBL0tmuvvcK?=
 =?us-ascii?Q?udqJkp4L9jE1IIwtb+mPfLvA9Z8HEmVFKwad6w1Ct+qiLMzZIYYpdatkBx9M?=
 =?us-ascii?Q?plk0fKSY4PyYfSE/7t4O4SuU4PNFKf+vPvp/HN99qXbWmpdzvcx9JiDHplGq?=
 =?us-ascii?Q?HDWskRP2hI5WSPE5iKorwlfcCg+QjeX82sm5Jqhh6/wYnGKd8RIQjOGavtd+?=
 =?us-ascii?Q?tAMeyYLpAGVnqoyrlMY68wGsBwaq7GsXhtTtUQ8R9E41I0AsNhFeyh1qWdIZ?=
 =?us-ascii?Q?LkaZmhS6ZKE2ou36L1n7ozh/6A9E4dwrJeOKrZfU0jVlWTvubiKvXBCKcdIW?=
 =?us-ascii?Q?2WMBwJRXm5fK/9u+Xp/RDBWfxCAOT+2kXCSdZkjqHDoB5FKsIJT0q4WyXf3q?=
 =?us-ascii?Q?WSGwRuCCK6UAQnIpphggKkzVWAfCl6O0JcHe7GLXfsqiOjhsxT840mgJgBGx?=
 =?us-ascii?Q?uDsIvaw9iMcSiOe4ov3eVfTpP0hd5XXtgFX3UhuYlCTEkcCASvHPiSQ6oWRG?=
 =?us-ascii?Q?a3ftWiNDlD9EIpBOyY9ze6cVuHCqLymF1xuZWY9OvzExTikZhZfLAv64ua5v?=
 =?us-ascii?Q?2GX6tu4DzmhgnrKCPd/VGvxRs1kRU8v+vGQ3eeeS9CUTzVCRYjlP1onYIhN8?=
 =?us-ascii?Q?+WDjfKbijqFxqcn5C8qS28HttfTVpO7fI4YnTXxbY+POyAY5hUxrXyXL14TQ?=
 =?us-ascii?Q?quKlzo0/nBCjYKS3GDgnzYN4JrIMQUboeT7NE061rLT/dEazhU974D1NTlI/?=
 =?us-ascii?Q?wBfJ761ru4aHWR8nPFeZvzSiXZN/zdoABVXMQEhtsYZmmqGmMQqgxjD1TafW?=
 =?us-ascii?Q?eB1Fwr2Nm+vgj3ZNPs9iSXTV09v13glrKIn0cyXj/o9s7zp1fswmzOT4V5d2?=
 =?us-ascii?Q?qF9IKVmVOvEGDhYqNAbivLGsKKBXsHbYDrE+qv0IqkDWBLNqHuaP8+HNTeMZ?=
 =?us-ascii?Q?1uFZ7PN+Zfpi2QxeVQluS1c7ogI+fWyQYfFxxx686r9BAHDQKetPOEsoMeNl?=
 =?us-ascii?Q?zbLI5DDSESuIxGX4UY1fTIbnFmAOtiVzYq5IJ/GpjcfR4xl22WpkFWHI5Sgo?=
 =?us-ascii?Q?sVW9OwntVYmNmuy/yAeFiuPl+RtJlgbTiBEikVccKcCil2zQd6DIIjOUj8Cy?=
 =?us-ascii?Q?57L9Ceifm14jYyd7FyNd4Jt+Xg+qHzU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469ebcd0-4027-4750-94db-08deaf9aed69
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:47.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BS6mRm1xlJwy/4KvGhwQY0FCWS1K/JZ4Zt/+qzLfvjMezuMBUszhkEnf9JmKL5lixlHwYfcehgwz6YcTrPARasbc9mXCCjzwvuueYg8nIoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8296

The Altera Agilex5 SoC integrates a Cadence SD6HC controller that needs
platform-specific configuration to operate correctly. Its SMMU exposes
DRAM within a 40-bit address space, requiring the DMA mask to be capped
at 40 bits to prevent address allocation beyond the controller's reach.

The silicon also has hardware limitations that require the
MULTIBLOCK_READ_ACMD12, PRESET_VALUE_BROKEN, and ACMD23_BROKEN quirks.
Support is registered under the "altr,agilex5-sd6hc" compatible string
with Agilex5-specific ops and platform data.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/host/sdhci-cadence4.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence4.c b/drivers/mmc/host/sdhci-cadence4.c
index 283d22328248..b6d35c165673 100644
--- a/drivers/mmc/host/sdhci-cadence4.c
+++ b/drivers/mmc/host/sdhci-cadence4.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 
 #include "sdhci-cadence.h"
@@ -84,6 +85,7 @@ struct sdhci_cdns4_phy_cfg {
 struct sdhci_cdns_drv_data {
 	int (*init)(struct platform_device *pdev);
 	const struct sdhci_pltfm_data pltfm_data;
+	u64 dma_mask;
 };
 
 static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
@@ -193,6 +195,31 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
 	return host->max_clk;
 }
 
+/**
+ * sdhci_cdns_set_dma_mask - Set platform-specific DMA mask
+ * @host: SDHCI host controller
+ *
+ * Configure DMA mask based on platform capabilities to avoid IOMMU
+ * address allocation beyond controller's reach or unnecessary bounce
+ * buffers.
+ */
+static int sdhci_cdns_set_dma_mask(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	struct device *dev = mmc_dev(mmc);
+	const struct sdhci_cdns_drv_data *data = of_device_get_match_data(dev);
+	int ret;
+
+	if (!data->dma_mask)
+		return 0;
+
+	ret = dma_set_mask_and_coherent(dev, data->dma_mask);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
+
+	return 0;
+}
+
 static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
 {
 	u32 tmp;
@@ -479,6 +506,17 @@ static const struct sdhci_ops sdhci_cdns6_ops = {
 	.hw_reset = sdhci_cdns6_hw_reset,
 };
 
+static const struct sdhci_ops sdhci_cdns6_agilex5_ops = {
+	.set_clock = sdhci_set_clock,
+	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.platform_execute_tuning = sdhci_cdns_execute_tuning,
+	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
+	.hw_reset = sdhci_cdns6_hw_reset,
+	.set_dma_mask = sdhci_cdns_set_dma_mask,
+};
+
 static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
 	.pltfm_data = {
 		.ops = &sdhci_cdns4_ops,
@@ -506,6 +544,16 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
 	},
 };
 
+static const struct sdhci_cdns_drv_data sdhci_cdns6_agilex5_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns6_agilex5_ops,
+		.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			   SDHCI_QUIRK2_ACMD23_BROKEN,
+	},
+	.dma_mask = DMA_BIT_MASK(40),
+};
+
 static const struct sdhci_cdns_drv_data sdhci_cdns6_drv_data = {
 	.pltfm_data = {
 		.ops = &sdhci_cdns6_ops,
@@ -691,6 +739,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
 		.compatible = "cdns,sd4hc",
 		.data = &sdhci_cdns4_drv_data,
 	},
+	{
+		.compatible = "altr,agilex5-sd6hc",
+		.data = &sdhci_cdns6_agilex5_drv_data,
+	},
 	{
 		.compatible = "cdns,sd6hc",
 		.data = &sdhci_cdns6_drv_data,
-- 
2.43.7

