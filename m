Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D825E37FF60
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530902; cv=fail; b=LRE9N/IP253vJXXVN/p5aQb1xgsdzGHffG9oo6ZZkt3Sm/lRXfE0plJaMqMPqmIShkkX3jacZ89zQ2ykgvHbNB4j6YCx8UaGuiHhDPhyas+MxX0oh6Hv5KywRRnuIP7Am6kRrQ0uU8a24Hnmz6jDdsTnumnjUzERl5rfas7TGkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530902; c=relaxed/simple;
	bh=jEaHEs1l5bPAI3q1HJ/uoCo2wFDarWiFpMz2OUxOoFo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qDWIvVLG9K8wBnmQcaIB7m5BQkxiO8P0OZdJ/4UfjJ93AEBkTpW3mzX0GmaV0VBefJ3bqsmtMLIM87zJKPcuzy9pL/AFAfocyma84VgRtugqSaK7NKMKRTrgyt6+m1HfvEZUxJLHe/8iznpwUoLiagR/YSqEgGyw9XBkq0/BjNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZrRHkBd1; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZrRHkBd1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZmpWFc+Jwg28wFRjzuiCy3eQ6bb05Uinb5jwBMVilKZSXxkIn2FuwLyh2ZudrucZ6VAc8/AgUhNhmKoAMwb4YMO1QTOP/sWn4xvyt5a4l+P69pxagwdHNW0JOHlq0JFcEc6sOkYZhWUfkVAfcOH34ILqHy8nuuqaao/xTIiRonhn1KLnrh1TqdL/zg/lzeLeSt3TTyrNeLOdqxDpC4IIfPFZcnrpT7oxERVXSb+7lczuvRdFabz5kIIjnz6GQB0nNxQrG7awDuGrj9vQ0EnBk0xjNqix32rqqzYwekDCdiXsCj84xWEfp6Tmu4c1K20WagZ9q6XPA5QjE/sgdh8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULWoLk5x4uvdKm3xkeXg61ntGy52nCnHh3K9kHPP6jE=;
 b=og4IVB/8wOdv4Ol9o/X5oRHQrrrYAk+yh9n5P77SO1pfdtWfjYR8CTPMIuFqsDcS6GrQWwdoVfEvXhdEwtsvIi0Zt3RSD80H3+AvTNR/+pYBibOgRN/TyCPZhn+vyq5Ik4btLEq8+uavjmnFm9vtjw+sZbe6NHw6KmoJxq5LV8Nagg1WOgSSefo7ngLzc+UAMSJ0DDXvc4+l0mny+uFvIL2ON1VjVHCGMJzfE7dhnPvfMR6ReLM7EjBwXXeJrLfYK+JjsbLLjtO3wYl6rvcP9nc5DmyAeKNK5frUaDSrJDqpkjSLUGyzTQyHFxrE8JveYCD1Gr6zzVQb8yA3Kjr61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULWoLk5x4uvdKm3xkeXg61ntGy52nCnHh3K9kHPP6jE=;
 b=ZrRHkBd1QLkzRF4ToJmokulU1fzD0chu0PS2Z/CySrogQc0cLTLad5zjlJOLchISXs1lRp0/0Ba6feU32taFp8AvD9n23uk/N7ReceGCNOF5fdXJYOCoi8unuY+wl46gS9zdaaG9u3CXwqVExm6fNKqm/yG7t1CewVm2S0nKAMVMHo6dn4hL0px51A03fpwzdMnhjpYnQ0fZLlt2YW92e5IPkFV5zlbsLWEhj1aorq/OsDEwE1k9grsSW3aFwmfZCKc4bIu1/NhByo8V7D4Ig+dAbCq72bBDXiJ8SwSQ2KJif1LvzwRexe7MeV1LN017vNqTQw4ek452EButMjep6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB8296.namprd03.prod.outlook.com (2603:10b6:8:292::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:21:38 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:21:38 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v1 0/9] mmc: sdhci-cadence: add SD6HC support and Agilex5 enablement
