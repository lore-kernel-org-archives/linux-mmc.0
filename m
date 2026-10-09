Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7D33DEC0;
	Fri,  9 Oct 2026 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512116; cv=fail; b=UX8HHq88BTusfLf//8IqjU6N3upftWHEh7kt8vKPRDxw144+m0jAH8DGVzH+Ebx21FHRQG1D0YElJQ8zbDIs4lYNQ44bPQ1X4bSyKkRbhP+muU5dXfkf6OnfiaF7PGnnQDtiNub2TgWrCFt30PsMU7C3KY0ZoiOyzk6qVAtjEeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512116; c=relaxed/simple;
	bh=JOoo40r6TGah1gfOm9d53lriuE29ROqhAqh5LoNLt/E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rwfXpS0rDMdZQjFbJGj4LKj2uYs61c6HL8RooQqzPE3csqz+y5F3pukv2KXr+IubbQEqP+EuOIp6hYWTamw23rtowYWTcgsWdljXxmWsTMx4ZGSZJgGeCiUoV2vZO2A85qh4qsb4b4NMnu+ZYNVjklTUJN083tdzBlvP+ha0dHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jZz/t1k9; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="jZz/t1k9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHBEzFMaW3Ne/+fVnE27IYacjNAYlsnv7ko9uUnxWVErY2ONUKafPbCSVUZbX3oU64XnYEkg4/+jFlBQQSKaRyvKmxRxou6mRDjxuIV332mOFEbvZB8Y9A06kiVLepiAe4Alt2MXwS0z2KedBB6v3p/sYNsI063DDu6BjD7xk2VPbK8w/hUNAu6AGHgVjqFECe4Nz74hQtal/aCyNwccslwlxpHHJTHY+RsN7rrIA4UUKtbOAxe58iyy00cr2PsrkAblYtj/JhHOg/5n8b6QVnCdTRwn8v3hgB2SH3p9BLA291bV6uCOl7xVsJWvtd2ufBm0P62dGRWnsymcY2yLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yqC6yM3IKjk0X8YMziODF6It0pjNC9cFodKX+JE+YY=;
 b=KT80KjHwki3tX/Kl9AzJQhIBJ6cay/K9QWJpnmKRMkShy5eVYBe5R0CuIdOdKX575OTmrTVJruPuCqFrLoCIwTwaZxAxHXXrjmpbP7n6oJ5z9brcpCutWjL7JZqoXxgdzkpS/brszJOVKI5tMJvfycTFI8PMKtIeiw3AdOA+9cmDxWAgf9UyH+z3VGxwvR9PvtMWeBzW1Tcx9GA/LrKiAgpPaKg5YKPw3YuVIqi7sOJXKiZujeF7Vtl4Iu0Y2zGqBFtk3ljR5k5gKi4CwP05hRHPgbV09+SJK5nZI+bk9gMBI+MzpSLZqungmD3wWbcAmKkFiSnON0ofirZmDLhexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yqC6yM3IKjk0X8YMziODF6It0pjNC9cFodKX+JE+YY=;
 b=jZz/t1k999KdGyPN3WyArv0Fm1VPEzapxbpF4Q7vzcg1/IXKivyUCcy+miC4b84/Cjq7V+f5SeH9BUPWWmu4tKgcx6WLfmjiGblUOMPY+HkJngXCowXlphIIWI1VRfF6zCTfCY7qwmtg2I5AyuuiH9SZdCW2iH7k6QOMwWe3PT88I9rP7EInyiavXZUHN79xh8TkPGe+S2bbhMa5b6iEp84V9dhKROzVyLOGmZ6Tcr1l7wlS6m1pt8LB8fVD3QMUCkgn7bakEnrA7dyq0nO1eGolrtqMAu4IT4C8LItk2dzYRjrdIopdaSANMWaVkNMM6n9VfpFD/bjL2qgc1hcUag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA3PR03MB8407.namprd03.prod.outlook.com (2603:10b6:208:540::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 02:15:08 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 02:15:08 +0000
From: tze.yee.ng@altera.com
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] mmc: sdhci-cadence6: read SD6HC DDR50 tuning from device tree
Date: Fri,  9 Oct 2026 10:14:51 +0800
Message-ID: <295b570ed26d727c4bd4ce943b723c6cc959ca71.1791459448.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1791459448.git.tze.yee.ng@altera.com>
References: <cover.1791459448.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA3PR03MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: e4911cec-a719-4ce0-d7a0-08df25ab2395
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|22082099003|18002099003|55112099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ri8M7nU5xhstTGt16FCMHmrNTXjTH1BzHnC8n33SxH7IryvRacpyoeznlU8hBJPD2Aconv/JavMXKR7YWIqrq+XoIA5nDeo+c98hPuGGMJpq/41mogqMJ5PKLEXZ3WiXbyrDCxJr/IxWkHTa5P0Pdm+mh4cCpCvhz/8iB6KyuwQfuLH4N7o2Jl8Ekm9Z8mW/QD2VMwOL+IUSHRGGDPN38P/cRWqRHpJIcGN1L3On16lpwasPhTS+V06chzeuC2iPibdoRZwnaIO4qNnvSXXp+fifnd34NIDealGLfZzx77A2aOYONN7vqgzvXbZcplOW+NTaNdH3zYyRFpzvOY5tffOXM7MecZuKrIixRwWqFc6AO95W25f7Hh5NpituAN5il/Um+c3CjK1yWgG3osMq/ZhB2dio3/k6aKzYmJaFc7DdlXsoWW28wAl38cQoVPqAjEW+Yhgd1Fu8Msr/njfibEmqjtOeXdiPMmDpI2hiTq3gi6/1pz0jeSXxdhbGVpNmjOLWiCcpMhjNUq2zRmcO3uHqpx27k3sR/Budx5OPawz58New1ZREANMRhr5FdF5wJyqThahlLk19UGoTuszVJsu5y9R0K5JFCQLemmd6tMPItQmgnncRVFjkc0FETmfxL5KHMaNYt+U5w6541UqsZ3uMPPiJhqyszFOia8QqzHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h9ELRgdRFXi/aieNoNR6nPVXgXExcJudAvKLjNUdD0BUF9dZFkGcZm4kl205?=
 =?us-ascii?Q?PTn4VD5hHYthzU6qiXJ94Hm8rXRL+RsDJaewhQGtCCv4qRZifqmCwZ0VIonD?=
 =?us-ascii?Q?2eeZegyFOtaUlR6jgheuysyYggcUajryY+51ZZyBHC8PJLcwomzk0TvGCYVw?=
 =?us-ascii?Q?W1ADYvQMLhpBXQRfA1g3+kA7Q1hqLFJ+hIx38HyKLbGkRZysP4DeGwBP3xRl?=
 =?us-ascii?Q?7TvToDDUQKTlBnsXAaWZqhJxFaCZTikJnNYdBjFDtNtvQ0gt3C4Fu0hKCjG2?=
 =?us-ascii?Q?VRvtTHOmNSSpqPhJa/U/pFZTA0FyxzUK6J1yXab4eN4nbGKzPRHfn8i27/JE?=
 =?us-ascii?Q?xlbzJM+fu1NhRh7oqBA3tCaLtRlhl20WYpmocdG/J7hPk2SpqvN4o56yCXgf?=
 =?us-ascii?Q?hjC5HURSozQcL7cKlBubNHWlJgZ4qLl2lBLcFxSoiGNrfiP8AZuQjaYCtQBX?=
 =?us-ascii?Q?xtrUSetDLWkD16Dd85wBno5elKcXpshuBwohGUr0n9DEPkx8WRPl+oIsXtNh?=
 =?us-ascii?Q?eMQuxHa2iBP7ff/J2rwT+PcAsXOFFhbNfeXrz7a1am2gdoxbBNIb/tNCW7XE?=
 =?us-ascii?Q?se2HACsCOaZEWt1glsdeDL79SfQz88hrMvZHuB7reyybNYOQZEIYNmPeIUCH?=
 =?us-ascii?Q?Rk+yz/qrltyZ8JiYL2uMclu6Iocn/K2aKmaa4787xl6RR8cX3xjCbf15glOz?=
 =?us-ascii?Q?ROSBE8L1pEthNnJXMY6Ei6Pano5b0ZzpIInimS5MP0D+bRKH/75+tJ6FjQ/7?=
 =?us-ascii?Q?THZYEIHTpgsXvmwQOuXRCY1IFug3PZJ9+dGo/lcNpegJVZ1Wtz3HPijiZsKu?=
 =?us-ascii?Q?bjwg7zVM3ExQRvw/MJvmc/rT3JD/rDwqHWnI8YjO8x0pGK5qpbbVZTAWp39p?=
 =?us-ascii?Q?cOctU3BGzLb/NTzyhCGIl53VW2FkyPuqczNFWxvYBdD0hDhey3pEYatAQhFT?=
 =?us-ascii?Q?8Cpo1IJPIYj6fOcN4x96NHSuYZeKl7O1N3nOTMBwO30/Fwq8uO28wGxsoWwS?=
 =?us-ascii?Q?QzYk/AO3ksBgbcRip1qRTqNN5j/WvHgHSduGzOhp95ODY8Gx3AwKMf6pTl7r?=
 =?us-ascii?Q?52WoXnEwFzjsstapnaNBx87STpAzhN2l2lLubcb1Sqsa62TMWHgHoxfwopBw?=
 =?us-ascii?Q?Blw63mBpy8m3YSIo5oyeUGnS6g5BV5XetD+R36TKKsTlbb0KYvDxKkpNhU0S?=
 =?us-ascii?Q?JEUhgOuNBTPYEzmrLjuxlPan03xtT4f0qf9pR3N16CG2RecSpfceddNlv3vm?=
 =?us-ascii?Q?Bcdnn6PGW/l098TVjqFBDzJOvg5g+uZLVwyr+8LnnDt61Ez3im7SuUED0X5u?=
 =?us-ascii?Q?xTKeW1UfRZt2kwj75ejqBa53h7vcVUOTY736eheGZrkx8oZke64guGKleEVf?=
 =?us-ascii?Q?3PNmRFaGfQr+BSYVzfQTIaKqEOz3WoYvYr9W0CcmfCjZZKMkhOjrrZ7wG/xi?=
 =?us-ascii?Q?UQWNxCVOwNsjOnoRhiMO8sLqsv7Jt3AT0Ls9RTXVV/dNsRAZqywGKim+2WTy?=
 =?us-ascii?Q?VfL37AvwdmxY9BaaH4JvuVvpV/MD0BYQfCR70+cd5+HB2KefXV939Gd5cBKU?=
 =?us-ascii?Q?o8a26COfl8bbAhmIle8kZ+XNT7j7R0UurGuAlF4MtQcCor379ApTeeNzLgEX?=
 =?us-ascii?Q?3tJK5fC+rYSM5MbfLQKu1EUAxokHIGfGRkEqJ3qJ6p30T7M97Dp1qWXD4/h4?=
 =?us-ascii?Q?fboMf8rg1o3SLkJ/eNIa4fUw6Km4CdAFQVqPaoSzMiXETOqLbhMmlxfZJKQu?=
 =?us-ascii?Q?0x4BRH3/Yg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4911cec-a719-4ce0-d7a0-08df25ab2395
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 02:15:07.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As5MFfIa9vFt7cHc+UmqkECHW5Bkl5/nAIEMV+9dOHa/UfEMPQpeDX2VIX7rgAGQF/aW5zhRDVRV1emTbGUL1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8407

