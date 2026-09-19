Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9435DA77;
	Sat, 19 Sep 2026 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811092; cv=fail; b=j1XprZ9MMkKMTzDezO09IVqMtl1IQ1ttJ0LbHWDaJRkwfrG2FIU9WF+IaAkZvQztts9VKCr75+v3At+1Fr3+Dvxu0VALg5IadiuW03OINSmrgEsjfpH3X6tlaHGpSdtzPqJxdtMTuPawFrAUZDW/KAj0nAVS+3Il31VgtmyBeMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811092; c=relaxed/simple;
	bh=BImAWiCUYZwtM3fhbR+UC9xB+C39k6HdYFIeq/UwQPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RaAzgV4lTdoiQjsHTyGacwqCgT23Ssv2+xdeZVuKEf5sc4pTVLpD3NxD63C3IgWJ7y8Uqd+jxXLdMI3YVdKETRvOGBI2+5nPN6x2Eds13oheRsYDzQdwvAkKwmrRyHeeP2ju+5ECKimDyKsnhGiO3uk8oyATaOclZ+NWrUR9eVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSZQcTcmdUFlbiMSEjdBxAtMCAJWp35g2eSG+Urs5pf1WxJUqRhgbKPEjSvcFOKa7T8MhERWYqLhKSr1nnwzCyxbHVoWxgBJbAos8cLAVDFfMSv07vkQKHokqWBmYafqIJzrYdaM1vwVfGaXKswOWat697mrzFc7/Cww0bYxU/OjyhpxY8AXCXRmEq8ldXjEDv53GCe/5Xfg9cu9z6SbPXZkDHsXDyGqBYr9Qz0bhko+8VL/2RSk6phzmDpb+lj01cQMTXBNNIqt8Cyd8QoucWTDiIvfOBybwubCPwLSjaWKpIXShAuGRaACeEs1AEsWKKl0bMl8YauIdV0lc5zWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6j0hGIzrw1PkFp7AJVBeAXWl4kKaPjhbeAIf+RHkAw=;
 b=X6NVrGoAqEyXSjSSTHpyz9kxOiAmo66pHx/Exvfm+glG5BTS5/rF0T5P+sOZwk+Nc80iUfTL/IABAkg5q6UZIL3nnYZzZZac/m8be1I3VNwa8uEIBzFDlMMBtyLjC2/Ubg2nOq9OUw2vzpTUVShsyW+31ompowVp2UE7+t7ucYXo4hWuhIz6Ik+pNHGyzmoqXuE4X7zAxol+0SuFoc75XZ/CHITVt8SzTr1aa2ywM49zKL4n1napEQpeaN8xKL12g15OtdXVRXk7MWfe5SkEysIDt0tZumuNGm3TQ4A+jibH2CuMM3VFuoYrRK/Nqn3warmgrBHG8+MFODqJdVNqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1155.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 09:30:01 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0428.014; Sat, 19 Sep 2026 09:30:01 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <chen.wang@linux.dev>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 2/2] mmc: sdhci-of-dwcmshc: Add support for StarFive JHB100