Date: Mon, 11 May 2026 13:21:22 -0700
Message-Id: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
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
X-MS-Office365-Filtering-Correlation-Id: fd9cf9a6-4c29-4e55-f617-08deaf9ae7c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	s01dMY3CA3E9+NpQW++33TJTyYzdgZM2PxGu6QYpjNTHoXD06VM9av1WQoiJ3X8n2J8jHHmF3yImltMyUCdxmwN9e4OL4g5BvQKu0DSP6ljM/4t+0ouRBFtvl1Uc1G2ZQU+6zRKgzhRzrvpz1d1DvHVSBa2gKt2lXtvG+8Du5wd55zK8O6nWRE6OtxNgnezLzftTE9AW8DWcFgPDszlBgN5P+SyrhwHz3Pzmlq68wMWKNQ8Ia5z6MlC3/v5Z8/LtrQD0u/Pu+vqEJjCrJuJOTjgcLGwHgu2+qknZWu8YWaBPPhq/cc9oKpZSrLzmaFj365ZA58/Z+qC5WM93OKFX35uRMPGe4YBLBpGWX+ksy+Nh11RXy8N1JODMTiffzLFSxrI8W+QGfsCeiUnjOZM3J6xIoFNf3YaGJdoH8WZE4h4JZ7KAvQdno0JONQ9MMUGLF9B+5DJaRB6R2MSndUbfA+o3d5xPEwFu4Y0R2j627iz+ZI1D70vV5EFkyxj/yWa8iIuqTyaW2KDS41JBjZ3Jk+P/VtvCmH2x+zAg3Wt9CUY/rROdlcbs/f2TEzSLAX+iKj03Z2GFWIxyMvUh//PfkOxKa6LsqKqIhUIfHtDJPvoNJpHh4pZS8ikkVoCJQ7bT+n68bpC2NXK4DI0OQwIh3/gyCY3qvkR74PmQp+k5bn/NK//iveBO7OY88uLxFWO/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wSbD08obsWXJ8NJGuJcXtk24amh8fIbur/hPu+thHGq6+LPokT1MbcVkDaBE?=
 =?us-ascii?Q?Pa3g3viO1MM0op1hX1az+XRD2E3JfNYqpdCvN6hEfEvmIu7PQ/+K/mxWz4IO?=
 =?us-ascii?Q?qI4xRgf047XSNy56U0jLL0MlIa1wuVW9AfcqBoNuuJpsD2RxwoQlCviK59v/?=
 =?us-ascii?Q?oIaUT7EEzcMuxkCC4E+W1g38EwlUILnKWKJzVe7POWAPNoHZQRqS3cwze1PS?=
 =?us-ascii?Q?C2ssWf5fC6KtZxZINdUCgzIY1mKPUJFc/AQokJqsg3Ku+g56ZpzEEYZRuYmn?=
 =?us-ascii?Q?wtO/iUXOzrlAU/Q7fRIDi8/cfo4/LatcW3bV13j2ogQXJfNVRlN4XmW6o3ti?=
 =?us-ascii?Q?hd0tO0dpylfqFQOHVw2Bwj/xOFVcbgt5erp44XYZ75LUmr4em674MogeiUjR?=
 =?us-ascii?Q?DW62ShXid0gg3X3vLt5tSeufv9jsxYnNuhTJrBF61kjYpGqI3y+dqEcaJzHw?=
 =?us-ascii?Q?XSCVWxIb+a9/E5c7yMrzXOWrm4YZGGsvrilykin9flNEvIXAh0cqRb8EeHBb?=
 =?us-ascii?Q?E9NAda41G4sUR+yGL68CcmtDWD2UhDj85THzW0DvWA0eyYhxz9ojMcbjjxvd?=
 =?us-ascii?Q?+CoTEqmwdYQlG7I21eqzLDRER1GByqU3u6BvUyzpbdwJD2CWUlKt9eeMs9ri?=
 =?us-ascii?Q?CPECov4jHVYkssYDFEAlwXmgnKFQ6rAa0RBg2m8Ep9IeL1X/NjZZ47TbR/5c?=
 =?us-ascii?Q?Pwu6/FZaImKZvT9X1tM7jrhCOpKBz7l6UDeuQrcr6uL9vNMCCqGUJMAItBd1?=
 =?us-ascii?Q?8Pua6fBQKktZuOObK/NziZBAkFSsNgmuvCwOLTb4Y+0i5TW7WrT4CDNJH0zy?=
 =?us-ascii?Q?njcqp/i1L32yjO6I2DtFZ24qlG/uk0t4I00rYjUCdgpH3LBO2Pq85aWGo/Qj?=
 =?us-ascii?Q?AXfitbl2v2a0VpiI42dMpA6TMk00yEYz4q2sAyn/39sv60rTv7ga5+Y4Opov?=
 =?us-ascii?Q?Z90KLMMkzT85/27Qk0J9fb2j1dRwdv6/m8tVBfzvjfG4X4LBE7HLgJiK2AeT?=
 =?us-ascii?Q?9Cl0d3qLq7Q67wbCObS22nZXJ7EIsXD0nnb/4K1A8yBS8Na0MJ+6Li8j1FUn?=
 =?us-ascii?Q?iE23r8L9o9a6kKNQbux1EUmLbD8c44iVggmGiMjaLCgBTdiQi+LNpaNci4Dm?=
 =?us-ascii?Q?/4UmJ42ADwcJDaxoV5NQ8aycgHwSs4mm/E+69y2DwL9ib47LRfx/K0BNGgjj?=
 =?us-ascii?Q?OUNCJ7xObMOKi/PjUnP27mzUUgS6aEY7+/vTSQncSP156VOL/qKrNXZ/kwYU?=
 =?us-ascii?Q?miDCAxp2f/CII4N3WlOanKSIHZGzK6cgntA/WEubfDClXXkmaZ9pOVSHmMtY?=
 =?us-ascii?Q?UkvJsBkW6LT5NKTsbfYXEGNDOW8Czl+/V1BR3hJ5EOnsGHuDHZA4UJ7OaB37?=
 =?us-ascii?Q?GOuq/IprHSUP/9RtGty74zHos4ayCUmMXHK8OE+N2R4bQ025KjZP8VfCgQPJ?=
 =?us-ascii?Q?UI56hBeu0Boq0O6c8+6uuB3lGW+0yogBk5LAzN/V1VgJf5ty+FUSrCnlKFLb?=
 =?us-ascii?Q?oiXrTP8qjDA95B2g4nXDC17erVPSNAeZyujeshheGItRFKw8EF2HF4BBSNRk?=
 =?us-ascii?Q?j7gILwkkV6HfGOO9W3m6xCtcWmx9BV3ffgbxp/bHvHuQGFxh1q+TXdL3oo87?=
 =?us-ascii?Q?AOXCsqsrTn/o9tfZFHdVYbOctvlMU48IzkuaNZIJOyZiHBtCneTaeUMx9xI+?=
 =?us-ascii?Q?eslZG4Ymplb2U/ORLQq5VDVZ9+/t5/k6bzIVR65zPERz9SgWx3izhIiBOI42?=
 =?us-ascii?Q?I+V1i2AJtZLJE/i8/uPSd1J3eNFPNTI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9cf9a6-4c29-4e55-f617-08deaf9ae7c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:38.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHrhIfWX94gvpEQWvrUm4Hf2z4Eb1hFkgMLTKkC/gOQRVFsrXJsa6zJB6g0Va731WKY4XGKztHsNjXctHCcI7uMXmgRMm2MQZZ4wDP57Kg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8296

