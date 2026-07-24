Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84B43B6D2;
	Fri, 24 Jul 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905251; cv=fail; b=UvuBRBxsC03tRo262CmP0i1oAM6Y9FhwcJ8msERi6u6UoDCte0GyZoKReKOqnsZuYCtteCJ6l1wxY/sTNYhN15xLE9tOdMO5kTKVmz/wYvrWf6EWjDfBOkr1YLhtL6oEhRD7p+5ikMBLlaTMsjdWikhNJ71G6s5HKvxmSSX7bFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905251; c=relaxed/simple;
	bh=mOmW0cRHJXV5ovwz/aFwlItGsJf1QEYS9Bd30Ocfp9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9kJj4CgcikfVFAKIpW0v0lRkkHPrV6IX+7JTnDhe1jmochwKNkYObCiUqx03gA/KSmOds+tTAjGYmGALtsvGCWJqYNUFbQUkFJFzBEZivvXY9nUrf4L2uBbWKMdrNf0Dmb7qxamuIEQennQG+jKrzzd3rZF13trB3FxSYAw4lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=F4LEXgJT; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="F4LEXgJT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxMEPTOl/Bj2Dzj0N2n1qDobge9Kp/AX2flMAf12gds3zxTiIkvNcDHBHIPHOv3P/SfowUuPHec8/S2jAzd6nAca+hcY5Jrda9xOmWGLPmPRjAyhy8gqz5cZQaXy7c3SYN5UGaH4LiIYYibOxVFhX99ePEawquCVonJ7MMggPo2mrsFReymJ8DklS3Yz2FdXBC37C4DxTgjmiIDVyCDMR6NrFw0hMp6SXPfaMm0w0WESm+fEdMx9lslGkZN3Bv5xMiYbKSdU2NeBvFfMDhihwuUwUHox1PcA30vUb5iKyBdGiaDxFNRGYaeU1O/HzNSW6Op4qzP4NXR/NRGEhbP9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Su/dIQxiaqEMXayqMgd/4IIBizo08cQhtr+TmC670=;
 b=NcEMvi3OnRZuE6UNj0zizl7bxYjSqPrusy/T2U/VVfmol+fylMjX7jgLMVVCeeVwmaLF238WDhGLlUd3ZAVyeZVnPnfIXOaSTeNwisrDxCXb5fXz7MaXzQd386m7NFF4jCsylZ3luKLQerGS+l+uSVqvjmBrSH26e1ydkj5NpMN9ixv7oy0P/dU1MsAEn3b3NK8oTA4iZ5I21iSY00vswrV+0KrzpDb/lRPSv/tLrWjyAN+nsVo9QyG9V7AZUv/w+JBJYA80EkLRFZJz0ZPJdMmu0oVCugtKZyfTgP2i4rSX5NH3BP+LqRDQ0p9O675fS5sfI8MOKDhcJNCz058/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+Su/dIQxiaqEMXayqMgd/4IIBizo08cQhtr+TmC670=;
 b=F4LEXgJTKbppEfsvsoFC7XSThRTv9RUYEiGcPxeo4vP06pYFz7hJyWOM5bcCYtM+ZwQIcK6ahVewhf/gBHcohdpXF+36RtIbC296a/zCbd0WNLcmEr+pttMeIU5j67JeODc/JUlf3YLysBdI7qZEAPn9ie0SYljWlviNZe2yl+rMAVrWZXQzU7bTtTEbhcGNdMJlAaX1ElC5eN2s+lsgIQnQshloz+LIvmv/OwnUMsW95Rnakxmg6jnfiaf1oWSVorMUkXgbTOdJkcsezoBjAbRJuLUKKFv8mUNsTUIRt+PkD1W+zcwL8GDINACgjoMWr665lTwo+1zG7+wagcWggA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 15:00:42 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 15:00:42 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/8] mmc: sdhci-cadence: add SD6HC support and Agilex5 enablement
