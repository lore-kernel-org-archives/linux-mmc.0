Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB82A13B5B3;
	Mon, 13 Jul 2026 04:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917388; cv=fail; b=tTwGJatCdG8qNJtJ57x+yQvOoQhUysQRieW+guJKeB73VeqtZDLyq9VqKJ/UQsJx7Qce5HGgM7r/gEAn6SU9xnSrKjiYYR0QbBI+0iiZlAYXeXVC8BnuopAf6qvxOw1F+6qRuaNmvxKv3OFvEypr1GtwLq9G2e38oT9fNghwFVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917388; c=relaxed/simple;
	bh=eOjLCPrzSaZGu7r/te0GZNuT0X7nBGBRxHdnYGsLV90=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mf0AxZcD8znDViDT7C1pC/clAf+9cej8Z6fhxRvJQh/AY4PqBKZse25H+xdsVVMxvD3731j9fOr+gdZVPQIUSvDVRV5wyUx4kgS7u4QC57oRU/WJcyYK7Uggidj5rfdpAq2KWGc3iDwI7jbL0R8fVW/Q3L6S4dlEL1O3LJuE0Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VUs90Mtz; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VUs90Mtz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjZrSjHxrbhXUJ23kuNYkQREovh5mxlah01bpDT1DToXYId9tZBQeuoetea0/ejJMM+I44fyWKhsQyx8GIxGivsbFf/9nxHxMHT15dyGMz3KMItiP92YdAcnmLFbGrMkzz3+YSjd/38Gl73uV6DTX5ottK696UzSTLDn9M2cMXEk02BxR6ujB1nz8q7T9hpfWvJrC3Qr2r9ayj2DneKb/gFkDP6f1LDjWvyoW7C4nTl70f160GiMnw8X0LrS4CpvVV/p4DQ849euSiwX8pV10M+aNB7cPvq/Lrj7SFvI+YQqZP96pm8t0PvDJETX9Nf0DxKWOvkTR3ptytn6oKkIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG8o+8M16cDKS75DlKWtiOhlxqbfWDfKUWx3iWdJi08=;
 b=s6B1jCW9K+Hoga7CcKxiJzhvYVUS9WsSJI00MavZTXREy9o44muxlXsnX3sFBCNItLBpt7VgXZQTqV+mMrkhGrsU6nCGWG4IxIBvsFrzbLGncd7B+gMLMXyVvqJkVCmMd/almlFjC8A6Ss09q9viag0LeGOBOWLFUx+P8CQsPmnACF72P6M3O/7IGhCdItSIVZ2lLFVEKPyiLPCwG2JjB8BrzP+iD91L2IWQRHTsaoz/1vMojXTm82hQmHfGTuGtxShvW9C6XPmTUnsLXgH2O3jPYMl1BMxwqV4pOb7LEH3WdprKAr+cNyA3kz64sTthXDAi6sOTLbr/q1NRhePoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG8o+8M16cDKS75DlKWtiOhlxqbfWDfKUWx3iWdJi08=;
 b=VUs90Mtz0f/F/spHXuoD8SyAz4cJCHXtXMJhUfBHZ4glqLo1o/bCV6FIY2i73ts8OFC/0r9M+qNDlXWjko6B3th2Tu1IeEz0IFYRiWSvALszClfV8MXTf0pclU7pyGDZcebWVHpYq8ZJEWVsqEtOi1pzgaWAAp/+lyBjV9+WHwQLTOnCkrfSKpgguCtAFZcZMcA+Mg0eOGpkWcePzqcSRgzW3kFrFtWAOuJYQk+6rEVS5pPUTAhK1VfzSYviB+6NWsh3avUbcvJR7vxGMsVtu5udV7I1Wg8mmS857h5P0QMi/oAgLFPFdWkoW2a+gaN8ZwycwAcJig9ZfDmxAf8TXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 04:36:23 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 04:36:23 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com,
	Frank.Li@nxp.com
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume issues
Date: Mon, 13 Jul 2026 12:38:56 +0800
Message-Id: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d1751e-166f-413c-bd6d-08dee0984b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|3023799007|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kD4P1wRD5nswkDHwFGt0BQUg0xsl/Mozl7wJOwz/U6hwQ1ekjea9XLpDZH5vM20zw/nmpLnrsmquvkeF37ygoVHSlki6aeVzzWtDPpYiDiif2VoMToQUs3pIGHavfbBGzQqVLbQQzXwC8ZYgcUQuWXCQ4oiklI9qfvQ+R1WO9GNfObfGtGtBsaFgIhMLpPZtYEHyBgDy/sZ9rttfRcAoAlRjZ1NvFXG9K829RCDUvwC0yJU6d9B3izL3Frp0VrG8lYIBJE9aZLXr27OaGCETeFDpIc8cJNHpwmrLwayhGQ4Y8AK5fgn7aHnh5y1nCtnlBXriwWl37sX2QSc9PDxNkInBAR4We0v2VeHEWvljKczbA3Qh20MevaGkxY67X5a8zxoQaY0y3iY61evn6v08lrXnQsJOhWSgSrKqwm4iZsqgdrZ72p3xsuF8mVyKquvphCN5rGxLUAUSgf+DOKEebAO2MMpAv6RNCn/f8wx/OGRWxcrwQOgPN78c9mwJtXdN1HjCYM2dGa72ihLS+lrxZinkhRG8I6tBeqf8UV7ecVUtC/EFQ5EVAJ9R7k9uLZEI17WPDRFiCIqxFQFVkQwAMDOKgpbIDqftQTQQ13NCEGaY2H9SBgFj+7QH2tiyy/jnmZu8K0GzZcQr7e75gecjuUSjId7UQAhAYQ53FdBBYsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(3023799007)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cgFU6aFDiMeMmMzL6Mu8aaes5VLIBQnZ8Qnm+L92hz59nkwi+EzkIJ4bnoFZ?=
 =?us-ascii?Q?suxh2Hjm4Ucr2Lp8GdYhep5+7tEtwGJh6c40S00RY2TTQFR3hIJughTRdFom?=
 =?us-ascii?Q?MzUdzWkejxQgcz+Inw9+j02DNdaVQLqN33TTx+jW+omShvkjDz0m7WJOq5aC?=
 =?us-ascii?Q?Jxj0zNnGRvENhbCQvKT7zRYR74W9UMdmkktoRJcvohV1+Fmvrx/w3x436Qqc?=
 =?us-ascii?Q?O4i4NxLpmxOAMziUqKujP6OaUIiiKtS4SZYbjCONS/XI/VQUnkubxIQKCiFj?=
 =?us-ascii?Q?v6z/ldarfI9qbQZGqDNKm3A7EWlMCROrEF8EvfNNYv/XDSrLpr/em/8MAgOV?=
 =?us-ascii?Q?Db3jKObqe2hbnZXMbiKZf7CV+d3lVpB77Mch9RQQPICKdLyTbw020JBscccD?=
 =?us-ascii?Q?nUV5VCHflPFYz6ZVX+c2p7KEJdwXJ2MghJlBSE9lzZy/rcquReEU8JQr80iw?=
 =?us-ascii?Q?SC5DQiTJmGyIscgspLI17HEkduCnXO0e/QMWgPOEwteNY+0N9WKdJdVhOofx?=
 =?us-ascii?Q?XF2PkQmJNzXbEh/oJbrOuweFIbMQPqOUZ3fc1WjKiTOtZ9Ze12Qi6IHOrEtS?=
 =?us-ascii?Q?NPeNj5btpjSwhzZSWlP4C62k6eL0ApFPrz8b2D8MLdXORdEIRg4dyM0pA6xI?=
 =?us-ascii?Q?CSiIQdQ9e+k2C1uHK9uf5sCaBf0pVPtj+/fa3gZjW2PhOKem8yi6hduWT6nq?=
 =?us-ascii?Q?I917V/Ul1mkZQexYwVZqacD9m85nL/5yhTYTdRnS31UOVg94dF3CUbtkV77A?=
 =?us-ascii?Q?Yuxxr6f/mLiaSxe1bvimi/yHCr3rYKfLc091mGBQJIean6Z9RUCPEo8jVrzL?=
 =?us-ascii?Q?YchK1SCgl1qLz3zROlSjmb/AFsdOx5UujkQcJYMAr9wD62LEhlsDqDwfsYOz?=
 =?us-ascii?Q?+9nMNMoAU1kAO2D2wgo0YG1cOmnCOCA+kxjJtMTWh8O0NSfVA95p830PJBoj?=
 =?us-ascii?Q?rlBeX3fz4jfbJlspfpNeixi0FqOIFXMfURjbDDxzAWZgXmPheQXqB+KetjUz?=
 =?us-ascii?Q?JyEAGADcZj1gyzWqFNS/zi2xLH/SFFhIzBTmKun4yB/FBwghIO2jWTUtCQ0n?=
 =?us-ascii?Q?+HRcwx3kMCiV0BiUYa3B1+Wdn/ZIddx9saetYIz+TEf/TbafuWQfKLOv+8VJ?=
 =?us-ascii?Q?uMKvCV+5+aq9ldYQ/6o8/kELgajgFpaB8Y+l9J+9lbX4lsH4wQ/gs0kqRfRk?=
 =?us-ascii?Q?bx8ZnMAJ3o2ALObUL4FhHPMCDNpaEyeMWLuQSAJwXsuEN2FygKZ97NAblAKC?=
 =?us-ascii?Q?wW4cTUxeujGSBGrlhKVuMRtl/s8nL+yQAaH4XzkQvJI4ztQEzqwAhzi+cy09?=
 =?us-ascii?Q?7rVLTMXUBSViIkrJzmujMtPK5IjLvqmvxl8OdJgQn4WtCnkXEN8E1W63LEJE?=
 =?us-ascii?Q?xysBcBeA66onG6JDwgnPGqs/23McwFLzishFfTbnUhHc4cRAt+/iCYOzkYRF?=
 =?us-ascii?Q?jJw1fuPynvFpM3VAglNIX9yZwjblJ7XWGdpnkvTKhOouhpmz4WqAIirPY0XP?=
 =?us-ascii?Q?+U9QlcEvXDDTkBmYmthTPO3z2HhhtryQXQSrSI44nMshb+6kujVooFvqb8w7?=
 =?us-ascii?Q?DaChi/9WgAr9vF14aKhcdTOLL3HLJTaB1sSwTou2yRM+I1EAjhrgrzhF7KdE?=
 =?us-ascii?Q?JkIjQiD29amuBtu39NEJDF3lZi/L2xS05Qhu/0YtY3I4WuB5kbw7/6NdnPUg?=
 =?us-ascii?Q?yJr4LqaWOLGVPAtcgmb7ysVPEwkDj4GfbbhKlvmKsiI0snuaygTeDYG1C+m7?=
 =?us-ascii?Q?2oPhIgTFGQVEXAjLbHZXwr/0Iop2MRbM2qoJ4oDz2R+wsnCqWQ2D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d1751e-166f-413c-bd6d-08dee0984b11
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:36:23.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1D6aRIbAmGWORSJvKLWZkeNQ7t9wZhbJuCTNcNbBA+c6OD9+3MVA4V2DbEBXqZXWJStYSAYchfo8qilBl09Xipo7SgGWwv7C+8bjtY8aDYahX6EhtC5Mmqtn4PS93vl8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

