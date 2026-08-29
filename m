Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8284341A4E4;
	Sat, 29 Aug 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788028986; cv=fail; b=XGeTRWtIqV16pKqeQuQUGAnnyhir3Sl9km/OXgL6z/pwLBNYlflF/F2bRM7wmOcS6qagBj1njUepHRqOl7r6DErrCsoKX8sz4V1Lqzs9JijDINwiSZnE1fV6QVxuU84tyBHmTJWZj7iAsTFdgDAMDi9tYXXj3O0kLp5rcPjRrAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788028986; c=relaxed/simple;
	bh=j+rXhdmIlVerY8arJmN6iVjHd8S4WgXbx5S0rhwBawU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d1aOtUq5JMkp/h3UP7asAQYi0nye37PiYiAwvKq9afpYCVRZKjb9YLmbT70Ry2EGpydR5fi/xpaa/dJOxw4iEhaNFCYO19Z/rS1hKZYODKysdynTUiLwWD/+Udr0ptTsLyzZ77Hf8k4gjGdluJ6mkqdxCdpZMHDjTWxs9Hk9ERI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Ykd5pHzA; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Ykd5pHzA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkL+p6bYPP21PUhAB/sCkUWSqQo7ZCqZnMjJXQvMY1hvuGvzx9g8Qkz+ZKIaYpNXNuGbxqm9tFuFxrktczySXjW5RWhD/XOv+IWm9opi+y1I/eMj4UUoMQFemrRv3jURz29lbpkm+mx9VwtpkiTbpQDV0P+tslsM7QdWRMfyUt/DzqkRGZmg7JkqpPMp8mhFrBQtCWgugJAKosbbpGDqX5cctRelMrPivdfMj/o2WUNEikNf89QJoMhZ/aQHBUZhP9al7eWSKEshc+HE4fuBG/O7eGxmqwLz3A/Zq4tk70p0lRlFlQORJVhvwDzhy6Udk6+3ZwI1yxoocyuLXd+BrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qcs2/+mAEAOiVvT6V70AzrQQKWkh/AxiIjiIgcuvEU=;
 b=K9KVCZHmKwoFivwKegwmTi6eYcfYLe3BPKD4GIjBfNJnhtmPO6Yaf5klTSagatxZAWgXlhepeMf9LaOOTPQcrVnnHxEd2l0F3Tjf9j3gaMoXnGu81IohuQ9R+jR78jkiqfuQXZeOi7+xrKyyDHx6O0F1Y/Nfz3SF/SU6rfQ0zmtukWUYPHanPYoNERIUhTPgdjxW1FSFybUFBFcjlmVmpQuHGkV+0DLrLgZvf1HyEVNFeiAa5qUVJNs8/oUCTBKtYPzhynshRBEw01JVYf13B3+QgY8bRCIzWMRmmFwdU0jaFx+GqFeHLZTNDScyanmMIlfjDmuL6bGP/p2NJv48yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qcs2/+mAEAOiVvT6V70AzrQQKWkh/AxiIjiIgcuvEU=;
 b=Ykd5pHzAdKV7cH0DO3IGs/KdpTfLCU7jjDnw1T6xAYYqObj+QKYCSptyKdAQf7caejHG6By+LR3i6VeEMWvKfLEXdHCaiGHU5tweWkVDkPy0QxFFgiNiEqPAbdc0EEAm8qaOn93EmHfGBNH9d7HvqSKtAuNI8EHPDgw7Rwv3vZvuOKqYMMAp5wKkW50QQYTLCZE66cd8XU4/3K/PZsPE5zjkBAJM1i0yIulJ7+AlKuhJ7Eva2xyYUavIkUTqaVSFzcpqUMA+AGOBtMF5q8QH8eTlEobLY8z/HY6fuFsYt7H0iNIVEN35GoyMmVPtRqditCm1MNaNwAkg87StUnpcDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB4926.namprd03.prod.outlook.com (2603:10b6:208:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 18:43:00 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 18:42:59 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] mmc: sdhci-cadence: add SD6HC support and Agilex5 enablement
