Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89C53A3BB;
	Tue, 22 Sep 2026 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075583; cv=fail; b=UhnQsEpTO6SG7tgqU+2wFvRoxRbJEJLVk1IQVJQc2E5c4nbN71yAu3s/GuFezeUE8MTEGwZ1W9khPqE6CBZa4BgdXOEGbH7xd9ibgRhOMsfoD0DZxjA5H7jG7PdqHKzQJjF+/0aKQqAWI4oD5K7OrAawsANVKOPbbdyHBFcpIXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075583; c=relaxed/simple;
	bh=4qd7mhr6jWkhZfxGUG2/McEDHM1V/GqS8nY9o/+NdjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AzNzqv/ihkRBHxwy5pmfqcGjXanR1CB/nWzAszcDKbpoUwIDv9MbYzBC3vRm6rLNa2XayF8ZBj0qKU94uCDu888Kp4jz2Au5X3eyFAGMJgxlptcW4sL/fPvKHcNM5Ni/REZpykJPIzOfaiApBoluuxcdPFFV13ePgBRMBrA3Nvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cTVnSY7E; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cTVnSY7E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltQGpCXc+jbwLtAaBi8Ua5cH5uFbx2V1P/S8hWV4wsHb5fi1P620zO9jaH9l3CaBMiV7fcREIsSx7Q0ac7o/hE5jczid9XsYDZlOjYlNh6ccKlgGIzwVA7FCMg1o168bab+82NHcOINaM7sYNNSGpKDc4XkimOoXQgctYwZGGoHiUTZYM7uz/i+WSwXC9wfeTZGypFONfsZZAAO0NtFpmKTreHvpYC6dvPV+jh8SqkYhFuQEVI+nv06SaVQg3BCfqki2INGCeSPGekbiEh5nmvcsfUvTmJIW0eAe96bCq1IMgKCLKFJ2tX2bYmQlojvHA/0rz4BeZn+hafldNOqvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yFt1C6I7ebI00gmcC4SrpkOFf2dLqBDfRZCR+m6PEw=;
 b=gHOa0sd3ZzVzQ78VY6VbojfD1lYwC6WOO5DZncuZK+W/ObPnKkjSlOa7a3Srfmp5CIcdzBMR3FAsXokxQ+tfdTYOzEbxplxN8chk8zBu9SNopYQw6CYf3o+r+BG2CcyHyMd01ErTEHBlg1oEFJQexe653DB/0Qh9BhvULTekqkldivtu4f946j1jYsIAWDgBBtopjnA8ePoxyQBE1qws9Wd07ODctH7Tp9KDkK9kY9PsxTuU2XSOQV7Wr8Ei8Nyqw1RZHaMk9demVsyOv9AU5Ia5EA49PwcHN3uTN/BdHHVcoaFO8bulA/+yZv4r5aBI0EK+C8thHGMWeEjgKpUotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yFt1C6I7ebI00gmcC4SrpkOFf2dLqBDfRZCR+m6PEw=;
 b=cTVnSY7EYrHt0m4IjLlHVxJ6oiPKq1hp36JyO+fkn1HUY3t249MoeMBjVnEvr8kHtg08D9YlGmt8zpkk/q8yPim9CTwgLzuWuRVH0RXLYSuk2dro83x8ip3HDRwLX5+w9TLdQuYPA5mEPJMF0GluHU13+sevjc3/jGMDMzupEwOeRHHmLr3bOCLSKQLwm13pCczmdELsMrUYL+4kcHpS/bjPw549CD/Atw2TZISdAa9sIUG/3EXtEwT+EPJe5zNezGTge+mxNYtNPwM7ko+7wxRZbfDHsTKaXcf7f8ZnEZQgDzT3Yldb4iDN5KBw5gxUjclaDCGOa3xyju9VBoGqZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB989354.namprd03.prod.outlook.com (2603:10b6:510:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 11:13:00 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:13:00 +0000
From: tze.yee.ng@altera.com
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 4/4] mmc: sdhci-cadence: read SD6HC DDR50 tuning from device tree
Date: Tue, 22 Sep 2026 19:12:38 +0800
Message-ID: <9440b973966df50c9f6c79055ec83ef3b634335a.1790074790.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1790074790.git.tze.yee.ng@altera.com>
References: <cover.1790074790.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB989354:EE_
X-MS-Office365-Filtering-Correlation-Id: c020f133-81a4-49d1-9b1e-08df189a765a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|3023799007|11063799006|10067099003|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8xM8nsz61EuPuf/+kFdh7Q7gM/HNFPUZya8ivB0r3h6usy4QhdHSmyGkA18k/aSXzftkiQ/vvKjV6WzxsjP80OYul0RnWDyOnjPPcpqtLpjk/inMyE0BpYBjAiFeb7X5ioj++3+Xehipg5eYdIn4uEOEGCcb6zs0gdVpGVVyFdhFH5RHC8QDeIiCLnTkxDXCy2JWQDY8SL7EHfcb0iHjdGscbHCDOYR5vpZqdlKGGRnos3Fx7MKZH9PLkoIXj/T5b3yOhC6CNOdsm9wjYL/aW410jNX11CUMmkKAfsUOyX114+pIk1cZFco7CYpU+HWJadSbS9zz1tDRVbp6ykbdomsNqRvBEb/aTUhPYAJgGsheFKUSvt2gdtpkh7WCkM0/CduUYPSJYGtxxd/VAFSmxS07F2U27/luF7RBWmxS3QMrA9I229greR6zFhPNd0KLs9SKGsgRzcifY6UXhy+1ImDqkfoA1riSURi+dWxvncB/2naQBeoL3TNisVAiHcZIw7hdmlZsqjh9pXBwhODgblMRGTEVkgSTvl1pHqX+bjo+jRvMzbePG4UBaiE1ATUkd1hWs6laVT9TSyS+IsGhozE6/aB/gxFzS+NvjUMq+VvUQPakbmJZ8QtK9WKH64gskeWrQX1tVPNmxjQ89LERDlBJWaHfAiyM3dH4J0guL1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(3023799007)(11063799006)(10067099003)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qTBGnUWpPYXj/Kv42umVBxmVpReE5wW5Er/KiAZNhLgQajUqVnftLnI0d1dD?=
 =?us-ascii?Q?c1C5z4K82GR1QuqwMlSa1NfE3tKC7UXP9POFzX1chtNMpWUpIeLhhfFuy0aC?=
 =?us-ascii?Q?ufsz3ILWld6uO/X751sECyiZcQtAFc1quBupVSHh9IxInEEZdr4a0iumgbJ+?=
 =?us-ascii?Q?1fsz3wx+kAQxMzoCke0WV39mUK96LfzjPANKLuUNJiVPrXwMOzsGPW4gG0UE?=
 =?us-ascii?Q?FFOET1W1WTLpeRgpHr4bzeiTkqfz404Xu65+c6gJYbrFyClLGQFClICIAg7n?=
 =?us-ascii?Q?SDcWeDvmDw9Ws1gYOe2f6pZ1zw7FsNm6s6+g2XFoMEBoLSNnufOz3vmREjJQ?=
 =?us-ascii?Q?jrd90x3Uu5TBUK2Rvg1+c6MWa4d+HPQCCiswXbA8kPP2ufJwTl2Q01TV3W+Z?=
 =?us-ascii?Q?QJq21MO4EsQdrkBOSJtbe0IzF7pjGYGOyIoIhrIOxj8xVFFP39nKDFF+mAyL?=
 =?us-ascii?Q?KN5SeT1NpWtxXTt8RBEVQDTHNawvtCUlQO3s56obQg5JoeK3pGY6skmfz1fO?=
 =?us-ascii?Q?ufHhihX2rdzvs8y+beHqvXSdvq/ymyVnBD6R9sm8iBluxouSrLpCdHdq5EjO?=
 =?us-ascii?Q?iQHPvc32tjO+R6Z1uS4JtTVRiYH3q7lMFoAsLY5h+vS+qCACtlQpxq8RY3+K?=
 =?us-ascii?Q?M4oEn1bbnWNLHVY4WS+HqhJSZtFKVcmx5dcXg5hZP2sqQhh8MW284VZv2DTu?=
 =?us-ascii?Q?6zjWqYLA9qHFlNHdKl/8K75AWYBe6WmBeH4C2wyr5P4hPtgGpQVKMuCuQgIA?=
 =?us-ascii?Q?4B/N0p24JeJfM8bAKlHaKYzzEug7ONjFQqMP3dcwaCA8CKICzWfqYvkcPuDh?=
 =?us-ascii?Q?hFLGe5EWcjisyv4mzcWtLgQ/6JNQGZOUvdkIXne2wRx+0CgfQ5DlWGsspcII?=
 =?us-ascii?Q?w4ZuF8lUcr04yGB8Td4GeW3DnWGLzUXoNzo/wpO48CHThvv4iGWNdUlEQoPm?=
 =?us-ascii?Q?laup9huxLWkEnJYFdMSqwptDlC12gsjZ/kPBywNtoJTPOiiPzN9CzCp/0fdK?=
 =?us-ascii?Q?xmpn07P5zf03sOp74X2Rpcj3ksgwTZ6yUETW5WCCCDPEX3xwPJPoZQ+Yc4uc?=
 =?us-ascii?Q?5R23FnUfqIthu+3c+21csMVQuGJyhKarSb/od+K9TjSS0PBW3u/LkR6FOiYj?=
 =?us-ascii?Q?A3sZ80z9K9L8tb6eHIrvs1WqjHduw+/7NixpUCNZz2he4I5bNbhEHeePUIdR?=
 =?us-ascii?Q?pvauA4TvEuPoMwIEoorXQXWmDB3yBOXExgVTX9i7et0KIlcumG7W1GGLKvL6?=
 =?us-ascii?Q?D67b9qTDOZgdnuqL3+qtOt+NANk7eeq8rHaY/frFVs5YAnkFJaQ8G9F43p0k?=
 =?us-ascii?Q?1bfWlsz+4mTiJPwvQl5iw389qZFQVOpuxoF13FUFyi87xSEGVpu8SAP2FIBh?=
 =?us-ascii?Q?q1RtfA0f4/GeZUh4JPb2AYjghHdvh8xA3HSuamdiaVs6niJISRCQK69JWbsW?=
 =?us-ascii?Q?+llJQGylgtwkDMoE75Wm+ZlJbJKwIuIpleuBzmtat4SEdHrSbKOJgwOzWOAf?=
 =?us-ascii?Q?xEX00bI/454PpVs4SrLOzzfoxK+1JCdK8MdJYTGrBxAFyQwd/7KbKiTVY/Oz?=
 =?us-ascii?Q?0djTzm1FIT96E+X9cLdhQ8AdhGWoySEMf7YTFVkCdXhP6riyh4SBjbSy4Vcq?=
 =?us-ascii?Q?l90wlbKO4PnJ8eI3FjIEd6YEulhqy8LYI3HGmpJpEsfuD3/pxLrHAMnc+NBs?=
 =?us-ascii?Q?cV+RJyEV6S9tz3Jfl1ej0HTKLm/FeX/fSh0IrGkK2Qop1ilI0+lcHbFWz+7a?=
 =?us-ascii?Q?KfVICsmgBw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c020f133-81a4-49d1-9b1e-08df189a765a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:13:00.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F466QIkC/hKi9yTc5djHPrCQIATrzTR4m/lWxSA/kWlYMPF3wOoG+gbJGdr5O6bGylPWpevtFZkJJFcU0osDXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989354