From: Tze Yee Ng <tze.yee.ng@altera.com>

DDR50 has no CMD19 tuning, so the SD6HC read path relies on static PHY
settings that need board/SoC characterisation. Read the read-DQS delay,
read-DQS source and phony DQS assertion timing from the new
cdns,ddr-read-dqs-delay-ps, cdns,ddr-no-lpbk-dqs and
cdns,ddr-phony-dqs-timing DT properties at PHY probe and apply them in
the extended-read DDR modes (DDR50 and DDR52). The read-DQS delay is
given in picoseconds and converted to delay elements with
cdns,delay-element-ps; since that quotient depends on the element size,
it is clamped to the 8-bit PHY field maximum (255) to avoid wrap-around.

Loopback DQS is the recommended read-capture path and stays the default;
cdns,ddr-no-lpbk-dqs lets a board fall back to the fabricated phony DQS.
When a property is absent the driver-computed value is kept - for the
phony DQS timing, the value derived from the RE# pulse width
(REBAR_PULSE_CYCLES-1).

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- Updated patch title to "mmc: sdhci-cadence6:" since it touches only the
  v6 PHY.
- Renamed the properties to cdns,ddr-*.
- Read cdns,ddr-read-dqs-delay-ps in ps and convert it to delay elements 
  (dividing by cdns,delay-element-ps), clamping that quotient to the 8-bit
  PHY field. (Krzysztof Kozlowski)
