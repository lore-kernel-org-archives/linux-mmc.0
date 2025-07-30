Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF461F237A;
	Wed, 30 Jul 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753855556; cv=fail; b=XDR3QRx+ccoUukDcriDyoZfHr/Fxj+fh6zNlcFWJ554yt/lCQ0YD0ZOAYH6CA76EWNKRc5D9Rtc5x2yoqpueFaHKAEXcERhlIat+hoc32YzHf4GIn2tGg+CBobIob+AuPtU0T/Vj6oStnuSrzIzcVG9yZJCY/dSaNAXRTpMYs9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753855556; c=relaxed/simple;
	bh=PrMbiQK7mpORFKWBWV0fnu8wyCnt9BramemHb1zdCTc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KLcHwssu1Rm5g+VQZyAVr80uHOBDv0zjrWZ20XFcospOEzwYjBHZonqb03Q0nnTKQXSTqkFO3Z0Q16JOA0DyL8/CCTttsRdgoLIgllEVpFKmCTExDLYEMGtGAlVjO3pPj+m1V3mNULbGCUMsFBVtQNjuHliMMKDpVCUKMvlaYGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i2S05Lux; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i2S05Lux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9FMZNZlh8jwIrHyppJCuPHoa3Gx7VqhSSZmf34kEa1q2nJmy9qaANQVQrADuzKXkPQ3gVbkr7yVCS6H2F3NqbPVb53xztC7/2k/MH2b+jlcU4MvYMoumQXRru+NehAoCB35+kRwrs1PbZzej00daRrybAgdsfiLbqiX01Dj81s/WqCYDQqFohdx5U92VfBB6V51i0Uau161BcF43n6ALVhqwOrw4RJpVDXO28Vne4uyTXScFelbucpnnXTT44HapaGG+ZIa15vKwy2HqyHLYonKqFKLVzjen5lAxrIAkHoTWtUMnR6OFNuu2BOsh9VjN86GUD3oFBc1q+UmokhlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GarnDOnNJKzeZ2lD2KNRhYJHX7+tWc+5HdYlPv7A2U=;
 b=xpYNMwl74+1C4BB8CaRiuF5robPE/FNvLC/Lm3h9Wi7MAqtnd2FSHRwmQ02adZ3P77rCdDEKvyXZB79FaZ3yL40txY02SwOhFOtRawB5DcVq5w23gdogb/ztiEvRua/ILTlyrjXbKHL+AQLCJhYad13KN6KGPx7GUwUHYxNPo7JevBcFm03CYj/e9N8SQ93ME7xx/B6r5Wu7TtELIf5oz3KzNGeF+FPyT+z57uVp+l4O9GT4F/Im/y9q9Wh48yvayWqUDDoDhVvT1x7/SngTS8MdMN3BDIYla2zbnDhD0eLAgW7MmBTbY6D3Nzn6EJCOCwvGJEZk2pZ9JPjJajVFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GarnDOnNJKzeZ2lD2KNRhYJHX7+tWc+5HdYlPv7A2U=;
 b=i2S05LuxDYgml+5IQQrH1ZUPp9fYQa1GONQRqVglsyhtnKGRDhkElPSb6shaauaJPBMihsKypjqouhNobG3/pvFM9ngdqCAaRmgBDzvjcRAHZg7cG831MDJTWfgM/eDpzUpHe6xMChfV+GCu3i+wU+Grjq0wrBqtz8Aj8nnAzzs=
Received: from BYAPR07CA0012.namprd07.prod.outlook.com (2603:10b6:a02:bc::25)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 06:05:51 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::30) by BYAPR07CA0012.outlook.office365.com
 (2603:10b6:a02:bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Wed,
 30 Jul 2025 06:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 06:05:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 01:05:49 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 01:05:46 -0500
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek
	<michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <saikrishna12468@gmail.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v3] mmc: sdhci-of-arasan: Ensure CD logic stabilization before power-up
