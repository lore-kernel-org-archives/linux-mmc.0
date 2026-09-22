Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90853A390;
	Tue, 22 Sep 2026 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075576; cv=fail; b=G0n1Am+Z8Qc5M9wglqDBuBy1y+U8aSdBNMIFUkwI82m55GyG5PJ9ZsHuMOizDHmP7nZ+IJgkieA10T/K9FEtSLK0VCYOsSlF1KcIBTwiCZqZn12GM+TvQjUq02i+mpNSvbywZdsqGHJw9Pbg8fX5Fl/KEDCujqYCIMZoEWD4YAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075576; c=relaxed/simple;
	bh=2xAYgWBRXwCnORyQWVfn0dwcxhPQ1LweOwU0CPqM1UM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEwOS4xBhCQZXeQN5DE0CIoeZiJIkAQdWjFt2FQnx8Zgdfz4UbtpvUvaK/V3vrcXPLyENcL+NHqNV0uWVY26oIGqvW/13WDARhJLdlUR75PYdJrh9AZYVs+YcUmuwlGtymqUQeI/LUElmGdb85MM31s/Iq2hWpy55Vep4VO98+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DyKwG+Sf; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DyKwG+Sf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKryGWaz1hm8rk/JQbb4sHDIv/ntQAVdh4R05pH6wh5DDiwpe3aLPkyE+EGte2lg0DR4gF+MMZRW/EudznloNISVb630sXqx5YSpBry/EHPWlM9ILRCRYmEUW5o4TEB+LLnpvh3Ag28NW9Y2gcWNkYuYkDxGKtRQZmR6q4ckiCge022Xj2iUhtWn1ZZrTOLy7knMTktEVXKR6/ngHBRSOTiGnu1AAIQRs/zoKGuJ7UzZ8Woxetu5o3fo6EKuDEK6Wfpac1V93eyVx14eckxQQ3Copb3MfEWy4KdUatOe9B1t75/cXG8dBL2tnUYvz0+ZfHGZIy+jC3sx1kbvfxD3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJXe+R76McSgZ87DKhs+XF3jZXlIl8nAilcmNCsG/CA=;
 b=evBuKU05a2/rR58vvkgcg/ycUHiJ9OVEPyG5N3x4W1bAi89QXLCuKYv7Jih/7uAFaZ5NpUD709k+is7YSo2uDBYTcV4H/Bc1+yLomobKRKawymtd4xjFDszP4Hn9FB+LTTk+MJJO223TGANixwDLOPqsh9imIFcPBsBkTqZKfVRro0IQ7psA0ddG3SJWEorljqLq/NTOqgSi70wVMnPjQbacd5dxtrX+Jm8RQ0T8HwNNogIEK0i2aMAMvuPfPvZX8mgmT7N3zc8h7kkvS33ZOxWAqjqBNreYhuKpVGZ/v8DykIo78okyJ5UUmXxTdA8DyFZfrLLtlso+2h7ZPUXmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJXe+R76McSgZ87DKhs+XF3jZXlIl8nAilcmNCsG/CA=;
 b=DyKwG+SfW+SvSriFnqbz5XQ/JXHhIUA/fbXZ+0evjQgY2Wxay0DkwNmGhUZ8umKAnSoMCklJUTB2VSclCMBWA7Ohb6iJlQENsc298DXYj29rxRenx+PNpmG0NXX5zB9FDs4dpLCqSMbDZ7MZz/gK1bi7cUPn/gf/pR8vpFTAnd3poCXSI0pj7W6CoBaM86ilSPnhCwBr1XSSxanrf+ZWyOBdBCrZsTuwOYzKWZa0H84NI9jGqfrphwdL+ENlc6323l9PN4uGaqH8eP6ec7UA7436jRE1WsKl/vU8qKGqIECXUlFobwOfSJ3sM4I5d4/FfTiqQol3SbYDLqV4Fa6yQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB989354.namprd03.prod.outlook.com (2603:10b6:510:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 11:12:53 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:12:53 +0000
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
Subject: [PATCH 2/4] mmc: sdhci-cadence6: program PHONY_DQS_TIMING for extended-read DDR
Date: Tue, 22 Sep 2026 19:12:36 +0800
Message-ID: <d89d11767f8f3ea073bd54b01ffbb9e700e7808e.1790074790.git.tze.yee.ng@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e9d9604-1526-4c5a-db9c-08df189a723f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|11063799006|10067099003|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HZp8AlWqSirInqkDyLXasojgeN9WoqthPY1jN5kk4nyZFQfvPHxiGSPAocnsSN4YsLNZ9j/KP7nyIS380Hxy3LonNjrBcxPN8nU8pKLdw2u4qgSXJDMJ1XJeSqWVgWmkaCnk36PNF24Zg23XFoAAefLG++TD6PKxHWj5b2IvCqkK0GMxOh8VYwlJyYmF0B+IH0VKAnXD6fTa+RijEwqH2iw38w/5t9W9DXMmGM/AmTqk4m9rH89OS2dJl7QuP5qP39T+IZsV2qyd2TENfaIvMsFLQGekhEuqARnDaXe652jVlLOtMBLkwsX10caIvVA4b+htQtjvrL1nn4ASDOrBEx4Bqw/ZqU0dglb/7Lk6F6Ka3irpg+JkV+KI/SMrhL1B1uCZ1lco2XdJSemAiXMJwLC7ixv8REieynJxfHCB3Nvh97cKf6h/g5Qn7D6ccsSvz1arcIY1UuWsPiw3vH3Auug323ROat5m9CX9N9Q8zDy8JMp6gJNQtjz4pRcbkW7/gjj7tf8/O+ERPOFa/Jv1upPuoJjXmjdd5HQq4dMqBPSi5BjesC1mWjlreihcZ71KC3cRO7forKECsf2sTUj2tTPHYBqEt35hpTm6aMRbOsuaafa0hvJ7mu+aht3wxliqd4n5nc8+3zaT7r7jWImBBwljgAqNyS+MHq8SStIzl3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(10067099003)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5pNbUEWep2n0uC8a/qWUmjVK18E6oYygyb4D6rtxp95kO13m+ZNyKMvxfkR0?=
 =?us-ascii?Q?MrgXDbBddOwGMjukZPWXe7jJrPwRiKfKoA4gUEf6yDB/pPgFv97jhtluqil2?=
 =?us-ascii?Q?RlE2TMFUri0/6+PpTaDlG0fHCz153r0ynaTYXSEgmzgwMekeafIBhExlNDgm?=
 =?us-ascii?Q?4/dD0bbdIY0LSUtDW+c7o4sPWo+3Tcd8UDyZTTtvRbKv+Xd2zxbKlUG3gxQh?=
 =?us-ascii?Q?yUnWfYiW9hjBc7tysJu/PKn63vfdAe+MbIe4UedM6eCF6tQIPvN74RWmXn2E?=
 =?us-ascii?Q?m1y7OdR29EPZsDZxeRNV0DavkPcirEztwOsaxr7Smhfv4eFmG/hh8At9y+pN?=
 =?us-ascii?Q?T0eEtJ1JOgroe1JStw7K9vMXkX1UCyGk4siHZW8gFeLMN7+irmV8ZU7OzPQN?=
 =?us-ascii?Q?8G59XuDhWN6QrwNE4ZZk9nX9NX4VnL+QgukR0hDQp90gPq1m/Q42GR0eRTQ1?=
 =?us-ascii?Q?pfU2QUvp7XsHORDDtvgouU+OSQLJNAzHgRtX0wzsAdzXgByLVSoUeCQEdEfc?=
 =?us-ascii?Q?i53QFPvpkMPLAmERfKnNkMkt87K4gyrxJCLOz/iq9NCazeBLTIehGmkeZTNc?=
 =?us-ascii?Q?TgIYYqiV+gNKPje2Hs3jur8ojOyAoyrVKX2cickanV9brB5DcTOnBcyDXVVb?=
 =?us-ascii?Q?gSL5rQIvF5HJPC8hH3K9UOTFttegV3c8xoNBxgwLqPGAIhSxnIHrTMldHwX/?=
 =?us-ascii?Q?9ndgNbsKk1slZp60g46fvZFlGJML8FeHWIRV3JwhWx/bwrfPJoStAR/xtg6W?=
 =?us-ascii?Q?Mz0WjSEdbFRUcjofQA0mHjk1E1G0mLbcrs6YO2c4gfzr6sGrrjM/8lal8XuR?=
 =?us-ascii?Q?8G4MRjrLmv1A2Jml7+nl4RHKACguSySukJoHotDG7XvtrTpw4t/zHyKsiNN7?=
 =?us-ascii?Q?zsTlrSO05E7CgguEwCntFoI7XTuZBzgv8HNCG84CTLiUvhFuKntA0D+32URj?=
 =?us-ascii?Q?JBn1roceIXbNtp4Po98fBMYps9XI3FJ5t4dVz0T5wMpj+Aw928IVzp3CXKgq?=
 =?us-ascii?Q?kK11kccd9dROJREZ3BL8CMUiW0lUuQlzE77XXhoNwnIt3808ilyqtYXFzPTa?=
 =?us-ascii?Q?0TmqP+Ct0q2vzV/cf6evQw8fzAJHm5I4bx33C2xrqxOa5wbKWp2Zl0FpH7CI?=
 =?us-ascii?Q?jNsV7YOB13lDy3phjLxVgM24qb3+bg3RBir+bHzIEmZ5go1w9/WkDBVVs8nl?=
 =?us-ascii?Q?akmK25tjmP0kTJ+lA1j9cqeusvvWbqT475lYbaV3qcx091gNVJl93k2z0DUP?=
 =?us-ascii?Q?Qqmqm/vjDxyLSzarpE9RMM10focZLFfw4m4ABXaAYD9o8CT+bm79EmnIUDCz?=
 =?us-ascii?Q?S3eFnAXlR3TmW6jUKFH/uH1Scb4Hv5eR/PBGAqUqecnvFnUPWwqxKpJDJv0X?=
 =?us-ascii?Q?AM4Hu6z5iJ4Xn9uPqKx4Me0yPnAbVtn/cdEfu4AUoEvOApz2m55jhKEiRjaf?=
 =?us-ascii?Q?Pd4x2zoyquUHwf4DGjqZBMDYCgv2EVqoXX0B0dtArltTw28LuoxC/uZQrMvD?=
 =?us-ascii?Q?RbI+y4UpjNgaKoCLPljMYb6zHFtrq6kIPma/ZuvMUaMhP+DtNZLhC2kb0vdz?=
 =?us-ascii?Q?Pz5ByHujXwpBd4dY0PnQSWCxY3M8dy2pYJJZFhX5BqaZKNT04X4WIBU1JJas?=
 =?us-ascii?Q?4wsd8PTbIe2FgN5Y0QLwCh+6XCS5d3gHP+5XKhf+SIv3oYAzM3O16ayLIH53?=
 =?us-ascii?Q?VgOz05qZmW0uL2m3smDQPxurVWh0Pk0l9f2fuojivofABSo5QFGPV5CiulHM?=
 =?us-ascii?Q?v5VTnZ5Dfg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9d9604-1526-4c5a-db9c-08df189a723f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:12:53.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3XC2TuGGokqy/V/OnthxQHpoqC38fQRaibvup1bPE319tpGAMsLtEotuu4PpQourwfkxPWXjR2U2h2Mfsk+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989354

From: Tze Yee Ng <tze.yee.ng@altera.com>

The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
pulse width in clk_phy cycles minus 1 in extended read mode, and 0
otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
(the silent odd/even edge-capture defect).

This controller's rebar pulse is a fixed 2 clk_phy cycles, so extended-
read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2
corrupts reads). Derive it from the extended-read-mode state and apply
it only in DDR modes, since SDR extended-read samples a single edge and
is unaffected. This is generic to any SD6HC-PHY SoC, so it is kept
separate from the per-SoC read-path tuning.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
index 35f35ef9c710..84592ae42762 100644
--- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -90,6 +90,9 @@
 #define SDHCI_CDNS6_PHY_CTRL_REG			0x2080
 #define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING			GENMASK(9, 4)
 
