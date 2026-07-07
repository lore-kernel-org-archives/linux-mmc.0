Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677DD3D88E8;
	Tue,  7 Jul 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422027; cv=fail; b=VFtTiNF5XYJILfANlCyUb5jg/6z+lcUHSvsDesyf9tNJo2lKABdxxhzlOE8NiCOlqSHRc8A8T7NmgOOBwSpSELPhisfYJsluAjpC8CwWGOU9Jr2g3tqJiZ6AYuDYh57RyVQuiYfk5wHcNGRuA6IOuQ20dSvmb8z59rS6l/S32jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422027; c=relaxed/simple;
	bh=buhe41+nNdahoYccz3TuFPTzk/j+q2iK2WmIWPXiIsY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XM7OMD6f9fjEFWKB/bf9mOQyrg9MJWB1mo/uJiHwCCM4OExq5UDQbdYnhD1K5YDxy46vTFe30qdlIIzgiqloBEGxz8mqtwCZKamt3Vn8PurmlTuXkx4vtQliT9SNMQrDa+fBtKeciXgRYjjTH3I1IBiZ3WTdGDSFoidJHtg0VuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JU+vBLeX; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JU+vBLeX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIzXbNTXXu2Ba4FiM70zAdSiwGPt5eKCntQmV3HgqSt4cZ9mLqoR81Nm0J85whAEo6TEQsvFMf3w8A1dzf6bnuARAdQeyblfJO3Y8ZyOMPneYa/Jlut6quNSV3GtWB8MU1m6nJ97rq0Z8crEvwh/gKFerP8eCu9mV5QaoLHIt7iMmhpdQwgEqcDMUGG+XcZUZFeojVjjT0y7j4ZVwmdQHSaCWJeo0PP3qq/xDr7zjNJQgMB+h120tbyDkovJM+LGkMIUmuIVG9Tv1M4RHmH6SrlTqoOOV8S6Z0Rig3lzCc9tYn8d2hTcHeFN4e2JiDQn0y402uGtBIuHMF2B5AEU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7M4lNghRvy+TUMxRRzY+Cxfan69VqvPK0WrAwL5w+w=;
 b=LlAtazttO2apEq8vsPr2S2Jpkc00x8PbHrtKusYETypOPJtMOKQLECIdXGFZE2fyOYlC+hRFnerbTkjU0f1Q/u4cGjoolDW00DuOOAaxO+bT0V85C8kVHFBMYsRg2a5UoY6VbWAcqOMx298y9JOcTS/pjQzvOshZil8ifTGSuTymKyilJwLEF61H71qNUeta2FUbjK9ggIubiNIM9919pZebM7QOLmy2RNjb+0HUI7LlwkZiHdHIrsnOjqtUag0qAwawtwxGGYyENSzrMyQddPDiwRw/A6oVYAJWs9XeZN7RZL/8Da+fvQLiANzNL595k31KRRmaQoGs4RMO65URFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7M4lNghRvy+TUMxRRzY+Cxfan69VqvPK0WrAwL5w+w=;
 b=JU+vBLeXtUlZ3SqhMdpw6+wnx/jcawmUx4IQwJDK9akXyMOboURzOGA1RkLHCWnXihuQhWaqrkKI3WW3aFJTC2NyPExvGU8RTdKrG3tdmo/8fGe499cHHwC0TU48oABC08Qg9c4cegEGChUh69SMeEWivCnlrE4sYg5CUnqCVquknl+AMeyVsEfZIzmcdBfnAAJBTpOwqRxgdMN7ytvyTL3lCOQD9/04vRoRq4xEAcZL7rfZ8ok2xCuVlcTzev6aRyjR/BffNrQ2CCs9OiStCUiNrShwn/QZTm+Om0qExkG/PZlbypze2UaROpR/lUf7MNuxTw+NZHALeswkNZHN7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by GVUPR04MB12195.eurprd04.prod.outlook.com (2603:10a6:150:33e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 11:00:20 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:00:20 +0000
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
Subject: [PATCH v5 0/8] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume issues
Date: Tue,  7 Jul 2026 19:02:55 +0800
Message-Id: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0274.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::18) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|GVUPR04MB12195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba2dbb6-bcf5-4460-b021-08dedc16efc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|3023799007|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Eh4XFL1JFhFWNC4adyxgEETSaHVTCLXc54Sfl4GNngwK52lbqPBAKRU1VhkJv/isyn8SeW/N/Xe8FgPpuRNnLW6usvSugXDgByXdufCtP2AUo2kSQc/ZsJSlOWrUFsf5JzdCDZLRarOdkv6Rm6eDQkNVVKaPJkaQAksDSSqRmtMCJc4W+pO0CKXJPRYcvgFQuPA5j5c4PbWlkGLBcWAX0743s7onuzJ/wb47YAwXOOgBO04bzGw/PD7W4wVS5BUNLW9j9CcAzaqzRF0VgX0zgl5e13ZlP5GYzbAZkqFZ5il44HgZnk/GCJPQ2SXZ3RXkV4INpDSMNUNoPGyzrT+uVBG4yVPPF4kIIEq5rew2Bgc6JtBng+E07b3MqGw/HwOcsVQG+0ZVBfMYxpzF6rcpu6hpr1okya5Ap7/Hj2/M56qRuNdmiLqeg8235JdUCEx0S3YyeBE/5mC0YU+5kuxkSYrXistSxDmoXSOpFG0eP/k7l6jCKRNh+8zV82k2eDQGdgpRaZw1mKOBJWwKBEvgtlJ5rAYiiJDBdpAKQ/KAM/jgK3b0oLNvP2xv6IwAimRpjZcEI12ONZoHF1XC8ZobdQkJ3RyrZGdSDa/uiVVa1+ouNDzVOhwGeY6MHFnRFH6S7dwX8isp5CVxzVZ/7ZM26RyL456/8YzP7XrX535fYMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(3023799007)(56012099006)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxO+2Orajz4taYlOfmHOJIkU0jGgozwFYmMiEoW3HwlEUDokjUaghMQLkjcz?=
 =?us-ascii?Q?/9ETvS3rxgCEMFNLc0mBp/0RhoyOXNxQmsDzY1Xont3Y97dJ5GSQwHUKrtua?=
 =?us-ascii?Q?RtnpaxT368zURJfwBKuHZfH1FJ+mQvXSF2JfgB56M3I8U1Y1my14CKotm+ir?=
 =?us-ascii?Q?cg429GC/adGkDXsSIx4Dvt8C7swWnfhjdBTb4z9ishfUmvqSZ0z3UwmxZkmE?=
 =?us-ascii?Q?ypiEhOhdkRTCnWheguwqvu+0TSTSdc/j0fiVd5nt55AqhHbzgWdejpKFRZLy?=
 =?us-ascii?Q?WzhzfYXvgsznumsPhlYJN15Xbj3TA9Z2/pdHOHKTk97sSycd7msOSo8XSLdz?=
 =?us-ascii?Q?Zi40J6pAJQj+B0e8yHJxXFl4Q8mSLXhm8xi8AatoK2rbk+dV1rRJm/qscsLl?=
 =?us-ascii?Q?Os2+DekGgwoMChLOcJZagJhKKMBShi2cxQ1go/lzHTacWojoCKKR+FmEf4Fc?=
 =?us-ascii?Q?d7zmEv1MOG6CG1qvfWujBV0iZ1AfmVrAfHbmegdYVFHONuNoUZEQNN3KMC57?=
 =?us-ascii?Q?vMpiX26ETrHeLvb66jQIADRZ0HGQfCgkVDAwTUw1NNujASnY4qJELt8bLDln?=
 =?us-ascii?Q?h7RlLJRx+KJkKK+wWViQMjpxCBQVMBw1BnQsX6Dn8VqAdRiCBsksKAhZpuUj?=
 =?us-ascii?Q?hiT+NBlo/dY3F5lhnILn/qezcRSfHv+gZyDXW6ajDNNl0C8mTpRe8if28wSQ?=
 =?us-ascii?Q?0AEkkqj5Fk8DaMtnoMzT53kOOF+NrfrUm9KdNsmNTkdzrnhUSfruCZG1JSxL?=
 =?us-ascii?Q?exaSXMHKN0VJjVuY/mKICUDfWmfDhzJ48Wui4MBRxwvk7NgvRJs43dB0EHyt?=
 =?us-ascii?Q?XDtkJ6MJvxyRouZz/wsNUI1naK7vuhnHBqFMagUs6LSvDZBUpABtCjTyW/fU?=
 =?us-ascii?Q?R3qoID3GFZUZT/HoFE9qfQ3LfRW3COqaiIFo53AOv2/2TST80/s1lESgsiTB?=
 =?us-ascii?Q?HDN4H2mou6Tz1CinEcEajgiKYngjnDRX+syMazQhMgVufWP7O2Z8OtXCtn1F?=
 =?us-ascii?Q?MkeHQqIf3ET6fkTeI7R0oUpNy+YovCyi/+tWQdy4U1NPj5YWyRbpJiTwAifZ?=
 =?us-ascii?Q?qJOmRhWh0C+1sSYZs1841uabTYmgKzGTLIypYL78ddjdSYvvsGyhvGs5F0Sx?=
 =?us-ascii?Q?g49cfZXgg1qdDmqMXSt8UCADoLzCknw1o9UC9yfMqIu3nf2KfF+y1e+Fielx?=
 =?us-ascii?Q?8/tscRaCADbu6jEkQZ0u3abwOBruF5cJs51gk5FmEK2l8aDpgwZpXc16WL9Z?=
 =?us-ascii?Q?A4PmDR0ySxLyLWM9fWY8nbsgW3grVPa8Upr2rcACQCgyZGR9RjNOdX7CyWV7?=
 =?us-ascii?Q?zXiLxTd5b8kgxe5Z1bi9phL4lTNuYvsT3M0jluxTOg3nyyYxZMCmYqkDCtk8?=
 =?us-ascii?Q?x5lBMlkbMJMayo/qBZQgxYkoZg8JuzZvLeAp2KLr1I8YSuc3L+deodi/YbIK?=
 =?us-ascii?Q?O3WZlwBpHFIPMdK89a7gsdwnPc52P3pbRw8agW3JHY6zj2VvZhm7Wq1RhA5x?=
 =?us-ascii?Q?2FnGW3upA/xiHcmQQuQe4JI/SfrzgJB/umARKU1rbfnIiSMW9lDJ2uBHJfwf?=
 =?us-ascii?Q?ZYNqds7p1vwzSN/hCDTkGz4YZ49q8F9j+slRUgMnGgcoXCdWhPbvf3YofdwW?=
 =?us-ascii?Q?do0VeD2q8gMDLidzCvBsFxkJLyjo8wWAw5TmQpm3IO5bUc/nYPLDarMpCqvB?=
 =?us-ascii?Q?sjDWM0r/+ZH138m+JjAQ7vfSR/7U1iVmUzI+ZxOvemvg7cXhSoo6LbcW+PJP?=
 =?us-ascii?Q?517D1iWnPHla5TE/2lPPgzV8yXPLVtqgkMFgM8Mk3wS0AzBx/kKF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba2dbb6-bcf5-4460-b021-08dedc16efc1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:00:20.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUBAxgcthQ2KrYU/Hx+DAkkovprGq7VXDzmLvXYye0Bef3gSh20Q28P+B4Zf+iXGYrtVYCiMZDOYrkNCZqbpJmv/CEKDD05eAkm3+gNTVGazwOgvbCpQnWzMq6M4TG62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12195

From: Luke Wang <ziniu.wang_1@nxp.com>

This series fixes several suspend/resume issues in the sdhci-esdhc-imx
driver, primarily affecting SDIO devices (e.g., WiFi).

Issues fixed:
- Tuning delay values not saved/restored for out-of-band wakeup devices
- DLL override lost after resume for DDR modes
- Pinctrl not restored before DDR_EN is set, causing CRC errors
- Unhandled interrupt during resume causing "nobody cared" warning
- Various error handling issues in suspend/resume paths

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
 1 file changed, 57 insertions(+), 27 deletions(-)

-- 
2.34.1