Date: Sat, 19 Sep 2026 02:29:50 -0700
Message-Id: <20260919092950.178617-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260919092950.178617-1-changhuang.liang@starfivetech.com>
References: <20260919092950.178617-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::12) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1155:EE_
X-MS-Office365-Filtering-Correlation-Id: 8562e76e-ef8c-4aa1-73f7-08df1630943b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|1800799024|366016|5023799004|56012099006|10067099003|6133799003|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2StkRqvZ4H66o8mbWvmx+2G6nh1VvQncs+l9i64PR3PLVXuj/ssWkRQcRc6px4tGCmTa/M8n4CZPjMw8bVujvfp+HGWa7JYidbb7gEXIG90XGZjilXETVnxSVQih3c1jXdaaKVvYILL3FjcXAA7P6qrKpJT3Sk/OEHLt0ap5iUEJ+aL6LXr2GwELQLqEgUjIVRutsMGhpAcNMhM92uZuDmDjoujN67cVGriIhRB2v56sVmNyOL0DWxX7+3KZUkQFEq9KQkdRoWxxdmGwEdn4dzXt2yk6Fw5SEAktDm39veNy1m5eYIscPl43U0FQklWntV/0c83DAC6WpHZBYozlaZQV9agSv7zdY2HSB7HUslybLb5PWjIwgEOSH35lQsDmTv0iAKmiHXjhJObRvgyJ0Dv/TfXlwLBFKRTv9ab3whw6t7bEzj/mHrIFVMQMndZvvvPzK2HricisJPojpnpvY1tm/rkCN7onHHBG3UkK9CTPjW/VRc9eYMZy8k2/grv214jIlc1TMWGth5RBKiGoT+BYpnnwFkOSsqpXG1CGy6GtrqA9rH6KjoimGsYET4Ku
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(1800799024)(366016)(5023799004)(56012099006)(10067099003)(6133799003)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqWxrU7Om/h4RXtQOi4dNmbLV1RtZjFacoBxTyAp8WaulU8MB2TDvRQeRkeO?=
 =?us-ascii?Q?jzC+d7AXJMo8bTWpvUTcEnqwnsw54GtwunZ9lHyjNIDmfLi02a+dG1sJ/Fzs?=
 =?us-ascii?Q?ihyZ1z6HfehMGIwuI5q2qm6AuEPeWVUI0mhZcJcyhewTeGn3ji8111EJCrMb?=
 =?us-ascii?Q?/Jlp95EGlEwiAP2n/JYSIpMfJjwxx8MAj/v56MTYzZ/CIhkXajLzGxdzwH+N?=
 =?us-ascii?Q?askntHQ1e9RxPv3Uf/6J+uvEEfoc2U5956Cvmz8Y1djAwcqfHywKR+VqpYH6?=
 =?us-ascii?Q?Z4/YBg+Ny4m0rMk4B5XN92aTIOojb1t3UszjenhmHFpFZChqv801PlyeKyvs?=
 =?us-ascii?Q?KvKPjk/ijVCaFsuL+aSc0bUyi5/nhffvrTwE8zKzB1u81cmu9eF5c17YMXXw?=
 =?us-ascii?Q?RojIJa0jjygqujNSZekazXF4bpvhQwijQ1+C28eOZEbk3W9YDm58TrlKwg/V?=
 =?us-ascii?Q?vcd2b+yBs5AI10Gf1XN4+ZFTrFHV/FlKFl5OSR3HdShuCrMq6rLa+6tifJsX?=
 =?us-ascii?Q?kGuDLgmbiHljU1olJV7XgyCjIjLV98jhzUK/O9EccxR+1TIW8dA0ytONPvAX?=
 =?us-ascii?Q?374ABwIRvckZw+T+t85nfDobY/uZFYW9QfOMRh+uyH0LQewCBf7kNka1/yGs?=
 =?us-ascii?Q?+gmMwUXpZajRCKvBmcZczpuEzWXAGGibKM8G7+Yi0rLz7g7DP+IBKr+ba+5+?=
 =?us-ascii?Q?Wd61Y7Nn0WGzDrJFuGH6pLiJ5cNdfiACTJ3YJ/zrUH/Kl1Wicxa9nI37iPzU?=
 =?us-ascii?Q?2aw4WRisVMrWiKk8Uh9w26F+INkH1qKYsGKYKHoXjagm08RuVco9uF+OBcza?=
 =?us-ascii?Q?lloGY6PVypivWABQE6Qfj+PlHKy+OW9Gi1L/TLz+C8mGGzIPkox96IzcQ54X?=
 =?us-ascii?Q?ENb3liMQghp0pw7DNpgSV4Wa3IesuBHATedMWwYTLBqWQyXzMlfIZxA5XXIg?=
 =?us-ascii?Q?5uTymJ2iKoZ88k2SeoBUkSupI6ojLxMuamVxSMtHjod8bM2fF6a8bUrTBAb2?=
 =?us-ascii?Q?doj4yZkCFUU0saGmDLgfUzjj6xft6mwQY/5qJEkfrdyZxE5kwc7tMXWZsiBB?=
 =?us-ascii?Q?20ZOvKPq3PjJQatMT0Wx4t0OW7OdRu6pgVOfVg4/IpTlUpsTFdueoDFKoBha?=
 =?us-ascii?Q?lB5P2zQ9/szJfhE3f94k0WJ0YfXNLRGOnWpHtaMHwx35oJho+3c5K1YpVVaj?=
 =?us-ascii?Q?Iwzsly3kIJ/53f3t4RDPmXa2T+5W72hbo4TlPu2P5KfU3U6lUk0/sxUXYPFA?=
 =?us-ascii?Q?2RFYWskE420CWvlfk8KB7oRw0XZzmyNikQ3G7nA6nNDisQMEyg8PgL3CAPBz?=
 =?us-ascii?Q?4XBhSNXd+3YuFMpQniWhs3HyOnYsDboOojo2kq3k3B1IHzICvzylOXHJGqGz?=
 =?us-ascii?Q?RE/TtW1R0BqXxtGtsNNp3VgvLAD3a2rSg0G+4dUMrKNg8TKin8tH+Gw37J0s?=
 =?us-ascii?Q?L5WmKpREDGN0XJcw37pM6E4ANaj/KZGh5j27dKLCiHiaV8ZOP69kMkjfqYVY?=
 =?us-ascii?Q?b9I6ABKPlzGt9Ujp4wXcb33VF75NWBtQr9M15mcMfHr8IqC0xdXSBHYddwtj?=
 =?us-ascii?Q?gCZxm+lWSE/uC0S6quEwDee8zvBMYBdgLZVh1VzkyGq88VBmU60m9cD5Lfib?=
 =?us-ascii?Q?qAISlDxMLCekFOL+ay9HD2c3eXaAoC5Cg2yd5Qfi1M2Si62ZSts3gOVA9WNT?=
 =?us-ascii?Q?9OvbOmcbXMk+3iE/mArIOdMHGY+jbp5u1quhawumzpKoHbywj+WSpY8VuUah?=
 =?us-ascii?Q?JgDUi3WU5Qa7h98jBZT6rY4E53b71KuzAycp2D0gnBsjiAAOlQ4m?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8562e76e-ef8c-4aa1-73f7-08df1630943b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 09:30:01.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfguOQgRjqsoFxJ82hSLWUl0ZZkPUB16ZlUu7fJcSaEuh9MNNWjHvpe0amL2H0Y4JLoMqiMaPGbkg3Zvv+V241RX1clE8v7+1EasYynDb4o9PltWMd054+0Kqu3t+vJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1155