Date: Sat, 29 Aug 2026 11:42:42 -0700
Message-Id: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 07860acc-41ae-4e6f-d18f-08df05fd5982
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|3023799007|6133799003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	5zwrpvcW3bHSagzwAw0UheHgQHUOD1SBsp7d2k88EIeIJcfZPOHbSIPIfJqNsvVjaTk0rgFjW2HsBU5UfqRRSBqcp0Th9lJxzPL/Z0ii068k7o6z0yN826ihncPHwyNGPB10wbmxc5gDyrKjHy5Sn+HlTBXsCphzOtTJ3BAjiO9URIqjJ087OaZXFVUezUIMnScgiFZQLGDcgJ2X3l+P4QoR6RpDNwfspCqCFgx+29Fwsqi+vpc2dosfDDFvxNFw/PMGcdH3bsCrUQBGhv2oYgmx2s5OA9kh55Wgu3zSQOk0TALzpV4HrG5Pjd+J6Q3ev741hxO+8fJSffr0zcbrPJTCeDGy7kF14f8Ciq97o+Zfxt2aUprXPLD3ocXcBcg1G7qFPDgvh6c2A3d+RjephyS8NPnbXFAt+uqrfzJJpxkawEpiAm+YIHCkQFKVxUdegxHlXXr96bTgq+e+T0U5qILtQan6O2jNZPElAEgDhfU2UKsGUdMxWpmRMGmU/Vz4fWiM+9Xg+o7FvH2jiPToZWX4tayXpQYgCU0W4KrgJZpZZB2/XrZ+54flZWfc8PjigYC2b5RddkdmnNqq6O+AbcMqX1dE2TTSpxDCUzL34Dor0oAv6zGYjntVBb9t7XUPcBo2WraHqB1DaLZQoAyh9x1GwoqKTUgdbb2PSongvsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(3023799007)(6133799003)(11063799006)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e04AYzJ59XH4/a1WsNJj/kOQ2bYrGcltqbEAdSuM76MzGoF32t5rkrAgFm9I?=
 =?us-ascii?Q?9VyU5rOBHbDdh0lwopVDEqmHA6IgZHTAZmziWK4mp5GcbqN6WIUHqgGMIDbq?=
 =?us-ascii?Q?3R9iTi42QWA6jcnF9ORUqGDNq2+o50/6ox01lAePaYod5mw1g1pr/QxIAniz?=
 =?us-ascii?Q?PRKTsapZtBjraTj2pZTX5FHTlEhGughOpaH7bW2kmMZU64uNhfsE/I8HGcvH?=
 =?us-ascii?Q?JnCoHvveCJEz/eOPeEwFiHfGKdsFdEC2XuNpbXBJv5mkg6SG+J6EGZ5f/sd6?=
 =?us-ascii?Q?98yf9TcSTlPguLUf4JhXWZlD7hcVjTeVoxvXXviR+NcXuTr9+TYyVMDM+6uT?=
 =?us-ascii?Q?FYPEMDeNBGRJsIuTCGfbEfAaJp8nPDK4ABdRe2u3enq7+vOmrwW2TUr+m3sd?=
 =?us-ascii?Q?rTKyLkE70xSUg7ZB0uUgMlWy1MoGG591cT5d2UYnWLJIgAJJ0n7ts5a8M0F/?=
 =?us-ascii?Q?QzGR5wMnAoPhML/WjUVdiTxkWlbYcXEz30GASoxdsFWbWhnNqD4d+QbETxyw?=
 =?us-ascii?Q?mMIMXahwXdCIL9wjSzeSZ8oAD4MCAzPAW7YUHAv1IP4r9Jt0Ww00rTDsPSXt?=
 =?us-ascii?Q?0yVTtwlYEgWYQg9fwmdNYdimkMeoZh7osi+zuMOw9fFEJ2p9Js3PzMphh7IT?=
 =?us-ascii?Q?5oCnxYpE1lNbXbcbtuoTUPTuFLsNKFMvmuNT9tj2HRNHqE2Sm+i3lXwo9vwh?=
 =?us-ascii?Q?uzW5zRSwmAmC/LrliFFhqYPR6Siz/uwE61PHvcLSnUdurrsv2GXZ5HjJmJ8q?=
 =?us-ascii?Q?+ub/JRXOwP/kaBnG64PjWB0PolaoznoMf5htZz4K4Ik8L4hTRVPUOKmRmgl1?=
 =?us-ascii?Q?xVhKa58OhBXlw3Wm2Ej1mJTN7DNfXun+Me/yBLWH6ETj0LTYtPtF4fiuee8v?=
 =?us-ascii?Q?1cTGrcP684M+CcF0xGvYNi6dQYhzKxiLRFNJ7Jf7LJOp915Zva4PJa3Ts3XE?=
 =?us-ascii?Q?gTGqsKafyPFvUGK3h667hhyTFwuz1FUcEEc5It6d5vVf6Pwi1sykM5kNTYSZ?=
 =?us-ascii?Q?o4TUlMT/2W+2XolOQsW4V+ntBIvdec7l6/OCR0KawuitPYyNLDQfHQJa7p14?=
 =?us-ascii?Q?jsNXWZzYiz59AdysZCzCkpBjkWTCOLVasHPAjLA23y8feLe8ArFRa0bqK2A/?=
 =?us-ascii?Q?0z2idnT7saN+WvSL8QWE3tAMjRJfNCuZTGShInWGPENi/JTlUoEnUR9gHCO9?=
 =?us-ascii?Q?8SlPX1hUzUxojFIkpU1w7xusvPH3DwCe0BCklfrije+kwxrKvlqB+EEizugU?=
 =?us-ascii?Q?3vU/NTKSXSmekJJ5wx4w9nNswEGbaDhkQRqPu5nfqheuXZ24AGFrOW9zjPEq?=
 =?us-ascii?Q?GnG7MjxehcfY6fue0JGtXOf91bG+FipDxlP85jddb5TV4OPsbiTGGgLVk/yG?=
 =?us-ascii?Q?S7uEiMmJ5Am3y1CfyQpt87/++ptltXIz4toetNQNgcCI5VnaQx9ewNdFz2dt?=
 =?us-ascii?Q?LAWIQH1/zURr9AW2WGNslrzaUsnYdJzgvbFbzSGydv68Ji5W/75iSzBCYfh/?=
 =?us-ascii?Q?3Yb0Efdx/bH15Q2NELpsWrEMRYqhnK6GuuUf0zGZi8f9Z4xw4+7C+/eC0i92?=
 =?us-ascii?Q?mIcjKbc+51YZnLqdKV05hNmNBVAkGwzZ2Ou8Bx83rHIi0TNvKtA7zbWKKwSL?=
 =?us-ascii?Q?u+TOOp96/LjV0HqBadlJHlAoXV2CDs1dtL5bRusQXSwxZPGT14LsMu7/hx6L?=
 =?us-ascii?Q?/f4fhI4mm8bmjHS3ZbK+xTcqOVVTzUngLUJJlk7odxw912NYcK8VZcSHXnvk?=
 =?us-ascii?Q?M5Y7yN3tF+u8ZLaaar2oZY7yxxNBGPU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07860acc-41ae-4e6f-d18f-08df05fd5982
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 18:42:59.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZWRmi/z7XeKwIw7hcUBUXiOsJNpbBEjPC25+5ckeFioz39s9Kgf3P81czVG1FshAZG+LOTfBBvu/JEjM2D4finijRMggF8ANvJFUMbLVnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4926

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

