Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A838F253;
	Thu, 20 Aug 2026 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252272; cv=fail; b=EQRMD9Dq45iV5q3+KfDJtJYoy6lr2TC3kwrmK1KvVebWOX1/3pcjOu5pu15hZxdPT+jA8SJi4AiaL/MUbNLVgnLrZCgH7AQGto90PEbcOYMQ6gCotk+rzzS+X7577d9Kq7Q8nsTDdqWF3f7oz2sRPR4qpq2wkhQAGIkgi/KqCzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252272; c=relaxed/simple;
	bh=Tnujm6cTAVXrew+CrJbRtVd/n54m4KQv5ftBxyn97h8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pPIqceVxj2wsHNSKsFC4jPONFMgDoyx1MFW4RROdweAxduYRgBhp7WqFw8Bdgvzt4GS0qLdyfXUie0zozGGWOb4Ob6fgN/nXzf12DPQTBbdXrrZKLivweoNYVH0NxHMeQzoDpHzLdduoWo3IX5FazZfDuJlKCPFZdDhrMSJ33e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=oVx8qNpB; arc=fail smtp.client-ip=40.93.194.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="oVx8qNpB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vboy3s3zfS+zz/DbjeEtjJwZHwUUECpFq7IX7gq04Rck4xwtG+72I1khMxcBPp+OhOpw16qPsVYoKfsjCWCIFk6rB19kCMS4bjNn0mIoHDx/ABa92EU6yxYtX2MBr/WkxHxBGsmwDwzryCDiA39bhGQLRdBamzoEG3fXPNH3AGjWCpaoRM22e6D/AGE39gcmnRhvFrw9H8NGrTf7tmqepYayjmDYkhJGbSxRrnv3qFM85at8EDRufvKeW3F1dCLWE3M26vof/9qboQuFPunokS39A6e3QJk36Q+ObNbBLO5/h7XMuibtT8i0IuhqKkiQb1hLH2chGj3jXKHIEvgUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRHsPOrMNX/Uig8HrWCKDAAF3wueqHWu24HCN05SFmA=;
 b=RTiEksnYxDQNt6oPwBKXvzaefEfrdL/f2HSEWwlzPGexciY4+zqpNmD/k6eh+Q5MWK1ACCpUS9DDfrdQoo2y6E5OSxogQS37S9NnB3ztEbGjU4bVun2rsduNhDZ83htee5SGtJMwHMVF6QMrcpCYxoDvuT2zfRXxYJ8vryv+GQiO7X590zoNrNuDSo1M5Ov3378XwbUdgJxMRZgqpcDOn1082NN/RsZGul4qKbJVkmgdwcbe3JJ3c79gI8RcCiYMCUMvjzuwHp1Aa4C8eFihwsIusccpJRiZLQdeU4wgH5RNBFWmj9/JAvF4kME2TO0WBn64HDU2b8JSZpfnKPvIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRHsPOrMNX/Uig8HrWCKDAAF3wueqHWu24HCN05SFmA=;
 b=oVx8qNpBY4ucDrymAvibvVeIIRDvxQCh/MlWw2jtnXCTo84uwHRqrMrxH7bN2vIz2ddngJDeQOIpf6bzg/GOtsxy02pKGoyIsaN4kOSyOl6ufB9qWet3yNXUE2LjpzIPY9sRxJTvXxUNMfWGLQGu/c4R2bWfrMGPZ5zASxsxDAiXw0ziKAiV4WUUxQZyxz7xaLLV+fVAtSRycCzMGlYb+bffIPux+DqqF5xFHkbE4PLEugIcIfBZM9QYKmHuR0R8l5TFDqudbf9k7hUNmtjJ3ybP++OTC+80KiF3VDixXqT0eOO8niJ5uy6FkfSdAGO6B0AVoIv6w+fkiuS8EFeQPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH3PR03MB7364.namprd03.prod.outlook.com (2603:10b6:610:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 18:57:35 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 18:57:34 +0000
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
Subject: [PATCH v5 0/8] mmc: sdhci-cadence: add SD6HC support and Agilex5 enablement
Date: Thu, 20 Aug 2026 11:57:06 -0700
Message-Id: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH3PR03MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 80744b43-07ba-47be-9e41-08defeece4d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	mbFyF2QVDdVUBr+7VCEundlZKnYDZpQSurJF+3lCqPRZKhGacv9Ce5NxaF6OnvHicY6bC7x6vIjd9m5uiL+Xb5dIJi1kKLiFcFIgJULhFhnTVHNgiA93dL3Y7gUAx2c5+80C88BX3yEefmQmsKwI/3yfMC/Etmnbge37sVmdyt3b8OE1peJWs1QUf5LrwFik6E8z1bSbjx7YO0LpbGdEp/nl81Ifm/7zAgXtZDqosh6JmbjoIkEXRbII6MiBD7S7MZZVMFMrw5+P/twLXNf35xYdS5Y6SBWdrkMH4lHNLPLGsTjFMahMIelpxJQj1EeaKcxPEEb3Scl6vIhdiBDuep9x19df4lfVmyGtVMSDaYgcQa+QtVvduhvmAgq2uZsiknbFaEywIi4OWPfBGTlxZH8X2EKvdTAA+MTNv18UcHuix+hld0wrMVWOQFmTZxawswOyssXRPvLUp3rfX6V6Vxz5dg5Vs6KyMp9odw4739RHc8UIzuubaJcWsiuBrQJQO4PFRWpKBWiwOZDNRUGwDlbVTFwf4cO0q/cA2Mih8EqcwsfRY1wXDoQ4vmCPVPKPxNsh6l7nQIgBP5QQHY5+OHk1CkmKs/S30o0UKPcb/6DUCgavVehb/lVFieRsg4Lzx9YWEwn+YRlOwFGU0rBMq17FhByH/YKZO7BZlPXmXiM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qNOZw6SRn1W+nCxbYWuHOKctq1yOtPgikMtFAWwu6ajPY/7hQFBb/LeKHvZd?=
 =?us-ascii?Q?RqxLY3y6r30zfGk5R+xto/60tSmUs7zYuAgw43zalYa3L0yiAFGvzg25a4Lk?=
 =?us-ascii?Q?UKh46x5dXNxtqqByZ7AbFCkQm3KcizxV95cwFzDqf/TGhhrzGTlCi/qcQ8Je?=
 =?us-ascii?Q?tRy2PC2RG3tTxBCUm0v2j607+8IPkqKevTXJdFmC5CGIDdJy12VhRUyMyNcV?=
 =?us-ascii?Q?RuBGNT5bhPBLZ4x0+ZfbKpsHtK8UItybmKKFkg2xo20L2RBQMyMdro1nfpsr?=
 =?us-ascii?Q?tAySPZSOxFWlBNb0H4ue/jL6CewCNbyRONefoRSkofkt9O0q7sokKfvKVkl0?=
 =?us-ascii?Q?BR7k3S9vuSZ3kHKar5zGipE+GZUSfqPRJ2dr3uno9+THFiTZQG7QJBaMVx2V?=
 =?us-ascii?Q?KeHKkLH2Ml/8F9sG7X8mR4mFzj608RCzH7VpUqtenAdqlxme6oLNkJP5u1q+?=
 =?us-ascii?Q?5qwxije4WNM410MRicfJgl8MKd0r3vyFwRL+PRboNW+leR69EYeCZMflSRNs?=
 =?us-ascii?Q?nmf/frI7ZJ3UGYtm2/72+lhVh0iYRdgySytbiPPZEBMf4PNsjXBEunQd8SJ1?=
 =?us-ascii?Q?FJXvHBR74f7ieKu38xBbx8tCHsRAxl1wCy0zEyqjBFf8ncDuryeQbpBzArJD?=
 =?us-ascii?Q?9iZl32ENjnWZKPh0Ww1ko+8ciuVBAjSXaer314INXUz+4LyfKqNMgkiA+buD?=
 =?us-ascii?Q?5SDBF+1Y0sr8ANAhXu4aIQBhpZgfPK/D2UB+yDnd4FhmWZ3DICBTz6yPC2Q0?=
 =?us-ascii?Q?HepgXX8Qf43MRmz++eBmeFy/dg3R8Y2NPjUxw0S5BvSql25/S6nba3QBjLkM?=
 =?us-ascii?Q?N1EGXdf/Zx+Y4li/EaMBBxGXnHbtOBmHR+XpZ3lCLIctSOqrHY8glKTh9/VA?=
 =?us-ascii?Q?9whXvU1O+5rRK2REBSDebVUODmNoMC/WHBaDYVnTWYe1aE9hTnKOlxe8QQP7?=
 =?us-ascii?Q?+szB5a7ThSxeqbeEQnTPdWpFE2m5YzH2MagaOuzhe5/hiqdCQ4vC9J9uR5vZ?=
 =?us-ascii?Q?5YxIbNCFTL6eIMcCyi9/vVdxAPyIZwhJ+BTmBbbxnu+FmYX9oQFEZpTLKK5R?=
 =?us-ascii?Q?NItl7RvwTDExizAdqrWWuSSVpP7t0ZEjVOL7GWjMtuJCog1eFhHPKwbQpP7Y?=
 =?us-ascii?Q?BacT/gOiAuQ5+6UlcE2AHJAkt0JHsCS8qkUZhfGd92LXzkCD2N6rn+phhf6k?=
 =?us-ascii?Q?QlqKBcXXiaIenIiohWWXDcRmOJrqdimccvRBJveZhlSPDlFobyeh2rW7VHQh?=
 =?us-ascii?Q?0En9lY8vfFu7ekJzuz9PX+rlqNaNrSn+un2LVYxJbTf3akr+txt9QRSbha0m?=
 =?us-ascii?Q?6/aNZy2EPqN1NZsh/nwRMeZBfY7QQ6Iwqqb/SXAUmTdLdoZZVD1PIK/NeuJc?=
 =?us-ascii?Q?UZTqEyPaW1cB5wXw7JdN1xnTQ6+eoaw0kbwkyg9KD5RL2/svcXLW+bU+7ehK?=
 =?us-ascii?Q?qMKiq5VlHGVODMzyF20NUnutc7xWUVLYe/nvsTSDD6kHZMwcKY19QW6Ssaqf?=
 =?us-ascii?Q?8gN19kbksNxy6ogeXjsA5FoUxDIiRn2g0IN4oE/aQP7w+aHn1OFWWmayPmp3?=
 =?us-ascii?Q?uqVGVvZs9YQZGPxF2rb5dZzRU6E/3XnUtdI1qc6z9Wc87B2W8SHug1Z3d4oL?=
 =?us-ascii?Q?96gZ6/kNnG48i4KkB0Z6udfWCbCeryFfcad8VP3kL37Z+V3X64qeRvOz8J+b?=
 =?us-ascii?Q?X4y0IZqAy77vmzkuVmk+t51bwIKQsZBA/A3P4pxUzBJztymujjmkcmqhJWz3?=
 =?us-ascii?Q?JWEp3JXEKn3sRcJ9vRU3BEGrytiyhJY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80744b43-07ba-47be-9e41-08defeece4d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:57:33.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr1USiLyqymEdh1ji7TK3aEZraiP8XPia9moAwdw0ISlEtmr8HgNK7fCZFC/jraBaan0IXZgYgFHv12MPxFB8Js3eFrP8pb9RyijQx0MTTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7364

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
  deasserts the three named resets together.

Tested on Agilex5 SOCDK:
  - SD card: Default Speed, High Speed, SDR25, SDR50, SDR104
  - eMMC daughter board: HS200, HS400

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

---
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

Link V4: https://lore.kernel.org/all/20260810190025.25045-1-tanmay.kathpalia@altera.com/
Link V3: https://lore.kernel.org/linux-mmc/20260724145009.7456-1-tanmay.kathpalia@altera.com/
Link V2: https://lore.kernel.org/linux-mmc/20260627201457.12318-1-tanmay.kathpalia@altera.com/
Link V1: https://lore.kernel.org/linux-mmc/20260511202132.5597-1-tanmay.kathpalia@altera.com/

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
 .../{sdhci-cadence.c => sdhci-cadence-core.c} | 290 ++++--
 drivers/mmc/host/sdhci-cadence-phy-v6.c       | 975 ++++++++++++++++++
 drivers/mmc/host/sdhci-cadence.h              | 118 +++
 11 files changed, 1608 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence-core.c} (68%)
 create mode 100644 drivers/mmc/host/sdhci-cadence-phy-v6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h

-- 
2.43.7