Add support for the DWCMSHC controller found on the StarFive JHB100
SoC.

The JHB100 CMSHC controller has only 32-bit DMA capability by default.
The higher DMA address bits [35:32] can be configured through the
PER1 SYSCON, extending the DMA address range up to 36 bits. Fix these
bits to 4, which limits the DMA range to [0x40000000 - 0x4ffffffff].

The cclk_tx clock must be disabled before sdhci_set_clock() to
eliminate glitches, and re-enabled afterwards. It is enabled during
probe and disabled in the platform deinit callback, which is invoked
from dwcmshc_remove().

Additionally, clear the PHY_DLLDL_CNFG_R register and re-initialize
the PHY when setting UHS signaling, and force 1.8V fixed I/O when the
DT specifies a DDR/HS200/HS400 1.8V mode.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 158 ++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 1baa2379c9c3..021b03c17312 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -48,6 +48,9 @@
 #define DWCMSHC_ENHANCED_STROBE		BIT(8)
 #define DWCMSHC_EMMC_ATCTRL		0x40
 #define DWCMSHC_AT_STAT			0x44
+/* StarFive JHB100 SoC MSHCCS register */
+#define DWCMSHC_ARWADDR			GENMASK(3, 0)
+#define DWCMSHC_ARWADDR_DEFAULT		4
 /* Tuning and auto-tuning fields in AT_CTRL_R control register */
 #define AT_CTRL_AT_EN			BIT(0) /* autotuning is enabled */
 #define AT_CTRL_CI_SEL			BIT(1) /* interval to drive center phase select */
@@ -294,6 +297,11 @@ struct k230_priv  {
 	struct regmap *hi_sys_regmap;
 };