Board DTS files do not enable the SMMU; that is provided by commit
10cf797f3f8a ("arm64: dts: socfpga: agilex5: Enable the SMMU") in the
SoC DT tree. It is not yet in mmc/next. Apply or merge that commit when
building/testing this series on top of mmc/next, otherwise the SMMU
stays disabled in socfpga_agilex5.dtsi.

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
  the SDHCI specification version reported by the controller, and
  reprograms the PHY from set_clock and set_uhs_signaling.
  Patch 8 adds the Agilex5 platform overlay under altr,agilex5-sd6hc:
  40-bit DMA mask for the SMMU address space, quirks for
  CAP_CLOCK_BASE_BROKEN, PRESET_VALUE_BROKEN, ACMD23_BROKEN and
  MULTIBLOCK_READ_ACMD12, .get_max_clock set to
  sdhci_pltfm_clk_get_max_clock, and an init hook that asserts and
  deasserts the three named resets together, keeping exclusive ownership
  via devm so they stay deasserted for the life of the device.

Tested on Agilex5 SOCDK:
  - SD card: Default Speed, High Speed, SDR25, SDR50, SDR104
  - eMMC daughter board: HS200, HS400

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

---
Changes in v6:

  [drivers]
  - Use devm_reset_control_bulk_get_exclusive() and keep the exclusive
    reset controls for the lifetime of the device instead of putting
    them after deassert (Philipp) (patch 8).