This series adds support for the Cadence SD6HC (sixth-generation) SDHCI
controller and enables it on Altera Agilex5 SoCs.

The SD6HC PHY architecture differs substantially from the SD4HC found on
prior SoCFPGA platforms and requires dedicated handling for PHY timing,
DLL configuration, and speed-mode switching.

Patches 1-2: Update device tree bindings for the Agilex5 reset manager
and the Cadence SDHCI controller to cover the SD6HC compatible strings
and its associated PHY properties.

Patches 3-5: Add device tree nodes for the SD6HC controller on Agilex5,
enabling SD card operation on the SOCDK board and eMMC operation on the
SOCDK eMMC daughter card.

Patches 6-9: Extend the sdhci-cadence driver to support the SD6HC. The
driver is split into sdhci-cadence4.c and sdhci-cadence6.c while
preserving the sdhci-cadence module name. Agilex5 platform-specific
support is registered under the altr,agilex5-sd6hc compatible string.

Tested on Agilex5 SOCDK with SD card (SDR104) and eMMC daughter board
(HS400).

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Tanmay Kathpalia (9):
  dt-bindings: reset: altr: add COMBOPHY_RESET for Agilex5
  dt-bindings: mmc: cdns,sdhci: add SD6HC support and PHY properties
  arm64: dts: agilex5: add Cadence SD6HC controller and SOCDK enablement
  dt-bindings: arm: intel: add Agilex5 SOCDK eMMC board variant
  arm64: dts: agilex5: add SOCDK eMMC daughter board support
  mmc: sdhci-cadence: rename V4 functions for V6 controller groundwork
  mmc: sdhci-cadence: refactor driver structure for V6 controller
    support
  mmc: sdhci-cadence: add Cadence SD6HC support
  mmc: sdhci-cadence: add Altera Agilex5 SD6HC support

---
 .../devicetree/bindings/arm/altera.yaml       |    1 +
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |  107 +-
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/intel/Makefile            |    1 +
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |   46 +
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |   26 +
 .../dts/intel/socfpga_agilex5_socdk_emmc.dts  |  111 ++
 drivers/mmc/host/Makefile                     |    3 +-
 drivers/mmc/host/sdhci-cadence.h              |  113 ++
 .../{sdhci-cadence.c => sdhci-cadence4.c}     |  241 ++--
 drivers/mmc/host/sdhci-cadence6.c             | 1051 +++++++++++++++++
 include/dt-bindings/reset/altr,rst-mgr-s10.h  |    2 +-
 12 files changed, 1623 insertions(+), 86 deletions(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
 create mode 100644 drivers/mmc/host/sdhci-cadence.h
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence4.c} (73%)
 create mode 100644 drivers/mmc/host/sdhci-cadence6.c

-- 
2.43.7