From: Luke Wang <ziniu.wang_1@nxp.com>

This series fixes several suspend/resume issues in the sdhci-esdhc-imx
driver, primarily affecting SDIO devices (e.g., WiFi).

Issues fixed:
- Tuning delay values not saved/restored for out-of-band wakeup devices
- DLL override lost after resume for DDR modes
- Pinctrl not restored before DDR_EN is set, causing CRC errors
- Unhandled interrupt during resume causing "nobody cared" warning
- Various error handling issues in suspend/resume paths

All patches now carry a Fixes tag pointing at v6.16. Patches 2-8 fix
regressions introduced by commit 676a83855614 ("mmc: host:
sdhci-esdhc-imx: refactor the system PM logic") in v6.16; patch 1 fixes
commit c63d25cdc59a ("mmc: sdhci-esdhc-imx: Save tuning value when card
stays powered in suspend"), also in v6.16.

Changes since v5:
- Added Fixes tags to all remaining patches (patch 3, 6, 7, 8) so the
  whole series is properly tagged for stable, as requested by Ulf.
  No functional changes.

Changes since v4:
- New patch 3: Fix esdhc_change_pinstate() to move IS_ERR checks for
  pins_100mhz/pins_200mhz into their respective switch cases, so that
  legacy timing modes can still reach pinctrl_select_default_state().
  This avoids log spam on resume for devices without UHS pin states (Sashiko)

Changes since v3:
- Patch 2: Remove unused 'boarddata' variable in esdhc_set_uhs_signaling()
- Patch 7: Expand commit message to document intentional skip of enable_irq()
  and sdhci_disable_irq_wakeups() on early return, and explain why the
  PM runtime usage counter leak is acceptable (Sashiko)

Changes since v2:
- Patch 3: Updated commit message to explain the SoC IP integration
  detail about internal loopback path change when switching pinctrl
  from GPIO to USDHC function (per Bough Chen suggestion)
- Patch 5 (v2): Split into three separate patches (5/6/7) so each
  patch fixes one problem (per Frank Li suggestion)

Changes since v1:
- Added patch 5 to fix error handling issues identified during review
- Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
- Make pinctrl and cd-wake failures non-fatal (dev_warn only)
- Use esdhc_change_pinstate() instead of pinctrl_pm_select_default_state()
  in resume to restore correct pin state based on timing mode
- Skip pinctrl restore for wakeup devices to avoid SD bus glitch
- Check pm_runtime_force_resume() return value in resume

Luke Wang (8):
  mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check
    for tuning save/restore
  mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
  mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate() to allow default
    state restore
  mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on
    resume
  mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled
    interrupt
  mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
  mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
  mmc: sdhci-esdhc-imx: fix resume error handling

 drivers/mmc/host/sdhci-esdhc-imx.c | 84 ++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 28 deletions(-)

-- 
2.34.1