- Read cdns,ddr-no-lpbk-dqs via of_property_read_bool(). (Krzysztof Kozlowski)
- Dropped the v1 per-property range checks and redundant FIELD_MAX() write
  masks. (Adrian Hunter)
- Apply the overrides in both DDR50 and DDR52.
---
 drivers/mmc/host/sdhci-cadence-phy-v6.c | 59 ++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
index 8d6a9c26c139..2b1b7256731a 100644
--- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -129,6 +129,11 @@ struct sdhci_cdns6_phy {
 	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
 	u32 delay_element;
 
+	/* DDR read-path overrides (SoC-specific) */
+	u32 ddr_read_dqs_delay_ps;
+	bool ddr_no_lpbk_dqs;
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
@@ -523,6 +529,16 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 	if (phy->mode == MMC_TIMING_MMC_HS200)
 		phy->cp_read_dqs_delay = phy->hs200_tune_val;
 
+	if ((phy->mode == MMC_TIMING_UHS_DDR50 ||
+	     phy->mode == MMC_TIMING_MMC_DDR52) && phy->ddr_read_dqs_delay_ps) {
+		u32 steps = phy->ddr_read_dqs_delay_ps / phy->delay_element_org;
+		u32 max_steps = FIELD_MAX(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY);
+
+		phy->cp_read_dqs_delay = min_t(u32, steps, max_steps);
+	}
+
+	phy->cp_use_lpbk_dqs = 1;
+
 	if (phy->sdhc_extended_rd_mode &&
 	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
 	     phy->mode == MMC_TIMING_MMC_DDR52))