Date: Wed, 30 Jul 2025 11:35:43 +0530
Message-ID: <20250730060543.1735971-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.potthuri@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1f5dd1-e132-4a6a-4dd3-08ddcf2f22c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kl6J0yNDR/tqkM+8IgaTlkAxFo/vSD14lp167cD7ItQR6z68JuHSIWakFIZr?=
 =?us-ascii?Q?HcMnymiSfNFh3KyQGRokUTNrcu3fPt41nDbXMukLoXihuEV+f8MODhGkjZyc?=
 =?us-ascii?Q?bwp5BIlrSl30iOo7lFDGtsuo7V+uc5hbIlEOqJ9VPy7cKXq7pBwIYECpjp9X?=
 =?us-ascii?Q?qPTsoH/NWX/aecJshHextkF/S7F2nMo3rDU7w2wo04XvDSmiBIqHHcSt3A4a?=
 =?us-ascii?Q?Cr/+YL6nOeVzy9AVIxODegG3ssrU0ywYGYnV6Y4rmrKlfniHd2d2HUYtjpiz?=
 =?us-ascii?Q?TaQGODFC5O/ISH4z1wWpNkBLSI91Y2mB+8c0f6iBpR+PlnxBZFotUgWlxO9g?=
 =?us-ascii?Q?GeJyYZ8zbup2ML16hQHPC0n9NB5UvbngLtbHVPog92bYJL112DAdL6pPI8L3?=
 =?us-ascii?Q?8bO0cJukyo9k2NmuvGKGLSJM3AqdhUqyUmw5BhJ95e6XG/5oBwnyTzCisHCv?=
 =?us-ascii?Q?mdQot76v8dKjC6l5JD4RTYlpFu+w1RWiEJvoX7q/QKXqM7svkYKSN1fx3fh0?=
 =?us-ascii?Q?M0GLuXBA2TbT/thoPZ6AeEOyua9V+ILlJC6dmjMoo/xPF/CfmBpunY6DS6ia?=
 =?us-ascii?Q?6VA8fYXm+5JgtIGUg/MP0WVS0wmYTVzbYlSpIUtt3HLU3GEPpDv3sU8f3M2D?=
 =?us-ascii?Q?5T/thP0OZU81lmhUUw+k8znX9EBmPfGNUfCO7/qOElO11+8Om1LuhVM77q/J?=
 =?us-ascii?Q?L3jxAmeM13ciBvWavZ6KgipqXfHQgff5Qqqz8AuSXFKJ2DJ/zpirOGi49qnv?=
 =?us-ascii?Q?62AOZ2Scfp8WwLOSdGpeCd79O0tccob46FCnTsCyL+n5QssZ6IGzb1KIv/cR?=
 =?us-ascii?Q?nDC13DiY7uwnPrA6zG7R/oRrqx4bW+hqFDX8uOcJhM2uVoLUqRc4nJe9Hs6z?=
 =?us-ascii?Q?3yYmXIn+ZiyIJYGbJAFJypkrcaJjzDVDfU4S4kHyvUFLhPaHguLSuW6rbgs4?=
 =?us-ascii?Q?V90KPQHEBD1nBdDgGTHFt/+gvGklQsatam+uIyX5fbX4tx7aS8xquE8zcx5H?=
 =?us-ascii?Q?mi7GxV/Lah5F0OWaMHSFTVnsSH3+KYdDxnhf2z55XtxRGkCo3xo8oEvlXMCY?=
 =?us-ascii?Q?EoGZL3zSjOBjQ0QJ1y4a+pbmlYLFONUwvqS7qb5uBttQxXNjRiE2B1Dm7a32?=
 =?us-ascii?Q?wdNUrHOigGRZ8zfWYxjZ2V2+qW4Z1lJ71tR6gXr0cC1o8WmRleh+68pIEhfY?=
 =?us-ascii?Q?q0eFL8kkAw3PUoVii/6CjzV8pvma5/vcYZObLB3BLYveuNynGDKaFhuzSHba?=
 =?us-ascii?Q?QHjm2YszvgU0R/8zlkV1LSN0TU6W3o5EH6HNGJhHxjlOaHgYlLXJW0jJNpZf?=
 =?us-ascii?Q?0w9j50kJMkfrGufDb2QIvxC6qtme5wPZr1PVmmf0AY9JFJWa4AwhZQYyA2pr?=
 =?us-ascii?Q?RGRZQIHR3yIHQbKMBdU8NisKhynhTTa4K+FRV5f4hlg2CX7r/9QTWV9B10ts?=
 =?us-ascii?Q?FmWSQpkr5c9S0JxHkVO4sbJ/OHUzToxS+ldcurQd0/NFYMfXkItPSheNPTa+?=
 =?us-ascii?Q?uOxZV1MSNRruhh8lsUFi8afdHh7y+KS52uiC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 06:05:50.9733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1f5dd1-e132-4a6a-4dd3-08ddcf2f22c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855

