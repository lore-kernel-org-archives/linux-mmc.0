Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C383477981;
	Tue,  1 Sep 2026 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288548; cv=fail; b=Jv8msXS8KAkGl2gUxAfOhr/8bN7chtBeO4ojHgAYxVAnUuQMIzaWQypQvz+Q+zXC8sK4vGeJm6eGtGQJ2fuatsiOCiigmyIRnFdqCNo+ZfXMfMwM5MNFh6YAQ/uekSU5BO9wTAJL3rwm9YBT8eBUryMnbX4gHZByGkvpiGrgiaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288548; c=relaxed/simple;
	bh=iKa3ZUzKk4jmTmo4PCPglIgeJUTLAbFzkrQcamwjYUg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A0Pyroi1QnmVdk0fGZd18fmtJXoxnj8fDc6Sc5ZrWfG+ootpacrbJokSnvUkxnVTlG8L58+VWJBK52iStA/c9mDmHg+sMvNrHH3ekrocv1Fm+flRzPDnKMpdhRmPV/uc4lwvLeYtkk8F4xnvyD9k1ADcG/p0BgGPbJpIi1LvsNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Wlv/LG2X; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Wlv/LG2X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOL2lP0EgQuc16fqWAUeibNxWczUhVGvYk4D8RrfyyzQL+fUku2Ky0Px0FcpNhVx0u20JVe/uPw7vvPuOovicc+J0V437PM9YSgx3yh4UEPEs+7G3FyuE0/Z+Xp2X1x8fRu9GTdp7qA7n93ohV9Hi5YLWsy4OVGNLeCSYd5igxlBFtIvvPIrSieF1jzumrNX9BFBTpA3+fZnUClL5SGHoz9gG9Dl7e94Ok35M+/XrtggCsTuTCUKyed+XKrBDqSO+2B2SXBLmdkQew+5O2zgyzYD28ZgprWTciSnQrZN4tXSyRwO9IV8THhLygD+vSFdVT01srW2ik9/cmQHINVxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srujOndOa3llnf8lqkdzYUWD3gtVnQ92GeP1BeW//Vw=;
 b=rAOHw1CylLRMydt0+xVvsGkp6LSAIejXBcs9XFpLb5vpRrlC/In+lR/A87kultT+a7qfHS0TJJbcJOapqMdHKEUoKUx50qYX3kqCnDOn04vb6E7ibnVYpDwWEjzR7jHS8PPiCHw08KPmnTmtKKNQ0VcQCfqR0tU4zb+JuKrN0nIKhOtGB8fo5vSxHcIoULprEeJWlzRME1lhZ+NDuQQEVcWOuNxWR1bVaB6BK48k4k1vUYYzTet33DYL5tUf94Yj3oKm2JrB52VbN49f1O6TW/izzxA/K3Csh0sDKoC/0T+/xsOiN6PJ3ZArqr5N71T7JRaAfyoWl8YrC1kRT9kcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srujOndOa3llnf8lqkdzYUWD3gtVnQ92GeP1BeW//Vw=;
 b=Wlv/LG2XPriIvlDfZQe8SWiMiV26RMN6+GyA2t3H8/wTtOkwpOM2PUMF3TLi0a2ghWtTqQpZ0LfU/MsMj9IwKI14rAr1N5MgmKEEOkozDrB8PLHcdug7LKsNPjf5+XGaN72hH8fUaarJijjbsiURYBekaYUCpwcyzn7adhkeReT4HN4fGGHWIdzFe1cXNcCVj6GHPC3E2mekZO9hwAbpVjSZV6IMQAAWuBCCjqkr+dL0paibcZ1cRNVkqIq4BsIYrETvgoEyMs0QtogO4d1re9UFR4PbANtxpAWoTU/c+IIJrtfFQjtXWXrRAEHdAf6+4KWIfpFoEG8Z3J3b9QTOTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA2PR03MB5866.namprd03.prod.outlook.com (2603:10b6:806:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 18:49:00 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:49:00 +0000
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
Subject: [PATCH v7 0/9] mmc: sdhci-cadence: add SD6HC support and Agilex5 enablement
Date: Tue,  1 Sep 2026 11:48:09 -0700
Message-Id: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA2PR03MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e45a4c-0b10-4101-8649-08df0859afa1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|11063799006|56012099006|6133799003|3023799007|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1IjRkSNLCtm354jPrWgI+ilVlRNYkoDNF+zkmSpoqMzJTxPBBIhdTWzeXXZd6HH8qwp81I0JAHTehlX2w6FBuINhnWQ/5zLeycRZIIr7YU8CYRt+BRdiGUoFbUCKp2dl4DpMDihTlF2+aPGvGsINHNtJtalOSiYTjndhox/hV2ENJzKOE3rlX5pdDkw0CGfk+vTXL7pnXjhoW+1QFjhUk9pDpv2akN/PyIALVqRwQIk6rpiwTIMFLL8KJCgJNJKj8BOFkMYtjdPvPZ2ZkYMOucdKZbqS9ALKjWtpWhUNkju+MzJcWtahgztVkpdi6SjzjY0ae96C4oqZwtFC6gJkVE1G/QmRSutBqf0J9LBhUvDOoFNaNedCmPHhoAo8J4uIirjYXBykI/ZQsLYTCl5LS2n8sxyjZQs1iJJEPsnfUov5l3Y0XAbpRVjxJOeK4fQce9qnwP5oaMmoRe0iYydX+Y6ANvhjSgzf5t2LpMEdBfQFKpDw9zsN1TzBmYbZK22BduLLY/nJurroTtwfwV6lKB84zEqxBD7+pOfagUp9AOhr59+iXarzd3auvqqj/pIpN4tKcukKIKouVzryoRj94ZzRnn7e/9L116JB+tQqtIDLP2nO5Vqf4lUkX1/oDKcVBjSLjWZSJeGPHzQUT8ToewgJeioiUp+o9v2lTdbAOlM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?65I4w7CiCBcsTTR4zG530tufC/XoqkXSmb9e00Pr8YFA8vqhUH//b6gt8JWB?=
 =?us-ascii?Q?XBp9QpCQiWGGgz63qiFdhPtHB7fpBA2aR5O//bUIgwJqnkdNBryNgbuWPZbL?=
 =?us-ascii?Q?PAJsvNmHHArEL0xQlXv8mURj7uWKDuRUu9GvAZaIM7pN6ha8xXOsQlogK5Fe?=
 =?us-ascii?Q?yE6/As7WT29WDPcMUp+u7oPW2kzyI+mvdrGMsd9GqBGWJNJM57X/jfGArG+7?=
 =?us-ascii?Q?Ox13MDGdTkUpwKWmDnuajDVasg7FDhFa6f9Skg0H6GM5yb6nrEqP6/iWcqfa?=
 =?us-ascii?Q?JYp1TA/q7T2H7HQ402NS4dUw4eqgem+2/IfRURAanPyX4p+wTAtbZXuM2yWj?=
 =?us-ascii?Q?6EowLvsCy+NBaVDCjZ0jQPDONn2LnYmPw0VEZIASeVUkwQ3sJzQttSeFTTP+?=
 =?us-ascii?Q?icRET0cA4sgIL1wGZA78BFfHadf/4ovllEa6b2+BwAb3O1PpnB2a7KZHQCgu?=
 =?us-ascii?Q?0vlpMp1vNSrSrq26qkprFVZlhXFbHH6uGysc3MKxG/sxi0AUKSmDl44DKzve?=
 =?us-ascii?Q?gB0pZYIhZPji3ikqunh+JAkWFVFk641cCir4r5O5Rq3OK+BDyn55IDOERT/p?=
 =?us-ascii?Q?9ozEteEBSx9oX7A2rMpzjBcUSytA2hxOingebvBXMz+9L0RS2b2mVLtt76Y1?=
 =?us-ascii?Q?7cOJ1rGpEI/cJblFM85l0lzNREQUjzZBhzaFSgENXfXActhnaut2v/mvp1KO?=
 =?us-ascii?Q?/+qOwNsh0chYk7cZKrnEp32RdiCil0iLT+NYUwpG/jrYnnJbWKzzcnxlnLEW?=
 =?us-ascii?Q?eRKCwz8Ta0hSPvvYiqrqxLGmEKfFBEAsLcm9g/3OQmKdGMMKpaj9zSUfPBNr?=
 =?us-ascii?Q?/JmpJiHUKNx0M9amUCj3+ciCtRYCstWnPxfxe4HgaXN5p+mTB1r0JU41fNHC?=
 =?us-ascii?Q?dLht6ao1WioqZNIRJDlIajwAhPyoUeLaecFE695MbDMEczVMVlJjfZez016F?=
 =?us-ascii?Q?pWUPP/Kyu3FM1PGkGoL+WELQLb3u+DNWhXvWZyOALU863imPZ309K05NWo5q?=
 =?us-ascii?Q?gU29l+DMln/4RDszgJsk1sQ6MqQUrXwiD/mN4q7k0MM8zp36ifvokTw1+8E+?=
 =?us-ascii?Q?5DWVwlqqSmwjR5TWC81NuraJyYGvtt9+zYhN7VZHSVsipgZvG7gPkfwjYimC?=
 =?us-ascii?Q?a2y+6/akVkWSJdTm52r6y9KGk28oZ+yssz9c2w3VeLbL6yLOs43SGbu5nhnl?=
 =?us-ascii?Q?5Jk/q7R0yqmgH+hdDY0svJJ5izbV7YQ3u83uZ+aic/OsnRwD6cnzevjOiYqB?=
 =?us-ascii?Q?Ro2M2ZdJwmbqd9wuCivvQtQo6O0CyhmJlZt/Cty1v6WinSzuKiilbHH4ezai?=
 =?us-ascii?Q?07Xop6cjZ3vfjc/UVYpAV3s+ge4njiSs3N9IWs/u3ML8SXlWrUXGxVOukeWo?=
 =?us-ascii?Q?WcwgKfAnlEAtpJw7YgYYBvo0emoZ9x6q3sQAL9P8jLdipVR+RdH7K96asI5Y?=
 =?us-ascii?Q?AnUm+DuCHNd3JcMJ3SLecYEpPgoGjtYBoJmBu7LTil3PUWCj6aSWgNE7bogJ?=
 =?us-ascii?Q?MKxCHWwkt/jkDRf8BBt0+f1gm5S7i8Qi4F1973J/mzETBzMjJsROo5s4Cjpf?=
 =?us-ascii?Q?eI7ircJIYOMjxiqc696GUdoMeLDNipNwXBK/O1ToJYkIDYyoKh9WREE8V820?=
 =?us-ascii?Q?sNVj0YMOCzx8OIGh2BqyOsjGNAjAbjo43H0zdr8DlL+d2D5UYA98o2eyjwry?=
 =?us-ascii?Q?ydvzCl4jdo4nV2sVpahx/xlPg5bIS4okG9YryQOuZm8m2r1tJI5oCpPlZf12?=
 =?us-ascii?Q?PzvKPl/pD+9DPdidAkXYDaXcei1TfUc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e45a4c-0b10-4101-8649-08df0859afa1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:49:00.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/8HRHhm2rNQ/4PKkV6zNQg5OwtiTV9LL0cCrBjJB46pIzkfB/v8Yx0jan80iE3KM0jbLPKLZO6WZWbelDLNZwkwH/CkLx5CHnCOTXpePmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5866

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

Patches 2-5: Device tree
  Patch 2 adds the SD6HC controller node to the Agilex5 SoC DTSI as
  sdmmc, left disabled.
  Patch 3 enables SD card operation (4-bit, SDR104, 200 MHz) on the
  SOCDK OOBE board with GPIO-switched IO-voltage regulation.
  Patch 4 registers the intel,socfpga-agilex5-socdk-emmc board variant
  in the arm/altera binding.
  Patch 5 adds socfpga_agilex5_socdk_emmc.dts for eMMC-only operation
  (8-bit, HS200/HS400, 1.8 V IO, 200 MHz).

Patches 6-9: Driver
  Patch 6 renames SD4HC-specific functions and structures with a "cdns4"
  prefix to separate them from shared driver paths.
  Patch 7 encapsulates SD4HC PHY probing in sdhci_cdns4_phy_probe() and
  makes every of_device_id entry carry explicit platform data, removing
  the silent fallback.
  Patch 8 introduces the SD6HC PHY driver (sdhci-cadence-phy-v6.c): DLL
  lock/bypass, per-speed-mode IO cell timing, tuning, and HW reset. The
  common driver core selects between v4 and v6 PHY operations based on
  the SDHCI specification version reported by the controller, and
  reprograms the PHY from set_clock and set_uhs_signaling. SD6HC clocks
  are requested by name ("ciu" and "biu").
  Patch 9 adds the Agilex5 platform overlay under altr,agilex5-sd6hc:
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
Changes in v7:

  [dts]
  - Drop the daughter-card comment from the SoC DTSI (Michael)
    (patch 2).
  - Rename the controller label from emmc to sdmmc to match the HPS
    register map (Michael) (patches 2/3/5).
  - Split SoC node addition from SOCDK SD enablement (Michael)
    (patches 2/3).
  - Drop the DTS comment about SDHCI platform clock order (Michael)
    (patch 2).

  [drivers]
  - Request the SD6HC CIU clock by name ("ciu") instead of relying on
    clocks index 0 (Michael) (patch 8).

Link V6: https://lore.kernel.org/all/20260829184008.10006-1-tanmay.kathpalia@altera.com/
Link V5: https://lore.kernel.org/all/20260820185021.18199-1-tanmay.kathpalia@altera.com/
Link V4: https://lore.kernel.org/all/20260810190025.25045-1-tanmay.kathpalia@altera.com/
Link V3: https://lore.kernel.org/linux-mmc/20260724145009.7456-1-tanmay.kathpalia@altera.com/
Link V2: https://lore.kernel.org/linux-mmc/20260627201457.12318-1-tanmay.kathpalia@altera.com/
Link V1: https://lore.kernel.org/linux-mmc/20260511202132.5597-1-tanmay.kathpalia@altera.com/

Changes in v6:

  [drivers]
  - Use devm_reset_control_bulk_get_exclusive() and keep the exclusive
    reset controls for the lifetime of the device instead of putting
    them after deassert (Philipp) (patch 8).

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

Tanmay Kathpalia (9):
  dt-bindings: mmc: add Cadence SD6HC binding
  arm64: dts: agilex5: add SD/eMMC host controller
  arm64: dts: agilex5: enable SD card on SOCDK OOBE card
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
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |  15 +
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  34 +-
 .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 123 +++
 drivers/mmc/host/Makefile                     |   1 +
 .../{sdhci-cadence.c => sdhci-cadence-core.c} | 303 ++++--
 drivers/mmc/host/sdhci-cadence-phy-v6.c       | 975 ++++++++++++++++++
 drivers/mmc/host/sdhci-cadence.h              | 118 +++
 11 files changed, 1608 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
 rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence-core.c} (67%)
 create mode 100644 drivers/mmc/host/sdhci-cadence-phy-v6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h

-- 
2.43.7