Date: Fri, 24 Jul 2026 08:00:39 -0700
Message-Id: <20260724150039.23387-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ2PR03MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd4f950-9a43-4f94-9a1f-08dee99454b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|55112099003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	kYOuFCAE7R3u7ryuEisxEjk6rOnpNLI3Q00I0uEmX00eP0oToPPGFru5lB2nBTDuaUz6T6fV6VG2XIAAAX64o+gxuKhu1f0ah1jkJrZM2nhXGNNc6KKHhLhPNBSDuHATF4rU1PlqGPdLc+tpAHbqpPjylknKxnC4UZCZmO1aGRcOCA596ikaUlN5FvY7hw24tycjH3iXw9h1RK9GeteKBcHSVdSqvUU6tPWyQM8vKdW5N0wa6dPtCZ3eg9Nf9J+aCpqLsJL6IveXTzagVqgKuPzIC6U5XeZMPu55LvhtDnTrs3qljogjmgS6/adeu4g/Boq9v1B7kUHcJ11pgUKWbFEnI/9aRaxWMRU7beb6b2qiobDfpc2JHBwxZuetmY4nqaPyv75yvu1rX+9uMXyoSNI9Tm5YMbh3OGUTJGIoYQNbbX4JT9K4A2yeIIxDeTeAssAUunBWXBsGH4YNw1U1Z3BGlQML2jaggST4VV+nZP0nGlHILk7UKWWTNssrYFX4C5a1dtAmdyeg4eQPsEjjqfNFwOTxGGisGIZhiMkYBmScpOvSa5QSF9x/TY5PeWsBZz6BzbLvSNBzX4MQevKv57oixPrIpN+oYVQvlxf0w+DtOxQXw+mZLibswsAHchE+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(55112099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMhiQMc886LIhmRncbxCe9o31jX3GxDuedMxRWQBkkk79M0H+JmVsxTGCj5I?=
 =?us-ascii?Q?E7Ojc9l0oF6DxbtNO69bjmZej95vjv0UN0VnD+G398J5ypHBF47geWF9jqmF?=
 =?us-ascii?Q?iZwpCJmqg0D9R6CToIRZAplHdR6IqOAusHWaIPZARsn2MppqTIpjlLmkhyLH?=
 =?us-ascii?Q?p57Ei+vKHOQpArkDp8GqSLWehc4nPR5RZ1urAO6hoh+1dGLnX1YAqLDtmFo/?=
 =?us-ascii?Q?WsGa3YXA6K7bjaO0J7kvAzfzyDK9Ngiz4m2ca3IFO9/ypyN7b6WZbMyizPhc?=
 =?us-ascii?Q?a/lsJFTrjDGqxZ2w8Cz1+l4WmwcB+LqkgQJk088gcy3nhbXFc+MgD5tfFbUl?=
 =?us-ascii?Q?PxhIldw7zMC2PwW1Y5nzIz80yLf6RgFsLjKedMXQLn0UhEye5ZoER9v8kKm/?=
 =?us-ascii?Q?e5z9NEVs83pyuRNtfnrg3zeWX/snaV+hCZwwEeRCv5pTCqxiQJAnpBBSxIUa?=
 =?us-ascii?Q?SgjEuRx6OGRGAjxNB141tJ3nVmZDa3OmTB44dI+UMRJDzZrQ4NQBgpwi+ZHc?=
 =?us-ascii?Q?ippDvfJx9Kx4NCILPsxDXeJ9mVM/142FSuLA5HZu4vtw6I2BxNuNa6IKCk1R?=
 =?us-ascii?Q?Trq47s9YHBMocAa53NE3KV55W0MwYS7MD3HQ/6L4/zpNb/uhyoO5FzYHFV4y?=
 =?us-ascii?Q?W/o5oeddCWGyxOo78OeO2VboK/MSiUDaA9Uux7lzJ6NjvzhvEZ8cY+XaJzgh?=
 =?us-ascii?Q?Qyeve0gbQOEMoXzdWHIpVcxkcwda1od0mYD8bgLUfuRQ2nBDitB+FCk0zkhr?=
 =?us-ascii?Q?UWUmvkLN1N8+NIbibr5oz9cPr7yl64frUzCTUu7ifFP5UGz3LpNa+B5Dxs9G?=
 =?us-ascii?Q?jZDYX6fFt1Vo14BBTCKGxZi2C2n+m9cOKs6teJpjhM8Ydx45jFyIIie9Tt0l?=
 =?us-ascii?Q?lG8ZaP1kufL7minPiRUkeLvfqgYf3kdV2FkoQT68w4f95NjjRzHfi1+yzxgX?=
 =?us-ascii?Q?uO36K7DhjFUbElXcGVkZJnTyfDFRVGOXsOcF5DZpclo1K71chet+AEbdTM4G?=
 =?us-ascii?Q?nEVeuRJweHsGbEm5CGbbP2vKY1WLVAq/A515KRfTYKxEgWY6t7I0IEO/0Yro?=
 =?us-ascii?Q?vP1MjTBaE5HNnnlKUG9bCfhF2hICkZ8P/RXDFX2crruJtkeNdsLSq3fUQ4xP?=
 =?us-ascii?Q?JNbCQOI9SKwOm6EqEcFxY+lZ0PYd4UjDkQDhfULSGhk4oRLSAF/WV7Bn6lhJ?=
 =?us-ascii?Q?YVzZw/0e58lVAWCEFiyFTWyTLmUrccyrV652bSjBUwXcw1sOxhaM4/V9Xrui?=
 =?us-ascii?Q?cGiPSepMqmoT67KMG6GkpbFAQVqz1h98AHHeAvV9le+VcglQDNlEnCCwQJh7?=
 =?us-ascii?Q?wufq+7p/CeyXCEJPD17XVK2r1PqDzGO8WDKTchjq6eigTAfrf02B9rkGnH2B?=
 =?us-ascii?Q?LfxyuumoggHV4Vl9DRj8qV5q8ubulyIbwlaSY46CjtJek/8Ib4iVHQdEBWQt?=
 =?us-ascii?Q?Lr8TO0A3vgxolNJVHifLHhjEJ6w7ReqU4mRR9NnlVFGuqyNx2TyOd45ufUTj?=
 =?us-ascii?Q?ZwecMRnxYx2Y+Gc98+YV4Kd6JadBzaksaMumd19b6s9hO4c3Y4tb+goqNFco?=
 =?us-ascii?Q?FJo1x278/08Gl0sHgHCx07LGrMchMaLKnmC4G0FOKzioR0LEpnI06TkCQW7p?=
 =?us-ascii?Q?UKjl2UWQRYA1y6Odn5A77aBCePMqmoqpekYWrEgYLrydUAih2GNO5Og+nXXI?=
 =?us-ascii?Q?ANpw6j/lSBb7//RSLEqliZoiOkwkm7yaGSoGWpm56c6c2lFk5BcDyqyenaCy?=
 =?us-ascii?Q?OkXH8OfKcOdbg7AOhZUNPxOmdMCdwm0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd4f950-9a43-4f94-9a1f-08dee99454b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 15:00:42.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5HNyBDZJUZdrG8UeFRCbM4U367C4jbB6KNuXE5BAOZjr1aEKNX7A75qdVnech875CXLoeFyStW3SbG9yrr6JibRVj8yRJ9TXRbvKYRJS5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7072

This series adds support for the Cadence SD6HC (sixth-generation) SDHCI
controller and enables it on Altera Agilex5 SoCs.

The SD6HC PHY architecture differs substantially from the SD4HC: it
requires dedicated per-speed-mode IO cell timing parameters and a
DLL-based delay line to achieve correct signal margins across all speed
grades from Default Speed through HS400. These are programmed through a
new sdhci-cadence-phy-v6.c file; shared driver infrastructure lives in
sdhci-cadence-core.c.

Note: this series depends on commit ab45ecfab540 ("dt-bindings: reset:
altr: add COMBOPHY_RESET for Agilex5"), which is already in mainline via
the reset tree. It is not yet in mmc/next; apply or merge that commit
when building/testing this series on top of mmc/next. The previous v1/v2
reset binding patch is therefore omitted from this series.

Patch 1: DT binding
  Adds a dedicated cdns,sd6hc.yaml binding with SD6HC compatible strings,
  clock/reset/IOMMU constraints, and PHY timing properties.

Patches 2-4: Device tree
  Patch 2 adds the SD6HC controller node to the Agilex5 SoC DTSI and
  enables SD card operation (4-bit, SDR104, 200 MHz) on the SOCDK board
  with GPIO-switched IO-voltage regulation.
  Patch 3 registers the intel,socfpga-agilex5-socdk-emmc board variant
  in the arm/altera binding.
  Patch 4 adds socfpga_agilex5_socdk_emmc.dts for eMMC-only operation
  (8-bit, HS200/HS400, 1.8 V IO, 200 MHz).

Patches 5-8: Driver
  Patch 5 renames SD4HC-specific functions and structures with a "cdns4"
  prefix to separate them from shared driver paths.
  Patch 6 encapsulates SD4HC PHY probing in sdhci_cdns4_phy_probe() and
  makes every of_device_id entry carry explicit platform data, removing
  the silent fallback.
  Patch 7 introduces the SD6HC PHY driver (sdhci-cadence-phy-v6.c): DLL
  lock/bypass, per-speed-mode IO cell timing, tuning, and HW reset. The
  common driver core selects between v4 and v6 PHY operations based on
  the SDHCI specification version reported by the controller.
  Patch 8 adds the Agilex5 platform overlay under altr,agilex5-sd6hc:
  40-bit DMA mask for the SMMU address space, quirks for
  CAP_CLOCK_BASE_BROKEN, PRESET_VALUE_BROKEN, ACMD23_BROKEN and
  MULTIBLOCK_READ_ACMD12, .get_max_clock set to
  sdhci_pltfm_clk_get_max_clock, and an init hook that asserts and
  deasserts the three named resets together.

Tested on Agilex5 SOCDK:
  - SD card: Default Speed, High Speed, SDR25, SDR50, SDR104
  - eMMC daughter board: HS200, HS400

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

---
Changes in v3:

  [bindings]
  - Drop the COMBOPHY_RESET binding patch; it is already in mainline as
    commit ab45ecfab540 via the reset tree.
  - Split SD6HC into a dedicated cdns,sd6hc.yaml binding instead of
    extending cdns,sdhci.yaml (Krzysztof).
  - Rename PHY timing properties with standard unit suffixes:
    cdns,iocell-*-delay-ps and cdns,delay-element-ps (Krzysztof).
  - Define clock-names and reset-names in the SD6HC binding, and keep
    iommus / dma-coherent at the top level (Krzysztof).
  - Rewrite binding/driver commit messages to describe the hardware
    rather than restating the diff (Krzysztof).
  - Fix alphabetical order of the SOCDK eMMC board compatible in
    altera.yaml, and retitle the patch as dt-bindings: arm: altera
    (Krzysztof).

  [drivers]
  - Trim sdhci-cadence.h to include only what it uses (types.h,
    compiler.h, spinlock.h, sdhci-pltfm.h) and keep direct includes in
    the .c files that need them (Adrian) (patch 7).
  - Pulse combophy with sdhc-reset and sdmmc-ocp (exclusive assert /
    deassert together). SoftPHY is shared with NAND at the SoC level,
    but only one of SDMMC or NAND is enabled on a given board
    (replaces shared_deasserted-only handling from v2) (patch 8).
  - Keep #include <linux/iopoll.h> when adding dma-mapping.h (patch 8).
  - Unwrap dev_err_probe() lines that already fit in 100 columns
    (Adrian) (patch 8).

Link V2: https://lore.kernel.org/linux-mmc/20260627201457.12318-1-tanmay.kathpalia@altera.com/
Link V1: https://lore.kernel.org/linux-mmc/20260511202132.5597-1-tanmay.kathpalia@altera.com/

Tanmay Kathpalia (8):
  dt-bindings: mmc: add Cadence SD6HC binding
  arm64: dts: agilex5: add SD/eMMC host controller
  dt-bindings: arm: altera: add Agilex5 SOCDK eMMC board variant
  arm64: dts: agilex5: add SOCDK eMMC daughter board
  mmc: sdhci-cadence: rename SD4HC symbols for SD6HC groundwork
  mmc: sdhci-cadence: refactor driver structure for V6 controller
    support
  mmc: sdhci-cadence: add Cadence SD6HC support
  mmc: sdhci-cadence: add Altera Agilex5 SD6HC support

 .../devicetree/bindings/arm/altera.yaml       |   1 +
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 114 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |  25 +
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  38 +-
 .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 127 +++
 drivers/mmc/host/Makefile                     |   1 +
 .../{sdhci-cadence.c => sdhci-cadence-core.c} | 314 ++++--
 drivers/mmc/host/sdhci-cadence-phy-v6.c       | 929 ++++++++++++++++++
 drivers/mmc/host/sdhci-cadence.h              | 111 +++
 11 files changed, 1596 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence-core.c} (65%)
 create mode 100644 drivers/mmc/host/sdhci-cadence-phy-v6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h

-- 
2.43.7