+/* Width of this controller's rebar (RE#) pulse in clk_phy cycles. */
+#define SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES	2
+
 /* Default PHY settings */
 #define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY		2500
 #define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT		24
@@ -143,6 +146,9 @@ struct sdhci_cdns6_phy {
 	bool cp_use_phony_dqs;		/* bit [20] */
 	bool cp_use_phony_dqs_cmd;	/* bit [19] */
 
+	/* PHY_CTRL register fields */
+	u32 cp_phony_dqs_timing;
+
 	/* HRS07 register - IO delay Information */
 	u8 sdhc_rw_compensate;		/* bits [20:16] */
 	u8 sdhc_idelay_val;		/* bits [4:0] */
@@ -517,6 +523,13 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 	if (phy->mode == MMC_TIMING_MMC_HS200)
 		phy->cp_read_dqs_delay = phy->hs200_tune_val;
 
+	if (phy->sdhc_extended_rd_mode &&
+	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
+	     phy->mode == MMC_TIMING_MMC_DDR52))
+		phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
+	else
+		phy->cp_phony_dqs_timing = 0;
+
 	if (strobe_dat) {
 		/* dqs loopback input via IO cell */
 		hcsdclkadj += phy->iocell_input_delay;
@@ -715,6 +728,8 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
 
 	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
 	reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING,
+			  phy->cp_phony_dqs_timing);
 	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG, reg);
 
 	/*
-- 
2.43.7