During SD suspend/resume without a full card rescan (when using
non-removable SD cards for rootfs), the SD card initialization may fail
after resume. This occurs because, after a host controller reset, the
card detect logic may take time to stabilize due to debounce logic.
Without waiting for stabilization, the host may attempt powering up the
card prematurely, leading to command timeouts during resume flow.
Add sdhci_arasan_set_power_and_bus_voltage() to wait for the card detect
stable bit before power up the card. Since the stabilization time
is not fixed, a maximum timeout of one second is used to ensure
sufficient wait time for the card detect signal to stabilize.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
Changes in v3:
- Add quirk to sdhci_arasan_of_data and assigned them to
sdhci_arasan->quirks in probe instead of using of_device_is_compatible().
Changes in v2:
- Use read_poll_timeout() instead of readl_poll_timeout().
- Enable the CD stable check using platform specific quirk.
- Define the quirk for Xilinx/AMD ZynqMP, Versal and Versal NET platforms.

 drivers/mmc/host/sdhci-of-arasan.c | 33 ++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 42878474e56e..60dbc815e501 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -99,6 +99,9 @@
 #define HIWORD_UPDATE(val, mask, shift) \
 		((val) << (shift) | (mask) << ((shift) + 16))
 
+#define CD_STABLE_TIMEOUT_US		1000000
+#define CD_STABLE_MAX_SLEEP_US		10
+
 /**
  * struct sdhci_arasan_soc_ctl_field - Field used in sdhci_arasan_soc_ctl_map
  *
@@ -206,12 +209,15 @@ struct sdhci_arasan_data {
  * 19MHz instead
  */
 #define SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN BIT(2)
+/* Enable CD stable check before power-up */
+#define SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE	BIT(3)
 };
 
 struct sdhci_arasan_of_data {
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
 	const struct sdhci_pltfm_data *pdata;
 	const struct sdhci_arasan_clk_ops *clk_ops;
+	u32 quirks;
 };
 
 static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
@@ -514,6 +520,24 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
+static void sdhci_arasan_set_power_and_bus_voltage(struct sdhci_host *host, unsigned char mode,
+						   unsigned short vdd)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/*
+	 * Ensure that the card detect logic has stabilized before powering up, this is
+	 * necessary after a host controller reset.
+	 */
+	if (mode == MMC_POWER_UP && sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE)
+		read_poll_timeout(sdhci_readl, reg, reg & SDHCI_CD_STABLE, CD_STABLE_MAX_SLEEP_US,
+				  CD_STABLE_TIMEOUT_US, false, host, SDHCI_PRESENT_STATE);
+
+	sdhci_set_power_and_bus_voltage(host, mode, vdd);
+}
+
 static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -521,7 +545,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_set_power_and_bus_voltage,
+	.set_power = sdhci_arasan_set_power_and_bus_voltage,
 	.hw_reset = sdhci_arasan_hw_reset,
 };
 
@@ -570,7 +594,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_set_power_and_bus_voltage,
+	.set_power = sdhci_arasan_set_power_and_bus_voltage,
 	.irq = sdhci_arasan_cqhci_irq,
 };
 
@@ -1447,6 +1471,7 @@ static const struct sdhci_arasan_clk_ops zynqmp_clk_ops = {
 static struct sdhci_arasan_of_data sdhci_arasan_zynqmp_data = {
 	.pdata = &sdhci_arasan_zynqmp_pdata,
 	.clk_ops = &zynqmp_clk_ops,
+	.quirks = SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE,
 };
 
 static const struct sdhci_arasan_clk_ops versal_clk_ops = {
@@ -1457,6 +1482,7 @@ static const struct sdhci_arasan_clk_ops versal_clk_ops = {
 static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
 	.pdata = &sdhci_arasan_zynqmp_pdata,
 	.clk_ops = &versal_clk_ops,
+	.quirks = SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE,
 };
 
 static const struct sdhci_arasan_clk_ops versal_net_clk_ops = {
@@ -1467,6 +1493,7 @@ static const struct sdhci_arasan_clk_ops versal_net_clk_ops = {
 static struct sdhci_arasan_of_data sdhci_arasan_versal_net_data = {
 	.pdata = &sdhci_arasan_versal_net_pdata,
 	.clk_ops = &versal_net_clk_ops,
+	.quirks = SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE,
 };
 
 static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
@@ -1937,6 +1964,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "rockchip,rk3399-sdhci-5.1"))
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 
+	sdhci_arasan->quirks |= data->quirks;
+
 	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
 	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
 	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
-- 
2.25.1

