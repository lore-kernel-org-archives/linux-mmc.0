Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC55347507;
	Tue,  3 Mar 2026 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534890; cv=fail; b=MmxXDcpavnFTRHE4pHEguu/wtdVVHz1/cp8jdK2onGAVs9gac32vV6ZOqEoVFWDBGbZcPaMWhltSi4Z7l/WtdOdL3T+EF5TIxzxmInvnZiaFR5iGmIBHJ80u4XYlswQ4W6nrTiigmYcYMX5nCKQEunfgXL7Njl80sZbR5ZliXcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534890; c=relaxed/simple;
	bh=9ujCtpUPg6idoTfl9q3ArO6ViQrwd3juE9ydUi6KEBY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WqzU43MyW0E6lhli3dNvv8YHxm7LO5wZhlNvWyWBc6E5Btb6F+NCwRh31SsVd/MEn/1vXRzDmeex3xIazPe9NanJR2etyvcxrH3K2jEV62d/TWrhh68vH+tRzagFj6AodXu3mgOS/pqP9TdWM8Pa9gcg1MNyEYiHMs/Q9CfA1z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AKbiiGQv; arc=fail smtp.client-ip=40.107.162.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AKbiiGQv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABGY3svbkVXy+O/qjNp3LmqHCov7PmcpUUSJCbMgOhH5Q389IYysmuO/Ln3utT8UeU67dHG++9PmM82PpwjONQFnirOVQojhQRFOP1923c1bKByYdga62mwuTOVGpBzDEPyunvplkoZfcO03DrAF13EkPZ4zTKdv3Eu+ayAvaNoW74NExCL98JJUuisvhm1ojjugT4Nr8QRoGO0vj1y4gt9eav2YnSooGTJ/swixFnWgFb3V8QTlASnrKgsye1A59dOuBkE7SfwDgSdq+hBmiLmx84QytRvy0V+HlznOqdEdDDmdORrOYCvsd0/Eb4S7m0zhif74BIFkVazUEzowug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbqyDM4GAKmTPr7SuKp+qErQHMPAFz7rwjMLAfTiEX4=;
 b=teg1ogzGV+iiwlaCGbhMT2QHM/zOt0lauSeoS4Ec6L4YGk/VkHT2NS6JC5x6q2c4uT5uBOgjxTHQ+OO0OVPb8LDalA1J6oE1/wMgeHgfxc2FgXSva7bnNgK0eNM0RrIAS+4JhiIrPpq+W4MtDZ7pjUq2b4SbggUqETbaKiOWEE/6SNaPdCUPeVKf/oBkCtRcfXt0TucUxkwWt7GgP5JXqso3Ek9qnu3swsMVMf3mmBEs7KB73b2BHnbq7BsDJDldNs6l/qK5nvHlxdWvyrsbO4hm2OsnAj8j5iEeGJLZLCr9ScXu9hu5QslXECH7uOc1BdxY6i2PPPPSZJ7v09DzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbqyDM4GAKmTPr7SuKp+qErQHMPAFz7rwjMLAfTiEX4=;
 b=AKbiiGQv/8yrZr0uV9m4F5hDeya61/YnObmLgf1ioBII1MkXw3CwQw+rL5TrEYKNm9zStRSV4KZ5ttXx88cYZdVTcq3puz1OOFbMfJb3bz5thWH2pOcvZFPvfU3UjmK+jDyOV3gE/Uhc0M8VyMlh/7XJJ2ElhR+PDP3ygHeznf69A97nHhBhbbjcdHNJJHTeDwQHMi7Gg4WeFDiQvWY1hMBZCa3YEKYh3oqxFPHY745ZBQelzcJ0T4CJfxEkPNkFvq3ybAk5h/FNtGk3Q2LVevSonCw/SUBYuMCEwTN2tYRug0x+pfFmMeuEN2Tul0n/lsBerRjDnybNYiOYV+F6rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU4PR04MB11926.eurprd04.prod.outlook.com (2603:10a6:10:628::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 10:48:05 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 10:48:05 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
Date: Tue,  3 Mar 2026 18:50:02 +0800
Message-Id: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0033.eurprd03.prod.outlook.com
 (2603:10a6:205:2::46) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|DU4PR04MB11926:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc19171-e8d3-448f-f269-08de791259a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	C9oG4V/B6y4BBNZGHebWpKXJJwy+rAlTlt1GhFtcmcuIXrtX73NBCJPLPDYb/gOwr/cIeExd/8r4auIMDKnymf5Ki43ToMFniMlaV1bUc9lYxntl+jEEvs13H8r7VQQFZ11yMClM6Rll5dz2SONQTIjX5/hQqiO2ksg5c1zHTsSh0HEmBBNOT35l9bqn9g4UZhRX95Sv1VYp3kvVstwA2Nv2w0s7EhSI4lNc+g2Ion87sFsWoZ5l1olgW2K32rAu4fIQZbBwPtjn8BiWjKiGretaRpzID37EFlh04VNl75BUeVoPfbdc9ObeyHh0skWdV9aS6MVTB6eUHg2iQI5EGULdH4S96LOiyW+c3R3mvvbMfDNSjmocWI+pLSCl4fVSF/T+UybqIWmzp35vH1IgEwRC22hKxP810smiBS/Aoi/16HaXEp7tgfz23Wfldoykp78w18rfW9TKW89ho+jnL/OGiDjDMMDh8T5WK0M9ko/vvKG0xcjgU09MOWhdInADsp0SpgqqE21Lp9/Oh7A+scG9MXEiHqDcq12MPHLCtgO/mhc39NLs54mixajdx6JOhldIWxeGguPGae75Wt49Jh0qmK5+UC4lZQvhOSdMLbq9GPQ8vR3qhNGWvQPI/uFF4x0f5NnoQ1dwLYtheuwIVFvo2hyNaOywp/ECZJJrNiaQDtAPvDxRQB5XbTAO73CRL/Kn4YYJzaLt/wR+u7lUfUmvjMsAE0R5XMGS16b8cE9IGQAgqvhNtshjHhXe3jsC3Xo85Gl7JwW+MvvauIP4yeekgP35LLuZhVgtHGOcE50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79hmIrCocackG1pzlGyHXeWh/BSTMm4dIYdtnGePD319kV0ZOixqykfIzfhS?=
 =?us-ascii?Q?nP04qTuKdchH7Y/7YbnjHatR4U2x1VybBO6bES8BArocs8/shiUmkCSrCuFe?=
 =?us-ascii?Q?hvLVp16QppwzkXDBLGjzwzD0mVougzjYbS3ddR0cAWrACsLJQfpS7hzXywai?=
 =?us-ascii?Q?XnUe0x0iEOrEtQLRGgHsjJNQ9puL3FoUNHTA5G7TjMzxGHW6Vif4iPr4UzLY?=
 =?us-ascii?Q?S1l4vQwqcHhKAehDBchHd1CxWvO1a8JNl9LlTfnwonFNEWeT2jFpQ+e23oXD?=
 =?us-ascii?Q?olflWI3YkON7+1N39bp/F3lYMm0pwjvsBvhADMWOiMdkrNUj6RiF6/2kWpBz?=
 =?us-ascii?Q?38aNRLPFffk0uyr5onQ8ZGqoxPsRmadsjwaV0ebLQyY7qzXD244b7cFdmuWt?=
 =?us-ascii?Q?SzlVEl9rso/Fy9Uit0I32IcolivLSA27ttSN7CKj7ZNXuepcuFLEjsgsVZO6?=
 =?us-ascii?Q?r9FO1rymRoV5u9nzllS7L1CH4NUoZRY1lzv+vMfJgxCmwQqGMoxffvnaoEYX?=
 =?us-ascii?Q?IKekWcmoTQ/ZYICvh9vuJQA38DWoYyguRpmQ59paFJWVPKTOmR5OMakiS5aQ?=
 =?us-ascii?Q?oVFY3uwQKRW2weXkD2hCXrmNFpXg/nyeqHdjdjdMJgMmIyNE/XAretGlGQym?=
 =?us-ascii?Q?XZyK/IFlKRAEfQ4wi5tYM7SCQtfwJMxihANVQ0j9pM5d+YKKIMn84KHQFJPd?=
 =?us-ascii?Q?L181W7rrXugXH7j5LgXHMeWs7aSp8zAj8nslLPDRQLMf7SlJcvXqDz8PMKtR?=
 =?us-ascii?Q?2i6uE8KI7zX1BSqCOo6D4fF8C6LHF1YEV8UQXYPKMRUDnJ91wSmCoRLVBQG8?=
 =?us-ascii?Q?318fu5jv5sGKDfaHgV3wF7B15gH07R3dA/bdChGVMn/lxkiaJpMbnIjKffWn?=
 =?us-ascii?Q?z3vgBb2x4wUvzMO92H4kw4/aOfcprZIRpnWMn33csDo0zd549Ay5UBnbB1kZ?=
 =?us-ascii?Q?ezs+UtCtSW9ZBxybS9+A9B2HQKbcwBKvrMWtrt1hsD/LDYahnzfc9HibwqCz?=
 =?us-ascii?Q?OuFmj0Hm85VVFYR41cKURfnl2YCAcFapH0XDGA6+iQvqD1q1ZPFxQ54U6RI2?=
 =?us-ascii?Q?aUEyTnFm1TcmWw3a4bG/j/7QHAnzcnkDdEAlExE5xHEiOIxTCJADjgl3xBTP?=
 =?us-ascii?Q?DyRE9BQw2jdawEqm9q8LMsuYp5QJIFY8Lz1G8/y85zaHg5H/RN93vUgSnS9i?=
 =?us-ascii?Q?RKyROx+dnmd4VQ3mB+TuXhx9L/yK28nnNlKap8OcpekMn2XUxg3t2VXW1T/G?=
 =?us-ascii?Q?by0+w+WUPXo3cqbeEsvK9stuSdV+mKb/SARANAy0ScNCHIhTnBW5LVQY5UtZ?=
 =?us-ascii?Q?TbQdO8EXTq25h/MIJ392tkwNjBdaFkII8GpFud6HdVDWPqBV0tB9Mn1y2mEf?=
 =?us-ascii?Q?YXOVnT88HyrtjOo79thUP7kAZnUKtt69R1mLZQD37rC4DG8GJBnDTQqpETHp?=
 =?us-ascii?Q?2mdsnWuo7YKXrUPdOOUG49jtz3PR97PGjo6HG8shI0Al3pl9J2NdNktF6Ny4?=
 =?us-ascii?Q?jLg8E7mvTE12pjvEcqYmuggGMIdslDo3Cbpmnh1Rw5Q+rAqk02FYUNiMNps9?=
 =?us-ascii?Q?DT7Deg4Lc8hGDxlZ2mPPrGG57r/7gwLt/aKhjS1JahpeZelPxnlaXvMA7lQC?=
 =?us-ascii?Q?6WuxCrm4e7ElPc4iCfRJjfpXq93rtWIn3u7Ss8A8DDldAhIUXEKtD9LDrj3V?=
 =?us-ascii?Q?mfTMxjss4GdQ+y/G8GvG7E4HPYLn53CNlgzm3Nfafqq3GurMXacBVxi87+kO?=
 =?us-ascii?Q?zwptk0lVPQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc19171-e8d3-448f-f269-08de791259a3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:48:05.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t01x+6HEujO/N9JyoSFZH90qCh35FcGNqTEgbfpIpOQeLHJN8EZWdW49dQQsArt5v3yPDmHNyYy4yvdp7q4Zkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11926

From: Luke Wang <ziniu.wang_1@nxp.com>

This series adds 1-bit bus width support for sdhci-esdhc-imx driver.

Currently sdhci-esdhc-imx doesn't support 1-bit width because it
doesn't call sdhci_get_property() to parse "bus-width = <1>" and
set SDHCI_QUIRK_FORCE_1_BIT_DATA quirk.

After adding sdhci_get_property(), another issue is exposed:
mmc_select_hs200() returns 0 without switching when 1-bit bus is
used, causing mmc_select_timing() to skip mmc_select_hs(). This
leaves eMMC in legacy mode (26MHz) instead of High Speed (52MHz).

Fix by dropping incompatible UHS/DDR/HS200/HS400 caps in
sdhci_setup_host() for 1-bit width, and clean up duplicate code now
handled by common framework.

Luke Wang (4):
  mmc: sdhci: fix timing selection for 1-bit bus width
  mmc: sdhci-esdhc-imx: add 1-bit bus width support
  mmc: sdhci-esdhc-imx: remove duplicate HS400 bus width validation
  mmc: sdhci-pltfm: remove duplicate DTS property parsing
---
Changes in v2:
- Moved fix from mmc_validate_host_caps() to sdhci_setup_host()
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 +-----
 drivers/mmc/host/sdhci-pltfm.c     | 7 -------
 drivers/mmc/host/sdhci.c           | 8 +++++++-
 3 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.34.1