+struct jhb100_priv {
+	struct clk *cclk_tx;
+	bool cclk_tx_on;
+};
+
 #define DWCMSHC_MAX_OTHER_CLKS 3

 struct dwcmshc_priv {
@@ -314,6 +322,7 @@ struct dwcmshc_pltfm_data {
 	const struct sdhci_pltfm_data pdata;
 	const struct cqhci_host_ops *cqhci_host_ops;
 	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
+	void (*deinit)(struct dwcmshc_priv *dwc_priv);
 	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
 };

@@ -2257,6 +2266,145 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_hpe_gsc_pdata = {
 	.init = dwcmshc_hpe_gsc_init,
 };

+static int sdhci_jhb100_set_dma_mask(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	struct device *dev = mmc_dev(mmc);
+	int ret;
+
+	/*
+	 * The StarFive JHB100's CMSHC controller only has 32-bit DMA
+	 * capability by default, but the higher DMA address bits [35:32]
+	 * can be configured through SYSCON, thus supporting up to 36-bit
+	 * DMA capability.
+	 */
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+	if (ret)
+		dev_err(dev, "Failed to set 36-bit DMA mask.\n");
+
+	return ret;
+}
+
+static void sdhci_jhb100_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	struct jhb100_priv *priv = dwc_priv->priv;
+
+	/* the cclk_tx clock is disabled before sdhci_set_clock() to eliminate glitches */
+	if (priv->cclk_tx_on) {
+		clk_disable_unprepare(priv->cclk_tx);
+		priv->cclk_tx_on = false;
+	}
+
+	fsleep(15);
+
+	sdhci_set_clock(host, clock);
+
+	if (clk_prepare_enable(priv->cclk_tx))
+		dev_err(mmc_dev(host->mmc), "failed to re-enable cclk_tx\n");
+	else
+		priv->cclk_tx_on = true;
+}
+
+static void sdhci_jhb100_set_uhs_signaling(struct sdhci_host *host,
+					   unsigned int timing)
+{
+	dwcmshc_set_uhs_signaling(host, timing);
+	sdhci_writeb(host, 0, PHY_DLLDL_CNFG_R);
+	th1520_sdhci_set_phy(host);
+}
+
+static const struct sdhci_ops starfive_jhb100_ops = {
+	.set_dma_mask		= sdhci_jhb100_set_dma_mask,
+	.set_clock		= sdhci_jhb100_set_clock,
+	.set_uhs_signaling	= sdhci_jhb100_set_uhs_signaling,
+	.set_bus_width		= sdhci_set_bus_width,
+	.reset			= sdhci_reset,
+	.get_max_clock		= dwcmshc_get_max_clock,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.irq			= dwcmshc_cqe_irq_handler,
+	.voltage_switch		= dwcmshc_phy_init,
+	.platform_execute_tuning = th1520_execute_tuning,
+};
+
+static int dwcmshc_starfive_jhb100_init(struct device *dev, struct sdhci_host *host,
+					struct dwcmshc_priv *dwc_priv)
+{
+	struct reset_control *reset;
+	struct jhb100_priv *priv;
+	unsigned int reg_offset;
+	struct regmap *syscon;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(struct jhb100_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	syscon = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+						      "starfive,jhb100-per1-syscon",
+						      1, &reg_offset);
+	if (IS_ERR(syscon))
+		return PTR_ERR(syscon);
+
+	/* configure the higher DMA address bits [35:32] */
+	ret = regmap_update_bits(syscon, reg_offset, DWCMSHC_ARWADDR,
+				 DWCMSHC_ARWADDR_DEFAULT);
+	if (ret)
+		return ret;
+
+	reset = devm_reset_control_get_exclusive_deasserted(mmc_dev(host->mmc), NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(reset),
+				     "Failed to get&deassert reset control\n");
+
+	priv->cclk_tx = devm_clk_get(dev, "cclk_tx");
+	if (IS_ERR(priv->cclk_tx))
+		return dev_err_probe(dev, PTR_ERR(priv->cclk_tx),
+				     "Failed to get cclk_tx clock\n");
+
+	ret = clk_prepare_enable(priv->cclk_tx);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable cclk_tx clock\n");
+
+	priv->cclk_tx_on = true;
+
+	if (device_property_read_bool(mmc_dev(host->mmc), "mmc-ddr-1_8v") ||
+	    device_property_read_bool(mmc_dev(host->mmc), "mmc-hs200-1_8v") ||
+	    device_property_read_bool(mmc_dev(host->mmc), "mmc-hs400-1_8v"))
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+	else
+		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
+
+	dwc_priv->delay_line = 0x10;
+	dwc_priv->priv = priv;
+
+	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->flags |=  SDHCI_SIGNALING_180;
+	}
+
+	return 0;
+}
+
+static void dwcmshc_starfive_jhb100_deinit(struct dwcmshc_priv *dwc_priv)
+{
+	struct jhb100_priv *priv = dwc_priv->priv;
+
+	if (priv->cclk_tx_on)
+		clk_disable_unprepare(priv->cclk_tx);
+}
+
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_jhb100_pdata = {
+	.pdata = {
+		.ops = &starfive_jhb100_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
+	.init = dwcmshc_starfive_jhb100_init,
+	.deinit = dwcmshc_starfive_jhb100_deinit,
+};
+
 static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
 	.enable		= dwcmshc_sdhci_cqe_enable,
 	.disable	= sdhci_cqe_disable,
@@ -2377,6 +2525,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "hpe,gsc-dwcmshc",
 		.data = &sdhci_dwcmshc_hpe_gsc_pdata,
 	},
+	{
+		.compatible = "starfive,jhb100-dwcmshc",
+		.data = &sdhci_dwcmshc_jhb100_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
@@ -2503,6 +2655,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_rpm:
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
+	if (pltfm_data->deinit)
+		pltfm_data->deinit(priv);
 err_bus_clk:
 	clk_disable_unprepare(priv->bus_clk);
 err_clk:
@@ -2527,6 +2681,7 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	const struct dwcmshc_pltfm_data *pltfm_data = priv->dwcmshc_pdata;

 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -2534,6 +2689,9 @@ static void dwcmshc_remove(struct platform_device *pdev)

 	sdhci_remove_host(host, 0);

+	if (pltfm_data->deinit)
+		pltfm_data->deinit(priv);
+
 	dwcmshc_disable_card_clk(host);

 	clk_disable_unprepare(pltfm_host->clk);
--
2.25.1
