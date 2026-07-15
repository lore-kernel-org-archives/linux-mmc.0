Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602D3BED1F;
	Wed, 15 Jul 2026 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099760; cv=fail; b=EL1idCV6KQm0kHYg/If1yRjwmmPxKywg7j52RkrjndnCnIprBNgKBMMIdqkViYFOqfISbYLBQ0NfOc++U3t/1xUwOUpmR/UJrfEMozsOe2SDD6UZ934Qnmj1jFX/1znPRj+zCt8p0fkt03fm1xpR+pP/WnC75hWb8px6YNgC8Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099760; c=relaxed/simple;
	bh=Tn8KwSnuPeT5NdDm8OQ8bJ7uwtn2psfgMuEbAkHelS4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lbXk1IrV3ZYyti0ZaoH7K0ac1yU01zk/gARYpRQwzZg7vwGPFOhtHzx7FNx+VZP4j3HpGJo769T41SCulABAmCbgZAHOslQ81wI3w5P5LuUm2hs42dHpPQrR5n/2fF5PCExIxLnZLnPw2axLXLAmWZqNteR4rfwHd+xdRH1/lb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BGS6pWDt; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BGS6pWDt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjtVMAdpvW2MDiQ8BJ+jik4A+cWxHu+AqZamCW4gXDEBUD8B4SHCx3rWX/V++ODTX1ZDl6IOcFt4BbpOG4PmN+Cc1G9pKaoCpCMVZwYPm93meETOKmU/rMaxj27J2++wanWD2N8lpRNur1XNxeKFqp8NlIq4Zi5HNzR6mHgQNvnqKxy+l4AViiDJsxSUgFPKtXJjXFp/l6tP7nJGHWjQp79kf+k5yKMOsQ/bLfUe3Kt17EZWF8mzp6cMncD4s2UAiD1LjPHmghssI+a0eQsbqpL1Eue4ia1btpPEg833/hzeYGiXIoCWXRMBYhEEGzdNL/vHhI1k4qOsrdxvvHQVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh0TWqTsmtb7p3NQ6fmp+kt5IBvZwPwG1A2GWel8vsI=;
 b=t85zKUaEwIDx9M6tnsuIczohkx8F7LJC7C6i/baC/T3Gh+CYRuMnCvwxQoemr4Mb56NbDXePYUgqIeA24tzEXWyVjo1kR8X1uSonRU1pZYGVr4mYw/ktvMHZsAWf0NSjdp6uTtJI9t0NCxgHeDzFEGy2MKVpnIBq+y9Od3pgA01hurIm1b2zKX62enX3IVO1rAOMy/RRlPI0eDomQoG0GkoQa11XwLAAmOzINVEYoDDQp6hQut/ymKaSg/MnIuMRu5vJg1+/W0Nd52OUnzB7509yvL0srrUes+D//t6p8TwrR7GAhCJLhFWIv2vSQKfiVrc0rNbKuAK0E2ssR0/ZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh0TWqTsmtb7p3NQ6fmp+kt5IBvZwPwG1A2GWel8vsI=;
 b=BGS6pWDteUA1r9ktUll7RbHdfXXAm4beO4vJBB0NBvqP5d4lk7w9Az/EIitSfrC7nmMk073loeFB9y7cRPUwU2A51biNnXoxa++gcNcMlD2jnSR+/EdWmq9Lm0KWO4HRUtv/zO5PwW8uYHCk0Au/ek5o3KQMlaSEfgBSy4LcUYBFPOuMKDHDSMual55BL8decBXV8R3GgMgyXUnaz+/aeDZQWmf/UvmCmI2Al2aec+2/0bqdaTGJC/IrdJtmlowVpHUlwOVefaTS59wtzzO88UTUkal3zhJF0GQ2fiYYmDsZMRv4mpZEUvAd2sXNrn4/nUQilBLU2ZhMmo32oFq94g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by MI3PR04MB12681.eurprd04.prod.outlook.com (2603:10a6:290:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 07:15:55 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb%5]) with mapi id 15.21.0181.016; Wed, 15 Jul 2026
 07:15:55 +0000
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
Subject: [PATCH v7 0/8] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume issues
Date: Wed, 15 Jul 2026 15:18:10 +0800
Message-Id: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|MI3PR04MB12681:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a88350-5c4b-402d-f17f-08dee240e8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|19092799006|1800799024|3023799007|6133799003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UewxhaaiaYDj5lLg6UWux+0Lnm+p20AMjRF6EfG5mSdS7RGnfTJTjJq0q//gEmbQtGt2A4xEBCtn+1HNtEVF9YGN2vBLy/Y7IueNd26xLOlqzTRk/zGkbk2fseurP6Ow5Z61uR01Qc97N08yV8eUozoaJnBXc5bkPLD3zJmSzUo4EnoIyEVlwa1Pe8/5GfBsA2QR1nHCOMnabTb9B+cmGmYVT/3c0SIv8fUdb4sW5Yc0l6mUZZIO6vufkF9IpsMnxIw3ZHPEhueDX6a9K4rbEDH1TM1vGKc1QKsWXWa9yOU77V+6GJJGpL9J4/iEI9pDrJqNLHu+qGWZKhBmlciN1rAukWOq2/DjdffGyvaXMIAnywOJM856NQG2wrnyq6Cn+aS6G+xufquSymNySme72aoe0DLdPRg5rKwksTAn5qoUe6ZJ1o8jDh4G5MXrGHLCM0Fe7deSbSdjO8QW+rgQuAiVhjdZgWBHJkfPkedDzi7dbLyCNPPhgC4iwROl679oxS/Hih/YG6Y1YA1Y9TFTf6mx0+pSXnu7vnIf7+87U7fSBDDFHfnpbH7NrXNPh26d12WFh4IO/zO+9DuCK+rUFALmOyswRwpZh72x70KQyeoMXe/4aP8f4bgup79gnQn4pgfctPZDv3x4vvju9z9Jyec9ZVf5lCa6TfyYV+0xw/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(3023799007)(6133799003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5aoplOkhkFDkdyIKI4RMfVh1QCpNMLbCOa1Qr6wil6JtzqU20lOFaWGJoPDx?=
 =?us-ascii?Q?GW7dv8gqq5pfLFZQ6gM05B+aSuw7VSRN4Kob+MjAx7q4l1mMpObHB1Am4G2i?=
 =?us-ascii?Q?E9R41BzOI8BZpyumEvYqcKu00IVFD6g8erkuOdHzfr5/u96V3iQUaVFrGBlW?=
 =?us-ascii?Q?3lCDATLdKQJBWbBYxG7cj2eXZ2OWBT2ot5C7dxAI7bQy6B/Fn0OsxnknPn7H?=
 =?us-ascii?Q?QD/KIolrHNwNhvuK1uSN0CdPaFfjQ45slNafz6kv8ZhjslEfeltXLVTDqqFc?=
 =?us-ascii?Q?zPR0PYHZkCxW6bCDAg+XGNT0EB670EA9XlG8osPBFV2t9IuLH6Zxql23UuVP?=
 =?us-ascii?Q?bTgvY0mlBbgezqw9XlKwq//rJMlPYxotZYK07G2GaT9f03fPNPTLegdTsYDf?=
 =?us-ascii?Q?OXxTLFm2/aWjIHkPi3HF78laGiQ9opzHVNaHu/xyAT8+Yr9y7OKdlIQq2zmC?=
 =?us-ascii?Q?vYd7WHClWTAMac8s7ZEQnyMzwLsVLWVzoVzka3581BEYX45BE+JjMlk05jo1?=
 =?us-ascii?Q?GkYthLO4hEELU7ofi/BHF2pDDrfcyTLBE2hYRLa8FHU0EcpFewVH+znVj3LM?=
 =?us-ascii?Q?GzF6IijCkeL27owNBJQ+VjmgqyNAZiEG9YEo/CTStQ/em/zxR/1jdMKTETUb?=
 =?us-ascii?Q?iZkrsbs//qj6OgDdvMOwRaqrO7hctBf1MItQsl3C3kedPgNb4SkyeeOpT5+j?=
 =?us-ascii?Q?TgY7huQCPq9Py+yoJd3MlSnAIy/wzT2A/o5xbxM0Q4pQ8DfU2JMuQpfOFvI5?=
 =?us-ascii?Q?a2C5m2K8thWI0AxDWLNmhcNtkJ3TocGdPyl0RzQrhzCe6xYoVyBUNQtrj22Y?=
 =?us-ascii?Q?WXn1zTggT1rZEkdvXYHcXlmIC7IKTTlwsfwirlabWiHh3ZJM1VbAlTL5+h+p?=
 =?us-ascii?Q?R3UL9243IXjywYegYfKNlq3VyHkdRgRMSEwcRGjufIupU128H+tYpAkWDrIw?=
 =?us-ascii?Q?4mD5cBsE72xtT5XwzBZrd023835SEUmBTKbnyncqoAygulYls833sIfyDf8x?=
 =?us-ascii?Q?Aqnrd+hwImxefLgXILZLLP77Y9Thz/rwy0Z7buc7trvHHrcFwSDClMKOFQt0?=
 =?us-ascii?Q?75N6HJiKXonUhO9TuEXpYNi3cWbexSJMYG0KycDPxTJVKdtczGhyv+HMBodo?=
 =?us-ascii?Q?hpFAOlNNDf1LvO7kLh5+EadVWdpkHhxDtOa4aaWbrjjnnHZPJqeNZUJb+XZ1?=
 =?us-ascii?Q?CdrNQXJ5GNxVzlKJW9DTI5Tx+a/sDvmoD1IvBokKV+6KD2lNeNTZvChYnLx/?=
 =?us-ascii?Q?CEt5isazpn1U7T0g1ftW9jDnnHI3jpqNQBR0lc2ftm58Sl7RmqfHyXCuJGjl?=
 =?us-ascii?Q?Oly4jc7yzBQxnEni//Fgz+M1e1kQ+nxZ6Le0zwDfaaArX5Bcr9VpMdvfoYdm?=
 =?us-ascii?Q?oivmQQRojh75mE6k1nSpLH+NDFM31vf4k9I0zWHKxYib3PrOZPJ/GK97YIlm?=
 =?us-ascii?Q?h3sjtok6Ayre9C4IO8T+6WtFX+qMXTMAOOCThoSXo62pCs/q+CGuhRDEPtVu?=
 =?us-ascii?Q?juTMh3y94nF8bXlqXRr0SwMyAwy8THPWBqxEJtAokKk/UN+85C8V8bPTGyWa?=
 =?us-ascii?Q?QgPueQwVa3riYgsMD1XoZ6kd0nfAbwiNlCXqre8dEIPqbVtMoqYixOKg9yt8?=
 =?us-ascii?Q?fgK33ERB8W1Cebyo/0R4/DF3vmx3veei0IyOa1ApvDb3X5TxyxRmzCF8x6YH?=
 =?us-ascii?Q?D2CyMM3oQxVj7wAFa1bpKvbkD0ZZWZkuuUiKsK48mEDyCdMW6cI8mGH/rJi7?=
 =?us-ascii?Q?sOU0EJjHnClj5k4Ly02rPIHKqXOKhr1dADJPioFBh/wzwlQPoJon?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a88350-5c4b-402d-f17f-08dee240e8bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:15:54.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qjkan6bw22Ny8yBy4oFSRM/at9z7A3pOKV2AvQIS0ndnOoSgJWTDAjtUoL6lK348RlIE2KvvlzulARSJN/VofoL0J8c7IqFvvPTym2lRCAlO5PrZnRg4BChz/0pZSjTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12681

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

Changes since v6:
- Patch 7: Drop "ret =" for non-fatal calls (sdhci_enable_irq_wakeups,
  pinctrl_pm_select_sleep_state, mmc_gpio_set_cd_wake) so they no longer
  touch ret. Call them directly in if() to keep semantics clear and
  avoid any risk of a non-fatal return value polluting the fatal error
  path. (Frank Li)

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

 drivers/mmc/host/sdhci-esdhc-imx.c | 91 +++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 33 deletions(-)

-- 
2.34.1
