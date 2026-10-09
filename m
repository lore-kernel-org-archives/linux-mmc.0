Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2863195FE;
	Fri,  9 Oct 2026 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512109; cv=fail; b=qCc8TRfMjGJJOvTvN326IyTx7bsUqOJweYolOuwCn5x1B+8FUGHpxuKCvU1zJMGnttZLqk5lK8znLrgqdaCq8RFyuI+jdO2kQsRWystV+XuR05BNxDLCbzWGqp12lufYLrTdD7jXTksYcHXlu3LzAmRst0sJ402wxRqmHrcqaxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512109; c=relaxed/simple;
	bh=38DK9sAbWHp6jm/sKMYTn7opyLiAcaEknUcfkFD1MxA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiLNOdIAe9IBzWy/jSkd8UhpwgDWBd3No55QsnvexBJpB4vqsu9tEnnhjB2EYX7sGbo7NI+KpR2AyAV8IWAykFybz1pNz5uyBxJ/NtVnl5IQXIq5U/PoEgSiD/McB/6UHFxgRia7WM4vlRkyLP/K0f53sJcXbPe6944AYCTno4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Q7PN81Aj; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Q7PN81Aj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVkWEeVnzie8r8/o6Hx+B2aPT2XpUDVHxK8YwDMfwHmoDozIWeZbKP7I0x1eECM6xyv1BOL9KSCl5a1rQVmJZ0rK4RiE/cu5xQpnXzLbTfKtPNzKVjNFJOoXkek9eLuSIod4TfZKezZAlk3aJGhwrtb6HenPqfWuFMkSFvPtEJATEo0bxmsM21OPnEQdkQ4Iq1n/qPg/1wGfcxqSyndneF/Af+EeskxKevSJIPOCntHR7oxjgBcW9EHmcrnKhRBz93L4Lk3+KuXGb8uOygHZ5YG3X7ZOZXIjt/GScDdvFLXqU/GAVccunqA70AFLA6wNN98d6w4UDIAL/0bQsvIApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak4JPDfxnrLsmzv+UfSArfDZaUyu3DYON6w9wLjkN/4=;
 b=JyX0LguoZ5YTVWtxBHbntITewwYyTbZ0yaEPdNkmkIEZh81ZQ1MniLpMbyHC3MPRFtR6Q6/2OeAj8GcQs24H9T0zfvQbMgrol+mOmaW2dTNluiJYXogoxFnDyUJSiSTEt1MNTQ796eGAb9d7mfu4Vni43AnWUMbZKI/Tf1ANjt31RuGXUpLKU3M9WZbFvqeAWse9Sa2km2AD7+p3janclJG8DJwAVUfanLtDj6AOjp020VH+8cp+prAVegHzsAddUI3tApXCzgcdFgNtn1TBGuda9BDgFITZBTa1zFKf9eOo9BUcDgkfomtAzK6TNKiRl8SDZSv3XUH+2WgYRuJF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak4JPDfxnrLsmzv+UfSArfDZaUyu3DYON6w9wLjkN/4=;
 b=Q7PN81AjM9Xc7UsnMfbYXnqWf4oafxCOk00XLO8y1o/TPvFAQV9r4/bHpfln+8ygKaj9NVEjmC0aFw4wFKulyqnb8xW4R4umKgJukCUQHNqkDh0GvSSv+2VLjOG/svR8pbHw+rzxy0HNGpcz9MJtMBKnMRSi/IiWq2SmB+xUoiLaFJ2DtEFFHwM+6N65u3j0UeSXBXbu+W4kOo1EtrpGBArDGwbyKoUVP/xi4MA+zgmeTa1nZbnJBIXO5ECcOD9j2vp8qwesjiXhsdNQyJtanMN6NVxxyXTzPPeixYP4DgwvVVMN5QK+aseybnuHMpPcKdHkFiHwsBMaJrMemEQeTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA1PR03MB8063.namprd03.prod.outlook.com (2603:10b6:208:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 02:15:02 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 02:15:02 +0000
From: tze.yee.ng@altera.com
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] mmc: sdhci-cadence6: program PHONY_DQS_TIMING for extended-read DDR
Date: Fri,  9 Oct 2026 10:14:49 +0800
Message-ID: <66f85b5d36dd8e644c6985b15c6111d5b263cadb.1791459448.git.tze.yee.ng@altera.com>
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA1PR03MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 66de7342-6e06-4f25-e59d-08df25ab208b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|56012099006|22082099003|55112099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QsoYqpQ62CV2gcJGkSBVpTDywpLJVCBDAYCAXCKHuD+IoDTfirjUXzLZ0lcUg9qCiGSLELJ8MxnM929s2QwLuwuyGHx7v7V+Z/IDUBLK0qSgVcy7tyQDpPnOSrpSOOEwVwpwkK4BwptMnjwavm5m5YMaGG7nnNTHdoi5/KLIH5MqE1UNarX1Z+onnsn17+Ho+794R3lppmX6iE6swep/tXdiGv0z14zybbFkaA6LM8i+LcAN0IfQb3fGHBA4PgpV7o+QPd83t2xobRzZWLjyRWOIKOdc5YABwL9FEsvEZgxUaq61Kuw6zUfCTK4AZ1EFYjPLUyT7FG5hKJsS1a1QPWcOBqG7CoWQ4MiveCJOcB/7eYV1ESNEbIcWav2soeZDlyQ5TH680D0oCARrgZ3le456niXXdA46dg1pneKyhFcZyviArJsJWG1BFHFInx9zwhTzHXn/C3iiBU7hCCqdOKR6dP/ZAYsYB369wAKzGrFgyKgrzEa8sR6oCdPI5Q3C7uElqnU/FIfuZcLdgE9lKTSr6XIrjWm4MPceZeVBUP7XxLIBiVQ8YDFcNwPkbVDGZ3vIssp6jYzkkY2SaaUrVTjZZZhsPBMf8af5KtDRHhO31pcsT0moN0RzGmdIclpDQshmEUznoiiVui9om7np4vWjoKXfmy478ZU9iYhQoew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(56012099006)(22082099003)(55112099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1wrtCnltzyHVqWkr1ihnV0LwoJRDOyAoAc7wODZLVMnP4dSp7kAgjywC2Dd?=
 =?us-ascii?Q?CIIcF+WaT+wV0T5rFCkuzglyI6MvPakCMwLi2xNmg0OtlLMyXvNOTHrjfiFa?=
 =?us-ascii?Q?USwJuD5INYZNn/VMOD+7DvbpmMAvyj8779t2ywAG8sqWNFS75ydCO2Q6hG/x?=
 =?us-ascii?Q?Qx8jS7g+7Odv2fmhZ3f9mHcuZTYllwh3ilRFGGpUzKfrxl0HqMug0IpTpLPA?=
 =?us-ascii?Q?HNTgJ0K0M9HCQ3MlalLkuRPEP90PqoAmVktHgWTGaM9p3VbE0dsbOxV3ZE1H?=
 =?us-ascii?Q?P/4czVfDnKquoWCm1paxWOAMdshKRdIkpgM08YymMEWRvUWKpAff+T3QTdm6?=
 =?us-ascii?Q?X7iuqCs3+0zWVvp6rCcB019EM2hrc+TZphN1GflFVko3Nvhhke6wB9YktJqj?=
 =?us-ascii?Q?xpj9HAvNsES5wZMn/98l9d5ZGooyL/Tdu6c2TDgw8BIEDIMGzgHjLjJpmeL7?=
 =?us-ascii?Q?gA4hTFtJiXtc6BKRO0mEIFkpxHXmxT5HDZs9t0BpAC3LoK4H7NdW+NDVjJPi?=
 =?us-ascii?Q?0mwO6APHfnnGsV65FnxqbgB066OVT46W1wTzKWZs1G4C6laEX3sNTNTbPA6g?=
 =?us-ascii?Q?ZJUGZHViAxDI2KOmKG1PAc261fqypuiQTve+rsLZjADSFJ/YtU/14yOm8JgS?=
 =?us-ascii?Q?oqCBxVDmu7ua2LounBKoQfuXmTI8YBfhB2rhi231snDkFTnANj8LwtGNi9j1?=
 =?us-ascii?Q?du7wrf7XOS6zE/NwdaxpoaFSVIb42UWdsMtdOMZAe+nhU+8Rx2z/6cV+Pl6l?=
 =?us-ascii?Q?jNgFZ7+YELzq4PvUoyK0//+QaNzlDJ1I7IFBzRAtMoxstJbg3kmvgDcNrRby?=
 =?us-ascii?Q?GwahwVW9Fh38lppNgbIDL4ZBf9ftXJOlSVPeXPkKlqjM+5ufELAb+v6RxWrf?=
 =?us-ascii?Q?eFdyWtu6K+CdM4QSsIQdAkk4qRViKADvC3SIxufZXa6dRqFJAO0catRQKJxI?=
 =?us-ascii?Q?p++p9hLxtu1zt6jS+upVNbU1yP55lteCJjEoYlef9XEULMfbla7JENw7kfGp?=
 =?us-ascii?Q?zZyB94Fn5T2mtv51OqTPXjRlA1+8SW+xaz08kXgqtI8f21qEMogKlKIg78NG?=
 =?us-ascii?Q?yAEvp3iN49e6y3iTaYIsLsYAXdG53Gj4FJ7bNJLxvMWbKIYCsv++NX8p0nrs?=
 =?us-ascii?Q?Kt1OgIhY+GtS6+d3g7XRth6REozvVvvtc12RSNGx52hK4kqiNQpQKldbGJbT?=
 =?us-ascii?Q?3qsYQXc5Jo0F/Y1v219DRuF1L1gglncDf58cPHY0Ar/iwvQ/XBdfWKeSoPAH?=
 =?us-ascii?Q?ESwQMLWGUAP3Ibp0XjwN/dDnXNLGu5XeZZ0QWducTsKFL4pvgCDKAZEYwI7/?=
 =?us-ascii?Q?GZTlVTAjkGQnsL6wl0of/HyUZHsJqudil0XH3voqv5YsW18FFsb94K+bUpJk?=
 =?us-ascii?Q?FxtQg247CnlLWN5KYlXhO2zrqf65NrU1IkPk7HrvGFlPYMorBaPxoQwVaDDw?=
 =?us-ascii?Q?7A53+5uPf6I+5XNJuQdQ90Wk4smWmjW/nd0+qiN3oQZXcxLdHXjzsyYQN16m?=
 =?us-ascii?Q?ConBwiOCrRR8FzG7fkIeebcaRbO/lwlkaYdYr9uR0P0VPsJO3dl+rJjnoJza?=
 =?us-ascii?Q?zv0Dmvm5pUASmtx7xqztB998lbjrfn/xea2tD83clEfmAWBfoEnUna27dkCJ?=
 =?us-ascii?Q?O0ER/33ahVCbeKQ5mnHmgsh1ZfrJxddqXxdOu154zSbZFcC+oHenTxn0cRvQ?=
 =?us-ascii?Q?jNhLOYus8Dk0Zm6GsiZzpJZSSFMbsrq+n1bchRZVwTTJUHXAuWZrN4d9/2rN?=
 =?us-ascii?Q?gGbrEblLGw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66de7342-6e06-4f25-e59d-08df25ab208b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 02:15:02.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mokfi69IoFHE2sazZRD05pMSbb5wEX6ucgqq0978l495Th63jX6Rl/BdrRbBd4hzGEk/2QqyHktzWH+eIlQSJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8063

From: Tze Yee Ng <tze.yee.ng@altera.com>

The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
pulse width in clk_phy cycles minus 1 in extended read mode, and 0
otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
(the silent odd/even edge-capture defect).

On this integration the rebar pulse is 2 clk_phy cycles, so extended-
read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2
corrupts reads). Derive it from the extended-read-mode state and apply
it only in DDR modes, since SDR extended-read samples a single edge and
is unaffected.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- Added Adrian's Acked-by.
- Reworded the commit message to drop the "generic to any SD6HC-PHY SoC"
  framing. (Adrian Hunter)
---
 drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
index 22d56bb46d75..8d6a9c26c139 100644
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