@@ -530,6 +546,23 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 	else
 		phy->cp_phony_dqs_timing = 0;
 
+	/*
+	 * Loopback DQS is the recommended read-capture path; allow boards that
+	 * need the fabricated phony DQS instead to opt out in the DDR modes.
+	 */
+	if ((phy->mode == MMC_TIMING_UHS_DDR50 ||
+	     phy->mode == MMC_TIMING_MMC_DDR52) && phy->ddr_no_lpbk_dqs)
+		phy->cp_use_lpbk_dqs = 0;
+
+	/*
+	 * The computed phony DQS timing above is derived from the RE# pulse
+	 * width. Allow a DT override for boards whose flight time shifts the
+	 * returning DDR data relative to the fabricated strobe.
+	 */
+	if ((phy->mode == MMC_TIMING_UHS_DDR50 ||
+	     phy->mode == MMC_TIMING_MMC_DDR52) && phy->ddr_phony_dqs_timing >= 0)
+		phy->cp_phony_dqs_timing = phy->ddr_phony_dqs_timing;
+
 	if (strobe_dat) {
 		/* dqs loopback input via IO cell */
 		hcsdclkadj += phy->iocell_input_delay;
@@ -693,10 +726,11 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
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
@@ -878,6 +912,7 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_cdns6_phy *phy;
 	unsigned long val;
+	u32 prop;
 	int ret;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
@@ -916,6 +951,28 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
 
 	phy->delay_element_org = phy->delay_element;
 
+	/*
+	 * Optional read-path tuning for the extended-read DDR modes (SD DDR50,
+	 * eMMC DDR52).
+	 */
+	phy->ddr_read_dqs_delay_ps = 0;
+	of_property_read_u32(dev->of_node, "cdns,ddr-read-dqs-delay-ps",
+			     &phy->ddr_read_dqs_delay_ps);
+	if (phy->ddr_read_dqs_delay_ps / phy->delay_element_org >
+	    FIELD_MAX(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY))
+		dev_warn(dev,
+			 "cdns,ddr-read-dqs-delay-ps %u too large, clamping to %lu elements\n",
+			 phy->ddr_read_dqs_delay_ps,
+			 (unsigned long)FIELD_MAX(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY));
+
+	phy->ddr_no_lpbk_dqs = of_property_read_bool(dev->of_node,
+						     "cdns,ddr-no-lpbk-dqs");
+
+	phy->ddr_phony_dqs_timing = -1;
+	if (!of_property_read_u32(dev->of_node, "cdns,ddr-phony-dqs-timing",
+				  &prop))
+		phy->ddr_phony_dqs_timing = prop;
+
 	priv->phy = phy;
 
 	return 0;
-- 
2.43.7

