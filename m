Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97567259CBE;
	Wed,  9 Apr 2025 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183504; cv=fail; b=rcLzxEqNR1yWlD7muAahss6tt7XkUBrwihBVDZigHLmujWE+5guDxUr0byoEj9mHl8zuyQkFs1ddnaAfz1awo7VQpdP1HV1yGTW5G5ePwShWJDFm9Bq8w6BB74zMYjf5mKEsg2l6iJBtywMGhw/YCcSWYyDiVpsxdV9s1lEanfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183504; c=relaxed/simple;
	bh=CQ6Kl5t/WFex9+1sswxDoUU0+k3PhPBSQunW/oAVK04=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y37eBBDAVTlVRtvoGo7XulyXcwOtZMT8gZlLrxyd5XuT/sJNxXK4LTg2IO/xtI38MZIKraNUw3wRYin35QJ+3zQ4hGaLzRnh+5xkhWRz2720TiTMo/9XP9+FesdU4NW7yMLi5Sp5v4+eOvjpz+kVx4PTUoVxmUVp0r2OwdV/TwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J1Lkavx8; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J1Lkavx8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leNvDf0UMbAlh/6DNSRxo4silRevojBX4onkiIDxWPtZjSU3xAzruKjBJXqCokCukF3uesz3zjtvTmaH8WMYmVWtsIQ/leFHJOklX5Q/AthG/E+5wamxuTBtpq7zFQiJFIhLqrfriQosRd7OLfUlOrzUC2+37nxATPIekn+p/eNhxLRAk18vmjS50tfLCkMJ+x157sTUmNF0PC123aErJl93Vj4Y3Xi7o0AazCiG+a/OowlFHsBtnH9i9bixcpSTEcUsWOr6pOc6wvQsXjgSFfzBPJ/SwNXH4wTfsi8Dx06aqqcmvpvVeQyqA+s5hIGKX0TKaZEgXChch40PB83Whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF8MKQcSY4Mlq6HXWy3F4CGIbMETGMBpgAkMLBXVYQ0=;
 b=Lrg3zVT2cFhaASWelmyUJCu0lmElgNRYXPxpeYZAyOyo80CHUjTZ/eYwiTNofwGTve5FmSqYFlTXLNL9bCjrLadOoq9MwNFcFXU5AqQmImXAjm6OIQae9nTeTzHf/rflHLNVEkAbDJGJrrcLpSIBWKPmfe0il4gWfc4cL9UpMRydVe1c9lsj3kJ28OJehgBannsWnRDlNJRElpdlw5A8oGz5RqO9IwyyDZEFrLbrTug5d7sVwJQprpoQ0WClO3xM52b3Zal21gYeJUpY0OoL3ftkaRC7+M0Z47K0y/HCaqEL8i1q5JZPNCtZEczb/5J9dORb0uB7cXfKI1pQop9CJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF8MKQcSY4Mlq6HXWy3F4CGIbMETGMBpgAkMLBXVYQ0=;
 b=J1Lkavx87hz1f+DzaR/WChtsDwQFplEgPipZ02ZXaLLRptHIwgicV0ZKOpy78nfE7+EjRgqg8Ole0U/XrtH0XFXkRo6unG8m1/az41M/eCyU5n6bm549V9UyrMKeOi0iVX1fjvT+Xn4wCeRUOg9kWEuvloC4JeVnLesa8xfZ4CDQ9OnNfFnWaLBYkjWKBy32wB2ssQDVaa108UmUU6b1pM59NuWHeKuu9xU0YWEqI15Z0mzTG77bprmzZUIEzDUEiEqzY1LLS3/VhLbXrtbOLe1l6fg0GdRlgBTeb21XGDcchvH+eFv1w7wQrVKjySSRvWhwNP+VZ7B9AbCJzl9lGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AS8PR04MB8835.eurprd04.prod.outlook.com (2603:10a6:20b:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 07:24:57 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 07:24:57 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: calculate data timeout value based on clock
Date: Wed,  9 Apr 2025 15:26:04 +0800
Message-Id: <20250409072604.3410459-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AS8PR04MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 7904a30f-8ff5-47e3-c7e9-08dd7737a189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o3DDOw7RHuZm7LyMKLeNTZgw5P0gsgzEu98FTtV1icmcqmJA0Eutgy/36gNF?=
 =?us-ascii?Q?PF4htWPlE3+SNzWR6fXIJW53JhbLvvMWwRjthtGKvb/mBw1lRpDYT9I2+hCg?=
 =?us-ascii?Q?LNb/blhBhY+US5DnIYadBdyT/q/B/MNhE0aQ0QbxmvtDuVc6TLVcdJOklLRQ?=
 =?us-ascii?Q?BtZ1N+DW5zjPGscXuuXGKufJiIMR+FzGzJpl+4yW13CgotaFuXG/JJEhCwTf?=
 =?us-ascii?Q?Twml89iTWJ0tvSKr69SZJLyJ5fIw33A4B6WCqnF/S7CGobgHJwudyjYbydom?=
 =?us-ascii?Q?94o/2hY6j9/+Ih4S5yrXnqUGHJW62nFJmLe5Q1CGbXuAoYc4tiO6YMZy7FpZ?=
 =?us-ascii?Q?IiW1wpsX1uaSxnDNK/B+6b5motaRCd8tQUcD/r+sidD8l3lA/CsYqiea2krN?=
 =?us-ascii?Q?HyNOkv9Zcvlzzh0qwrfh2xRU++YwhN+WT4DrSvoPls66kT5H/8h4244xWX2I?=
 =?us-ascii?Q?lkLfW5sbgwM8SOIZ6xR2ryRahaYsUxr+oK0Iw1GnJnoVLeJOqUmP1nDMJTgJ?=
 =?us-ascii?Q?UHaNbqg1SwK82qtFEBLdQdMlrWUsjEuinYeQajzaBGj95lfHLUkAZnuP9TNG?=
 =?us-ascii?Q?8Vj2JLULR5nGboR51mRTtyu/rbP1IsWXTuUVmOPOpXVYwygWDqpVh7TKyXoo?=
 =?us-ascii?Q?YtPvo17fSzhnMYMHVnOMU+TDmFBSm7xH5N770V3DjWCKlYELhYih9A5YRfvD?=
 =?us-ascii?Q?2ZnbJ2spuyu6y7XB+NzCwAUu0zui2u1LbgJnd1AADYChR7oTsWNliZJ/qf8z?=
 =?us-ascii?Q?VOfSAgT3lzf0WtHB0dhAPAfPsJCJSA6whtVs+BQrfV/pnaNlVaFk7MkL+qyD?=
 =?us-ascii?Q?emVh55Iwuj+rxAcf0nRJbErVPov1QKEaYBmQJGSPpk5RlNRyC3O3B02TwFm/?=
 =?us-ascii?Q?A+OPTEJFcaVj0Ppv8wsAMHs9NmXRTabbl1bzbD2IdmiIu5OJeMgl12FBXoWy?=
 =?us-ascii?Q?Rj5bEm1iKGHTThhV3TrcztqnJL7rLLySmU/pQEJ1IWdTBfz5qYBubWibG0Fd?=
 =?us-ascii?Q?ydF4vfiQ3lE8EVxdk4UcTRGKLliBPuL7Uf/gMjHwCih4tyMuusVEAxf/R9D8?=
 =?us-ascii?Q?aYESSO2io3JX67V2s8QUgqTf6w3D9gk3wlvpFcVgavKlTnDnlZ/CrXplqKA0?=
 =?us-ascii?Q?rihwGxV5CpRdMfY7fkcHUzL1Ee5ADDljw5KTvM231EWPzUttELfugaef1j/I?=
 =?us-ascii?Q?ua6cF+zlBhnvW7yqeFlcfv5HOklyxvLntsfkursrOnFRBb8cUduBWZXwdTdR?=
 =?us-ascii?Q?BQcLcGIdFE7vyz9h5v50uXWMuVPgw8hfyWIL+yBNSLtRxid9h2B3cIj3GvM0?=
 =?us-ascii?Q?inXiZaLIwJHnm5TVAc31F4jUllmt2dcF0wmX2X+be6cxWl9rxFeohuBdEqxo?=
 =?us-ascii?Q?zzJErVgNwBuGr+9gybZ9zCnKQLkJyYi4aBMvPvAJKKzwUgrEx+ASTZDAQ7UO?=
 =?us-ascii?Q?xMbzn1Rr21gwObKuCHKBTHHzloJsuwuo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VX86rDscp6//wy5hU4p0mricOMGoS6J7KC6s6yV7IfZiEPc2Zz1Vadqy+A1N?=
 =?us-ascii?Q?XV5UCeStzufajrGaZo/kbN+ucEozoLFIIKHj2Vb1OFEmqGHRObuEy0uzbs3R?=
 =?us-ascii?Q?LGK9lnid9lBRhRxAI2q26N8AnuxAhb/tnBeciCf9vVzZ5AEo/OklvvfojivA?=
 =?us-ascii?Q?tbp11Pmvty/OSqu8qUluv8rf7x6BA2N7udwnENmZM6i/bxiz6W8NDw7Drtvu?=
 =?us-ascii?Q?lR2gnwjAGgU5cRpkOVNDUwMZdYkl5lfZ+iQA5+x1etOtpSYgjAULbG7y2vQj?=
 =?us-ascii?Q?eyek8v3EM0dcvIqWGHrJNgoZwdGuqNQhjKtsP7SAGEac9qxoCqSlyixzk/3t?=
 =?us-ascii?Q?AS3PInvonCGQKFt3s+7DfFzwf+M5GNINn87P7hSoS4OSZ9tvUlWpbx17PYNY?=
 =?us-ascii?Q?Vzy2PrDUG1Eglq8OiE0CXlyjMa2Bv4Bq10gBQF4YZ9EHtH6CCI9+Q1cUY0X3?=
 =?us-ascii?Q?l0f+tSnUEfQj7esq+TJOWlaVKR6+wxdVHU2f5u/VZGRWFm5ItPoUlbPMAjVY?=
 =?us-ascii?Q?qDx9Bbtv0kMHE8RkX9iZe3IGuJD6igHwEGp6X4ah2YMpkPaHGmpxg369PpUR?=
 =?us-ascii?Q?Y2jA0otSxCWsiNJ61lRnwcAQUq2mjTVMwTGY4Nl1EMmWYYmdeCEWPsOryiu9?=
 =?us-ascii?Q?v2P01aDXtIED/DqbQZXhexY4F9gf10wNL73B2Q0ZIu3Kyy6Ar2+Kh/2PDcUn?=
 =?us-ascii?Q?BDjrS/JzsXgSvY1jzTPv+Elt8tJA8UNBAJrlCQ5FrBW0e2Z45s4EdHBZeIxc?=
 =?us-ascii?Q?RzRiFqDMBAsYCmdS9JrLtFhoO8RloITLMouuLDLKc26NDNmUODvIcSveTyF6?=
 =?us-ascii?Q?Lg7INn9l8lz2cLPHPFX89c66TZDPsH76w2Da2m9mm4WwBAkkKU2LV357XYEE?=
 =?us-ascii?Q?111hYvLR4Ijxubr+jFvzdxQonZ6g0QCDEE7kiTjnnFvlBzyFhue0fDjpWDGp?=
 =?us-ascii?Q?D/nuxLbIZJhKr82NzNfpxbT1cPAOjZCoD/nrkilB4pW973GGp1rDKGWQfWKu?=
 =?us-ascii?Q?RLEF7+TcgsdBF5lCA7G+KyW0h79jKAxRADB4QL8U9Bjke+CFgysXLicvSH7h?=
 =?us-ascii?Q?d2I+jEEfCS8apmHoSVch9rHw+/zTrR6CWenVky01dNvk3ZKIvHovd3LkEEhh?=
 =?us-ascii?Q?jZleNcxjavfX7LTD9klOZbRbXHOHxXfcdd9zC/UHengk1E3ptHUyYTfGDcJ+?=
 =?us-ascii?Q?EkgMwZ1XJEshDRe1A+lsQLZGKM0PUx06tMpCQlVUiETOBrtOtlhM5IpZZ/FF?=
 =?us-ascii?Q?ny2grKdAQmcW7hUNdZmthJkTUjkbpmFlafYztQuZ9YKFgytLJhsL2JmtAn1q?=
 =?us-ascii?Q?oMp9pmgQ80dmUBrN7WO+BcIPhHx0gyjl+GYzMXrzU+aCa2SMoj80dUrRh0P2?=
 =?us-ascii?Q?HgU12NxYjZmU0e+9U3Oje1ajYaRNtVSLy4GCeBI+9dPTE2FGgaNW7ROhN7JY?=
 =?us-ascii?Q?mxjj+1FKftRapqYL4Buag1GEoqbyR1tigm0m7WTCHjKnCby2mT4t72GYbbBE?=
 =?us-ascii?Q?fiXu6OQ5MGa82Qd+R503uzccXPKyKj19YfOm/gw0eHaKMztEK42ktNbSSvWf?=
 =?us-ascii?Q?qblEU6bTqWY7lRqfD570LbWY4xu10OOkOBHSLndG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7904a30f-8ff5-47e3-c7e9-08dd7737a189
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:24:57.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+8AXaoqFGS1q8vUIZSxNWkW8291q/VfMfsZdh/bW1zA8Aerj4FzCrqrVxcR5rBmmzc0+QZwfa68sOuYF+94LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8835

From: Luke Wang <ziniu.wang_1@nxp.com>

Calculate data timeout value based on clock instead of using max value.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
v1->v2:
 * Added SDHCI_TIMEOUT_CONTROL to esdhc_writeb_le()
 * Removed esdhc_set_timeout() to use common __sdhci_set_timeout().
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ff78a7c6a04c..a34cabee5916 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -870,6 +870,16 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 
 		esdhc_clrset_le(host, mask, new_val, reg);
 		return;
+	case SDHCI_TIMEOUT_CONTROL:
+		/*
+		 * ESDHC_SYSTEM_CONTROL bit[23] used to control hardware reset
+		 * pin of the card. Write 0 to bit[23] will reset the card.
+		 * Only write DTOCV field here.
+		 */
+		esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
+				FIELD_PREP(ESDHC_SYS_CTRL_DTOCV_MASK, val),
+				ESDHC_SYSTEM_CONTROL);
+		return;
 	case SDHCI_SOFTWARE_RESET:
 		if (val & SDHCI_RESET_DATA)
 			new_val = readl(host->ioaddr + SDHCI_HOST_CONTROL);
@@ -1385,17 +1395,6 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 	return esdhc_is_usdhc(imx_data) ? 1 << 29 : 1 << 27;
 }
 
-static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-
-	/* use maximum timeout counter */
-	esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
-			esdhc_is_usdhc(imx_data) ? 0xF0000 : 0xE0000,
-			ESDHC_SYSTEM_CONTROL);
-}
-
 static u32 esdhc_cqhci_irq(struct sdhci_host *host, u32 intmask)
 {
 	int cmd_error = 0;
@@ -1432,7 +1431,6 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_max_timeout_count = esdhc_get_max_timeout_count,
 	.get_ro = esdhc_pltfm_get_ro,
-	.set_timeout = esdhc_set_timeout,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
 	.reset = esdhc_reset,
@@ -1777,6 +1775,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		 * to distinguish the card type.
 		 */
 		host->mmc_host_ops.init_card = usdhc_init_card;
+
+		host->max_timeout_count = 0xF;
 	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
-- 
2.34.1

