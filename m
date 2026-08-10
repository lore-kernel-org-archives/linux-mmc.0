Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46F435AAF;
	Mon, 10 Aug 2026 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388470; cv=fail; b=my+m+AxREnmpRtLFMifM+/RpoRHBp++QqdxOrueDOFLGgSoMBh5kcqQhYJ6EdORmheWjoBFCABq/1gVzOLg3Mi1XiEzn4rR/0Yzdc8wnt/xuKqwB7Sj+4cTUczJlwTYtoCnKvYL11APiNrXoCsz6psXgNgeCqaH4ehodZY6ux18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388470; c=relaxed/simple;
	bh=R3JdePGdBbqlld/d1P2fLfrmQTDs/CRHlkG4osGEQ1g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lOkYkf1ti/2wJgUa4VdncgOWNRxXltXK39tB1THtTz5sbwsuTyTTBN4ZV9GwRfoGczJxJeveaBy4CmHXoA9/nZwbyfg7bgYBuXxcsIpX47ZLKldHVou9mjpeR3dx4QRpXPu4d1P1a6gHbOoCo6D7r2LRPqSmbr7tXj/cs9z3eQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=A90lcRC3; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="A90lcRC3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3p47x2u35uMB15qoMQL8XTUuut/ypess0Bk+/pd+aLI2zhxE5+4RmtzH3xjCbpKauPjFDAs7DXGUtChdPAGX/YzYEWXn6/Is+avnM5hNkl72Z/R8hIHBFEB2ZsBgslyguWV3tiSik+H3K+R3UMhXfmXtKX7VwNNsxdTRmAvPuT3CbuwJu0lyIDxujy57RzKQfykLiqgS91dkM+RUoYBrHmwzK2t/laD+7U2xhD3tVtNDsuGRwPyG7C5E5742JYGWblZxhn2suRJF66fBO3mrDipkjIyKLD18reY9L+tvWZU5mMjtZT3GNYZWZy19057dY1f5GEp9m9Rr3F+lVZ/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdfVAZ1CyKV/uo/M/5XuIOunUh+nRNtvuAH/U+O2PrI=;
 b=dES9WcMUV1Xfp7ZMvXJrWavHdwLrE4B8xngek+zHX2cVJLhC5nj0QxApKArP8LCTs3DxLVDmAIv5kTAs72ztlopBdnrerkBFc6ZVbH89n0yXX8tl1p7kO0sRskBmXfZJyPExRZmCT0Cr1U2fCWucg4Taeh0TLytxm956Kxi4eYgf4vcPNvYhR9iZRh8xEJCbrP96jIZCSrzRVQNRhSurwRt4Pu2SJbe0dIV7vxfR2AWSeAVQ+sCIcFlG2Rz37cUVdbWzj+ys3en3ongGCpKwaLjihKHBF9SkPNN+xDZ8nwGI69Km7DdfIxXRQpIqFLjgFnePzn/2aUkowUxfcsDtJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdfVAZ1CyKV/uo/M/5XuIOunUh+nRNtvuAH/U+O2PrI=;
 b=A90lcRC3tk6BnbqZewj2KBK4Rm6pVDnX1SMjRWQ+4uqRgcLhNF9tLf1EVVdnji0MdXRIstPDNZZzwpCoUTO/LoJjAUdYA3x/jAGCOhuBXoR+dvq3fnJMYfdmvQV+kdj9/fgVZGg7a7rilIn9bdYRvODstbYqeX4nE7JPKtk4vyiBX2fHvjdx7KZEWT/xH+BUVg42hWi64suKmfTaFfXoYv1gLAxDPb4vgFz6z6MtEhQiKyN2sd+BSC6+GmHUUf0OGsTTipkof9v+u9wLBxodSCrZShVNf7M2jyUQTidUn+BJl2wm0NblSmY6nhh+OWWNhovekgaZFQGyRKGQZxfgmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7676.namprd03.prod.outlook.com (2603:10b6:610:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:00:34 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:00:34 +0000
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
Subject: [PATCH v4 0/8] mmc: sdhci-cadence: add SD6HC support and Agilex5 enablement
Date: Mon, 10 Aug 2026 12:00:14 -0700
Message-Id: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: c00a930f-27c3-4dff-2651-08def711a7f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|10067099003|56012099006|11063799006|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0U4PR6aH7GgUcbgIALDFjvBxI6n69Mqq0ZF1M68AI1hUsGw7SP0NiveCJQDqPvl6eB0vjY04NIJyslolfzMUxpZQCjYuNlHdAhF/96PqCBvKK6vdywjVs5peAdIzI0LZTLvhXBUzw6d29OcEeXrIqoH+8SNg8q0y0XK4bl8c9hXegKdGHAgVo8JrlJbuQQo7vMexjlyzmtvacWlSC9bIdvHM2XaQHVxBA+Ii02sfD7DfdSTdYrixSoz7yIl73laXQYQxX+9rpa8kFnF0yHa/chnGDaPNNK/ho1mPuk/ZJiQqOC18Ssxbp+5Vai/MXki+uzVzldIczml/d5CsQzAk84sIPGuSJaTbdanWxLDMU++uNE2kqq8XtVOJcqRSuZbmS7U5vjFSa449n8qP3e2xzembq7XjcILfCTLkbwXNRIiASOfMNC9Iz8JIAyKdsQgxcNN/CvhQ5uM4ZfB09jj9+U9HzUpjBEU5/MJj7B1YAgHGs7LiTxTMrZzZ2PMXWSWZarcR4K0vU8USMgmMYMupxbBl82FrjSs7cN7cAV8qDB7jK1IzVF1FLQ/1PiKAyE57GHqFgzEggNAvmAg3gQct5ExSJX54sL+yVlMkFdARPGkmV8D/0qBxQgImPFfAZs70e80ofmtHN/HiNnevRNUu1eiouWvJ5p0n6lc3v8doCWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ML6AfK7EHgQa8dthNsv2TuM0Id6iktcnBGogQUTzCSLg+sD86kRivlXmCcW1?=
 =?us-ascii?Q?aMsOiuPIJh+O/yXAYiZQyYeg6ulEcdugB5s8UzCmXd75WOQcfZgdIbMjxRF3?=
 =?us-ascii?Q?ixSfPiPBLB/Bbo6tNBIYY4yCbWRsQUi1pei5NeBCwHwCnS6kUUqFF8IDnPr+?=
 =?us-ascii?Q?kvcJTa2sNsQv+WQZfgbtWbBNCHGjc8naeaZ6KVTrXS00n8DPpwLAxldUMojt?=
 =?us-ascii?Q?2v4QmD4V2LdxsE1ro4Du7UNMF6rqXP+wXY40K1y3iW8CxL/ElZxd5GcXiIBa?=
 =?us-ascii?Q?Ur4tMn9jqWQ8JNGLoAIcG0uJINLM1nnCw87Ubf17aWbnQbCW8XABzLmLCzX+?=
 =?us-ascii?Q?L6a1/H+zidRn7NQp2cVc+7+YH3lSSV7Zicn+DpvcJHwGNokfHFInCf0YE0RT?=
 =?us-ascii?Q?bUteBTlBlawIhYDuX+HhVeEmRsFIopCUB4d0Jf906gXxNtIfoXmdI7oMXgFO?=
 =?us-ascii?Q?MuPGP9YuGoZIDqaqDQY/eYmvStVn4Nk1U7FaxHegPKQmQzlr1Sbg+D/IqKGB?=
 =?us-ascii?Q?mMIGRpQD9x5E7nomghsb7Xqly1WJuGf8qHYq9H2aZ+oWcOlMHoEhku2aJan1?=
 =?us-ascii?Q?EYRqyJ2nlnYqkO84ARQOqeBU2xI2gSWMatHQjKWwiygMJo/Si/8KVf2nXtb8?=
 =?us-ascii?Q?q5pJJv3VCBZIyImiYq9d18O+f4X4q/t+5RBQuAk12P50BcgR6mgzg+cjAttm?=
 =?us-ascii?Q?HfuZU809gPykL8IEs+LrpnK7+nH59BpEEiSeE95l0qFsx/rrxl2a2jfdP+Zi?=
 =?us-ascii?Q?DM073vnDUrMDCui/hG7FBK44IQgu7NKADM3dezCr4UnkKW2xBnJ1oDgCThrs?=
 =?us-ascii?Q?B8g5BKyqU4KmjGDvaOQPvmD8mjpoBqA+jX/yYrLfX1P/cpSOEkE/UfTiEV91?=
 =?us-ascii?Q?bNLfmuc1Zgv49lDDqxtkAsqYXgYIBGPZDzWa8vyt6kzXoUA+Bw8OwefrMOlx?=
 =?us-ascii?Q?Magwq/6EbXXlNlFQUkMdmvYqraCGUno8lt9QK2MO1gax+X7mM8sJLt1g0WtY?=
 =?us-ascii?Q?HluTkf/QnRSbs6AHBj19oUIREzT1xjk7S0cpa2BqzG6qaL09ZcX8BNHFXpyz?=
 =?us-ascii?Q?QdSzi87RONbWIzHDCyGaqMafNidM7x6b/Xm11ZNe+s9Nsx1uzjSiQyMnr9hT?=
 =?us-ascii?Q?LljL5NfxcKh7YOaUMVQTFDrHas5tdsHan9CVhlA6YAppn6/UEC46zFI5H3pE?=
 =?us-ascii?Q?otZ8LIM6j2tZiPTjRR2X4ITKLmiQNc4MaEsg/rIMAhLWIEouteTt3kTh2H4y?=
 =?us-ascii?Q?OG/T8vf6lQOzhT1BiKNzFs60+1bA497s8bhOI8x9eTGmXv3BjLqbMeDezY6L?=
 =?us-ascii?Q?SFkSemfmWthd1C3D86sVQAa+U2/SVeuP00PzLm1sbP/ojkK6TlnfF53P6Szw?=
 =?us-ascii?Q?18yi4BPi3Y6h7/Q5a/buSPvp0AXYIrZp8XXoio5jgGALBUYiHxT1e0I7UjyP?=
 =?us-ascii?Q?984MCcjQFvBtBD5uWn3tJ+dI/24yhavYfytVbNZjyNelUFRrzVlgauWsVddi?=
 =?us-ascii?Q?3zPrh8I2N3FYOoEclQNB81pYgxvbuQNaNuAzqKx1Lk/j40/SCDxf6hYYv68o?=
 =?us-ascii?Q?laA+3iAcOZXKaU0qGu8no88NMQhIiBv+ElTpUVD8jRfBVVYWikVfOqBEAu/b?=
 =?us-ascii?Q?AfVSz574NVYDUqEmvg9pM4jV3X99BDcsMcfomtzR97D/9L1SGDiwhGyZAyBD?=
 =?us-ascii?Q?ygrg3gEhr1+DyK+tLDvHkg4PlveFIZxpI18ZDxosCVgeWZ7EYoxBS8H5NOdZ?=
 =?us-ascii?Q?mnubJGkcJuSwTIksYtvyLus6GHR/URs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00a930f-27c3-4dff-2651-08def711a7f2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:00:33.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4Wmlv+yW9wY/JEkPNRKorhI8dBun1e61n8q3dG3Dahm4n/5OUvq2mc3mFgBb5PV1jZNa6sFVEMiWA+jcEbgnzz4zjo+bPcAcq9ECifVPoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7676

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
  the SDHCI specification version reported by the controller, and
  reprograms the PHY from set_clock and set_uhs_signaling.
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

Link V3: https://lore.kernel.org/linux-mmc/20260724145009.7456-1-tanmay.kathpalia@altera.com/
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
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 102 ++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |  25 +
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  38 +-
 .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 127 +++
 drivers/mmc/host/Makefile                     |   1 +
 .../{sdhci-cadence.c => sdhci-cadence-core.c} | 290 ++++--
 drivers/mmc/host/sdhci-cadence-phy-v6.c       | 975 ++++++++++++++++++
 drivers/mmc/host/sdhci-cadence.h              | 118 +++
 11 files changed, 1613 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence-core.c} (68%)
 create mode 100644 drivers/mmc/host/sdhci-cadence-phy-v6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h

-- 
2.43.7