Link V5: https://lore.kernel.org/all/20260820185021.18199-1-tanmay.kathpalia@altera.com/
Link V4: https://lore.kernel.org/all/20260810190025.25045-1-tanmay.kathpalia@altera.com/
Link V3: https://lore.kernel.org/linux-mmc/20260724145009.7456-1-tanmay.kathpalia@altera.com/
Link V2: https://lore.kernel.org/linux-mmc/20260627201457.12318-1-tanmay.kathpalia@altera.com/
Link V1: https://lore.kernel.org/linux-mmc/20260511202132.5597-1-tanmay.kathpalia@altera.com/

Changes in v5:

  [bindings]
  - Document driver defaults for cdns,iocell-input-delay-ps (2500),
    cdns,iocell-output-delay-ps (2500), and cdns,delay-element-ps (24)
    (Krzysztof) (patch 1).
  - Collect Reviewed-by from Krzysztof Kozlowski (patch 1).

  [dts]
  - Drop redundant &smmu enablement from the SOCDK and eMMC board DTS
    files. SMMU is enabled by 10cf797f3f8a ("arm64: dts: socfpga:
    agilex5: Enable the SMMU") (Dinh) (patches 2/4).

Changes in v4:

  [bindings]
  - Require the three named resets (sdhc-reset, combophy, sdmmc-ocp) for
    SD6HC nodes. Agilex5 is the first platform using this binding, so the
    Agilex5-only if/then is dropped; a later SoC with different reset
    requirements can reintroduce a compatible-based constraint (patch 1).

  [dts]
  - Note in the commit message that DMA for this controller needs the
    SMMU (stream ID 5) (patch 2).

  [drivers]
  - Add sdhci_cdns6_set_clock() so PHY timings are programmed on clock
    changes (including initial 400 kHz discovery), preferring
    mmc->actual_clock over ios.clock; share the path with
    set_uhs_signaling via sdhci_cdns6_phy_reconfigure() (patches 7/8).
  - Skip redundant PHY reprogramming when mode, rate, and enhanced
    strobe are unchanged; invalidate cached t_sdclk on failure or
    clock-disable (patch 7).
  - Use ios->timing in hs400_enhanced_strobe instead of hardcoding
    MMC_TIMING_MMC_HS400 (patch 7).
  - Program tuning delays with a DLL reset cycle instead of calling
    full phy_init() (patch 7).
  - Cap dll_max_value at 255 in DLL bypass mode so the delay cannot
    wrap when stored in an 8-bit field (patch 7).
  - Reject cdns,delay-element-ps = 0 and fall back to the default with
    a warning (patch 7).
  - Pulse Agilex5 resets with reset_control_bulk_* instead of three
    separate reset_control handles (patch 8).
  - Collect Acked-by tags from Adrian Hunter (patches 5-8) and Conor
    Dooley (patch 3).

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
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 105 ++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |  25 +
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  34 +-
 .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 123 +++
 drivers/mmc/host/Makefile                     |   1 +
 .../{sdhci-cadence.c => sdhci-cadence-core.c} | 294 ++++--
 drivers/mmc/host/sdhci-cadence-phy-v6.c       | 975 ++++++++++++++++++
 drivers/mmc/host/sdhci-cadence.h              | 118 +++
 11 files changed, 1612 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence-core.c} (67%)
 create mode 100644 drivers/mmc/host/sdhci-cadence-phy-v6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h

-- 
2.43.7