From: Tze Yee Ng <tze.yee.ng@altera.com>

DDR50 has no CMD19 tuning, so the SD6HC read path relies on static PHY
settings that need board/SoC characterisation. Read the read-DQS delay,
read-DQS source and phony DQS assertion timing from the new
cdns,ddr50-read-dqs-delay, cdns,ddr50-use-lpbk-dqs and
cdns,ddr50-phony-dqs-timing DT properties at PHY probe, range-check them,
and apply them only in DDR50. When a property is absent the existing
driver default is kept - for the phony DQS timing, the derived
REBAR_PULSE_CYCLES-1.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/mmc/host/sdhci-cadence-phy-v6.c | 72 ++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
index 84592ae42762..0f47fa62d894 100644
--- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -129,6 +129,11 @@ struct sdhci_cdns6_phy {
 	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
 	u32 delay_element;
 
+	/* DDR read-path overrides (SoC-specific) */
+	s32 ddr_read_dqs_delay;
+	s32 ddr_use_lpbk_dqs;
+	s32 ddr_phony_dqs_timing;
+
 	/* PHY_DLL_SLAVE_CTRL register fields */
 	u8 cp_read_dqs_cmd_delay;	/* bits [31:24] */
 	u8 cp_clk_wrdqs_delay;		/* bits [23:16] */
@@ -145,6 +150,7 @@ struct sdhci_cdns6_phy {
 	/* PHY_DQS_TIMING register fields */
 	bool cp_use_phony_dqs;		/* bit [20] */
 	bool cp_use_phony_dqs_cmd;	/* bit [19] */
+	bool cp_use_lpbk_dqs;		/* bit [21] */
 
 	/* PHY_CTRL register fields */
 	u32 cp_phony_dqs_timing;
@@ -523,6 +529,12 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 	if (phy->mode == MMC_TIMING_MMC_HS200)
 		phy->cp_read_dqs_delay = phy->hs200_tune_val;
 
+	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_read_dqs_delay >= 0)
+		phy->cp_read_dqs_delay = phy->ddr_read_dqs_delay &
+			SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY;
+
+	phy->cp_use_lpbk_dqs = 1;
+
 	if (phy->sdhc_extended_rd_mode &&
 	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
 	     phy->mode == MMC_TIMING_MMC_DDR52))
@@ -530,6 +542,18 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 	else
 		phy->cp_phony_dqs_timing = 0;
 
+	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_use_lpbk_dqs >= 0)
+		phy->cp_use_lpbk_dqs = phy->ddr_use_lpbk_dqs &
+			FIELD_MAX(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS);
+
+	/*
+	 * The phony DQS timing derived above depends on the board's SD flight
+	 * time, so allow a DT override to re-position the fabricated strobe.
+	 */
+	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_phony_dqs_timing >= 0)
+		phy->cp_phony_dqs_timing = phy->ddr_phony_dqs_timing &
+			FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING);
+
 	if (strobe_dat) {
 		/* dqs loopback input via IO cell */
 		hcsdclkadj += phy->iocell_input_delay;
@@ -693,10 +717,11 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
 	sdhci_cdns6_dll_reset(priv, true);
 
 	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
+	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
 	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
 	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
 	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
-	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS, phy->cp_use_lpbk_dqs);
 	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy->cp_use_phony_dqs);
 	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, phy->cp_use_phony_dqs_cmd);
 	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
@@ -881,6 +906,7 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_cdns6_phy *phy;
 	unsigned long val;
+	u32 prop;
 	int ret;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
@@ -919,6 +945,50 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
 
 	phy->delay_element_org = phy->delay_element;
 
+	/*
+	 * Optional DDR50 read-path tuning. These are board/card-characterised
+	 * values with no CMD19 tuning in DDR50; absence keeps the driver
+	 * default (-1 => not overridden).
+	 */
+	phy->ddr_read_dqs_delay = -1;
+	if (!of_property_read_u32(dev->of_node, "cdns,ddr50-read-dqs-delay",
+				  &prop)) {
+		if (prop > SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY) {
+			dev_warn(dev,
+				 "cdns,ddr50-read-dqs-delay %u out of range, clamping to %lu\n",
+				 prop,
+				 (unsigned long)SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY);
+			prop = SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY;
+		}
+		phy->ddr_read_dqs_delay = prop;
+	}
+
+	phy->ddr_use_lpbk_dqs = -1;
+	if (!of_property_read_u32(dev->of_node, "cdns,ddr50-use-lpbk-dqs",
+				  &prop)) {
+		if (prop > FIELD_MAX(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS)) {
+			dev_warn(dev,
+				 "cdns,ddr50-use-lpbk-dqs %u out of range, clamping to %lu\n",
+				 prop,
+				 (unsigned long)FIELD_MAX(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS));
+			prop = FIELD_MAX(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS);
+		}
+		phy->ddr_use_lpbk_dqs = prop;
+	}
+
+	phy->ddr_phony_dqs_timing = -1;
+	if (!of_property_read_u32(dev->of_node, "cdns,ddr50-phony-dqs-timing",
+				  &prop)) {
+		if (prop > FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING)) {
+			dev_warn(dev,
+				 "cdns,ddr50-phony-dqs-timing %u out of range, clamping to %lu\n",
+				 prop,
+				 (unsigned long)FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING));
+			prop = FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING);
+		}
+		phy->ddr_phony_dqs_timing = prop;
+	}
+
 	priv->phy = phy;
 
 	return 0;
-- 
2.43.7

